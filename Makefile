PACKAGE_MANAGER := $(shell command -v apt-get || command -v dnf || command -v pacman || command -v yay)
CONFIG_DIR := $(HOME)/.config
HOME_DIR := $(HOME)
PACKAGES := fuzzel fish kitty tmux fzf fd eza zoxide nerd-fonts

.PHONY: all install links check clean

all: install links

install:
	@if [ -z "$(PACKAGE_MANAGER)" ]; then \
		echo "Error: No supported package manager found (apt, dnf, pacman, or yay)."; \
		exit 1; \
	fi
	@if command -v apt-get > /dev/null; then \
		sudo apt-get update && sudo apt-get install -y $(PACKAGES); \
	elif command -v dnf > /dev/null; then \
		sudo dnf install -y $(PACKAGES); \
	elif command -v pacman > /dev/null; then \
		sudo pacman -S --noconfirm $(PACKAGES); \
	elif command -v yay > /dev/null; then \
		yay -Syu --noconfirm $(PACKAGES); \
	fi

links:
	# Ensure target directories exist
	mkdir -p $(CONFIG_DIR)/fish
	mkdir -p $(CONFIG_DIR)/fuzzel
	mkdir -p $(CONFIG_DIR)/waybar

	# Create symbolic links
	ln -sf $(CURDIR)/etc.d/shell/fishcfg.fish $(CONFIG_DIR)/fish/config.fish
	ln -sf $(CURDIR)/etc.d/shell/alias.fish $(CONFIG_DIR)/fish/alias.fish
	ln -sf $(CURDIR)/etc.d/fuzzel.ini $(CONFIG_DIR)/fuzzel/fuzzel.ini

	ln -sf $(CURDIR)/etc.d/shell/tmux.conf $(HOME_DIR)/.tmux.conf
	ln -sf $(CURDIR)/etc.d/waybar/launcher.sh $(CONFIG_DIR)/waybar/launcher.sh
	ln -sf $(CURDIR)/etc.d/waybar/waybar.jsonc $(CONFIG_DIR)/waybar/config.jsonc
	ln -sf $(CURDIR)/etc.d/waybar/style.css $(CONFIG_DIR)/waybar/style.css

check:
	# Check if packages are installed
	@for pkg in $(PACKAGES); do \
		if ! command -v $$pkg > /dev/null; then \
			echo "Error: $$pkg is not installed."; \
			exit 1; \
		else \
			echo "$$pkg is installed."; \
		fi; \
	done

	# Check symbolic links
	@{ \
		[ -L $(CONFIG_DIR)/fish/config.fish ] && echo "fish config link exists." || echo "fish config link is missing."; \
		[ -L $(CONFIG_DIR)/fuzzel/fuzzel.ini ] && echo "fuzzel config link exists." || echo "fuzzel config link is missing."; \
		[ -L $(CONFIG_DIR)/i3status-rust/config.toml ] && echo "waybar config link exists." || echo "waybar config link is missing."; \
	}

clean:
	rm -f $(CONFIG_DIR)/fish/config.fish
	rm -f $(CONFIG_DIR)/fuzzel/fuzzel.ini
	rm -f $(CONFIG_DIR)/i3status-rust/config.toml

