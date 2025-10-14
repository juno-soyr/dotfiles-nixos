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
