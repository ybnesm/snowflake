{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
      up = ''
        	if not set -q argv[1]
        		set argv[1] 1
        	end
        	cd (printf "%.s../" (seq $argv[1]));
        	ls
      '';
      cdl = ''
        	cd $argv[1]
        	ls
      '';
      lst = ''
        	${pkgs.exa}/bin/exa -Tl --git --no-permissions --git-ignore --icons -I=".git" $argv
      '';
      # ls + deep
      lsd = ''
        if test -z $argv[1]
          lst -L 2
        else
          lst -L $argv[1]
        end
      '';
      mkcd = ''
        	mkdir $argv[1]
        	cd $argv[1]
      '';
      # https://fishshell.com/docs/current/interactive.html#programmable-title
      fish_title = ''
        if test -z $argv[1]
          prompt_pwd
        else
          echo $argv[1] 
        end
      '';
      fish_user_key_bindings = ''
        bind --erase --mode insert --preset \cd
        bind --erase --mode visual --preset \cd
        bind --erase --preset \cd
      '';
    };

    shellInit = ''
      fish_vi_key_bindings
      set -U fish_greeting ""
      # Disable noise from direnv
      set -x DIRENV_LOG_FORMAT ""
    '';
  };
}
