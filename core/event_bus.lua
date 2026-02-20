---@class WarpageEventBusImpl: WarpageEventBus
local EventBus = {}
EventBus.__index = EventBus

---@class WarpageScopedBindingImpl: WarpageScopedBinding
local ScopedBinding = {}
ScopedBinding.__index = ScopedBinding

---@param value unknown
---@param name string
local function ensure_table(value, name)
  if type(value) ~= "table" then
    error(name .. " must be a table.")
  end
end

---@param source unknown
local function ensure_source(source)
  if type(source) ~= "string" or source == "" then
    error("Handler source must be a non-empty string.")
  end
end

---@param handler unknown
---@param source unknown
local function ensure_function(handler, source)
  if type(handler) ~= "function" then
    error("Handler from '" .. tostring(source) .. "' must be a function.")
  end
end

---@param event_id unknown
local function ensure_event_id(event_id)
  local event_type = type(event_id)
  if event_type ~= "number" and event_type ~= "string" then
    error("event_id must be a number or string.")
  end
end

---@param tick unknown
local function ensure_tick(tick)
  if type(tick) ~= "number" or tick < 1 or tick % 1 ~= 0 then
    error("nth tick value must be an integer greater than zero.")
  end
end

---@param map table<integer|string, unknown>
---@return (integer|string)[]
local function sorted_keys(map)
  local keys = {} ---@type (integer|string)[]
  for key in pairs(map) do
    ---@cast key integer|string
    keys[#keys + 1] = key
  end

  ---@param left integer|string
  ---@param right integer|string
  ---@return boolean
  table.sort(keys, function(left, right)
    local left_type = type(left)
    local right_type = type(right)
    if left_type == right_type then
      return left < right
    end

    return left_type < right_type
  end)

  return keys
end

---@param handlers WarpageHandlerEntry[]
---@param payload table|nil
local function dispatch(handlers, payload)
  for _, entry in ipairs(handlers) do
    entry.handler(payload)
  end
end

---@param map table<integer|string, WarpageHandlerEntry[]>
---@param key integer|string
---@param handler fun(payload: table|nil)
---@param source string
local function add_handler(map, key, handler, source)
  local handlers = map[key]
  if handlers == nil then
    handlers = {}
    map[key] = handlers
  end

  handlers[#handlers + 1] = {
    handler = handler,
    source = source
  }
end

---@param base string
---@param suffix string
---@return string
local function append_source(base, suffix)
  return base .. ":" .. suffix
end

---@return WarpageEventBus
function EventBus.new()
  return setmetatable({
    _bound = false,
    _on_init = {},
    _on_load = {},
    _on_configuration_changed = {},
    _events = {},
    _nth_tick = {}
  }, EventBus)
end

function EventBus:_assert_not_bound()
  if self._bound then
    error("EventBus is already bound; additional handlers are not allowed.")
  end
end

---@param handler unknown
---@param source unknown
function EventBus:_register_on_init(handler, source)
  self:_assert_not_bound()
  ensure_source(source)
  ensure_function(handler, source)
  ---@cast handler fun(payload: table|nil)
  ---@cast source string
  self._on_init[#self._on_init + 1] = { handler = handler, source = source }
end

---@param handler unknown
---@param source unknown
function EventBus:_register_on_load(handler, source)
  self:_assert_not_bound()
  ensure_source(source)
  ensure_function(handler, source)
  ---@cast handler fun(payload: table|nil)
  ---@cast source string
  self._on_load[#self._on_load + 1] = { handler = handler, source = source }
end

---@param handler unknown
---@param source unknown
function EventBus:_register_on_configuration_changed(handler, source)
  self:_assert_not_bound()
  ensure_source(source)
  ensure_function(handler, source)
  ---@cast handler fun(payload: table|nil)
  ---@cast source string
  self._on_configuration_changed[#self._on_configuration_changed + 1] = { handler = handler, source = source }
end

---@param event_id unknown
---@param handler unknown
---@param source unknown
function EventBus:_register_event(event_id, handler, source)
  self:_assert_not_bound()
  ensure_event_id(event_id)
  ensure_source(source)
  ensure_function(handler, source)
  ---@cast event_id integer|string
  ---@cast handler fun(payload: table|nil)
  ---@cast source string
  add_handler(self._events, event_id, handler, source)
end

---@param tick unknown
---@param handler unknown
---@param source unknown
function EventBus:_register_nth_tick(tick, handler, source)
  self:_assert_not_bound()
  ensure_tick(tick)
  ensure_source(source)
  ensure_function(handler, source)
  ---@cast tick integer
  ---@cast handler fun(payload: table|nil)
  ---@cast source string
  add_handler(self._nth_tick, tick, handler, source)
end

---@param source unknown
---@return WarpageScopedBinding
function EventBus:for_source(source)
  self:_assert_not_bound()
  ensure_source(source)
  ---@cast source string

  return setmetatable({
    _bus = self,
    _source = source
  }, ScopedBinding)
end

function EventBus:bind()
  self:_assert_not_bound()
  self._bound = true

  if #self._on_init > 0 then
    script.on_init(function()
      dispatch(self._on_init)
    end)
  end

  if #self._on_load > 0 then
    script.on_load(function()
      dispatch(self._on_load)
    end)
  end

  if #self._on_configuration_changed > 0 then
    script.on_configuration_changed(function(event)
      dispatch(self._on_configuration_changed, event)
    end)
  end

  for _, event_id in ipairs(sorted_keys(self._events)) do
    local handlers = self._events[event_id]
    if handlers ~= nil then
      script.on_event(event_id, function(event)
        dispatch(handlers, event)
      end)
    end
  end

  for _, tick in ipairs(sorted_keys(self._nth_tick)) do
    local handlers = self._nth_tick[tick]
    if handlers ~= nil then
      script.on_nth_tick(tick, function(event)
        dispatch(handlers, event)
      end)
    end
  end
end

---@param handler fun()
function ScopedBinding:on_init(handler)
  self._bus:_register_on_init(handler, append_source(self._source, "on_init"))
end

---@param handler fun()
function ScopedBinding:on_load(handler)
  self._bus:_register_on_load(handler, append_source(self._source, "on_load"))
end

---@param handler fun(event: table)
function ScopedBinding:on_configuration_changed(handler)
  self._bus:_register_on_configuration_changed(handler, append_source(self._source, "on_configuration_changed"))
end

---@param event_id WarpageEventId
---@param handler fun(event: table)
function ScopedBinding:on_event(event_id, handler)
  self._bus:_register_event(event_id, handler, append_source(self._source, "event(" .. tostring(event_id) .. ")"))
end

---@param tick integer
---@param handler fun(event: table)
function ScopedBinding:on_nth_tick(tick, handler)
  self._bus:_register_nth_tick(tick, handler, append_source(self._source, "nth_tick(" .. tostring(tick) .. ")"))
end

---@param registration unknown
function ScopedBinding:bind(registration)
  ensure_table(registration, "registration")
  ---@cast registration WarpageEventRegistration

  if registration.on_init ~= nil then
    self:on_init(registration.on_init)
  end

  if registration.on_load ~= nil then
    self:on_load(registration.on_load)
  end

  if registration.on_configuration_changed ~= nil then
    self:on_configuration_changed(registration.on_configuration_changed)
  end

  if registration.events ~= nil then
    ensure_table(registration.events, "registration.events")
    for _, event_id in ipairs(sorted_keys(registration.events)) do
      local handler = registration.events[event_id]
      if handler ~= nil then
        self:on_event(event_id, handler)
      end
    end
  end

  if registration.nth_tick ~= nil then
    ensure_table(registration.nth_tick, "registration.nth_tick")
    for _, tick in ipairs(sorted_keys(registration.nth_tick)) do
      local handler = registration.nth_tick[tick]
      if handler ~= nil then
        ---@cast tick integer
        self:on_nth_tick(tick, handler)
      end
    end
  end
end

return EventBus
