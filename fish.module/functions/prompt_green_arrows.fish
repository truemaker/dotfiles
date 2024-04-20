function prompt_green_arrows -d "The green arrows prompt"
  set -l last_status $status
  set -l stat
  if test $last_status -ne 0
    set stat (set_color red) 'x'
  else
    set stat (set_color green) '>'
  end
  string join '' -- (set_color green) (prompt_pwd --full-length-dirs 2) $stat (set_color green) '> ' (set_color normal)
end
