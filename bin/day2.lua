#!/usr/bin/env nvim -l

local aoc = require "aoc"

local Game = {}

function Game:parse(line)
  match, id = line:match("(Game (%d+): )")

  local rounds = {}
  for round in line:sub(#match):gmatch("[^;]+") do
    local reveals  = {}
    for reveal in round:gmatch(" ([^,]+)") do
      local count, color = reveal:match("(%d+) (%a+)")
      reveals[color] = tonumber(count)
    end
    table.insert(rounds, reveals)
  end

  return setmetatable(
    {
      id = tonumber(id),
      rounds = rounds,
    },
    { __index = Game }
  )
end

local COLOR_QUOTAS = {
  ["red"] = 12,
  ["green"] = 13,
  ["blue"] = 14,
}

function Game:is_possible()
  for _, round in ipairs(self.rounds) do
    for color, count in pairs(round) do
      if count > COLOR_QUOTAS[color] then
        return false
      end
    end
  end
  return true
end

aoc.play {
  part1 = {
    run = function()
      local possible_sum = 0
      for line in io.lines("bin/day2.txt") do
        local game = Game:parse(line)
        if game:is_possible() then
          possible_sum = possible_sum + game.id
        end
      end
      return possible_sum
    end,
    answer = 2268
  },
}
