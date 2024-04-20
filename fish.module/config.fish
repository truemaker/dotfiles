if status is-interactive
  set -g EDITOR nvim
  
  set -g theme tokyonight
  set -g theme_style night
  
  set -g mode_theme tokyonight
  set -g mode_style brackets
  
  set -g prompt_theme green
  set -g prompt_style arrows

  set -g right_theme dimmed
  set -g right_style gittime

  set -g bindings fish_vi_key_bindings
  set -g greeting greeting_arch_btw

  apply_settings

  say_goodbye > /dev/null
end
