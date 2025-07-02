{ 
  pkgs, 
  inputs, 
  outputs, 
  ... 
}:

{
  imports = 
  [
    # outputs.nixosModules.firefox
    outputs.nixosModules.sound
    outputs.nixosModules.ssh
    outputs.nixosModules.zsh
    # outputs.nixosModules.vscode
    outputs.nixosModules.fonts
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  nixpkgs.config.allowUnfree = true;

  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.swraid.enable = false;
  boot.kernelParams = [
    "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1"
  ];
  boot.supportedFilesystems = [ "ntfs" ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users.letrec = import ../../home.nix;
  };
  
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = false;
  };

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

  services.e-imzo.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.letrec = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
  
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = false;
    powerManagement.enable = true;
  };

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;   
    };
  };

  environment.shells = with pkgs; [ zsh ];
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
    libGL
    pulseaudio
    prismlauncher
    telegram-desktop
    keepassxc
    git
    element-desktop
    firefox
    vscode
  ];


  environment.gnome.excludePackages = (with pkgs; [
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
  ]);

  environment.variables = {
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.libGL}/lib";
  };


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
  nix.settings.experimental-features = ["nix-command flakes"];
  system.stateVersion = "25.05";

}
