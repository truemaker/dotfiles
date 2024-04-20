function switch_wallpaper -d "Set new wallpaper"
  test (count $argv) -eq 1
  or return 1
  swww img -t center -- $argv[1]
end
