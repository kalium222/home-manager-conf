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
      man
      less
      curl
      fastfetch
      neovim
      yazi
      zellij
      bat
      ripgrep
      fzf
      fd
    ];
    shellAliases = {
      "ls" = "ls --color=auto";
      "grep" = "grep --color=auto";
      "diff" = "diff --color=auto";

      "h" = "home-manager";
      "v" = "nvim";
      "f" = "fastfetch";
      "y" = "yazi_wrapper";
      "z" = "zellij_wrapper";
    };
    sessionVariables = {
      EDITOR = lib.getExe pkgs.neovim;
      PAGER = "${lib.getExe pkgs.bat} -p";
    };
    shell.enableBashIntegration = true;

    file."tools" = {
      target = "${config.xdg.configHome}/tools";
      text = builtins.readFile ./tools;
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
      source ${config.xdg.configHome}/tools
      PS1="''${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
      set -o vi
    '';
  };
}
