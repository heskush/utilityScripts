echo Deleting all snapshots...
for dir in $(hdfs lsSnapshottableDir | tr -s ' ' | cut -d' ' -f10); 
   do 
      for d in $(hdfs dfs -ls $dir/.snapshot| awk -F '.snapshot/' '{print $2}'); 
        do  
           hdfs dfs -deleteSnapshot $dir $d; 
           done; 
       hdfs dfsadmin -disallowSnapshot $dir; 
   done > /dev/null 2>&1;
echo Snapshots deleted and disallowed. 
echo NOTE: DELETE THE CONCERNED OUTPUT FOLDER. 

