#!/bin/bash
# 强制编译CSAC路由器固件脚本
echo "=== 强制编译CSAC路由器固件 ==="
# 1. 清理环境
make clean
# 2. 创建强制CSAC配置
cat > .config << 'EOF'
# 强制CSAC路由器配置
CONFIG_TARGET_ath79=y
CONFIG_TARGET_ath79_generic=y
CONFIG_TARGET_ath79_generic_DEVICE_csac_router=y
CONFIG_TARGET_DEVICE_ath79_generic_csac_router=y
CONFIG_TARGET_PROFILE=DEVICE_csac_router
# 禁用所有其他设备
# CONFIG_TARGET_ath79_generic_DEVICE_generic=y
# CONFIG_TARGET_ath79_generic_DEVICE_8dev_carambola2=y
EOF
echo "✅ 创建强制CSAC配置"
# 3. 验证配置
echo "=== 验证配置 ==="
grep -i "csac" .config
grep "CONFIG_TARGET_DEVICE" .config
grep "CONFIG_TARGET_PROFILE" .config
# 4. 锁定配置，防止defconfig覆盖
cp .config .config.locked
# 5. 编译
echo "=== 开始编译 ==="
make defconfig
# 6. 强制恢复CSAC配置
cp .config.locked .config
# 7. 下载依赖
make download -j$(nproc)
# 8. 编译固件
echo -e "$(nproc) thread compile"
make -j$(nproc) || make -j1 V=s
echo "=== 编译完成 ==="
# 9. 检查生成的固件
echo "=== 检查生成的固件 ==="
ls -la bin/targets/ath79/generic/*csac* 2>/dev/null || echo "⚠️  未找到CSAC固件"
ls -la bin/targets/ath79/generic/*.bin 2>/dev/null || echo "⚠️  未找到任何固件"
