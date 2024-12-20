local M = {}

-- Create the content for LSP info
function M.create_lsp_info_content()
  local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
  local lines = {}

  if #buf_clients == 0 then
    return nil, "No LSP clients attached to this buffer"
  end

  table.insert(lines, "LSP Clients:")
  table.insert(lines, "")
  table.insert(lines, string.format("Active Clients: %d", #buf_clients))
  table.insert(lines, "------------")
  table.insert(lines, "")

  for _, client in ipairs(buf_clients) do
    table.insert(lines, string.format("• %s", client.name))
    table.insert(lines, string.format("  - ID: %d", client.id))
    -- table.insert(lines, string.format("  - Version: %s", client.server_capabilities.serverInfo.version or "0.0"))
    table.insert(lines, string.format("  - Root dir: %s", client.config.root_dir or "Not set"))
    if client.config.filetypes then
      local filetypes = table.concat(client.config.filetypes, ", ")
      table.insert(lines, string.format("  - Filetypes: %s", filetypes))
    end

    -- Get supported server capabilities
    local caps = {}
    if client.server_capabilities.documentFormattingProvider then
      table.insert(caps, "formatting")
    end
    if client.server_capabilities.documentRangeFormattingProvider then
      table.insert(caps, "range formatting")
    end
    if client.server_capabilities.documentHighlightProvider then
      table.insert(caps, "document highlights")
    end
    if client.server_capabilities.hoverProvider then
      table.insert(caps, "hover")
    end
    if client.server_capabilities.referencesProvider then
      table.insert(caps, "references")
    end
    if client.server_capabilities.definitionProvider then
      table.insert(caps, "definitions")
    end

    if #caps > 0 then
      table.insert(lines, "  - Capabilities: " .. table.concat(caps, ", "))
    end

    -- NOTE: Debug: Print client settings
    -- if client.config.settings and type(client.config.settings) == "table" then
    --   local settings = vim.inspect(client.config.settings)
    --   table.insert(lines, "  - Settings:")
    --   for setting_line in settings:gmatch("[^\r\n]+") do
    --     table.insert(lines, "    " .. setting_line)
    --   end
    -- end

    table.insert(lines, "")
  end

  return lines
end

-- Calculate window dimensions and position
function M.calculate_window_layout()
  local padding = 1
  local width = 60
  local editor_width = vim.o.columns
  local editor_height = vim.o.lines

  return {
    relative = "editor",
    width = width,
    height = 0, -- Will be set based on content
    row = padding,
    col = math.floor((editor_width - width) / 2),
    style = "minimal",
    border = "rounded",
  }
end

-- Set up buffer options and keymaps
function M.setup_buffer(buf)
  -- Set buffer options
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  -- Set buffer local keymaps
  local opts = { noremap = true, silent = true, buffer = buf }
  vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
  vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", opts)
end

-- Set up window options
function M.setup_window(win)
  vim.api.nvim_win_set_option(win, "wrap", false)
  vim.api.nvim_win_set_option(win, "cursorline", true)
end

-- Apply highlighting
function M.apply_highlights(buf, lines)
  vim.api.nvim_buf_add_highlight(buf, -1, "Title", 0, 0, -1)
  vim.api.nvim_buf_add_highlight(buf, -1, "Comment", 1, 0, -1)
  -- Highlight LSP client names
  for i, line in ipairs(lines) do
    if line:match("^• ") then
      -- Highlight client names
      vim.api.nvim_buf_add_highlight(buf, -1, "Special", i - 1, 2, -1)
    elseif line:match("^  %-") then
      -- Highlight labels (Version:, ID:, etc.)
      local label_end = line:find(":")
      if label_end then
        vim.api.nvim_buf_add_highlight(buf, -1, "Identifier", i - 1, 4, label_end)
      end
    end
  end
end

-- Main function to show LSP info
function M.show_lsp_info(opts)
  -- Get content
  local lines, error = M.create_lsp_info_content()
  if not lines then
    vim.notify(error, vim.log.levels.WARN)
    return
  end

  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)

  -- Calculate layout
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }
  -- local win_opts = M.calculate_window_layout()
  -- win_opts.height = #lines -- Set height based on content

  -- Create window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  -- Set content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Setup buffer and window
  M.setup_buffer(buf)
  M.setup_window(win)
  M.apply_highlights(buf, lines)
end

return M
