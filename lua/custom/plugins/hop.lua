return {
  {
    'smoka7/hop.nvim',
    version = '*',
    opts = {
      multi_windows = true,
      keys = 'htnsueoaidgcrlypmbkjvx',
      uppercase_lables = true,
    },
    keys = {
      {
        '<leader>fj',
        function()
          require('hop').hint_words()
        end,
        desc = '[F]ind and [J]ump to words with Hop',
        mode = { 'n', 'x', 'o' },
      },
    },
  },
}