{ config, pkgs, ... }:

{
    imports = 
  let 
    home-manager = (builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz");
  in
      [
        ./hardware-configuration.nix
        (import "${home-manager}/nixos")
      ];
    home-manager.users.eve = {pkgs, ... }: {
      home.packages = [ pkgs.atool pkgs.httpie ];
      programs.bash.enable = true;
      home.stateVersion = "25.05";
    };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.swraid.enable = false;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tashkent";

  i18n.defaultLocale = "en_US.UTF-8";

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

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = (with pkgs.vscode-extensions; [
        vscodevim.vim
        rust-lang.rust-analyzer
        jnoortheen.nix-ide
      ]);
    };
  };

  system.stateVersion = "25.05";

}
