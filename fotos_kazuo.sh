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
if ( rsync -rtuv $source $dest 2>&1 > $log/fotos_sync_$today.log );
then
	echo "rsync ok";
else
	echo "rsync problem ... exiting";
	return -1;
fi 

echo "executing diff...";
if ( diff -r $source $dest 2>&1 > $log/fotos_diff_$today.log );
then
	echo "directories are equal";
else	
	echo "directories are differents";
fi

echo "open check file...";
if  ! [ -s $log/fotos_diff_$today.log ]
    ! [ -f $log/fotos_diff_$today.log ];
then
    echo "can not find the check file";
    return -1;
fi;

echo "checking diff...";
if ( grep -c 'Only in $source' $log/fotos_diff_$today.log );
then
    echo "somefiles can not copied to destination folder, please check the network and execute the command again.";
    return -1;
else
	echo "diff check is ok";
fi

echo "FINISHED DIRECTORIES SYNCED";
