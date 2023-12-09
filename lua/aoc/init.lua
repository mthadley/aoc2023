local M = {}

local function play_day(num, fn)
  fn = fn or function() end
  local answer, expected = fn()

  local result = ""
  if expected == nil then
    result = "❔"
  elseif expected == answer then
    result = "✅"
  else
    result = "❌"
  end

  print(("Part %d: %s %s\n"):format(num, tostring(answer or ""), result))
end

function M.play(options)
  play_day(1, options.part1)
  play_day(2, options.part2)
end

return M
