{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        width = 25;
        line-height = 50;
        terminal = "alacritty";
        prompt = "❯   ";
        show-actions = "yes";
      };
      colors = {
        background = "282a36fa";
        selection = "3d4474fa";
        border = "fffffffa";
      };
      border.radius = 20;
    };
  };
}
