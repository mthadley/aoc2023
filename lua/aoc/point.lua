local Point = {}
Point.__index = Point

function Point.new(x, y)
  return setmetatable({ x = x, y = y}, Point)
end

local CARDINALS = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
local ORDINALS = {{1, 1}, {-1, 1}, {1, -1}, {-1, -1}}

function Point:cardinals()
  local points = {}
  for _, v in ipairs(CARDINALS) do
    table.insert(points, self + Point.new(unpack(v)))
  end
  return points
end

function Point:ordinals()
  local points = {}
  for _, v in ipairs(ORDINALS) do
    table.insert(points, self + Point.new(unpack(v)))
  end
  return points
end

function Point:principals()
  local points = self:cardinals()
  local ords = self:ordinals()
  for _, point in ipairs(ords) do
    table.insert(points, point)
  end
  return points
end

function Point:__eq(other)
  return self.x == other.x and self.y == other.y
end

function Point:__add(other)
  return Point.new(self.x + other.x, self.y + other.y)
end

function Point:__tostring()
  return "(" .. self.x .. ", " .. self.y .. ")"
end

return Point
