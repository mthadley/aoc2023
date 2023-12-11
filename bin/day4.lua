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

function Card:num_matching()
  return self.winning_nums:intersection(self.nums):size()
end

function Card:points()
  local count = self:num_matching()
  if count == 0 then return 0 end
  return 2 ^ (count - 1)
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
  end,

  part2 = function()
    local cards = {}
    for line in io.lines("bin/day4.txt") do
      table.insert(cards, Card.parse(line))
    end

    local card_counts = aoc_table.fill(#cards, 1)
    for i, card in ipairs(cards) do
      for j = i + 1, i + card:num_matching() do
        card_counts[j] = card_counts[j] + card_counts[i]
      end
    end

    return aoc_table.sum(card_counts), 8549735
  end
}
