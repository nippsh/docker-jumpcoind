#!/bin/sh
#Thanks to WlanWerner(https://github.com/WlanWerner)
#install requirements
sudo apt-get update 
sudo apt-get upgrade -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:bitcoin/bitcoin -y
sudo apt-get update

if [[ `lsb_release -rs` == "17.10"  ]] || [[ `lsb_release -rs` == "18.04"  ]] || [[ `lsb_release -rs` == "19.04"  ]] #Check the Version
then

sudo apt-get install unzip nano git build-essential libtool autotools-dev autoconf automake libssl-dev libminiupnpc-dev libqt4-dev libprotobuf-dev protobuf-compiler libqrencode-dev -y
sudo apt-get install git qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools build-essential libdb++-dev libminiupnpc-dev libqrencode-dev -y

sudo apt-get install g++ python-dev autotools-dev libicu-dev libbz2-dev -y
wget -O boost_1_58_0.tar.gz https://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz/download
tar -xvzf boost_1_58_0.tar.gz
cd boost_1_58_0/

./bootstrap.sh --prefix=/usr/local
user_configFile=`find $PWD -name user-config.jam`
echo "using mpi ;" >> $user_configFile
n=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{print $NF}'`
sudo ./b2 --with=all -j $n install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/local.conf'
sudo ldconfig
cd ~
rm -rf boost_1_58_0 
rm -rf boost_1_58_0.tar.gz

else 

sudo apt-get install unzip nano git build-essential libtool autotools-dev autoconf automake libssl-dev libboost-all-dev libdb4.8-dev libdb4.8++-dev libminiupnpc-dev libqt4-dev libprotobuf-dev protobuf-compiler libqrencode-dev -y
sudo apt-get install git qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools build-essential libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-thread-dev libdb++-dev libminiupnpc-dev libqrencode-dev -y

fi

#create folder + get jumpcoind + execute jumpcoind
mkdir /root/.jumpcoin
wget https://github.com/Jumperbillijumper/jumpcoin/releases/download/1/jumpcoind
mv jumpcoind /root/jumpcoind
cd ~
chmod 777 jumpcoind
./jumpcoind
#create .conf
cat >/root/.jumpcoin/jumpcoin.conf << EOF
addnode=62.138.238.45
addnode=93.186.200.171
addnode=93.243.70.137
addnode=159.69.14.216
addnode=185.216.214.17
addnode=159.69.14.216
server=1
rpcuser=$user
rpcpassword=$password
maxconnections=12
EOF
cd ~
rm jumpcoind_install.sh
echo The Wallet is now starting and you wont see anything below, but the Wallet has started. Just close this terminal and open a new one.
#execute jumpcoind
./jumpcoind -daemon

