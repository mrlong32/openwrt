# 手动强制编译CSAC路由器固件指南
## 问题分析
之前的编译失败是因为：
1. `make defconfig` 覆盖了我们的CSAC配置
2. 编译系统默认选择了 `8dev_carambola2` 设备
3. 配置优先级问题导致CSAC配置被忽略
## 解决方案
使用强制编译脚本绕过OpenWrt的自动设备选择机制。
### 方法1: 使用GitHub Actions
1. 提交 `force_csac_build.sh` 和 `.github/workflows/force-csac-build.yml` 到仓库
2. 在GitHub Actions页面找到 "Force Build CSAC Router" 工作流
3. 点击 "Run workflow"
4. 等待编译完成
### 方法2: 本地手动编译
```bash
# 进入仓库目录
cd /path/to/openwrt
# 运行强制编译脚本
chmod +x force_csac_build.sh
./force_csac_build.sh
# 检查生成的固件
ls -la bin/targets/ath79/generic/
```
## 脚本原理
1. **直接写入.config文件**：绕过.config.csac.sample
2. **锁定配置**：创建.config.locked防止被覆盖
3. **强制CSAC设备**：只启用CSAC设备，禁用其他所有设备
4. **验证配置**：确保配置正确应用
## 预期结果
应该生成以下固件文件：
- `openwrt-ath79-generic-csac-router-squashfs-sysupgrade.bin`
- `openwrt-ath79-generic-csac-router-squashfs-factory.bin`
- `openwrt-ath79-generic-csac-router.manifest`
## 故障排除
如果仍然失败：
1. 检查CSAC设备定义是否完整
2. 检查设备树文件是否存在
3. 查看编译日志中的错误信息
