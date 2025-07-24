source ~/.config/fish/local.fish

if status is-interactive
    set fish_greeting ''

    # Vterm
    # =====
    function vterm_printf;
        if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end
            # tell tmux to pass the escape sequences through
            printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
        else if string match -q -- "screen*" "$TERM"
            # GNU screen (screen, screen-256color, screen-256color-bce)
            printf "\eP\e]%s\007\e\\" "$argv"
        else
            printf "\e]%s\e\\" "$argv"
        end
    end

    if [ "$INSIDE_EMACS" = 'vterm' ]
	function clear
            vterm_printf "51;Evterm-clear-scrollback";
            tput clear;
	end
    end

    function vterm_prompt_end;
	vterm_printf '51;A'(whoami)'@'(hostname)':'(pwd)
    end

    if not type -q vterm_old_fish_prompt
        functions --copy fish_prompt vterm_old_fish_prompt
    end

    function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
	# Remove the trailing newline from the original prompt. This is done
	# using the string builtin from fish, but to make sure any escape codes
	# are correctly interpreted, use %b for printf.
	printf "%b" (string join "\n" (vterm_old_fish_prompt))
	vterm_prompt_end
    end
end

# Path
# ====
fish_add_path ~/bin

abbr pipi "pip install"
abbr pipr "pip install -r requirements.txt"
abbr pipd "pip uninstall"
abbr pipf "pip freeze > requirements.txt"
abbr pipl "pip list"

abbr dira "direnv allow"

abbr d "docker"
abbr db "docker build"
abbr dp "docker push"
abbr dcb "docker-compose build"
abbr dcu "docker-compose up"
abbr dcud "docker-compose up -d"
abbr dcd "docker-compose down"
abbr dcdv "docker-compose down -v"

zoxide init fish --cmd j | source
