#!/bin/bash
echo "=== CSAC配置验证脚本 ==="
echo ""
echo "1. 检查Makefile中的CSAC设备定义:"
grep -n "csac-router" target/linux/ath79/image/Makefile
echo ""
echo "2. 检查设备树文件:"
ls -la target/linux/ath79/dts/*csac* 2>/dev/null || echo "未找到CSAC设备树文件"
echo ""
echo "3. 检查.config.csac.sample配置:"
grep -E "(csac|carambola)" .config.csac.sample
echo ""
echo "4. 检查当前配置:"
if [ -f .config ]; then
    echo "=== .config中的CSAC配置 ==="
    grep -i csac .config
    echo ""
    echo "=== .config中的carambola配置 ==="
    grep -i carambola .config
else
    echo ".config文件不存在"
fi
echo ""
echo "5. 检查设备支持:"
echo "=== 支持的设备列表 ==="
make info 2>/dev/null | grep -i csac || echo "未找到CSAC设备信息"
