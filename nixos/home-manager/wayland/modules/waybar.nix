{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 32;
          margin-top = 5;
          margin-bottom = 0;
          margin-right = 7;
          margin-left = 7;

          modules-left = ["clock" "sway/workspaces" "mpris"];
          modules-center = ["privacy" "group/system-metrics"];
          modules-right = [
            "battery"
            "power-profiles-daemon"
            "pulseaudio"
            "tray"
            "custom/notification"
            "custom/power"
          ];

          mpris = {
            format = "{status_icon} {dynamic}";
            format-playing = "  <b>{title}</b> - {artist} - {position}";
            format-paused = "󰏤 <b>{title}</b> - {artist} - {position}";
            title-len = 35;
            artist-len = 20;
            dynamic-len = 30;
            dynamic-order = ["title" "artist" "position"];
            dynamic-separator = " - ";
            dynamic-importance-order = ["title" "artist" "position"];
            ellipsis = "…";
          };

          "custom/notification" = {
            format = "";
            on-click = "swaync-client -t";
          };

          "custom/power" = {
            format = "⏻ ";
            on-click = "wlogout";
          };

          tray = {
            icon-size = 18;
            spacing = 20;
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "󰝟 ";
            format-icons = {
              default = ["󰕿" "󰖀" "󰕾"];
              bluetooth = "󰂯";
            };
            max-volume = 100;
            scroll-step = 5;
            tooltip = true;
          };

          power-profiles-daemon = {
            format = " {icon} ";
            tooltip-format = "Power profile: {profile}\nDriver: {driver}";
            tooltip = true;
            format-icons = {
              performance = "";
              balanced = " ";
              power-saver = "󰌪";
            };
          };

          battery = {
            format = "{icon} {capacity}%";
            format-icons = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
            format-charging = "󰂄 {capacity}%";
            interval = 30;
            states = {
              warning = 30;
              critical = 15;
            };
            tooltip = true;
          };

          "group/system-metrics" = {
            orientation = "horizontal";
            modules = ["cpu" "memory" "temperature" "network"];
            drawer = {
              transition-duration = 500;
              transition-left-to-right = true;
            };
          };

          network = {
            format = " {bandwidthUpBits}  {bandwidthDownBits}";
            interval = 1;
          };

          cpu = {
            format = "  {usage}%";
            interval = 1;
          };

          memory = {
            format = "  {percentage}%";
            interval = 1;
          };

          temperature = {
            format = " {temperatureC} C°";
            thermal-zone = 9;
            interval = 1;
          };

          clock = {
            interval = 60;
            tooltip = true;
            format = "{:%I : %M %p}";
            tooltip-format = "{:%Y-%m-%d}";
          };

          "sway/workspaces" = {
            persistent-workspaces = {
              "*" = 5;
            };
            active-only = false;
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              active = "   ";
              default = "   ";
            };
          };
        };
      };
    };
  };
}
