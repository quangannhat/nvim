return {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  opts = {},
  config = function()
    local tsx_comment = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
    require("Comment").setup({
      pre_hook = tsx_comment,
    })
  end,
}
