#!/usr/bin/env zsh
ESC="\e["
ESCEND=m
COLOR_OFF=${ESC}${ESCEND}
echoImportant() {
  # 文字色：Yellow
  echo -en "${ESC}33${ESCEND}"
  echo "${@}" | tee -a ${LOG}
  echo -en "${COLOR_OFF}"
}
echoGreen() {
  # 文字色：Red
  echo -en "${ESC}32${ESCEND}"
  echo "${@}" | tee -a ${LOG}
  echo -en "${COLOR_OFF}"
}

wget https://raw.githubusercontent.com/rawdigits/wee-slack/master/wee_slack.py
cp wee_slack.py ~/.weechat/python/autoload
echo hoge >>/dev/null
if [[ $? -eq 0 ]]; then
  echoGreen SETUP WAS DONE.
fi

cat <<HERE|while read line ;do echoImportant $line ;done
/set plugins.var.python.slack_extension.slack_api_token [YOUR_SLACK_TOKEN]
^^ (find this at https://api.slack.com/web)

See : https://github.com/rawdigits/wee-slack
HERE

