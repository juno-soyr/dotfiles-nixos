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
      url = "https://raw.githubusercontent.com/whoisYoges/lwalpapers/refs/heads/PicturesOnly/wallpapers/b-010.jpg";
      hash = "sha256-oUXpV05POhAypQHibL+kQUHN0MT6ny/+meH60YLfkjM=";
    };
  in {
    wrapperFeatures.gtk = true;
    enable = true;
    config = rec {
      modifier = "Mod4"; # Super key
      terminal = "alacritty";
      keybindings = lib.mkOptionDefault {
        "${modifier}+d" = "exec ${pkgs.fuzzel}/bin/fuzzel";
      };

      gaps = {
        inner = 5;
        outer = 7;
      };
      window = {
        titlebar = false;
        border = 0;
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
