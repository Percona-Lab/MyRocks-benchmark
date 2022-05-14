export NROWS=750M
export NTABS=24
export NTHREADS=24
#export SECS=150
export SECS=1800
export MEMORY=32
export ZENFS_DEV=nvme1n2
export WORKLOAD_SCRIPT=all_percona.sh
export BENCH_PATH=~/bench
export BUILDDIR=~
DATA_MOUNT=/mnt/nvmexfs
BUILD=wdc-8.0.28-19-rel-gcc10-rocks
CNF_ROCKS=~/sh/cnf/percona-rocksdb.cnf
CNF_INNO=~/sh/cnf/percona-innodb.cnf

sudo ~/sh/create_fs.sh /dev/nvme0n1 $DATA_MOUNT xfs -K
#DATADIR=${DATA_MOUNT}/master_innodb  run_sysbench.sh $BUILD $CNF_INNO  innodb  init,prepare,prepare,verify,run
DATADIR=${DATA_MOUNT}/master_rocksdb run_sysbench.sh $BUILD $CNF_ROCKS rocksdb init,prepare,verify,run
DATADIR=${DATA_MOUNT}/master_zenfs   run_sysbench.sh $BUILD $CNF_ROCKS zenfs   init,prepare,verify,run

#sudo ~/sh/create_fs.sh /dev/nvme0n1 $DATA_MOUNT ext4 -K
#run_sysbench.sh $BUILD $CNF_ROCKS rocksdb init,prepare,verify,run
