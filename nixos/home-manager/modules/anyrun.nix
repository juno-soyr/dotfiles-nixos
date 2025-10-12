{
  pkgs,
  config,
  ...
}: {
  programs.anyrun = {
    enable = true;

    config = {
      layer = "overlay";
      y = {fraction = 0.3;};
      height = {absolute = 1;};
      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
      ];
    };
    extraCss = ''
      window {
        background: transparent;
      }

      box.main {
        padding: 5px;
        margin: 10px;
        border-radius: 50px;
        border: 2px solid black;
        background-color: #1a1b26;
        box-shadow: 0 0 5px black;
      }



    '';
  };
}
