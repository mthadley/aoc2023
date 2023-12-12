#!/usr/bin/env nvim -l

local aoc = require "aoc"
local aoc_string = require "aoc.string"
local aoc_table = require "aoc.table"
local Point = require "aoc.point"

local Grid = {}

function Grid.parse(file)
	local rows = {}
	for line in io.lines(file) do
		table.insert(rows, line)
	end

	return setmetatable({ rows = rows }, { __index = Grid })
end

function Grid:part_numbers()
	local numbers = {}

	for y, row in ipairs(self.rows) do
		local has_symbol = false
		local number = ""

		for char, x in aoc_string.chars(row) do
			if char:match("%d") then
				number = number .. char
				for _, point in ipairs(Point.new(x, y):principals()) do
					if
						point.y > 0
						and point.y <= #self.rows
						and self.rows[point.y]:sub(point.x, point.x):match("[^%.%d]")
					then
						has_symbol = true
						break
					end
				end
			else
				if number ~= "" and has_symbol then
					table.insert(numbers, tonumber(number))
				end

				has_symbol = false
				number = ""
			end

			if has_symbol and x >= #self.rows[1] then
				table.insert(numbers, tonumber(number))
			end
		end
	end

	return numbers
end

function Grid:ratios()
	local ratios = {}

	for y, row in ipairs(self.rows) do
		for char, x in aoc_string.chars(row) do
			if char == "*" then
				local numbers = {}
				for _, point in ipairs(Point.new(x, y):principals()) do
					local number = ""
					if
						point.y > 0
						and point.y <= #self.rows
						and self.rows[point.y]:sub(point.x, point.x):match("%d")
					then
						local number_start = point.x
						for i = point.x, 1, -1 do
							if not self.rows[point.y]:sub(i, i):match("%d") then
								break
							end
							number_start = i
						end

						numbers[tonumber(self.rows[point.y]:match("%d+", number_start))] = true
					end
				end

				if aoc_table.count(numbers) == 2 then
					table.insert(
						ratios,
						aoc_table.product(numbers, function(_, key)
							return key
						end)
					)
				end
			end
		end
	end

	return ratios
end

aoc.play {
	part1 = function()
		return aoc_table.sum(Grid.parse("bin/day3.txt"):part_numbers()), 528799
	end,

	part2 = function()
		return aoc_table.sum(Grid.parse("bin/day3.txt"):ratios()), 84907174
	end,
}
