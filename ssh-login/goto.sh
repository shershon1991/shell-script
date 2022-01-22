#!/bin/bash

# 服务器列表文件
BASE_PATH=$(
  cd "$(dirname "$0")"
  pwd
)
FILE_SERVER_LIST=$BASE_PATH"/goto.conf"

# 暂存服务器列表，用于登录操作
CONFIG_ARR=()

# 记录默认分隔符，用于修改后的还原
IFS_OLD=$IFS

# 初始化
function menu {
  # 检查配置文件
  if [ ! -f $FILE_SERVER_LIST ]; then
    echo "Config file not found."
    exit 1
  fi

  # 读取配置文件，显示待操作服务器列表
  clear
  echo "-------------------------------------"
  local serverNum=1 # 服务器列表索引
  local config=()
  local MENUS=""
  while read line || [ -n "$line" ]; do
    if [[ ${line} != \#* && "$line" != "" ]]; then
      IFS=, # 定义读取配置文件时的分隔符
      config=($line)
      CONFIG_ARR[$serverNum]=$line

      # 计算空格数，使 IP 占用固定的最大长度，以美化菜单
      spacenum=$(expr 16 - ${#config[2]})
      spaces=$(seq -s ' ' $spacenum | sed 's/[0-9]//g')

      # 拼接菜单中的一行服务器信息
      MENUS=$MENUS" \033[41m${config[5]}\033[0m ${config[2]}$spaces- \033[32m$serverNum\033[0m.${config[0]} \n"

      # 累加服务器索引，直到配置文件读取完毕
      serverNum=$(($serverNum + 1))
    fi
  done <$FILE_SERVER_LIST
  echo -en $MENUS
  IFS=$IFS_OLD
  echo "-------------------------------------"
  echo -en "请输入\033[32m序号\033[0m选择要登录的服务器: "
  handleChoice
}

# 处理用户输入
function handleChoice {
  read -n 2 choice
  local serverListLength=${#CONFIG_ARR[@]}
  if [[ "$choice" -lt 1 || "$choice" -gt serverListLength ]]; then
    echo -en "\n\033[31m无效的序号[ $choice ], 是否重新输入( y 是 | n 否 ):\033[0m"
    read -n 1 retry
    if [[ -n "$retry" && "$retry" = "y" ]]; then
      clear
      menu
    else
      echo ""
      exit 1
    fi
  else
    sshLogin $choice
  fi
}

# 执行 ssh 登录
function sshLogin {

  IFS=, # 定义读取分隔符
  local config=(${CONFIG_ARR[$1]})

  # 默认用户 root
  local user=${config[1]}
  if [[ $user == "" ]]; then
    user="root"
  fi

  # 默认端口号 22
  local port=${config[3]}
  if [[ $port == "" ]]; then
    port="22"
  fi

  # 开始登录
  echo -e "\n\n\033[32m==>\033[0m 正在登录【\033[32m${config[0]}\033[0m】，请稍等...\n"
  sleep 1
  $(which expect) $BASE_PATH/goto.ex ${config[0]} ${config[2]} $port $user ${config[4]}
  echo -e "\n\033[32m==>\033[0m 您已退出【\033[32m${config[0]}\033[0m】\n"
}

# 执行初始化
menu
