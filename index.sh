
# export MY_SH_FOLDER=/drive_d/work/my_sh

if [ -f "$MY_SH_FOLDER/config.sh" ]; then
  source "$MY_SH_FOLDER/config.sh"
fi

if [ -f "$MY_SH_FOLDER/modules/env.sh" ]; then
  source "$MY_SH_FOLDER/modules/env.sh"
fi

if [ -f "$MY_SH_FOLDER/modules/tools.sh" ]; then
  source "$MY_SH_FOLDER/modules/tools.sh"
fi

if [ -f "$MY_SH_FOLDER/modules/common.sh" ]; then
  source "$MY_SH_FOLDER/modules/common.sh"
fi

if [ -f "$MY_SH_FOLDER/modules/func.sh" ]; then
  source "$MY_SH_FOLDER/modules/func.sh"
fi

if [ -f "$MY_SH_FOLDER/modules/desktop.sh" ]; then
  source "$MY_SH_FOLDER/modules/desktop.sh"
fi

if [ -f "$MY_SH_FOLDER/modules/helpers.sh" ]; then
  source "$MY_SH_FOLDER/modules/helpers.sh"
fi

if [ -f "$MY_SH_FOLDER/modules/aliases.sh" ]; then
  source "$MY_SH_FOLDER/modules/aliases.sh"
fi


bash_history_log

