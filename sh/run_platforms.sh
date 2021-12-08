BUILD=wdc-8.0.26-rel-gcc10
CNF=~/cnf/percona-zenfs.cnf
ZENFS_DEV=nvme1n2
DISKNAME=nvme0n1
DATADIR=/mnt/nvme0n1/master

sudo ~/sh/create_fs.sh /dev/nvme0n1p1 /mnt/nvme0 xfs
SECS=1800 NTABS=28 NROWS=500M NTHREADS=14,26 MEMORY=32 DATADIR=$DATADIR BULK_SYNC_SIZE=100000000 ZENFS_DEV=$ZENFS_DEV DISKNAME=$DISKNAME run_sysbench.sh $BUILD $CNF zenfs init,verify,run
SECS=1800 NTABS=28 NROWS=500M NTHREADS=14,26 MEMORY=32 DATADIR=$DATADIR DISKNAME=$DISKNAME run_sysbench.sh $BUILD $CNF rocksdb init,verify,run
sudo ~/sh/create_fs.sh /dev/nvme0n1p1 /mnt/nvme0 ext4
SECS=1800 NTABS=28 NROWS=500M NTHREADS=14,26 MEMORY=32 DATADIR=$DATADIR DISKNAME=$DISKNAME run_sysbench.sh $BUILD $CNF rocksdb init,verify,run
