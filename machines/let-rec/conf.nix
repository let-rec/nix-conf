{
  pkgs,
  hostname,
  username,
  config,
  ...
}: {
  imports = [
    # inputs.home-manager.nixosModules.home-manager
    ./hardware.nix
  ];
  # nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.swraid.enable = false;
  boot.supportedFilesystems = ["ntfs"];
  
  # ACPI tweaks
  boot.kernelParams = [
    "acpi_osi="
    "acpi_osi=Linux"
  ];
  programs.starship.enable = false;
  nixpkgs.overlays = [
    (self: super: {
      python3 = super.python312;
      python3Packages = super.python312Packages;
    })
  ];

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
  time.timeZone = "Etc/GMT-5";
  i18n = {
    defaultLocale = "en_US.UTF-8";

    # extraLocales = [
    #   "ru_RU.UTF-8/UTF-8"
    #   "en_US.UTF-8/UTF-8"
    #   "uz_UZ.UTF-8/UTF-8"
    #   "all"
    # ];
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
  services.flatpak.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = true;
    };
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

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      sync.enable = true;
      offload.enable = false;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  environment.shells = with pkgs; [zsh];
  environment.systemPackages = with pkgs; [
    docker-compose
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
    pulseaudio
    telegram-desktop
    keepassxc
    # git
    firefox
    # vscode
    gnome-builder
    zed-editor
    fractal
    poedit
    github-desktop
    pinentry
  ];

  environment.gnome.excludePackages = with pkgs; [
    # gnome-console
    # gnome-terminal...
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

  system.stateVersion = "25.05";
}
