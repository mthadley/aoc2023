local M = {}

function M.count(tbl, fn)
  fn = fn or function() return true end
  local count = 0
  for key, val in pairs(tbl) do
    if fn(key, val) then
      count = count + 1
    end
  end
  return count
end

function M.sum(table, fn)
  fn = fn or function(num) return num end
  local sum = 0
  for key, value in pairs(table) do
    sum = sum + fn(value, key)
  end
  return sum
end

function M.product(table, fn)
  fn = fn or function(num) return num end
  local product = 1
  for key, value in pairs(table) do
    product = product * fn(value, key)
  end
  return product
end

return M
