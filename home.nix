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

      MANROFFOPT = "-c";
      LESS = "-R";
      LESS_TERMCAP_mb = ''$'\E[1;31m' '';
      LESS_TERMCAP_md = ''$'\E[1;36m' '';
      LESS_TERMCAP_me = ''$'\E[0m' '';
      LESS_TERMCAP_so = ''$'\E[01;33m' '';
      LESS_TERMCAP_se = ''$'\E[0m' '';
      LESS_TERMCAP_us = ''$'\E[1;32m' '';
      LESS_TERMCAP_ue = ''$'\E[0m' '';
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
    '';
  };
}
