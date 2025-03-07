local tools = require("dbee.layouts.tools")

---@mod dbee.ref.layout UI Layout
---@brief [[
---Defines the layout of UI windows.
---The default layout is already defined, but it's possible to define your own layout.
---
---Layout implementation should implement the |Layout| interface and show the UI on screen
---as seen fit.
---@brief ]]

---Layout UIs that are passed to ̏|Layout| open method.
---@alias layout_uis { drawer: DrawerUI, editor: EditorUI, result: ResultUI, call_log: CallLogUI }

-- Layout that defines how windows are opened.
---@class Layout
---@field open fun(self: Layout, uis: layout_uis) function to open ui.
---@field close fun(self: Layout) function to close ui.

local layouts = {}

---@divider -

-- Default layout uses a helper to save the existing window layout before opening any windows,
-- then makes a new empty window for the editor and then opens result and drawer.
-- When later calling close(), the previously saved layout is restored.
---@class DefaultLayout: Layout
---@field private egg? layout_egg
---@field private windows integer[]
layouts.Default = {}

---Create a default layout.
---@return Layout
function layouts.Default:new()
  local o = {
    egg = nil,
    windows = {},
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

---@package
---@param uis layout_uis
function layouts.Default:open(uis)
  -- save layout before opening ui
  self.egg = tools.save()

  self.windows = {}

  -- editor
  tools.make_only(0)
  local editor_win = vim.api.nvim_get_current_win()
  table.insert(self.windows, editor_win)
  uis.editor:show(editor_win)

  -- result
  vim.cmd("bo 15split")
  local win = vim.api.nvim_get_current_win()
  table.insert(self.windows, win)
  uis.result:show(win)

  -- drawer
  vim.cmd("to 40vsplit")
  win = vim.api.nvim_get_current_win()
  table.insert(self.windows, win)
  uis.drawer:show(win)

  -- call log
  vim.cmd("belowright 15split")
  win = vim.api.nvim_get_current_win()
  table.insert(self.windows, win)
  uis.call_log:show(win)

  -- set cursor to drawer
  vim.api.nvim_set_current_win(editor_win)
end

---@package
function layouts.Default:close()
  -- close all windows
  for _, win in ipairs(self.windows) do
    pcall(vim.api.nvim_win_close, win, false)
  end

  -- restore layout
  tools.restore(self.egg)
  self.egg = nil
end

return layouts
