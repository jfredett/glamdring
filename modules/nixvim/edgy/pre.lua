-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

-- this is used to dump notify history into a buffer, that can then be used by edgy
local function open_notify_history()
  local notify = require("notify")
  local history = notify.history()

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "notify"

  local level_names = {
    [vim.log.levels.TRACE] = "TRACE",
    [vim.log.levels.DEBUG] = "DEBUG",
    [vim.log.levels.INFO]  = "INFO",
    [vim.log.levels.WARN]  = "WARN",
    [vim.log.levels.ERROR] = "ERROR",
  }

  local lines = {}

  for _, msg in ipairs(history) do
    -- ---- title ----
    local title = ""
    if type(msg.title) == "string" then
      title = "[" .. msg.title .. "] "
    elseif type(msg.title) == "table" then
      title = "[" .. tostring(msg.title[1] or "") .. "] "
    end

    -- ---- level ----
    local level = ""
    if level_names[msg.level] then
      level = "(" .. level_names[msg.level] .. ") "
    end

    -- ---- message (NO vim.split) ----
    if type(msg.message) == "string" then
      table.insert(lines, title .. level .. msg.message)

    elseif type(msg.message) == "table" then
      for _, chunk in ipairs(msg.message) do
        if type(chunk) == "string" then
          table.insert(lines, title .. level .. chunk)
        elseif type(chunk) == "table" then
          table.insert(lines, title .. level .. tostring(chunk[1] or ""))
        end
      end
    end

    table.insert(lines, "")
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_set_current_buf(buf)
end

-- this creates :NotifyHistory to invoke the above
vim.api.nvim_create_user_command("NotifyHistory", open_notify_history, {})

-- this refreshes the history automatically
vim.api.nvim_create_autocmd("User", {
  pattern = "Notify",
  callback = function()
    if vim.bo.filetype == "notify" then
      vim.cmd("NotifyHistory")
    end
  end,
})

