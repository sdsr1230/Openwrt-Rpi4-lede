#!/bin/bash

mkdir package/community
pushd package/community
git clone --depth=1 https://github.com/fw876/helloworld
git clone --depth=1 https://github.com/rufengsuixing/luci-app-adguardhome
git clone --depth=1 https://github.com/lisaac/luci-app-diskman
mkdir parted
cp luci-app-diskman/Parted.Makefile parted/Makefile
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/subconverter
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/jpcre2
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/rapidjson
popd

sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
