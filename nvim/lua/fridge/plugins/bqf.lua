return {
  "kevinhwang91/nvim-bqf",
  event = "BufRead",
  config = function()
    require("bqf").setup {
      auto_enable = true,
      auto_resize_height = true,
    }
  end,
}
