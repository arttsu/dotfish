fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path -gp "$HOME/.local/bin"
fish_add_path "$HOME/.oly/bin"
fish_add_path "$HOME/Library/Application Support/Coursier/bin"
fish_add_path "$HOME/node_modules/.bin"

. ~/.asdf/plugins/java/set-java-home.fish

direnv hook fish | source

abbr ktp "~/.config/kitty/theme-picker.sh"

abbr mcc "source ~/claude-code-otel-env.sh && command claude"
