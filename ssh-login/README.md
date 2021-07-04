SSH 自动登录脚本
1.赋予脚本可执行权限 `sudo chmod u+x goto.sh goto.ex goline.sh`
2.将 goto 加入当前用户全局使用

		```bash
		➜  ~ echo "alias goto=\"$PWD/goto.sh\"" >> ~/.zshrc
		echo "alias goline=\"$PWD/goline.sh\"" >> ~/.zshrc
		➜  ~ source ~/.zshrc
		➜  ~ goto
		```
