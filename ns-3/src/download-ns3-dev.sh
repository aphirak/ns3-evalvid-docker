#!/bin/sh
ROOTDIR=/home/ns3


cd ${ROOTDIR}
#download  evalvid ns3 module
git clone https://gitlab.com/gercom/evalvid-ns3

#git clone https://gitlab.com/nsnam/ns-3-allinone
git clone https://gitlab.com/nsnam/ns-3-allinone.git/

cd ns-3-allinone
./download.py

cd ns-3-dev/src/
cp -R ${ROOTDIR}/evalvid-ns3 .
mv evalvid-ns3 evalvid
#./build.py --enable-examples --enable-tests