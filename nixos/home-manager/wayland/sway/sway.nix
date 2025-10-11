{
  self,
  nixpkgs,
  home-manager,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.sway = let
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/whoisYoges/lwalpapers/PicturesOnly/wallpapers/b-158.jpg";
      hash = "sha256-YNBjewJPtpxlvonnAOC+78X6QT3xFulayhNtq2jtDDA=";
    };
  in {
    enable = true;
    config = rec {
      modifier = "Mod4"; # Super key
      terminal = "alacritty";
      keybindings = lib.mkOptionDefault {
        "${modifier}+d" = "exec ${pkgs.rofi-wayland}/bin/rofi -show drun";
      };
      window = {
        border = 1;
      };
      gaps = {
        inner = 5;
        outer = 7;
      };
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];

      input = {
        "*" = {
          xkb_layout = "es,us";
          xkb_options = "grp:rctrl_toggle";
        };
      };
      output = {
        "*" = {
          bg = "${src} fill";
        };
      };
    };
  };
}
