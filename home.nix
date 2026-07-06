{ config, pkgs, ... }:
{
    targets.genericLinux.enable = true;

    home.username = "droid";
    home.homeDirectory = "/home/droid";
    home.stateVersion = "26.11";
    home.packages = with pkgs; [
        neovim
        zsh
    ];
    home.sessionVariables = {
        EDITOR = "nvim";
    };
    programs.home-manager.enable = true;
    programs.bash.enable = true;

    xdg.enable = true;
}
