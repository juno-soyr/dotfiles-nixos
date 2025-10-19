{
  ...
}:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        width = 25;
        line-height = 50;
        terminal = "ghostty";
        prompt = "❯   ";
        show-actions = "yes";
        anchor = "left";
      };
      colors = {
        background = "282a36fa";
        selection = "3d4474fa";
        border = "fffffffa";
      };
      border.radius = 5;
    };
  };
}
