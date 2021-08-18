EDITOR="alacritty -e nvim"

declare -a options=(

"alacritty   - $HOME/.config/alacritty/alacritty.yml"
"nvim        - $HOME/.config/nvim/init.vim"
"xmonad      - $HOME/.xmonad/xmonad.hs"
"xmobar      - $HOME/.config/xmobar/xmobarrc"
"xmobar-alt  - $HOME/.config/xmobar/xmobarrc0"
"zsh         - $HOME/.zshrc"
"dmenu edit config script - $HOME/.config/dmenu-scripts/dmenu-conf.sh"
"quit"

)

choice=$(printf '%s\n' "${options[@]}" | dmenu -c -i -l 15 -p 'Edit config: ')

if [[ "$choice" == quit ]]; then
	echo "Program terminated" && exit 1

elif [ "$choice" ]; then
	cfg=$(printf '%s\n' "${choice}" | awk '{print $NF}')
	$EDITOR "$cfg"

else
	echo "Program terminated" && exit 1
fi
