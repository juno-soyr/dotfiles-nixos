{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./wayland/sway/sway.nix
    ./wayland/modules/waybar/waybar.nix
    ./wayland/modules/fuzzel.nix
    ./modules/firefox/firefox.nix
    ./modules/anyrun/anyrun.nix
  ];

home.username = "soyr";
  home.homeDirectory = "/home/soyr";
  services.gnome-keyring.enable = true;
  services.swww.enable = true;
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
    texlive.combined.scheme-small
    spotify
  ];

  # basic configuration of git, please change to your own
  xdg.configFile."niri/config.kdl".source = ./modules/niri/config.kdl;
  xdg.configFile."niri/b-010.jpg".source = ./modules/niri/b-010.jpg;
  xdg.configFile."uair/uair.toml".source = ./wayland/modules/waybar/uair.toml;
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    xdgOpenUsePortal = true;
  };
  xdg.portal.config.common.default = "*";
  programs.git = {
    enable = true;
    userName = "juno-soyr";
    userEmail = "h.gaspar@proton.me";
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      yzhang.markdown-all-in-one
      ms-python.python
      jnoortheen.nix-ide
      kamadorueda.alejandra
    ];
  };
  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      background-opacity = 0.9;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
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
  services.mako.enable = true;
  services.mako.settings = {
    background-color = "#1e1e2e";
    text-color = "#cdd6f4";
    border-color = "#b4befe";
    progress-color = "over #313244";

    "urgency=high" = {
      border-color = "#fab387";
    };
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
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
  programs.nvf = {
    enable = true;
    defaultEditor = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
    };
  };
  home.file.".icons/default".source = "${pkgs.volantes-cursors-material}/share/icons/volantes_cursors";

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
