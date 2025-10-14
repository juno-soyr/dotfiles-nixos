{
  description = "NixOS-soyr";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cursor-theme.url = "github:mrcjkb/volantes-cursors-material";
    # Optional, if you intend to follow nvf's obsidian-nvim input
    # you must also add it as a flake input.
    obsidian-nvim.url = "github:epwalsh/obsidian.nvim";

    # Required, nvf works best and only directly supports flakes
    nvf = {
      url = "github:NotAShelf/nvf";
      # You can override the input nixpkgs to follow your system's
      # instance of nixpkgs. This is safe to do as nvf does not depend
      # on a binary cache.
      inputs.nixpkgs.follows = "nixpkgs";
      # Optionally, you can also override individual plugins
      # for example:
      inputs.obsidian-nvim.follows = "obsidian-nvim"; # <- this will use the obsidian-nvim from your inputs
    }; 
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    cursor-theme,
    ...
  } @ inputs: {
    nixosConfigurations = {
      lechuga = nixpkgs.lib.nixosSystem rec {
        specialArgs = {inherit inputs;};
        modules = [
          ({
            config,
            pkgs,
            ...
          }: {
            nixpkgs.overlays = [
              cursor-theme.overlay
            ];
          })
          ./hosts/lechuga/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.soyr = import ./home-manager/home.nix;
            home-manager.backupFileExtension = "backup-lechuga";
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };
      tomate = nixpkgs.lib.nixosSystem rec {
        specialArgs = {inherit inputs;};
        modules = [
          ({
            config,
            pkgs,
            ...
          }: {
            nixpkgs.overlays = [
              cursor-theme.overlay
            ];
          })
          ./hosts/tomate/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.soyr = import ./home-manager/home.nix;
            home-manager.backupFileExtension = "backup-tomate";
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };
    };
  };
}
