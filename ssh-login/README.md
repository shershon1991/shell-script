## SSH 自动登录脚本
> 赋予脚本可执行权限 
```sh
sudo chmod u+x goto.sh goto.ex goline.sh
```

> 将goto加入当前用户全局使用
```sh
➜  ~ echo "alias goto=\"$PWD/goto.sh\"" >> ~/.zshrc
echo "alias goline=\"$PWD/goline.sh\"" >> ~/.zshrc
➜  ~ source ~/.zshrc
➜  ~ goto
```
