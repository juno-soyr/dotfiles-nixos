{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.catppuccin.enable = true;

    plugins = {
      lualine.enable = true;
      barbar = {
        enable = true;
        keymaps = {
          next = {
            key = "<A-z>";
          };
          previous = {
            key = "<A-x>";
          };
        };
      };
      web-devicons.enable = true;
      treesitter.enable = true;
      remote-nvim.enable = true;
      nvim-tree = {
        enable = true;
      };
      lsp = {
        enable = true;
        servers = {
          metals.enable = true;
          nixd.enable = true;
          pylsp.enable = true;
          pyright.enable = true;
          jdtls.enable = true;
          ltex = {
            enable = true;
          };

        };
      };

      lsp-format = {
        enable = true;
        autoLoad = true;
      };
      vimtex = {
        enable = true;
        texlivePackage = pkgs.texlive.combined.scheme-full;
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<Tab>" = ''
              cmp.mapping(
                function(fallback)
                  local col = vim.fn.col('.') - 1

                  if cmp.visible() then
                    cmp.select_next_item(select_opts)
                  elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                    fallback()
                  else
                    cmp.complete()
                  end
                end,
                { "i", "s" }
              )
            '';
          };
          window = {
            completion = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None";
              zindex = 1001;
              scrolloff = 0;
              colOffset = 0;
              sidePadding = 1;
              scrollbar = true;
            };
            documentation = {
              border = "rounded";
              winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None";
              zindex = 1001;
              maxHeight = 20;
            };
          };

        };

      };
      telescope.enable = true;
      neogit.enable = true;

      coq-nvim.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          default_format_opts.lsp_format = "fallback";
          formatters_by_ft = {
            "nix" = [ "alejandra" ];
            "typst" = [
              "typstyle"
              "injected"
            ];
            "sh" = [ "shfmt" ];
            "python" = [
              "black"
            ];
          };
        };
      };
    };
  };
}
