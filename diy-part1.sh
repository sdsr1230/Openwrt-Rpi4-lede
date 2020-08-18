#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Clone Lean's latest sources.
pushd package
git clone --depth=1 https://github.com/coolsnowwolf/lede
popd

# Copy Lean's packages to ./package/lean.
mkdir package/lean
pushd package/lede/package/lean
cp -r {adbyby,automount,luci-app-adbyby-plus,luci-app-autoreboot,luci-app-cpufreq,luci-app-filetransfer,luci-lib-fs,microsocks,n2n_v2,npc,pdnsd-alt,redsocks2,luci-app-netdata,proxychains-ng,shadowsocksr-libev,tcpping,v2ray,v2ray-plugin} "../../../lean"
popd

# Add luci-app-ssr-plus
git clone --depth=1 https://github.com/fw876/helloworld
popd

# Clean Lean's code
pushd package
rm -rf lede
popd

# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add Lienol's Packages
git clone --depth=1 https://github.com/Lienol/openwrt-package
rm -rf openwrt-package/lienol/luci-app-ssr-python-pro-server

# Add luci-app-onliner. (need luci-app-nlbwmon)
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# Add luci-app-adguardhome.
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-adguardhome
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/AdGuardHome

# Add luci-app-diskman.
git clone --depth=1 https://github.com/lisaac/luci-app-diskman
mkdir parted
cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon

# Add udptools
git clone --depth=1 https://github.com/bao3/openwrt-udp2raw
git clone --depth=1 https://github.com/bao3/openwrt-udpspeeder
git clone --depth=1 https://github.com/bao3/luci-udptools

# luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-lib-docker

# Add tmate
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/tmate
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/msgpack-c

# Add gotop
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gotop

# Subscribe converters
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/subconverter
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/jpcre2
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/rapidjson
popd

# Enable irqbalance
sed -i 's/0/1/g' feeds/packages/utils/irqbalance/files/irqbalance.config

# Max connections
sed -i 's/16384/65536/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# Change dnsmasq to dnsmasq-full
sed -i 's/dnsmasq i/dnsmasq-full i/g' include/target.mk

# Convert Translation
cp ../scripts/convert-translation.sh .
chmod +x ./convert-translation.sh
./convert-translation.sh || true

# Convert Translation
cp ../scripts/convert-translation.sh .
chmod +x ./convert-translation.sh
./convert-translation.sh || true

# Remove upx
cp ../scripts/remove-upx.sh .
chmod +x ./remove-upx.sh
./remove-upx.sh || true
