#!/bin/bash
echo "=========================================="
echo "  终极强制编译 CSAC 固件脚本"
echo "=========================================="
# 清理旧配置
rm -f .config .config.old
# 使用CSAC配置
echo "1. 使用CSAC配置..."
cp .config.csac.sample .config
# 强制设置CSAC设备（确保不会被覆盖）
echo "2. 强制设置CSAC设备..."
sed -i '/CONFIG_TARGET_DEVICE_ath79_generic_8dev_carambola2/d' .config
sed -i '/CONFIG_TARGET_DEVICE_ath79_generic_.*=/d' .config
echo "CONFIG_TARGET_DEVICE_ath79_generic_csac_router=y" >> .config
echo "CONFIG_TARGET_PROFILE=DEVICE_csac-router" >> .config
# 禁用所有其他设备
echo "3. 禁用所有其他设备..."
for device in $(grep -h "define Device/" target/linux/ath79/image/Makefile | grep -v csac-router | cut -d'/' -f2 | cut -d' ' -f1); do
    echo "# CONFIG_TARGET_DEVICE_ath79_generic_${device}=y" >> .config
done
# 验证配置
echo "4. 验证配置..."
echo "=== 当前配置中的CSAC设备 ==="
grep -i "csac" .config
echo ""
echo "=== 当前配置中的carambola设备 ==="
grep -i "carambola" .config
echo ""
# 编译
echo "5. 开始编译..."
make defconfig
echo "=== make defconfig 输出 ==="
make defconfig 2>&1 | grep -E "(Selected device|Building for|csac|carambola)"
echo ""
# 下载源码
echo "6. 下载源码..."
make download -j$(nproc) || make download -j1
# 编译固件
echo "7. 编译固件..."
make -j$(nproc) V=s 2>&1 | tee build.log | grep -E "(Building for|openwrt-.*\.bin|Error|Warning)"
# 显示结果
echo "8. 显示结果..."
echo "=== 生成的固件文件 ==="
find bin/targets -name "*.bin" -type f | grep -i csac || find bin/targets -name "*.bin" -type f | head -10
echo "=========================================="
echo "  编译完成！"
echo "=========================================="
