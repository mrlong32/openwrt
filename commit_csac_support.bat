
@echo off
echo 提交CSAC路由器支持到GitHub...
cd /d H:\GitHub\openwrt
git add target/linux/ath79/dts/csac-router.dts
git add target/linux/ath79/image/Makefile
git add .config
git add .github/workflows/openwrt-build.yml
git commit -m "Add CSAC Router support (QCA9563+QCA8337+QCA9886, 128MB+16MB)"
echo 提交完成！请执行 git push origin main 推送到GitHub
pause
