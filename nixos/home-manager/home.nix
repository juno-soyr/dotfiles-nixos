{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./wayland
    ./modules
    inputs.nixvim.homeModules.nixvim
    inputs.nix-doom-emacs-unstraightened.hmModule
  ];
  home.username = "soyr";
  home.homeDirectory = "/home/soyr";
  services.gnome-keyring.enable = true;
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Volantes Material Dark";
      package = pkgs.volantes-cursors-material;
    };
  };
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # Gnome tests
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar

    neofetch
    yazi # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses
    bluetui

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # my stuff
    bitwarden
    discord
    pavucontrol
    alejandra
    tokyo-night-gtk
    xwayland-satellite
    anytype
    uair
    wlogout
    texlive.combined.scheme-full
    libnotify
    spotify
    thunderbird
    nixfmt-rfc-style
    protonmail-desktop
    black
    shfmt
    typstyle
    python3Packages.python-lsp-server
    python3Packages.aiohttp
    lutris
  ];
  programs.doom-emacs = {
    enable = true;
    doomDir = ./doom.d;
  };
  # basic configuration of git
  services.swayidle =
    let
      # Lock command
      lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
      # TODO: modify "display" function based on your window manager
      # Sway
      # display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
      # Hyprland
      # display = status: "hyprctl dispatch dpms ${status}";
      # Niri
      display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 250; # in seconds
          command = "/etc/profiles/per-user/soyr/bin/notify-send 'Locking in 20 seconds' -t 20000";
        }
        {
          timeout = 270;
          command = lock;
        }
        {
          timeout = 500;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 510;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          # adding duplicated entries for the same event may not work
          command = (display "off") + "; " + lock;
        }
        {
          event = "after-resume";
          command = display "on";
        }
        {
          event = "lock";
          command = (display "off") + "; " + lock;
        }
        {
          event = "unlock";
          command = display "on";
        }
      ];
    };
  programs.git = {
    enable = true;
    userName = "juno-soyr";
    userEmail = "h.gaspar@proton.me";
  };
  dconf.settings = {
    # ...
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "trayIconsReloaded@selfmade.pl"
        "Vitals@CoreCoding.com"
        "dash-to-panel@jderose9.github.com"
        "sound-output-device-chooser@kgshank.net"
        "space-bar@luchrioh"
      ];
    };
  };

  # Alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      window = {
        opacity = 0.9;
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  home.file.".icons/default".source =
    "${pkgs.volantes-cursors-material}/share/icons/volantes_cursors";

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
