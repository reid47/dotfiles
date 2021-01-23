function print_git_info
  set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)

  if test -n "$branch"
    set -l git_status (git status -s)

    if test -n "$git_status"
      set_color yellow
    else
      set_color normal
    end

    printf ' (%s)' $branch
  end
end

function fish_prompt
  set -l previous_exit_code $status

  set_color green
  printf '\n%s' (pwd | string replace $HOME "~")

  printf '%s' (print_git_info)

  if test $previous_exit_code -ne 0
    set_color red
    printf ' (exited %s)' $previous_exit_code
  end

  set_color blue
  printf '\n$ '

  set_color normal
end
