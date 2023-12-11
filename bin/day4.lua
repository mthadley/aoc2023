#!/usr/bin/env nvim -l

local aoc = require "aoc"
local aoc_table = require "aoc.table"
local Set = require "aoc.set"

local Card = {}

local function parse_nums(str)
  local nums = Set.new()
  for digits in str:gmatch("%d+") do
    nums:add(tonumber(digits))
  end
  return nums
end

function Card.parse(line)
  local winning, nums = line:match("Card%s+%d+:%s+(.+) | (.+)")

  return setmetatable(
    { winning_nums = parse_nums(winning), nums = parse_nums(nums) },
    { __index = Card }
  )
end

function Card:points()
  local count = self.winning_nums:intersection(self.nums):size()
  if count == 0 then return 0 end
  return 2 ^ (count - 1)
end

function Card:is_winning_num(num)
  return self.winning_nums()
end

aoc.play {
  part1 = function()
    local cards = {}
    for line in io.lines("bin/day4.txt") do
      table.insert(cards, Card.parse(line))
    end

    return aoc_table.sum(
      cards,
      function(card) return card:points() end
    ), 21213
  end
}
