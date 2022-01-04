local issues = require "youtrack.issues"
local projects = require "youtrack.projects"

local ok, _ = pcall(require, "plenary.curl")
if not ok then
  error "Could not find plenary.curl.  Require it in packer..."
end

return {
  issues = issues,
  projects = projects,
}
