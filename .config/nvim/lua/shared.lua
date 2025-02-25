local M = {}

local function decode_json_file(filename)
  local file = io.open(filename, "r")
  if file then
    local content = file:read "*all"
    file:close()

    local ok, data = pcall(vim.fn.json_decode, content)
    if ok and type(data) == "table" then return data end
  end
end

local function has_nested_key(json, ...) return vim.tbl_get(json, ...) ~= nil end

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

M.decode_json_file = decode_json_file
M.has_nested_key = has_nested_key
M.has_words_before = has_words_before

return M
