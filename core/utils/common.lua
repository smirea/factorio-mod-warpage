local Common = {}

local DIRECTION_COUNT = 8
local DEFAULT_POSITION_EPSILON = 0.0001
local HOLOGRAPHIC_TEXT_ENTITY_NAME = "compi-speech-bubble"

---@param _value unknown
---@param _name string
function Common.ensure_table(_value, _name) end

---@param _value unknown
---@param _name string
function Common.ensure_non_empty_string(_value, _name) end

---@param _value unknown
---@param _name string
function Common.ensure_function(_value, _name) end

---@param _value unknown
---@param _name string
function Common.ensure_boolean(_value, _name) end

---@param _value unknown
---@param _name string
function Common.ensure_direction(_value, _name) end

---@param _value unknown
---@param _name string
function Common.ensure_position(_value, _name) end

---@param position MapPosition
---@return MapPosition
function Common.copy_position(position)
  return {
    x = position.x,
    y = position.y
  }
end

---@param direction WarpageDirection|integer
---@return WarpageDirection
function Common.normalize_direction(direction)
  local normalized = direction % DIRECTION_COUNT
  ---@cast normalized WarpageDirection
  return normalized
end

---@param offset MapPosition
---@param direction WarpageDirection|integer
---@return MapPosition
function Common.rotate_offset(offset, direction)
  local normalized_direction = Common.normalize_direction(direction)

  if normalized_direction == defines.direction.north then
    return { x = offset.x, y = offset.y }
  end

  if normalized_direction == defines.direction.east then
    return { x = -offset.y, y = offset.x }
  end

  if normalized_direction == defines.direction.south then
    return { x = -offset.x, y = -offset.y }
  end

  if normalized_direction == defines.direction.west then
    return { x = offset.y, y = -offset.x }
  end

  local angle = (normalized_direction * math.pi) / 4
  local cos_angle = math.cos(angle)
  local sin_angle = math.sin(angle)

  return {
    x = (offset.x * cos_angle) - (offset.y * sin_angle),
    y = (offset.x * sin_angle) + (offset.y * cos_angle)
  }
end

---@param left MapPosition
---@param right MapPosition
---@param epsilon? number
---@return boolean
function Common.positions_match(left, right, epsilon)
  local threshold = epsilon
  if threshold == nil then
    threshold = DEFAULT_POSITION_EPSILON
  end

  return math.abs(left.x - right.x) <= threshold
    and math.abs(left.y - right.y) <= threshold
end

---@param event_name string
---@return integer
function Common.required_event_id(event_name)
  return defines.events[event_name]
end

---@param event_name string
---@return integer|nil
function Common.optional_event_id(event_name)
  return defines.events[event_name]
end

---@param options WarpageHolographicTextOptions
---@return WarpageCleanupFn, MapPosition
function Common.create_holographic_text(options)
  local target_offset = options.target_offset
  if target_offset == nil then
    target_offset = { x = 0, y = 0 }
  end

  local map_position = {
    x = options.target.position.x + target_offset.x,
    y = options.target.position.y + target_offset.y
  }

  local speech_bubble = options.surface.create_entity({
    name = HOLOGRAPHIC_TEXT_ENTITY_NAME,
    position = map_position,
    target = options.target,
    text = options.text,
    lifetime = options.time_to_live
  })

  local function cleanup()
    if speech_bubble ~= nil and speech_bubble.valid == true then
      speech_bubble.destroy()
    end
  end

  return cleanup, map_position
end

return Common
