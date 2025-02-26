return {
  { "rebelot/kanagawa.nvim" },
  { "marko-cerovac/material.nvim" },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  { "catppuccin/nvim", name = "catppuccin" },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    config = function()
      vim.g.zenbones_darken_comments = 45
      vim.cmd.colorscheme('rosebones')


      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("wezterm_colorscheme", { clear = true }),
        callback = function(args)
          local colorschemes = {
            ["catppuccin-frappe"] = "Catppuccin Frappe",
            ["catppuccin-macchiato"] = "Catppuccin Macchiato",
            ["catppuccin-latte"] = "Catppuccin Latte Custom",
            ["catppuccin-mocha"] = "Catppuccin Mocha Custom",
            ["rose-pine"] = "Rose Pine",
            -- add more color schemes here ...
          }
          local colorscheme = colorschemes[args.match]
          if not colorscheme then
            return
          end
          -- Write the colorscheme to a file
          local filename = vim.fn.expand("~/.config/wezterm/colorscheme")
          assert(type(filename) == "string")
          local file = io.open(filename, "w")
          assert(file)
          file:write(colorscheme)
          file:close()
          vim.notify("Setting WezTerm color scheme to " .. colorscheme, vim.log.levels.INFO)
        end,
      })
    end,
  },
}
