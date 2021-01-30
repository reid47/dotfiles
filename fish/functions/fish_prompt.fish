function __print_git_info
  set -l branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)

  if test -n "$branch"
    set -l git_status (git status -s)
    set -l git_counts (git rev-list --left-right --count $branch...origin/$branch || '')
    set -l formatted_counts (echo $git_counts | awk '{ print ($1 == "0" ? "" : " +"$1) ($2 == "0" ? "" : " -"$2) }')

    if test -n "$git_status"
      set_color yellow
    else
      set_color normal
    end

    printf ' (%s%s)' $branch $formatted_counts
  end
end

function fish_prompt
  set -l previous_exit_code $status

  set_color green
  printf '\n%s' (pwd | string replace $HOME "~")

  printf '%s' (__print_git_info)

  if test $previous_exit_code -ne 0
    set_color red
    printf ' (%s)' $previous_exit_code
  end

  set_color blue
  printf '\n$ '

  set_color normal
end
