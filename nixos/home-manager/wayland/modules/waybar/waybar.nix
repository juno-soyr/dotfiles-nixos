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
        height = 33;
        "margin-top" = 10;
        "margin-left" = 10;
        "margin-right" = 10;
        spacing = 1;

        modules-left = [
          "custom/launcher"
          "mpris"
        ];

        modules-center = [
          "sway/workspaces"
        ];

        modules-right = [
          "pulseaudio"
          "cpu"
          "memory"
          "battery"
          "network"
          "custom/notification"
          "tray"
          "clock"
          "custom/power"
        ];

        "custom/launcher" = {
          format = "<span size='x-large'></span>";
          "on-click" = "exec ${pkgs.rofi-wayland}/bin/rofi-wayland --show run";
          tooltip = false;
        };

        clock = {
          format = "{:%H:%M:%S}";
          "format-alt" = "{:%d/%m/%Y}";
          timezone = "Europe/Vienna";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          interval = 1;
          calendar = {
            mode = "month";
            format = {
              months = "<span color='#cecece'><b>{}</b></span>";
              days = "<span color='#dadada'><b>{}</b></span>";
              weekdays = "<span color='#cecece'><b>{}</b></span>";
              today = "<span color='#ffffff'><b><u>{}</u></b></span>";
            };
          };
        };

        battery = {
          bat = "BAT0";
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          "format-full" = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
          "format-plugged" = " {capacity}%";
          "format-icons" = [" " " " " " " " " "];
          "tooltip-format" = "{time}";
          interval = 1;
          "on-click" = "control -p";
        };

        network = {
          interval = 5;
          "format-ethernet" = " ";
          "format-disconnected" = "⚠";
          "tooltip-format" = "{essid} ({signalStrength}%)\n{ifname}: {ipaddr}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          "format-muted" = "Muted";
          "format-icons" = {
            headphone = "  ";
            "hands-free" = "  ";
            headset = "  ";
            phone = "  ";
            portable = "  ";
            car = "  ";
            default = ["" "" "   "];
          };
          "on-click" = "pavucontrol";
        };

        tray = {
          "icon-size" = 15;
          spacing = 1;
        };

        "custom/power" = {
          format = " ⏻  ";
          "on-click" = "exec ${pkgs.wlogout}/bin/wlogout";
          tooltip = false;
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          "format-icons" = {
            notification = " <span foreground='#f38ba8'><sup> </sup></span> ";
            none = " ";
            "dnd-notification" = " <span foreground='#f38ba8'><sup> </sup></span> ";
            "dnd-none" = " ";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb";
          "on-click" = "swaync-client -t -sw";
          "on-click-right" = "swaync-client -d -sw";
          escape = true;
        };

        mpris = {
          format = " Playing: {player_icon} {title} - {position} / {length}";
          "format-paused" = " Paused: {status_icon} {title} - {position} / {length}";
          interval = 1;
          "player-icons" = {
            default = "▶";
            mpv = "🎵";
          };
          "status-icons" = {
            paused = "⏸";
          };
          "ignored-players" = ["firefox"];
        };

        cpu = {
          interval = 5;
          format = " {usage:>3}% ";
          states = {
            warning = 70;
            critical = 90;
          };
          "on-click" = "footclient -T waybar_htop -e htop";
        };

        memory = {
          interval = 5;
          format = " {:>3}%";
          "on-click" = "footclient -T waybar_htop -e htop";
          states = {
            warning = 70;
            critical = 90;
          };
        };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
