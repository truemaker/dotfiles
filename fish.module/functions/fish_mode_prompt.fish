function fish_mode_prompt -d "Write out the mode prompt"
  if set -q mode_prompt
    $mode_prompt
  end
end
