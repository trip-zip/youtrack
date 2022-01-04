local curl = require "plenary.curl"
local env = require "youtrack.env"

--Import these somehow.  Also make them global...
local base_url = "https://" .. env.subdomain .. ".myjetbrains.com/youtrack/api/"
local headers = {
  Accept = "application/json",
  ["Content-Type"] = "application/json",
  Authorization = "Bearer " .. env.token,
}

local function list()
  local opts = {
    headers = headers,
    query = {
      fields = "summary,idReadable,reporter(name),commentsCount,comments(author(name),text,created)",
      query = "for: me #Unresolved",
      ["$top"] = 5,
    },
  }
  local res = curl.get(base_url .. "issues", opts)
  vim.notify("Status: " .. tostring(res.status))
  print(vim.inspect(res.body))
end
--list()

local function get(id)
  local opts = {
    headers = headers,
    query = {
      fields = "summary,idReadable,reporter(name),commentsCount,comments(author(name),text,created)",
    },
  }
  local res = curl.get(base_url .. "issues/" .. id, opts)
  vim.notify("Status: " .. tostring(res.status))
  print(vim.inspect(res.body))
end
get "GA-17640"

local function create()
  local opts = {
    headers = headers,
    body = vim.fn.json_encode {
      summary = "Test issue",
      description = "This is a test issue",
      project = {
        id = "81-5",
      },
      customFields = {
        {
          name = "Assignee",
          ["$type"] = "SingleUserIssueCustomField",
          value = {
            login = "jimmy_cozza",
          },
        },
      },
    },
  }
  local res = curl.post(base_url .. "issues", opts)
  vim.notify("Status: " .. tostring(res.status))
  print(vim.inspect(res.body))
end
--create()

local function comment() end

local function close() end

return {
  list = list,
  get = get,
  create = create,
  comment = comment,
  close = close,
}
