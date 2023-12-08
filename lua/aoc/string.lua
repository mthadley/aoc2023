local M = {}

function M.chars(str)
  return coroutine.wrap(function()
    for i = 1, #str do
      coroutine.yield(str:sub(i, i), i)
    end
  end)
end

return M
