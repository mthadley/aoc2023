#!/usr/bin/env nvim -l

local aoc = require "aoc"
local aoc_string = require "aoc.string"

local DIGIT_WORDS = {
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine",
}

local function calibration_value_from_word(line)
	local nums = {}
	for char, i in aoc_string.chars(line) do
		if char:match("%d") then
			table.insert(nums, char)
		else
			for word_value, word in ipairs(DIGIT_WORDS) do
				if line:sub(i, i + #word - 1) == word then
					table.insert(nums, word_value)
					break
				end
			end
		end
	end

	if #nums == 0 then
		return 0
	end
	return tonumber(nums[1] .. nums[#nums])
end

local function calibration_value_from_digit(line)
	local nums = {}
	for char in line:gmatch("%d") do
		table.insert(nums, char)
	end

	if #nums == 0 then
		return 0
	end
	return tonumber(nums[1] .. nums[#nums])
end

aoc.play {
	part1 = function()
		sum = 0
		for line in io.lines("bin/day1.txt") do
			sum = sum + calibration_value_from_digit(line)
		end
		return sum, 54968
	end,

	part2 = function()
		sum = 0
		for line in io.lines("bin/day1.txt") do
			sum = sum + calibration_value_from_word(line)
		end
		return sum, 54094
	end,
}
