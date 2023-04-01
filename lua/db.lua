local Drawer = require("db.drawer")
local Handler = require("db.handler")
local UI = require("db.ui")
local M = {}

---@alias setup_opts { connections: { name: string, type: string, url: string }, lazy: boolean }

-- is the plugin loaded?
local loaded = false
---@type setup_opts
local setup_opts = {}

local function lazy_setup()
  local opts = setup_opts

  local ui_drawer = UI:new { win_cmd = "to 40vsplit" }
  if not ui_drawer then
    return
  end

  local editor_win_cmd = function()
    -- TODO: check if tree is the only window etc.
    vim.cmd("vsplit")
  end

  local ui_editor = UI:new { win_cmd = editor_win_cmd }
  if not ui_editor then
    return
  end

  local handler = Handler:new { connections = opts.connections, editor_ui = ui_editor, win_cmd = "bo 15split" }
  if not handler then
    print("error in handler setup")
    return
  end

  M.drawer = Drawer:new {
    handler = handler,
    ui = ui_drawer,
  }

  loaded = true
end

---@param opts setup_opts
function M.setup(opts)
  setup_opts = opts or {}
  if setup_opts.lazy then
    return
  end
  lazy_setup()
end

function M.open_ui()
  if not loaded then
    lazy_setup()
  end
  M.drawer:render()
end

function M.close_ui()
  if not loaded then
    lazy_setup()
  end
  M.drawer:close()
end

return M
