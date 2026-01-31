
@echo off
echo 提交CSAC路由器支持到GitHub（包含.config）...
cd /d H:\GitHub\openwrt
git add --force target/linux/ath79/dts/csac-router.dts
git add target/linux/ath79/image/Makefile
git add --force .config
git add .config.csac.sample
git add .github/workflows/openwrt-build.yml
git commit -m "Add CSAC Router support (QCA9563+QCA8337+QCA9886, 128MB+16MB) - fixed config tracking"
echo 提交完成！请执行 git push origin main 推送到GitHub
pause
