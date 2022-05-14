In this benchmark we compared Percona Server for MySQL using the RocksDB storage engine with XFS and ZenFS file systems.

The contents of this directory:
- [cnf](./cnf) - a configuration file for Percona Server
- [sh](./sh) - bash scripts to run sysbench (we started our benchmark with `bench_24x750M.sh`)
- [sysbench.lua](./sysbench.lua) - based on Mark Callaghan’s scripts from [github.com/mdcallag/mytools](https://github.com/mdcallag/mytools/tree/master/bench/sysbench.lua)

A short description of the setup:
- CPU: Intel Xeon E5-2697 v3 (14 cores, 28 threads), 128 GB of RAM
- Linux OS: Debian 11 with 5.10.70-1 (2021-09-30) kernel
- Storage for ext4: 3.84 TB conventional SSD, WUS4B7638DSP303
- Storage for ZenFS: 3.96 TB ZNS SSD, WZS4C8T4TDSP303
- Percona Server for MySQL 8.0.28-19

Benchmark procedure:

In the first step we created 24 tables x 750 millions rows each. The scripts used sysbench to populate 24 tables using 24 threads. The secondary index was disabled (with sysbench option “--create_secondary=off”) and we used RocksDB’s bulk loading (with Percona Server option “--rocksdb_bulk_load=1”) to populate tables faster. We used 32 GB of RAM with Percona Server option "--rocksdb_block_cache_size=32G". The created database took about 3.4 TB of disk space which is 95% for XFS and 87% for ZenFS of our 4 TB disks. Tables were created in 140 minutes for XFS and 339 minutes for ZenFS.

In the second step we ran 13 OLTP tests that simulated various types of sysbench workloads. Each test was started using 24 threads for 1800 seconds. Altogether it took about 428 minutes for each file system including warming-up.
