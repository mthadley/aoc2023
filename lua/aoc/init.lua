local M = {}

local default_options = {
  run = function() end,
  answer = nil
}

local function play_day(num, options)
  options = options or default_options
  local answer = options.run()

  local result = ""
  if answer == nil then
    result = "❔"
  elseif answer == options.answer then
    result = "✅"
  else
    result = "❌"
  end

  print(("Part %d: %s %s\n"):format(num, tostring(answer), result))
end

function M.play(options)
  play_day(1, options.part1)
  play_day(2, options.part2)
end

return M
