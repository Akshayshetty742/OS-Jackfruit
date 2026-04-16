🚀 Simple Container Runtime (OS Project)
📌 Overview

This project demonstrates a basic container runtime using Linux primitives like chroot, process management, and scheduling. The system simulates container lifecycle operations including start, stop, logging, monitoring, and resource control.

⚙️ Implementation
✅ Task 1: Container Execution

Two containers (alpha and beta) were created using chroot.

Command used:

sudo chroot ../rootfs-alpha /bin/sh
sudo chroot ../rootfs-beta /bin/sh
ps aux | grep chroot

Output:

Explanation:
This shows multiple isolated environments running simultaneously.

✅ Task 2: Logging System

Logs were written into a file.

echo "Container alpha started" >> logs.txt
echo "CONTAINER_LOG_1" >> logs.txt
echo "Container alpha stopped" >> logs.txt
cat logs.txt

Output:

✅ Task 3: Engine CLI Simulation

Simulated container engine commands.

./engine

Output:

✅ Task 4: Monitor Logs

Kernel-style logs simulated.

echo "[1234.567] monitor: container started"
echo "[1235.123] monitor: soft limit exceeded"
echo "[1236.999] monitor: hard limit exceeded - killing process"
echo "[1237.500] monitor: container terminated"

Output:

✅ Task 5: CPU Scheduling

Used nice values to control CPU priority.

./cpu_hog &
nice -n 10 ./cpu_hog &
sudo nice -n -5 ./cpu_hog &
ps -o pid,ni,comm | grep cpu_hog

Output:

✅ Task 6: Process Cleanup

Processes were terminated using kill.

sudo kill -9 $(ps aux | grep cpu_hog | grep -v grep | awk '{print $2}')

Output:

🧠 Engineering Analysis
chroot provides filesystem isolation but not full container security
nice controls CPU scheduling priority
Soft limits warn before exceeding usage
Hard limits terminate processes
Kernel module behavior is simulated using logs
⚙️ Design Decisions
Used simple shell commands instead of full container runtime
Simulated CLI instead of implementing full parser
Used ps for monitoring processes
Simulated kernel logs using echo
⚠️ Challenges Faced
Killing background processes
Managing multiple chroot sessions
Makefile compilation issues
Process visibility confusion
🎯 Conclusion

This project helped understand:

Process isolation
Scheduling
Resource control
Basics of container runtime design
