{
  description = "NixOS live ISO via nixos-generators";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-generators,
    home-manager,
    ...
  }: {
    # A single nixos config outputting multiple formats.
    # Alternatively put this in a configuration.nix.
    nixosModules.myFormats = {config, ...}: {
      imports = [
        nixos-generators.nixosModules.all-formats
      ];

      nixpkgs.hostPlatform = "x86_64-linux";

      # customize an existing format
      formatConfigs.vmware = {config, ...}: {
        services.openssh.enable = true;
      };

      # define a new format
      formatConfigs.my-custom-format = {
        config,
        modulesPath,
        ...
      }: {
        imports = ["${toString modulesPath}/installer/cd-dvd/installation-cd-base.nix"];
        formatAttr = "isoImage";
        fileExtension = ".iso";
        networking.wireless.networks = {
          # ...
        };
      };
    };

    # using above module, we define a machine named `installer`
    nixosConfigurations.installer = nixpkgs.lib.nixosSystem {
      # system = "x86_64-linux";
      modules = [
        self.nixosModules.myFormats
        # you can include your own nixos configuration here, i.e.
        ./iso.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
          };
        }
      ];
    };
  };
}
