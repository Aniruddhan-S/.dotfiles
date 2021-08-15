EDITOR="alacritty -e nvim"

declare -a options=(

"alacritty  - $HOME/.config/alacritty/alacritty.yml"
"xmonad     - $HOME/.xmonad/xmonad.hs"
"xmobar     - $HOME/.config/xmobar/xmobarrc"
"nvim       - $HOME/.config/nvim/init.vim"
"zsh        - $HOME/.zshrc"

)

choice=$(printf '%s\n' "${options[@]}" | dmenu -c -i -l 20 -p 'Edit config: ')

if [[ "$choice" == quit ]]; then
	echo "Program terminated" && exit 1

elif [ "$choice" ]; then
	cfg=$(printf '%s\n' "${choice}" | awk '{print $NF}')
	$EDITOR "$cfg"

else
	echo "Program terminated" && exit 1
fi
