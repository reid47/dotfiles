function print_git_info
  set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)

  if test -n "$branch"
    set -l git_status (git status -s)

    if test -n "$git_status"
      set_color red
    else
      set_color normal
    end

    printf ' (%s)' $branch
  end
end

function fish_prompt
  set_color green
  printf '\n%s' (pwd | string replace $HOME "~")

  printf '%s\n' (print_git_info)

  set_color blue
  printf '$ '

  set_color normal
end
