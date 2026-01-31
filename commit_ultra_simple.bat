
@echo off
echo 提交超简配置文件...
cd /d H:\GitHub\openwrt
git add --force .config
git add --force .config.csac.sample
git add target/linux/ath79/image/Makefile
git commit -m "Ultra simple config - remove all problematic packages for 25.12"
echo 提交完成！请执行 git push origin main 推送到GitHub
pause
