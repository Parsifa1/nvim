return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    { "<leader>sf", "<cmd>GrugFar astgrep<CR>", desc = "Find and Replace in files" },
  },
  config = function()
    require("grug-far").setup { transient = true }
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("grug-far-keybindings", { clear = true }),
      pattern = { "grug-far" },
      callback = function(args)
        local function smart_save()
          local inst = require("grug-far").get_instance(args.buf)
          if not inst then return end
          local values = require("grug-far.inputs").getValues(inst._params.context, args.buf)
          if values.replacement and #values.replacement > 0 then
            inst:replace()
          else
            inst:sync_all()
          end
        end
        vim.keymap.set({ "n", "i" }, "<C-s>", smart_save, { buffer = args.buf })
        vim.keymap.set("n", "<C-c>", function()
          local inst = require("grug-far").get_instance(args.buf)
          if inst then inst:close() end
        end, { buffer = args.buf, desc = "Close" })
      end,
    })
  end,
}
