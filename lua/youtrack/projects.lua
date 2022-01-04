local curl = require "plenary.curl"
local env = require "youtrack.env"

--Import these somehow.  Also make them global...
local base_url = "https://" .. env.subdomain .. ".myjetbrains.com/youtrack/api/"
local headers = {
  Authorization = "Bearer " .. env.token,
}

local function list()
  local opts = {
    headers = headers,
    query = {
      fields = "id,name,shortName",
    },
  }
  local res = curl.get(base_url .. "admin/projects", opts)
  vim.notify("Status: " .. tostring(res.status))
  print(vim.inspect(res.body))
end
--list()

return {
  list = list,
}
