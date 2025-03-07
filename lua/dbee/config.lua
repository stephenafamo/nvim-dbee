local config = {}

---@mod dbee.ref.config Dbee Configuration

-- Configuration object.
---@class Config
---@field sources Source[] list of connection sources
---@field extra_helpers table<string, table<string, string>>
---@field drawer drawer_config
---@field editor editor_config
---@field result result_config
---@field call_log call_log_config
---@field window_layout Layout

---@class Candy
---@field icon string
---@field icon_highlight string
---@field text_highlight string

---Keymap options.
---@alias key_mapping { key: string, mode: string, opts: table, action: string|fun() }

---@divider -

---Configuration for result UI tile.
---@alias result_config { mappings: key_mapping[], page_size: integer, progress: progress_config }

---Configuration for editor UI tile.
---@alias editor_config { directory: string, mappings: key_mapping[] }

---Configuration for call log UI tile.
---@alias call_log_config { mappings: key_mapping[], disable_candies: boolean, candies: table<string, Candy> }

---Configuration for drawer UI tile.
---@alias drawer_config { disable_candies: boolean, candies: table<string, Candy>, mappings: key_mapping[], disable_help: boolean }

---@divider -

-- DOCGEN_START
---Default configuration.
---To see defaults, run :lua= require"dbee.config".default
---@type Config config
config.default = {
  -- loads connections from files and environment variables
  sources = {
    require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
    require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
  },
  -- extra table helpers per connection type
  -- every helper value is a go-template with values set for
  -- "Table", "Schema" and "Materialization"
  extra_helpers = {
    -- example:
    -- ["postgres"] = {
    --   ["List All"] = "select * from {{ .Table }}",
    -- },
  },
  -- drawer window config
  drawer = {
    -- show help or not
    disable_help = false,
    -- mappings for the buffer
    mappings = {
      -- quit the dbee interface
      { key = "q", mode = "n", action = "quit" },
      -- manually refresh drawer
      { key = "r", mode = "n", action = "refresh" },
      -- actions perform different stuff depending on the node:
      -- action_1 opens a note or executes a helper
      { key = "<CR>", mode = "n", action = "action_1" },
      -- action_2 renames a note or sets the connection as active manually
      { key = "cw", mode = "n", action = "action_2" },
      -- action_3 deletes a note or connection (removes connection from the file if you configured it like so)
      { key = "dd", mode = "n", action = "action_3" },
      -- these are self-explanatory:
      -- { key = "c", mode = "n", action = "collapse" },
      -- { key = "e", mode = "n", action = "expand" },
      { key = "o", mode = "n", action = "toggle" },
      -- mappings for menu popups:
      { key = "<CR>", mode = "n", action = "menu_confirm" },
      { key = "y", mode = "n", action = "menu_yank" },
      { key = "<Esc>", mode = "n", action = "menu_close" },
      { key = "q", mode = "n", action = "menu_close" },
    },
    -- icon settings:
    disable_candies = false,
    candies = {
      -- these are what's available for now:
      history = {
        icon = "",
        icon_highlight = "Constant",
        text_highlight = "",
      },
      note = {
        icon = "",
        icon_highlight = "Character",
        text_highlight = "",
      },
      connection = {
        icon = "󱘖",
        icon_highlight = "SpecialChar",
        text_highlight = "",
      },
      database_switch = {
        icon = "",
        icon_highlight = "Character",
      },
      table = {
        icon = "",
        icon_highlight = "Conditional",
        text_highlight = "",
      },
      view = {
        icon = "",
        icon_highlight = "Debug",
        text_highlight = "",
      },
      add = {
        icon = "",
        icon_highlight = "String",
        text_highlight = "String",
      },
      edit = {
        icon = "󰏫",
        icon_highlight = "Directory",
        text_highlight = "Directory",
      },
      remove = {
        icon = "󰆴",
        icon_highlight = "SpellBad",
        text_highlight = "SpellBad",
      },
      help = {
        icon = "󰋖",
        icon_highlight = "Title",
        text_highlight = "Title",
      },
      source = {
        icon = "󰃖",
        icon_highlight = "MoreMsg",
        text_highlight = "MoreMsg",
      },

      -- if there is no type
      -- use this for normal nodes...
      none = {
        icon = " ",
      },
      -- ...and use this for nodes with children
      none_dir = {
        icon = "",
        icon_highlight = "NonText",
      },

      -- chevron icons for expanded/closed nodes
      node_expanded = {
        icon = "",
        icon_highlight = "NonText",
      },
      node_closed = {
        icon = "",
        icon_highlight = "NonText",
      },
    },
  },

  -- results window config
  result = {
    -- number of rows in the results set to display per page
    page_size = 100,

    -- progress (loading) screen options
    progress = {
      -- spinner to use in progress display
      spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
      -- prefix to display before the timer
      text_prefix = "Executing...",
    },

    -- mappings for the buffer
    mappings = {
      -- next/previous page
      { key = "L", mode = "", action = "page_next" },
      { key = "H", mode = "", action = "page_prev" },
      -- yank rows as csv/json
      { key = "yaj", mode = "n", action = "yank_current_json" },
      { key = "yaj", mode = "v", action = "yank_selection_json" },
      { key = "yaJ", mode = "", action = "yank_all_json" },
      { key = "yac", mode = "n", action = "yank_current_csv" },
      { key = "yac", mode = "v", action = "yank_selection_csv" },
      { key = "yaC", mode = "", action = "yank_all_csv" },

      -- cancel current call execution
      { key = "<C-c>", mode = "", action = "cancel_call" },
    },
  },

  -- editor window config
  editor = {
    -- mappings for the buffer
    mappings = {
      -- run what's currently selected on the active connection
      { key = "BB", mode = "v", action = "run_selection" },
      -- run the whole file on the active connection
      { key = "BB", mode = "n", action = "run_file" },
    },
  },

  -- call log window config
  call_log = {
    -- mappings for the buffer
    mappings = {
      -- show the result of the currently selected call record
      { key = "<CR>", mode = "", action = "show_result" },
      -- cancel the currently selected call (if its still executing)
      { key = "<C-c>", mode = "", action = "cancel_call" },
    },

    -- candies (icons and highlights)
    disable_candies = false,
    candies = {
      -- all of these represent call states
      unknown = {
        icon = "", -- this or first letters of state
        icon_highlight = "NonText", -- highlight of the state
        text_highlight = "", -- highlight of the rest of the line
      },
      executing = {
        icon = "󰑐",
        icon_highlight = "Constant",
        text_highlight = "Constant",
      },
      executing_failed = {
        icon = "󰑐",
        icon_highlight = "Error",
        text_highlight = "",
      },
      retrieving = {
        icon = "",
        icon_highlight = "String",
        text_highlight = "String",
      },
      retrieving_failed = {
        icon = "",
        icon_highlight = "Error",
        text_highlight = "",
      },
      archived = {
        icon = "",
        icon_highlight = "Title",
        text_highlight = "",
      },
      archive_failed = {
        icon = "",
        icon_highlight = "Error",
        text_highlight = "",
      },
      canceled = {
        icon = "",
        icon_highlight = "Error",
        text_highlight = "",
      },
    },
  },

  -- window layout
  window_layout = require("dbee.layouts").Default:new(),
}
-- DOCGEN_END

-- Validates provided input config
---@package
---@param cfg Config
function config.validate(cfg)
  vim.validate {
    sources = { cfg.sources, "table" },
    extra_helpers = { cfg.extra_helpers, "table" },

    drawer_disable_candies = { cfg.drawer.disable_candies, "boolean" },
    drawer_disable_help = { cfg.drawer.disable_help, "boolean" },
    drawer_candies = { cfg.drawer.candies, "table" },
    drawer_mappings = { cfg.drawer.mappings, "table" },
    result_page_size = { cfg.result.page_size, "number" },
    result_progress = { cfg.result.progress, "table" },
    result_mappings = { cfg.result.mappings, "table" },
    editor_mappings = { cfg.editor.mappings, "table" },
    call_log_mappings = { cfg.call_log.mappings, "table" },

    window_layout = { cfg.window_layout, "table" },
    window_layout_open = { cfg.window_layout.open, "function" },
    window_layout_close = { cfg.window_layout.close, "function" },
  }
end

return config
