# in .bashrc set:
# source ~/sh/set_env.sh ~/sh

SH_PATH=$1

export PATH="$SH_PATH:$SH_PATH/../sysbench.lua:$PATH"
