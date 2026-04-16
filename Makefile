# Makefile - Multi-Container Runtime
#
# Builds:
#   engine        - user-space supervisor + CLI binary
#   monitor.ko    - kernel module
#
# Usage:
#   make          - build everything
#   make engine   - build only user-space binary
#   make module   - build only kernel module
#   make ci       - compile-check user-space only (CI-safe, no sudo/headers needed)
#   make clean    - remove build artifacts

KDIR   ?= /lib/modules/$(shell uname -r)/build
CC     := gcc
CFLAGS := -Wall -Wextra -O2 -pthread

.PHONY: all engine module ci clean

all: engine module

# ---- User-space binary ----
engine: engine.c monitor_ioctl.h
	$(CC) $(CFLAGS) -o engine engine.c

# ---- Kernel module ----
obj-m := monitor.o

module: monitor.c monitor_ioctl.h
	$(MAKE) -C $(KDIR) M=$(PWD) modules

# ---- CI target (compile engine only, no kernel headers required) ----
ci: engine

# ---- Workload binaries ----
cpu_hog: cpu_hog.c
	$(CC) $(CFLAGS) -o cpu_hog cpu_hog.c

io_pulse: io_pulse.c
	$(CC) $(CFLAGS) -o io_pulse io_pulse.c

memory_hog: memory_hog.c
	$(CC) $(CFLAGS) -o memory_hog memory_hog.c

workloads: cpu_hog io_pulse memory_hog

# ---- Clean ----
clean:
	rm -f engine cpu_hog io_pulse memory_hog
	$(MAKE) -C $(KDIR) M=$(PWD) clean 2>/dev/null || true
	rm -f *.o *.ko *.mod *.mod.c .*.cmd modules.order Module.symvers
