local aoc_table = require "aoc.table"

local Set = {}
Set.__index = Set

function Set.new(items)
  items = items or {}

  local data = {}
  for _, value in pairs(items) do
    data[value] = true
  end

  return setmetatable({ data = data }, Set)
end

function Set:add(item)
  self.data[item] = true
  return self
end

function Set:has(item)
  return self.data[item] or false
end

function Set:values()
  return coroutine.wrap(function()
    for item, _ in pairs(self.data) do
      coroutine.yield(item)
    end
  end)
end

function Set:intersection(other)
  local intersection = Set.new()
  for item in self:values() do
    if other:has(item) then
      intersection:add(item)
    end
  end
  return intersection
end

function Set:size()
  return aoc_table.count(self.data)
end

return Set
