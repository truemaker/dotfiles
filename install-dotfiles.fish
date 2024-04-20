#!/usr/bin/env fish

function query_yes_no
  while read --nchars 1 -l response --prompt-str=(string join "" -- $argv[1] " (y/n) ")
        or return 1 # if the read was aborted with ctrl-c/ctrl-d
    switch $response
      case y Y
        break
      case n N
        return 1
      case '*'
        echo Not valid input
        continue
    end
  end
end

set -l modules (ls | grep .module)

for module in $modules
  query_yes_no (string join " " -- "Install module (this will remove existing files)" $module)
  or continue
  echo (string join " " -- "Installing module" $module "...")
  set -l dotfiles (find $module -type f -name \*.dotfiles)
  if test (count $dotfiles) -eq 0
    echo "ERROR: No dotfile descriptors for module" $module
    exit 1
  end
  for dotfile_descriptor in $dotfiles
    echo "Processing" $dotfile_descriptor "..."
    while read -la line  
      echo "Linking" $line
      set -l link_info (string split -- ":" $line)
      mkdir -p (echo (path dirname ~/$link_info[2]))
      rm -f (path resolve ~/$link_info[2])
      ln -sf (path resolve $module/$link_info[1]) -T (path resolve ~/$link_info[2])
    end < $dotfile_descriptor
  end
end
