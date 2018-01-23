 printf "Nameserver-Backup \n"

path=/backup1/criticalserverbackup/nsbackup

for i in `ls $path |sort`
do
cd $path/$i
file=$(ls -Art | tail -n 1)
size=$(du -sh $file)
echo $i$'\t'$size
done


printf  "\n\nCP-Server-Backup \n"
path=/backup1/criticalserverbackup/hsphere


for i in  cp1 cp1/DB cp2 cp2/DB
do
cd $path/$i
file=$(ls -Art |grep -v DB| tail -n 1)
size=$(du -sh $file)
echo $i$'\t'$size
done

printf  "\n\nDatabase-Backup \n\n"
cd /backup1/dbbak
for i in `ls |sort|grep -v cpdbhosting`
do
#d=$(find $i -name daily_*_*_2017*sql.gz -print -quit | cut -d'/' -f5|cut -d'_' -f4)
d=$(find $i -name *sql.gz -exec stat -c "%y %n" {} + | sort -r | head -n 1|cut -d" " -f1)
echo $i$'\t'$d
done

printf  "\n\nVPS-Backup \n\n"
path=/backup6/vpsbackup

for i in `ssh root@202.53.73.150 -p5040 vzlist -o ctid |grep -v CTID`
do
cd $path/
file=$(ls -Art |grep $i| tail -n 1)
size=$(du -sh $file)
dt=$(stat --printf='%x' $file |cut -d " " -f1)
echo $i$'\t'$size$'\t'$dt
done

printf  "\n\nCPanel-Server-Backup \n"
path=/backup2/cpanelbak/

for i in  cpdbhosting hdcp001 hdcp002 hdcp003 hdcp004
do
cd $path/$i/weekly
file=$(ls -Art |grep -v DB| tail -n 1)
size=$(du -sh $file)
echo $i$'\t'$size
done
