function pkg -d "Packaging wrapper"
  if test (count $argv) -eq 0
    echo "Supported subcommands:"
    echo "- install"
    echo "- remove"
    echo "- list (if supported)"
    echo "- orphans (if supported)"
    echo "- search (if supported)"
    return
  end
  if which paru > /dev/null
    _pkg_handle_args_w_search paru _pkg_generic_pacman_like $argv
    or return 1
  else if which yay > /dev/null
    _pkg_handle_args_w_search yay _pkg_generic_pacman_like $argv
    or return 1
  else if which pacman > /dev/null
    _pkg_pacman_args_w_search pacman _pkg_generic_pacman_like $argv
    or return 1
  end
end

function _pkg_generic_pacman_like_install
  if test (count $argv) -gt 1
    $argv[1] -S $argv[2..(count $argv)]
  else
    echo "Please specify a package"
    return 1
  end
end

function _pkg_generic_pacman_like_remove
  if test (count $argv) -gt 1
  $argv[1] -R $argv[2..(count $argv)]
else
    echo "Please specify a package"
    return 1
  end

end

function _pkg_generic_pacman_like_list
  if test (count $argv) -gt 1
    $argv[1] -Q $argv[2..(count $argv)]
  else
    $argv[1] -Q
  end
end

function _pkg_generic_pacman_like_orphans
  $argv[1] -Qdtq
end

function _pkg_generic_pacman_like_upgrade
  $argv[1] -Syu
end

function _pkg_generic_apt_like_install
  if test (count $argv) -gt 1
    $argv[1] install $argv[2..(count $argv)]
  else
    echo "Please specify a package"
    return 1
  end
end

function _pkg_generic_apt_like_remove
  if test (count $argv) -gt 1
    $argv[1] remove $argv[2..(count $argv)]
  else
    echo "Please specify a package"
    return 1
  end
end


function _pkg_handle_args_w_search
  set -l cmd
  set -l pkgs
  if test (count $argv) -gt 4
    set pkgs $argv[4..(count $argv)]
  else
    set pkgs $argv[4]
  end
  switch $argv[3]
    case install
      set cmd (string join "_" -- $argv[2] "install") $argv[1] $pkgs
    case remove
      set cmd (string join "_" -- $argv[2] "remove") $argv[1] $pkgs
    case list
      set cmd (string join "_" -- $argv[2] "list") $argv[1] $pkgs
    case orphans
      set cmd (string join "_" -- $argv[2] "orphans") $argv[1]
    case search
      $argv[1] $pkgs
      return 0
    case upgrade
      set cmd (string join "_" -- $argv[2] "upgrade") $argv[1]
    case "*"
      echo "Invalid command:" $argv[3]
      return 1
  end
  $cmd
  or return 1
end
