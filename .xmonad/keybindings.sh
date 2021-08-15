sed -n '/START_KEYS/,/END_KEYS/p' ~/.xmonad/xmonad.hs \
	| grep -e '\-\- ' -e '\-\-\-' \
	| grep -v '\-\- , (' \
	| sed -e 's/^[ \t]*/ /' -e 's/-- //' -e 's/ - /\t- /' \
	| yad --text-info --back=#2D2A2E --fore=#FCFCFA --geometry=1200x800
