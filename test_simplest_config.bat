
@echo off
echo 测试最简单的配置...
cd /d H:\GitHub\openwrt
copy .config.test .config
git add --force .config
git commit -m "Test simplest config - device only, no packages"
echo 提交完成！请执行 git push origin main 进行测试
pause
