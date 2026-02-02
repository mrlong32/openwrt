# CSAC路由器编译指南
## 问题描述
CSAC路由器（QCA9563+QCA8337+QCA9886）在官方OpenWrt 25.12分支中编译时，系统总是选择8dev_carambola2设备，而不是CSAC设备。
## 解决方案
已创建以下文件来强制编译CSAC固件：
### 1. 强制编译脚本
- `force_csac_build.sh` - 终极强制编译脚本，确保编译系统选择CSAC设备
### 2. GitHub Actions工作流
- `.github/workflows/force-csac-build.yml` - GitHub云编译工作流
### 3. 验证脚本
- `verify_csac_config.sh` - 验证配置是否正确
### 4. 修复的文件
- `target/linux/ath79/image/Makefile` - 修复了CSAC设备定义
- `target/linux/ath79/dts/csac-router.dts` - 修复了设备树文件
- `.config.csac.sample` - 修复了配置文件
## 使用方法
### 本地编译
```bash
# 运行强制编译脚本
./force_csac_build.sh
```
### GitHub云编译
1. 登录GitHub仓库 `mrlong32/openwrt`
2. 进入 "Actions" 页面
3. 找到 "Force Build CSAC Router" 工作流
4. 点击 "Run workflow" → "Run workflow"
5. 等待编译完成（大约1-2小时）
6. 下载生成的固件
## 验证配置
```bash
./verify_csac_config.sh
```
## 关键修复
1. **Makefile修复**: 确保CSAC设备定义完整
2. **设备树修复**: 添加QCA8337和QCA9886配置
3. **配置修复**: 强制设置CSAC设备，禁用carambola设备
4. **编译脚本**: 强制编译系统选择CSAC设备
## 硬件配置
- CPU: QCA9563 (MIPS 74Kc)
- 交换芯片: QCA8337 (千兆)
- 无线芯片: QCA9886 (802.11ac Wave2)
- 内存: 128MB
- 闪存: 16MB
