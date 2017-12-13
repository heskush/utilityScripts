stop-hbase.sh
oozied.sh stop;
sh $SPARK_HOME/sbin/stop-history-server.sh;
mr-jobhistory-daemon.sh stop historyserver;
stop-yarn.sh;
stop-dfs.sh;


