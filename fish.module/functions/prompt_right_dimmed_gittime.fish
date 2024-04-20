function prompt_right_dimmed_gittime -d "A dimmed prompt displaying the time and git status"
  string join '' -- (set_color -d white) (date "+%H:%M") (fish_git_prompt) (set_color normal)
end
