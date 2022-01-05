local curl = require "plenary.curl"
local token = vim.env.YOUTRACK_TOKEN
local subdomain = vim.env.YOUTRACK_SUBDOMAIN

local base_url = "https://" .. subdomain .. ".myjetbrains.com/youtrack/api/"
local headers = {
  Accept = "application/json",
  ["Content-Type"] = "application/json",
  Authorization = "Bearer " .. token,
}

local function list()
  local opts = {
    headers = headers,
    query = {
      fields = "summary,idReadable",
      --fields = "summary,idReadable,reporter(name),commentsCount,comments(author(name),created)",
      --query = "for: me #Unresolved",
      ["$top"] = 50,
    },
  }
  local res = curl.get(base_url .. "issues", opts)
  vim.notify("Status: " .. tostring(res.status))
  return vim.fn.json_decode(res.body)
end
list()

local function get()
  local id = vim.fn.input "Enter issue id: "
  if not id or id == "" then
    error "No id provided"
  end
  local opts = {
    headers = headers,
    query = {
      fields = "summary,idReadable,reporter(name),commentsCount,comments(author(name),created)",
    },
  }
  local res = curl.get(base_url .. "issues/" .. id, opts)
  vim.notify("Status: " .. tostring(res.status))
  return vim.fn.json_decode(res.body)
end
--get()

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

local function comment()
  local id = vim.fn.input "Enter issue id: "
  if not id or id == "" then
    error "No id provided"
  end
  local opts = {
    headers = headers,
    body = vim.fn.json_encode {
      text = vim.fn.input "Enter comment: ",
    },
  }
  local res = curl.post(base_url .. "issues/" .. id .. "/comments", opts)
  vim.notify("Status: " .. tostring(res.status))
  print(vim.inspect(res.body))
end
--comment()

local function close() end

return {
  list = list,
  get = get,
  create = create,
  comment = comment,
  close = close,
}
