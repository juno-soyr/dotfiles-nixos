{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.librewolf = {
    enable = true;
  };
}
