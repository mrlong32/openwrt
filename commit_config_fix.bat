
@echo off
echo 提交修复后的配置文件...
cd /d H:\GitHub\openwrt
git add --force .config
git add --force .config.csac.sample
git commit -m "Fix config packages - remove incompatible packages for 25.12"
echo 提交完成！请执行 git push origin main 推送到GitHub
pause
