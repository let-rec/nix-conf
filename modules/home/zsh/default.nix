{pkgs, ...}: {
  # Installing zsh for system
  programs.zsh = {
    enable = true;
    # vteIntegration = true;
    # enableCompletion = true;
    autosuggestion.enable = true;
    # enableBashCompletion = true;
    syntaxHighlighting.enable = true;
    # plugins= [{
    #   name = "vi-mode";
    #   src = pkgs.zsh-vi-mode;
    #   file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
    # }];
  };

  # history = {
  #   extended = true;
  # };

  # ohMyZsh = {
  #   enable = true;
  #   plugins = ["git"];
  #   theme = "robbyrussell";
  # };

  # All users default shell must be zsh
  # users.defaultUserShell = pkgs.zsh;

  # Automatic flake devShell loading
  # programs.direnv = {
  #   enable = true;
  #   silent = true;
  #   loadInNixShell = false;
  #   nix-direnv.enable = true;
  #   enableZshIntegration = true;
  # };

  # # Replace commant not found with nix-index
  # programs.nix-index = {
  #   # enable = true;
  #   # enableBashIntegration = true;
  #   # enableZshIntegration = true;
  # };

  # # System configurations
  # environment = {
  #   shells = with pkgs; [zsh];
  #   pathsToLink = ["/share/zsh"];
  #   systemPackages = [inputs.home-manager.packages.${pkgs.system}.default];
  # };
}
