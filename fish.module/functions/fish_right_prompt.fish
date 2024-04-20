function fish_right_prompt -d "Write out the right prompt"
  if set -q right_prompt
    $right_prompt
  end
end
