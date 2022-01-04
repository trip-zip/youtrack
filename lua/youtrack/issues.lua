local curl = require('plenary.curl')
--Import these somehow.  Also make them global...
local base_url = 'https://${}.myjetbrains.com/youtrack/api/'
local token = ''
local headers = {
  Authorization = 'Bearer ' .. token
}

local function list()
  local opts = {
    headers = headers,
    query = {
      fields = 'summary,idReadable,reporter(name),commentsCount',
      query = 'for: me #Unresolved',
      ['$top'] = 5
    }
  }
  local res = curl.get(base_url .. 'issues', opts)
  vim.notify('Status: ' .. tostring(res.status))
  print(res.body)
end
--list()

local function get(id)
  local opts = {
    headers = headers,
    query = {
      fields = 'summary,idReadable,reporter(name)',
    }
  }
  local res = curl.get(base_url .. 'issues/' .. id, opts)
  vim.notify('Status: ' .. tostring(res.status))
  print(vim.inspect(res.body))
end
--get('GA-17640')

local function create()
end

local function comment()
end

local function close()
end

return {
  list = list,
  get = get,
  create = create,
  comment = comment,
  close = close,
}
