{ config, pkgs, ... }:
{
    xdg.enable = true;
    nix.assumeXdg = true;
    targets.genericLinux.enable = true;

    home.username = "Kalium";
    home.homeDirectory = "/home/Kalium";
    home.stateVersion = "26.11";
    home.packages = with pkgs; [
        neovim
    ];
    home.sessionVariables = {
        EDITOR = pkgs.neovim;
    };
    programs.home-manager.enable = true;
    programs.bash = {
        enable = true;
        historySize = 1000;
        historyFile = "${config.xdg.stateHome}/histfile";
        historyFileSize = 1000;
    };
}
