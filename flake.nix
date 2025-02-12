{
  description = "A NixOS configuration with Home Manager integration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    # NixOS System Configuration
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix  # Your NixOS configuration file
          home-manager.nixosModules.home-manager  # Integrating home-manager into NixOS
        ];
      };
    };

    # Home Manager Configuration
    homeConfigurations = {
      dorian = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          /home/dorian/nixos-config/home.nix  # Absolute path to your Home Manager configuration
        ];
      };
    };
  };
}

