{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-bottom = -10;
        spacing = 0;

        modules-left = ["sway/workspaces" "cpu"];
        modules-center = ["clock"];
        modules-right = [
          "network"
          "pulseaudio"
          "battery"
          "memory"
          "backlight"
          "custom/lock"
        ];

        "niri/workspaces" = {
          disable-scroll = false;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
        };

        clock = {
          timezone = "Europe/Warsaw";
          tooltip = false;
          format = "{:%H:%M:%S  -  %A, %d}";
          interval = 1;
        };

        network = {
          format-wifi = "󰤢";
          format-ethernet = "󰈀 ";
          format-disconnected = "󰤠 ";
          interval = 5;
          tooltip-format = "{essid} ({signalStrength}%)";
        };

        cpu = {
          interval = 1;
          format = "  {icon0}{icon1}{icon2}{icon3} {usage:>2}%";
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          on-click = "ghostty -e htop";
        };

        memory = {
          interval = 30;
          format = "  {used:0.1f}G/{total:0.1f}G";
          tooltip-format = "Memory";
        };

        backlight = {
          format = "{icon}  {percent}%";
          format-icons = ["" "󰃜" "󰃛" "󰃞" "󰃝" "󰃟" "󰃠"];
          tooltip = false;
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "";
          format-icons.default = ["" "" " "];
          on-click = "pavucontrol";
        };

        battery = {
          interval = 2;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-full = "{icon}  {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = ["" "" "" "" ""];
        };

        "custom/lock" = {
          tooltip = false;
          on-click = "${pkgs.wlogout}/bin/wlogout";
          format = " ";
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
