for i in `echo "list clients" | bconsole |grep '|'|cut -d "|" -f3|grep -v Name`
do
echo "status client=$i" | bconsole |grep $i |grep Full |tail -n 1
echo "status client=$i" | bconsole |grep $i |grep Diff |tail -n 1
done
