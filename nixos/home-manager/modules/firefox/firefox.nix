{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles = {
      "main" = {
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
          ];
        };
        userChrome = ./chrome/userChrome.css;
        userContent = ./chrome/userContent.css;
        extraConfig = builtins.readFile ./user.js;
      };
    };
  };
}
