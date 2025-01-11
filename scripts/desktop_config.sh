#!/bin/sh

# If XDG_CONFIG_HOME is not defined, set to $HOME/.config.
if [ -z "${XDG_CONFIG_HOME}" ]; then
  XDG_CONFIG_HOME="$HOME/.config"
fi

is_exist_org () {
  if [ ! -e $1 ]; then
    echo "Not found original $1. Aborted."
    exit 1
  fi
}

### Alacritty ###
install_alacritty_config () {
  echo "Install config for alacritty"
  org=$(realpath ../alacritty)
  is_exist_org ${org}

  # If $XDG_CONFIG_HOME/alacritty has already exist and is a symbolic link,
  # skip the procedure.
  if [ -L "${XDG_CONFIG_HOME}/alacritty" ]; then
    if [ -e "${XDG_CONFIG_HOME}/alacritty" ]; then
      echo "Config for alacritty has already been done. Skip"
      return 0
    else
      return $(ln -s ${org} "${XDG_CONFIG_HOME}/alacritty")
    fi
  elif [ -e "${XDG_CONFIG_HOME}/alacritty" ]; then
    rm -rf "${XDG_CONFIG_HOME}/alacritty"
    return $(ln -s ${org} "${XDG_CONFIG_HOME}/alacritty")
  else
    return $(ln -s ${org} "${XDG_CONFIG_HOME}/alacritty")
  fi
}

### tmux ###
install_tmux_config () {
  echo "Install config for tmux"
  org=$(realpath ../.tmux.conf)
  is_exist_org ${org}
  ln -si ${org} $HOME/.tmux.conf
}

### conky ###
install_conky_config () {
  echo "Install config for conky"
  org_conf=$(realpath ../conky/conky.conf)
  org_desktop=$(realpath ../conky/conky.desktop)
  is_exist_org ${org_conf}
  is_exist_org ${org_desktop}

  if [ ! -e "${XDG_CONFIG_HOME}/conky" ]; then
    mkdir "${XDG_CONFIG_HOME}/conky"  
  fi

  ln -si ${org_conf} "${XDG_CONFIG_HOME}/conky/conky.conf"   

  # autostart
  if [ ! -e "${XDG_CONFIG_HOME}/autostart" ]; then
    mkdir "${XDG_CONFIG_HOME}/autostart"  
  fi

  ln -si ${org_desktop} "${XDG_CONFIG_HOME}/autostart/conky.desktop"   

  return 0
}

### NeoVim ###
install_nvim_config () {
  echo "Install config for NeoVim"
  org=$(realpath ../nvim)
  is_exist_org ${org}

  # If $XDG_CONFIG_HOME/nvim has already exist and is a symbolic link,
  # skip the procedure.
  if [ -L "${XDG_CONFIG_HOME}/nvim" ]; then
    if [ -e "${XDG_CONFIG_HOME}/nvim" ]; then
      echo "Config for NeoVim has already been done. Skip"
      return 0
    else
      return $(ln -s ${org} "${XDG_CONFIG_HOME}/nvim")
    fi
  elif [ -e "${XDG_CONFIG_HOME}/nvim" ]; then
    rm -rf "${XDG_CONFIG_HOME}/nvim"
    return $(ln -s ${org} "${XDG_CONFIG_HOME}/nvim")
  else
    return $(ln -s ${org} "${XDG_CONFIG_HOME}/nvim")
  fi
}

install_alacritty_config
install_tmux_config
install_conky_config
install_nvim_config
