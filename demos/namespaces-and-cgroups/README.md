# Namespaces and CGroups

## CGroups

1. See [README](../containers-cgroup-info/README.md) for instructions on building.

2. Start the container: `podman run -it --rm -p 8080:8080 --cpus=1 --memory=1G localhost:5001/dmikusa/containers-cgroup-info`. This sets a 1 CPU and 1G RAM limit on the container.

3. Go to [https://localhost:8080/](). You can view the CGroup information.

4. Restart the container with different CPU & RAM limits. Observe how the limits change in the UI.

## Namespaces

1. Start a container: `podman run -it --privileged -h outer-container localhost:5001/library/ubuntu:noble bash`

2. Run:

    ```
    $ hostname
    outer-container
    $ unshare -u /bin/sh
    $ hostname inner-container
    $ hostname
    inner-container
    $ ps aux
    USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
    root           1  0.0  0.0   4300  3540 pts/0    Ss   03:29   0:00 bash
    root           7  0.0  0.0   2384  1424 pts/0    S    03:30   0:00 /bin/sh
    root           8  0.0  0.0   7632  3532 pts/0    R+   03:30   0:00 ps aux
    $ exit
    $ hostname
    outer-container
    ```

This shows how you can start a new process and `unshare` removes it from the UTS namespace, at the same time, you can see processes across the two processes because those share a pid namespace.

Tools like `unshare` allow you to customize how you isolate processes (remember a container is just an isolated process), picking and choosing which isolations make sense for your workloads.
