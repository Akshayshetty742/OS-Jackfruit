/*
 * monitor_ioctl.h - Shared ioctl definitions between user-space and kernel-space.
 *
 * Include this in both engine.c (user-space) and monitor.c (kernel module).
 */

#ifndef MONITOR_IOCTL_H
#define MONITOR_IOCTL_H

#ifdef __KERNEL__
#include <linux/ioctl.h>
#include <linux/types.h>
#else
#include <linux/ioctl.h>
#include <sys/types.h>
#endif

#define MONITOR_MAGIC  'M'

/*
 * MONITOR_REGISTER   - register a container PID for RSS monitoring
 * MONITOR_UNREGISTER - remove a container PID from the monitor
 */
#define MONITOR_REGISTER   _IOW(MONITOR_MAGIC, 1, struct monitor_request)
#define MONITOR_UNREGISTER _IOW(MONITOR_MAGIC, 2, struct monitor_request)

struct monitor_request {
    pid_t         pid;
    char          container_id[64];
    unsigned long soft_limit_bytes;
    unsigned long hard_limit_bytes;
};

#endif /* MONITOR_IOCTL_H */
