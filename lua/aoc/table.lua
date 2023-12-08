local M = {}

function M.count(tbl, fn)
  local count = 0
  for key, val in pairs(tbl) do
    if fn(key, val) then
      count = count + 1
    end
  end
  return count
end

return M
