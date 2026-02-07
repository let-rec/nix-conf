
{
  pkgs,
  hostname,
  username,
  config,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    inputs.relago.nixosModules.relago
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.swraid.enable = false;
  boot.supportedFilesystems = ["ntfs"];
  # services.relago.enable = true;
  # ACPI tweaks
  # boot.kernelParams = [
  #   "acpi_osi="
  #   "acpi_osi=Linux"
  # ];
  # programs.starship.enable = false;
  # nixpkgs.overlays = [
  #   (self: super: {
  #     python3 = super.python312;
  #     python3Packages = super.python312Packages;
  #   })
  # ];

  # security.polkit = {
  #   enable = true;
  #   extraConfig = ''
  #     polkit.addRule(function(action, subject) {
  #         if (subject.isInGroup("wheel")) {
  #             return polkit.Result.YES;
  #         }
  #     });
  #   '';
  # };

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

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us,ru";
        options = "caps:escape,grp:alt_shift_toggle";
        variant = "altgr-intl,,";
      };

      # videoDrivers = ["nvidia"];
    };
    desktopManager.gnome = {
      enable = true;
    };
    displayManager = {
      gdm.enable = true;
     #gdm.wayland = false;
    };
  };
  services.pcscd.enable = true;
  services.printing.enable = true;
  services.earlyoom.enable = true;
  services.earlyoom.freeMemThreshold = 5;
  services.thermald.enable = true;
  # services.flatpak.enable = true;

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

  # hardware = {
  #   graphics = {
  #     enable = true;
  #   };

  #   nvidia = {
  #     open = false;
  #     modesetting.enable = true;
  #     nvidiaSettings = false;
  #     powerManagement.enable = true;
  #   };

  #   bluetooth.settings = {
  #     General = {
  #       Experimental = true;
  #     };
  #   };
  # };

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
    # firefox
    gnome-builder
    zed-editor
    fractal
    poedit
    github-desktop
    pinentry-curses
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
    #adasdad
  ];

  system.stateVersion = "25.05";
}
