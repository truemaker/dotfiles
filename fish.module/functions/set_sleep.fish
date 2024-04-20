function set_sleep -d "Turn abillity to suspend on/off"
  switch $argv[1]
    case disable 0 off
      sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
    case enable 1 on
      sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
    case "*"
      set_sleep on
  end
end
