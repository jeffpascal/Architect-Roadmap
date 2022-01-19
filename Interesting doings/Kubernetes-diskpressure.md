## Kubernetes DiskPressure taint on a node

### Problem: /var/ had over 75% storage filled up and caused DiskPressure on a node

What we tried:

Remove taint manually:

kubectl taint nodes node5 node.kubernetes.io/disk-pressure-

### Solution

The folder /var/lib/mlocate had the mlocate.db at 52 GB causing /var to be full

What we had to do was Prunde the docker directory

```
PRUNE_BIND_MOUNTS = "yes"
PRUNEFS = "9p afs anon_inodefs auto autofs bdev binfmt_misc cgroup cifs coda configfs cpuset debugfs devpts ecryptfs exofs fuse fuse.sshfs fusectl gfs gfs2 gpfs hugetlbfs inotifyfs iso9660 jffs2 lustre mqueue ncpfs nfs nfs4 nfsd pipefs proc ramfs rootfs rpc_pipefs securityfs selinuxfs sfs sockfs sysfs tmpfs ubifs udf usbfs fuse.glusterfs ceph fuse.ceph"
PRUNENAMES = ".git .hg .svn"
PRUNEPATHS = "/afs /media /mnt /net /sfs /tmp /udev /var/cache/ccache /var/lib/yum/yumdb /var/spool/cups /var/spool/squid /var/tmp /var/lib/ceph /var/lib/docker /var/lib/kubelet"
```