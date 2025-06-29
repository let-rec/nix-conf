{ config, pkgs, inputs, outputs, ... }:

{
  imports = 
  [
    ./hardware-configuration.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users.letrec = import ../home.nix;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # boot.kernelParams = [
  #   "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1"
  # ]

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.swraid.enable = false;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Etc/GMT-5";

  i18n = {
    defaultLocale = "en_US.UTF-8";
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
    
  };

  services.printing.enable = true;
  services.openssh.enable = true;
  services.pcscd.enable = true;
  services.earlyoom.enable = true;
  services.earlyoom.freeMemThreshold = 5;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.letrec = {
    isNormalUser = true;
    description = "let-rec";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.steam.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
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

  nixpkgs.config.allowUnfree = true;

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
    firefox
    prismlauncher
    telegram-desktop
    keepassxc
    git
    vscode
    element-desktop
    discord
    rustc
    cargo
  ];
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
    cheese
    gnome-music
    gnome-console
    gnome-terminal
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

  system.stateVersion = "25.05";

}
