{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.programs.latex-terminal = {
    enable = lib.mkEnableOption "LaTeX terminal rendering using Kitty graphics protocol";

    fullSetup = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable full LaTeX support with texlive and imagemagick.
        This adds support for complex LaTeX environments (align, gather) and special symbols.
        Note: This significantly increases disk usage (~3-4GB due to texlive).
      '';
    };

    inlineScaleFactor = lib.mkOption {
      type = lib.types.float;
      default = 1.05;
      description = "Scale factor for inline math size relative to line height (default: 1.05).";
    };

    blockFontSize = lib.mkOption {
      type = lib.types.int;
      default = 6;
      description = "Font size for block math equations (default: 6).";
    };

    inlinePadding = lib.mkOption {
      type = lib.types.float;
      default = 0.01;
      description = "Padding around inline math images, 0=tight, higher=more space (default: 0.01).";
    };

    blockPadding = lib.mkOption {
      type = lib.types.float;
      default = 0.01;
      description = "Padding around block math images, 0=tight, higher=more space (default: 0.01).";
    };

    dpi = lib.mkOption {
      type = lib.types.int;
      default = 200;
      description = "Resolution for rendered math images (default: 200).";
    };
  };

  config = lib.mkIf config.programs.latex-terminal.enable {
    home.packages = with pkgs; [
      (pkgs.callPackage ./package.nix { })
    ] ++ lib.optionals config.programs.latex-terminal.fullSetup [
      texlive.combined.scheme-full
      imagemagick
    ];

    programs.ghostty.settings = {
      image-storage-limit = "320000000";
    };

    home.file.".config/latex-terminal/config.py" = {
      text = ''
"""
Configuration settings for LaTeX Terminal Renderer.
Adjust these values to customize appearance of rendered equations.
"""

INLINE_MATH_PADDING = ${toString config.programs.latex-terminal.inlinePadding}
INLINE_MATH_MARGIN_TOP = 0
INLINE_MATH_MARGIN_BOTTOM = 0
INLINE_MATH_SCALE_FACTOR = ${toString config.programs.latex-terminal.inlineScaleFactor}
INLINE_MATH_DPI = ${toString config.programs.latex-terminal.dpi}

BLOCK_MATH_PADDING = ${toString config.programs.latex-terminal.blockPadding}
BLOCK_MATH_FONT_SIZE = ${toString config.programs.latex-terminal.blockFontSize}
BLOCK_MATH_MARGIN_TOP = 0
BLOCK_MATH_MARGIN_BOTTOM = 0
BLOCK_MATH_DPI = ${toString config.programs.latex-terminal.dpi}
      '';
    };

    programs.zsh.initContent = lib.mkOrder 1490 ''
      # LaTeX Terminal rendering setup
      
      # Set Python path for config
      export LATEX_CONFIG_DIR="$HOME/.config/latex-terminal"
      export PYTHONPATH="$LATEX_CONFIG_DIR:$PYTHONPATH"
      
      # LaTeX rendering shortcuts
      # --------------------------------
      
      # Direct rendering: ltx "text with $latex$"
      ltx() {
        latex-terminal "$@"
      }
      
      # Short math shortcut
      m() {
        latex-terminal "$@"
      }
      
      # Render from clipboard: ltxclip
      ltxclip() {
        if command -v wl-paste &>/dev/null; then
          local content=$(wl-paste --type text 2>/dev/null)
        elif command -v pbpaste &>/dev/null; then
          local content=$(pbpaste 2>/dev/null)
        elif command -v xclip &>/dev/null; then
          local content=$(xclip -o -selection clipboard 2>/dev/null)
        else
          echo "No clipboard support (try wl-paste, pbpaste, or xclip)"
          return 1
        fi
        [ -n "$content" ] && latex-terminal "$content"
      }
      
      # Render command output: ltxcmd "command"
      # Captures and renders the output of any command
      ltxcmd() {
        if [ -z "$1" ]; then
          echo "Usage: ltxcmd <command> [args...]"
          echo "Example: ltxcmd echo 'Formula: E=mc^2'"
          return 1
        fi
        
        # Run the command and pipe output through LaTeX renderer
        "$@" | latex-terminal
      }
      
      # Render file: ltxfile <path>
      ltxfile() {
        if [ -z "$1" ]; then
          echo "Usage: ltxfile <file>"
          return 1
        fi
        
        if [ -f "$1" ]; then
          latex-terminal "$(<"$1")"
        else
          echo "Error: File not found: $1"
          return 1
        fi
      }
      
      # Render and edit: ltxedit
      # Opens text in editor, renders LaTeX when saved
      ltxedit() {
        local file="''${1:-/tmp/latex_draft.txt}"
        
        if [ ! -f "$file" ]; then
          echo "# LaTeX draft - lines with $...$ will render in terminal" > "$file"
        fi
        
        "$EDITOR" "$file"
        echo
        echo "Press Enter to render, Ctrl+C to cancel:"
        read -r
        echo
        latex-terminal "$(<"$file")"
      }
    '';
  };
}
