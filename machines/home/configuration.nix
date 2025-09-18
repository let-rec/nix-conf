{
  pkgs,
  inputs,
  outputs,
  config,
  ...
}: {
  imports = [
    # outputs.nixosModules.firefox
    outputs.nixosModules.sound
    outputs.nixosModules.ssh
    outputs.nixosModules.zsh
    outputs.nixosModules.fonts
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.swraid.enable = false;
  boot.supportedFilesystems = ["ntfs"];
  # boot.kernelModules = [ "i915" ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users.letrec = import ../../home.nix;
  };

  networking = {
    hostName = "let-rec";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  virtualisation.docker.enable = true;

  time.timeZone = "Etc/GMT-5";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    ### JAPANESE
    # inputMethod = {
    #   enable = true;
    #   type = true;
    #   ibus.engines = with pkgs.ibus.engines; [
    #     mozc
    #   ];
    # };
    # extraLocationSettings = {
    #   LANGUAGE = "ja_JP";
    #   LC_ALL = "ja_JP.UTF-8";
    # };
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us,ru";
      options = "caps:escape,grp:alt_shift_toggle";
      variant = "altgr-intl,,";
    };
    displayManager = {
      gdm.enable = true;
      gdm.wayland = false;
    };
    desktopManager.gnome = {
      enable = true;
    };
    videoDrivers = ["nvidia"];
  };

  services.pcscd.enable = true;
  services.printing.enable = true;
  services.earlyoom.enable = true;
  services.earlyoom.freeMemThreshold = 5;
  services.thermald.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.letrec = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware = {
    nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        sync.enable = true;
        offload.enable = false;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
  
  
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  environment.shells = with pkgs; [zsh];
  environment.systemPackages = with pkgs; [
    vim
    wget
    file
    gnumake
    xclip
    lsof
    strace
    zip
    unzip
    fdupes
    # libGL
    pulseaudio
    prismlauncher
    telegram-desktop
    keepassxc
    git
    element-desktop
    firefox
    vscode
    gnome-builder
    zed-editor
    fractal
    poedit
    github-desktop
  ];

  environment.gnome.excludePackages = with pkgs; [
    # gnome-console
    # gnome-terminal
    gnome-photos
    gnome-tour
    gedit
    cheese
    gnome-music
    epiphany
    geary
    evince
    totem
    tali
    iagno
    hitori
    atomix
    seahorse
  ];

  #environment.variables = {
  #  LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.libGL}/lib";
  #};

  ####
  # fonts = {
  #   packages = with pkgs; [
  #     noto-fonts-cjk-sans
  #     iosevka-bin
  #     julia-mono
  #     apple-fonts.sf-pro
  #   ];
  #   fontconfig = {
  #     enable = true;
  #     localConf = builtins.readFile ../../.config/fontconfig/fonts.conf;
  #   };
  # };

  # programs.ssh.extraConfig = ''
  #   Host *
  #   ServerlALiveInternal 120
  # '';
  ####

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  # environment.sessionVariables = {
  #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
  #     "/home/user/.steam/root/compatibilitytools.d";
  # };

  nix.settings.experimental-features = ["nix-command flakes"];
  system.stateVersion = "25.05";
}
