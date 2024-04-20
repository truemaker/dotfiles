function apply_settings
  if set -q theme
    if set -q theme_style
      set -l theme_setter (string join "_" -- "theme" $theme $theme_style)
      $theme_setter
    else
      $theme
    end
  end
  if set -q mode_theme
    if set -q mode_style
      set -g mode_prompt (string join "_" -- "prompt_mode" $mode_theme $mode_style)
    else
      set -g mode_prompt (string join "_" -- "prompt_mode" $mode_theme)
    end
  end
  if set -q prompt_theme
    if set -q prompt_style
      set -g prompt (string join "_" -- "prompt" $prompt_theme $prompt_style)
    else
      set -g prompt (string join "_" -- "prompt" $prompt_theme $prompt_style)
    end
  end
  if set -q right_theme
    if set -q right_style
      set -g right_prompt (string join "_" -- "prompt_right" $right_theme $right_style)
    else
      set -g right_prompt (string join "_" -- "prompt_right" $right_theme $right_style)
    end
  end
  if set -q bindings
    $bindings
  end
end
