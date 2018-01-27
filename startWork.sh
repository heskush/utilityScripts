start-dfs.sh; #3 JPS
start-yarn.sh; #2 JPS 
mr-jobhistory-daemon.sh start historyserver; # 1 JPS
oozied.sh start; # 
sh $SPARK_HOME/sbin/start-history-server.sh; # 1 JPS
start-hbase.sh
