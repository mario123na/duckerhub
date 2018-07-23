apt-get update
apt-get -y install fail2ban software-properties-common
apt-get install nano vim -y
apt-get install build-essential libevent-dev libssl-dev -y
ippublic=$(ifconfig | grep inet | awk {'print $2'} | head -1)
cd /etc/
wget http://3proxy.ru/0.7.1.1/3proxy-0.7.1.1.tgz
tar -xvzf 3proxy-0.7.1.1.tgz
rm 3proxy-0.7.1.1.tgz
cd 3proxy/src/
cp proxy.h  /home/
sed "29i\ #define ANONYMOUS 1 \n" proxy.h  > proxy.h.new
cat proxy.h.new  | tr -d "\r" > archivo.tmp
mv archivo.tmp proxy.h
rm proxy.h.new 
cd ..
make -f Makefile.Linux
make -f Makefile.Linux install
mkdir log
cd cfg/
wget https://gettraffic.pro/docs/3proxy.cfg
sed "2i\ ippublic=$(ifconfig | grep inet | awk {'print $2'} | head -1) \n" 3proxy.cfg  > 3proxy.cfg.new
cat 3proxy.cfg.new  | tr -d "\r" > archivo.tmp
cat archivo.tmp > 3proxy.cfg
sed -i "s/000.000.000.000/$ippublic/g" 3proxy.cfg
sed -i "29,30d" 3proxy.cfg
chmod 0777 3proxy.cfg
cd ..
cd scripts/rc.d/
rm proxy.sh
wget https://raw.githubusercontent.com/mario123na/duckerhub/bash/proxy.sh
sh proxy.sh start
netstat -tulpan