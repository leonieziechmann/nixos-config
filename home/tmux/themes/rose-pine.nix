{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    tmux-theme.rose-pine = lib.mkEnableOption "rose-pine theme";
  };

  config = lib.mkIf config.tmux-theme.rose-pine {
    programs.tmux.plugins = [
      {
        plugin = pkgs.tmuxPlugins.rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main' # Options are 'main', 'moon' or 'dawn'

          # set -g @rose_pine_host 'on' # Enables hostname in the status bar
          set -g @rose_pine_user 'on' # Turn on the username component in the statusbar
          set -g @rose_pine_directory 'on' # Turn on the current folder component in the status bar
          set -g @rose_pine_bar_bg_disable 'on' # Disables background color, for transparent terminal emulators

          set -g @rose_pine_show_pane_directory 'on' # Forces tmux to show the current directory as window name

          set -g @rose_pine_field_separator ' | ' # Again, 1-space padding, it updates with prefix + I

          # These are not padded
          set -g @rose_pine_session_icon '' # Changes the default icon to the left of the session name
          set -g @rose_pine_current_window_icon '' # Changes the default icon to the left of the active window name
          set -g @rose_pine_folder_icon ' ￤' # Changes the default icon to the left of the current directory folder
          set -g @rose_pine_username_icon '' # Changes the default icon to the right of the hostname
          # set -g @rose_pine_hostname_icon '󰒋' # Changes the default icon to the right of the hostname
          set -g @rose_pine_date_time_icon '󰃰' # Changes the default icon to the right of the date module
          # set -g @rose_pine_window_status_separator "  " # Changes the default icon that appears between window names

          # set -g @rose_pine_prioritize_windows 'on' # Disables the right side functionality in a certain window count / terminal width
          # set -g @rose_pine_width_to_hide '80' # Specify a terminal width to toggle off most of the right side functionality
          # set -g @rose_pine_window_count '5' # Specify a number of windows, if there are more than the number, do the same as width_to_hide
        '';
      }
    ];
  };
}
