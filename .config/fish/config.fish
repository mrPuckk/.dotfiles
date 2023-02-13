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

function fzflash
  set home_dir "/Users/tuongphung"
  set file_name "$argv[1]"

  set selected_path (find $home_dir -mindepth 0 \( -path "$home_dir'/\'" -o -fstype sysfs -o -fstype devfs -o -fstype devtmpfs \) -prune \
    -o \( -type f -print -o -type d -print -o -type l -print \) 2> /dev/null | fzf)

  if [ -n "$selected_path" ]
    if test -d "$selected_path"
      set -gx FZF_TMP_DIR "$selected_path"
      cd $FZF_TMP_DIR;
    else
      set -gx FZF_TMP_DIR (dirname $selected_path)
      cd $FZF_TMP_DIR;
      echo $selected_path
    end
  end
end

function fs -d "Switch tmux session"
  tmux list-sessions -F "#{session_name}" | fzf | read -l result; and tmux switch-client -t "$result"
end


# Start Up the Starship theme
# zoxide init fish | source
starship init fish | source
