local Common = {}

local DIRECTION_COUNT = 8
local DEFAULT_POSITION_EPSILON = 0.0001
local HOLOGRAPHIC_TEXT_ENTITY_NAME = "compi-speech-bubble"

---@param value unknown
---@param name string
function Common.ensure_table(value, name)
  if type(value) ~= "table" then
    error(name .. " must be a table.")
  end
end

---@param value unknown
---@param name string
function Common.ensure_non_empty_string(value, name)
  if type(value) ~= "string" or value == "" then
    error(name .. " must be a non-empty string.")
  end
end

---@param value unknown
---@param name string
function Common.ensure_function(value, name)
  if type(value) ~= "function" then
    error(name .. " must be a function.")
  end
end

---@param value unknown
---@param name string
function Common.ensure_boolean(value, name)
  if type(value) ~= "boolean" then
    error(name .. " must be a boolean.")
  end
end

---@param value unknown
---@param name string
function Common.ensure_direction(value, name)
  if type(value) ~= "number" or value % 1 ~= 0 or value < 0 or value >= DIRECTION_COUNT then
    error(name .. " must be an integer direction between 0 and 7.")
  end
end

---@param value unknown
---@param name string
function Common.ensure_position(value, name)
  if type(value) ~= "table" then
    error(name .. " must be a MapPosition table.")
  end

  local x = value.x
  local y = value.y
  if type(x) ~= "number" or type(y) ~= "number" then
    error(name .. " must define numeric x and y.")
  end
end

---@param position MapPosition
---@return MapPosition
function Common.copy_position(position)
  Common.ensure_position(position, "position")
  return {
    x = position.x,
    y = position.y
  }
end

---@param direction WarpageDirection|integer
---@return WarpageDirection
function Common.normalize_direction(direction)
  if type(direction) ~= "number" or direction % 1 ~= 0 then
    error("direction must be an integer.")
  end

  local normalized = direction % DIRECTION_COUNT
  ---@cast normalized WarpageDirection
  return normalized
end

---@param offset MapPosition
---@param direction WarpageDirection|integer
---@return MapPosition
function Common.rotate_offset(offset, direction)
  Common.ensure_position(offset, "offset")

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
  local rotated_x = (offset.x * cos_angle) - (offset.y * sin_angle)
  local rotated_y = (offset.x * sin_angle) + (offset.y * cos_angle)

  return {
    x = rotated_x,
    y = rotated_y
  }
end

---@param left MapPosition
---@param right MapPosition
---@param epsilon? number
---@return boolean
function Common.positions_match(left, right, epsilon)
  Common.ensure_position(left, "left")
  Common.ensure_position(right, "right")

  local threshold = epsilon
  if threshold == nil then
    threshold = DEFAULT_POSITION_EPSILON
  elseif type(threshold) ~= "number" or threshold < 0 then
    error("epsilon must be a non-negative number.")
  end

  return math.abs(left.x - right.x) <= threshold
    and math.abs(left.y - right.y) <= threshold
end

---@param event_name string
---@return integer
function Common.required_event_id(event_name)
  Common.ensure_non_empty_string(event_name, "event_name")
  local event_id = defines.events[event_name]
  if type(event_id) ~= "number" then
    error("defines.events." .. event_name .. " must be a number.")
  end

  return event_id
end

---@param event_name string
---@return integer|nil
function Common.optional_event_id(event_name)
  Common.ensure_non_empty_string(event_name, "event_name")
  local event_id = defines.events[event_name]
  if event_id == nil then
    return nil
  end

  if type(event_id) ~= "number" then
    error("defines.events." .. event_name .. " must be a number.")
  end

  return event_id
end

---@param options WarpageHolographicTextOptions
---@return WarpageCleanupFn, MapPosition
function Common.create_holographic_text(options)
  Common.ensure_table(options, "options")
  if options.text == nil then
    error("options.text is required.")
  end

  if options.surface == nil then
    error("options.surface is required.")
  end

  if options.target == nil then
    error("options.target is required.")
  end

  if options.target.valid ~= true then
    error("options.target must be a valid LuaEntity.")
  end

  if options.target.surface ~= options.surface then
    error("options.target.surface must match options.surface.")
  end

  local target_offset = options.target_offset
  if target_offset == nil then
    target_offset = { x = 0, y = 0 }
  else
    Common.ensure_position(target_offset, "options.target_offset")
  end

  local lifetime = options.time_to_live
  if lifetime ~= nil and (type(lifetime) ~= "number" or lifetime % 1 ~= 0 or lifetime < 1) then
    error("options.time_to_live must be a positive integer when provided.")
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
    lifetime = lifetime
  })
  if speech_bubble == nil then
    error("surface.create_entity(...) must return a speech bubble entity.")
  end

  local function cleanup()
    if speech_bubble.valid ~= true then
      return
    end

    local destroyed = speech_bubble.destroy()
    if destroyed ~= true and speech_bubble.valid then
      error("Failed to destroy holographic text entity.")
    end
  end

  return cleanup, map_position
end

return Common
