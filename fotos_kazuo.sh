#!/bin/sh

#  fotos_kazuo.sh
#  
#
#  Created by Sidney Kazuo Kawamura on 2/17/13.
#
#  version 1.0

today=`date "+DATE_%d_%m_%Y_%H%M"`;

#sync both folders
source=/Users/kazuo/Public/fotos/;
dest=/Volumes/HITACHI/fotos/;
log=/Users/kazuo/Public/;

echo "Sync information";
echo $today;
echo "Souce: $source";
echo "Dest:  $dest";
echo "Log available at: $log";
echo ;

echo "sync ...";
error=`rsync -rtuv $source $dest > $log/fotos_sync_$today.log`;
if [ $error -ne 0 ];
then
    echo "rsync error..."
    return -1;
fi

echo "executing diff...";
error=`diff -r $source $dest > $log/fotos_diff_$today.log`;
if [ $error -ne 0 ];
then
echo "diff error..."
return -1;
fi

echo "open check file...";
if  ! [ -s $log/fotos_diff_$today.log]
    ! [ -f $log/fotos_diff_$today.log];
then
    echo "can not find the check file";
    return -1;
fi;

echo "checking diff...";
error=`grep -c 'Only in $source' $log/fotos_diff_$today.log`;
if [ $error -ne 0 ];
then
    echo "somefiles can not copied to destination folder, please check the network and execute the command again.";
    return -1;
fi

echo "FINISHED DIRECTORIES SYNCED%n";