return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp_ok, cmp = pcall(require, "cmp")
    if not cmp_ok then
      vim.notify("nvim-cmp not available", vim.log.levels.WARN)
      return
    end

    local luasnip_ok, luasnip = pcall(require, "luasnip")
    if not luasnip_ok then
      luasnip = nil
    end

    local lspkind_ok, lspkind = pcall(require, "lspkind")
    if not lspkind_ok then
      lspkind = nil
    end

    local snippet_expand = function(args)
      if luasnip then
        luasnip.lsp_expand(args.body)
      end
    end

    local mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-y>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
        else
          fallback()
        end
      end, { "i", "s" }),
    }

    cmp.setup {
      snippet = {
        expand = snippet_expand,
      },

      mapping = mapping,

      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer", keyword_length = 3 },
      },

      formatting = {
        format = function(entry, vim_item)
          if lspkind and lspkind.cmp_format then
            return lspkind.cmp_format { mode = "symbol_text", maxwidth = 80 }(entry, vim_item)
          end
          return vim_item
        end,
      },

      performance = {
        debounce = 75,
        throttle = 30,
      },

      experimental = {
        ghost_text = false,
      },
    }

    if luasnip then
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  end,
}
