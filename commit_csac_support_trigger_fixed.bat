
@echo off
echo 提交CSAC路由器支持到GitHub（修复触发条件）...
cd /d H:\GitHub\openwrt
git add --force target/linux/ath79/dts/csac-router.dts
git add target/linux/ath79/image/Makefile
git add --force .config
git add .config.csac.sample
git add .github/workflows/openwrt-build.yml
git commit -m "Add CSAC Router support - fixed workflow trigger"
echo 提交完成！请执行 git push origin main 推送到GitHub
echo 这次推送会触发编译！
pause
