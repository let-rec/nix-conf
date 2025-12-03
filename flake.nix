{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    nur.url = "github:nix-community/NUR";

    # Needed for Xinux
    nix-data = {
      url = "github:xinux-org/nix-data";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xinux-modules = {
      url = "github:xinux-org/modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    ...
  } @ inputs: let
    outputs = self;
  in
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = import ./shell.nix {inherit pkgs;};
        formatter = nixpkgs.legacyPackages.${system}.alejandra;
      }
    )
    // {
      lib = nixpkgs.lib // home-manager.lib;

      # This systems for xinux-module-manager
      systems.modules.nixos = with inputs; [
        nix-data.nixosModules.nix-data
        xinux-modules.nixosModules.efiboot
        xinux-modules.nixosModules.gnome
        xinux-modules.nixosModules.kernel
        xinux-modules.nixosModules.networking
        xinux-modules.nixosModules.packagemanagers
        xinux-modules.nixosModules.pipewire
        xinux-modules.nixosModules.printing
        xinux-modules.nixosModules.xinux
        xinux-modules.nixosModules.metadata
      ];

      nixosModules = import ./modules/nixos;
      homeModules = import ./modules/home;

      nixosConfigurations.let-rec = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/home/configuration.nix
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };
}
