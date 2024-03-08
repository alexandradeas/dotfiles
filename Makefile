.PHONY: link
link:
	stow . -t ~/.config

.PHONY: theme
theme:
	./Colloid-gtk-theme/install.sh
	./Colloid-icon-theme/install.sh

