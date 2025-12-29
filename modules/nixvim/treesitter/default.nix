{ config, lib, pkgs, vimUtils, ... }: {
  config = lib.mkIf config.glamdring.nixvim.enable {
    programs.nixvim = {
      extraConfigLua = ''
        vim.o.foldlevel = 99
      '';

      # TODO: Precompile all grammars and link where nvim expects them (or correct the setting elsewise)
      plugins = {
        treesitter = {
          enable = true;
          folding.enable = false;
          languageRegister = {
            markdown = "octo";
          };

          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            angular
            arduino
            asm
            bash
            bicep
            c
            capnp
            cmake
            cpp
            css
            csv
            diff
            dockerfile
            editorconfig
            elixir
            elm
            erlang
            git_config
            git_rebase
            gitattributes
            gitcommit
            gitignore
            glsl
            gnuplot
            go
            gomod
            gosum
            groovy
            haskell
            hcl
            helm
            hlsl
            hurl
            hyprlang
            idris
            ini
            java
            javadoc
            javascript
            jinja
            jinja_inline
            jq
            json
            jsonc
            jsonnet
            just
            kitty
            kotlin
            latex
            llvm
            lua
            luadoc
            make
            markdown
            markdown_inline
            matlab
            mermaid
            muttrc
            nginx
            nickel
            nix
            passwd
            pem
            php
            powershell
            printf
            prolog
            properties
            puppet
            python
            r
            racket
            readline
            regex
            requirements
            ron
            rst
            ruby
            rust
            scala
            scheme
            scss
            ssh_config
            strace
            supercollider
            svelte
            terraform
            tmux
            toml
            tsv
            tsx
            typescript
            udev
            unison
            vim
            vimdoc
            wgsl
            wgsl_bevy
            xml
            xresources
            yaml
          ];

          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
        };

        treesitter-textobjects = {
          enable = true;
        };
      };
    };
  };
}
