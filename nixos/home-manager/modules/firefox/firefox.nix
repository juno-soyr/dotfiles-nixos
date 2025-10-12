{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        name = "main";
      };
    };
  };
}
