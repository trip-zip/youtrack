local issues = require "youtrack.issues"
local projects = require "youtrack.projects"
local ok, _ = pcall(require, "plenary.curl")
if not ok then
  error "Could not find plenary.curl.  Require it in packer..."
end

local function connect()
  vim.notify "Connecting to youtrack..."
end
print(Local)

return {
  connect = connect,
  issues = issues,
  projects = projects,
}
