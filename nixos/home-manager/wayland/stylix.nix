{
  inputs,
  pkgs,
  lib,
  ...
}: {
  inputs.stylix = {
    enable = true;
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/whoisYoges/lwalpapers/refs/heads/PicturesOnly/wallpapers/b-010.jpg";
      hash = "sha256-oUXpV05POhAypQHibL+kQUHN0MT6ny/+meH60YLfkjM=";
    };
  };
}
