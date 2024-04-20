function fish_prompt -d "Write out the prompt"
  if set -q prompt
    $prompt
  else
    echo "> "
  end
end
