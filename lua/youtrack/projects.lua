local curl = require "plenary.curl"
local token = vim.env.YOUTRACK_TOKEN
local subdomain = vim.env.YOUTRACK_SUBDOMAIN

local base_url = "https://" .. subdomain .. ".myjetbrains.com/youtrack/api/"
local headers = {
  Authorization = "Bearer " .. token,
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

local function get()
  local id = vim.fn.input "Enter project id: "
  local opts = {
    headers = headers,
    query = {
      fields = "id,name,shortName",
    },
  }
  local res = curl.get(base_url .. "admin/projects" .. id, opts)
  vim.notify("Status: " .. tostring(res.status))
  print(vim.inspect(res.body))
end
--get()

return {
  list = list,
  get = get,
}
