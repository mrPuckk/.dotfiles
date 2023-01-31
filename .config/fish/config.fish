set fish_greeting ""

# exa shortcut
if type -q exa 
	alias ll "exa -l -g --icons"
	alias lla "ll -a"
end 

# set $VARIABLE 
set -gx COLORTERM truecolor
set -gx EDITOR nvim 

set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path yes

# alias
alias nvim lvim
alias ls "ls -p -G -al"
alias la "ls -A"
alias lla "ll -A"

# Start Up the Starship theme
starship init fish | source
