function say_goodbye --on-event fish_exit
  status is-interactive
  or exit
  echo "Goodbye!"
end
