local actions = require "telescope.actions"
local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local conf = require("telescope.config").values
local entry_display = require "telescope.pickers.entry_display"
local action_state = require "telescope.actions.state"
local issues = require("youtrack").issues
local projects = require("youtrack").projects

local function search(opts)
  local displayer = entry_display.create {
    separator = " ",
    items = {
      { width = 40 },
      { width = 18 },
      { remaining = true },
    },
  }
  local make_display = function(entry)
    return displayer {
      entry.value .. " " .. entry.name,
      entry.shortName,
    }
  end

  pickers.new(opts, {
    prompt_title = "Issues",
    sorter = conf.generic_sorter(opts),
    finder = finders.new_table {
      results = issues.list(),
      entry_maker = function(entry)
        return {
          value = entry.idReadble,
          display = entry.idReadable .. ": " .. entry.summary,
          ordinal = entry.summary,
          --results = projects.list(),
          --entry_maker = function(entry)
          --return {
          --value = entry.id,
          --display = entry.name,
          --ordinal = entry.shortName,
        }
      end,
    },
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        -- print(vim.inspect(selection))
        vim.api.nvim_put({ selection[1] }, "", false, true)
      end)
      return true
    end,
  }):find()
end
search()

return require("telescope").register_extension {
  exports = {
    search = search,
  },
}
