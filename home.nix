{
  config,
  pkgs,
  lib,
  ...
}:
{
  home = {
    username = "Kalium";
    homeDirectory = "/home/Kalium";
    stateVersion = "26.11";
    preferXdgDirectories = true;
    packages = with pkgs; [
      neovim
    ];
    shell.enableBashIntegration = true;
    shellAliases = {
      "ls" = "ls --color=auto";
      "grep" = "grep --color=auto";
      "diff" = "diff --color=auto";

      "v" = "nvim";
      "h" = "home-manager";
    };
    sessionVariables = {
      EDITOR = lib.getExe pkgs.neovim;
    };
  };

  nix.assumeXdg = true;
  targets.genericLinux.enable = true;
  xdg.enable = true;

  programs.home-manager.enable = true;
  programs.bash = {
    enable = true;
    historySize = 1000;
    historyFile = "${config.xdg.stateHome}/histfile";
    historyFileSize = 1000;

    initExtra = ''
      PS1="''${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
    '';
  };
}
