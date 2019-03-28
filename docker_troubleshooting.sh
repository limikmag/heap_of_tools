#!/bin/bash

$ docker ps -q | xargs  docker stats --no-stream
CONTAINER ID        NAME                CPU %               MEM USAGE / LIMIT   MEM %               NET I/O             BLOCK I/O           PIDS
201998aa550c        angry_meitner       0.00%               100KiB / 15.53GiB   0.00%               4.56kB / 0B         0B / 0B             1
e7250beb9dca        nostalgic_pascal    0.00%               100KiB / 15.53GiB   0.00%               13.8kB / 0B         4.36MB / 0B         1


Putting everything together to look at the memory metrics for a Docker container, take a look at /sys/fs/cgroup/memory/docker/<longid>/

$ cd /sys/fs/cgroup/memory/docker/201998aa550cee092351edb19ce5b2e33c46c5f6da8d2cf359295d54ca97479f
$ ls
cgroup.clone_children  memory.kmem.failcnt             memory.kmem.tcp.limit_in_bytes      memory.max_usage_in_bytes        memory.move_charge_at_immigrate  memory.stat            tasks
cgroup.event_control   memory.kmem.limit_in_bytes      memory.kmem.tcp.max_usage_in_bytes  memory.memsw.failcnt             memory.numa_stat                 memory.swappiness
cgroup.procs           memory.kmem.max_usage_in_bytes  memory.kmem.tcp.usage_in_bytes      memory.memsw.limit_in_bytes      memory.oom_control               memory.usage_in_bytes
memory.failcnt         memory.kmem.slabinfo            memory.kmem.usage_in_bytes          memory.memsw.max_usage_in_bytes  memory.pressure_level            memory.use_hierarchy
memory.force_empty     memory.kmem.tcp.failcnt         memory.limit_in_bytes               memory.memsw.usage_in_bytes      memory.soft_limit_in_bytes       notify_on_release


.Container	Container name or ID (user input)
.Name	Container name
.ID	Container ID
.CPUPerc	CPU percentage
.MemUsage	Memory usage
.NetIO	Network IO
.BlockIO	Block IO
.MemPerc	Memory percentage (Not available on Windows)
.PIDs	Number of PIDs (Not available on Windows)


$ docker stats --format "{{.Container}}: {{.CPUPerc}}"


Installation ctop - great tool to monitoring docker containers:

$ sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.1/ctop-0.7.1-linux-amd64  -O /usr/local/bin/ctop
$ sudo chmod +x /usr/local/bin/ctop

$ dmesg - program which print logs from kernel ( when some process in container are killed we can take a look to this logs)

Monitoring Resource Consumption
The systemd-cgls command provides a static snapshot of the cgroup hierarchy. To see a dynamic account of currently running cgroups ordered by their resource usage (CPU, Memory, and IO), use:
$ systemd-cgtop -p
e.g. output
/                                                                                                        110   38.3     6.1G        -        -
/docker                                                                                                    -    3.6     7.4G        -        -
/docker/8211c306daf29bd1241c004ac530bf45d334b29f3678d1e59d70795c43abd581                                  18    3.3   674.9M        -        -
/docker/9680e059657f8a82f770ec46b2a8659696e220df8a4a719d12ad3a0d28196955                                   5    0.3   506.1M        -        -
/kubepods                                                                                                  -    7.8     1.1G        -        -
/kubepods/besteffort                                                                                       -    1.3   538.8M        - 


After this we can run:
$ watch systemd-cgls /docker/1633e7ffa4a1ea4887d997941d7b02512cd3f5b2dc3ba7ce30d1a705a248839d

And we will see all processes running in container

