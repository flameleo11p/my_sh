
if [ -f ./modules/config.sh ]; then
  . ./modules/config.sh
fi

if [ -f ./modules/env.sh ]; then
  . ./modules/env.sh
fi

if [ -f ./modules/tools.sh ]; then
  . ./modules/tools.sh
fi

if [ -f ./modules/common.sh ]; then
  . ./modules/common.sh
fi

if [ -f ./modules/func.sh ]; then
  . ./modules/func.sh
fi

# if [ -f ./modules/desktop.sh ]; then
#   . ./modules/desktop.sh
# fi

if [ -f ./modules/helpers.sh ]; then
  . ./modules/helpers.sh
fi

if [ -f ./modules/aliases.sh ]; then
  . ./modules/aliases.sh
fi

bash_history_log

