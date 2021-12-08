In this benchmark we compared Percona Server for MySQL using the RocksDB storage engine with ext4, XFS, and ZenFS file systems.

The contents of this directory:
- [cnf](./cnf) - a configuration file for Percona Server
- [sh](./sh) - bash scripts to run sysbench (we started our benchmark with `run_platforms.sh`)
- [sysbench](./sysbench) - contains `oltp_common.lua` modification which adds `rocksdb_bulk_load_sync_size` to sysbench
- [sysbench.lua](./sysbench.lua) - based on Mark Callaghan’s scripts from [github.com/mdcallag/mytools](https://github.com/mdcallag/mytools/tree/master/bench/sysbench.lua)
- [results_28x500M_1800s.xlsx](./results_28x500M_1800s.xlsx) - full results of sysbench run with ext4, XFS, and ZenFS file systems

A short description of the setup:
- CPU: Intel Xeon E5-2697 v3 (14 cores, 28 threads), 128 GB of RAM
- Linux OS: Debian 11 with 5.10.70-1 (2021-09-30) kernel
- Storage for ext4: 3.84 TB conventional SSD, WUS4B7638DSP303
- Storage for ZenFS: 3.96 TB ZNS SSD, WZS4C8T4TDSP303
- Percona Server for MySQL 8.0.26-16

Benchmark procedure:

In the first step we created 28 tables x 500 millions rows each. The scripts used sysbench to populate 28 tables using 14 threads.
The secondary index was disabled (with sysbench option `--create_secondary=off`) and we used RocksDB’s bulk loading (with Percona Server option `--rocksdb_bulk_load=1`)
to populate tables faster. The created database took about 2.7 TB of disk space which is 79% for ext4, 75% for XFS, and 87% for ZenFS of our 4 TB disks.
Tables were created in 161 minutes for ext4, 160 minutes for XFS, and 244 minutes for ZenFS.

In the second step we ran 13 OLTP tests that simulated various types of workloads.
Each test was started using 14 and 26 threads for 1800 seconds. Altogether it took about 1020 minutes for each file system including warming-up.
