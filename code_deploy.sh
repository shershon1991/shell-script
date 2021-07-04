#!/bin/bash
USER=`whoami`

if [ $USER != 'www' ]; then
    echo 'The login user is' $USER
    echo 'But the shell only for the www user'
    echo 'Please use the command "su www" to change the user'
    exit 1
fi

#cd /data/syncdata/zhugexuetang && git pull && cd -

#backup files
echo ' start back up files ..............'
TIME=`date +%Y-%m-%d-%H-%M-%S`
FILENAME=backup-$TIME.tar.gz
SRCDIR=/data/webroot/zhugexuetang
DESDIR=/data/syncdata/back
cd /data/webroot
#tar -cpzf $FILENAME ./zhugexuetang
#mv $FILENAME $DESDIR/
#rm -f ./$FILENAME
cd /data/syncdata/
#tar -cpzf $DESDIR/$FILENAME  $SRCDIR
echo 'backup file end.'

echo 'rsync web1 start ..........'
echo
rsync -avz  --exclude='.git' --exclude='vendor' /data/syncdata/zhugexuetang/ /data/webroot/zhugexuetang/
rm -rf /data/webroot/zhugexuetang/runtime/*
rm -rf /data/webroot/zhugexuetang/pcweb/web/assets/*
chown www:www -R /data/webroot/zhugexuetang/
echo
echo 'rsync web1 end ..........'

echo
echo 'rsync web2 start ..........'
echo
rsync -avz --exclude='runtime'  --exclude='.git' --exclude='vendor' /data/webroot/zhugexuetang/ www@10.19.117.73:/data/webroot/zhugexuetang/
echo
echo 'rsync web2 end ..........'

echo
echo 'rsync web3 start ..........'
echo
#rsync -avz --exclude='runtime'  --exclude='.git' --exclude='vendor' /data/webroot/zhugexuetang/ www@10.19.95.94:/data/webroot/zhugexuetang/
#rsync -avz --exclude='runtime'  --exclude='.git' --exclude='vendor' /data/webroot/zhugexuetang/ root@10.19.95.94:/data/webroot/zhugexuetang/
echo
echo 'rsync web3 end ..........'

echo
echo 'rsync web4 start ..........'
echo
rsync -avz --exclude='runtime'  --exclude='.git' --exclude='vendor' /data/webroot/zhugexuetang/ www@10.19.124.79:/data/webroot/zhugexuetang/
echo
echo 'rsync web4 end ..........'

echo
echo 'rsync web5 start ..........'
echo
rsync -avz --exclude='runtime'  --exclude='.git' --exclude='vendor' /data/webroot/zhugexuetang/ www@10.19.153.57:/data/webroot/zhugexuetang/
echo
echo 'rsync web5 end ..........'

echo
echo 'rsync web6 start ..........'
echo
rsync -avz --exclude='runtime'  --exclude='.git' --exclude='vendor' /data/webroot/zhugexuetang/ www@10.19.97.187:/data/webroot/zhugexuetang/
echo
echo 'rsync web6 end ..........'
cd -