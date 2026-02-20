local EventBus = {}
EventBus.__index = EventBus

local ScopedBinding = {}
ScopedBinding.__index = ScopedBinding

local function ensure_table(value, name)
  if type(value) ~= "table" then
    error(name .. " must be a table.")
  end
end

local function ensure_source(source)
  if type(source) ~= "string" or source == "" then
    error("Handler source must be a non-empty string.")
  end
end

local function ensure_function(handler, source)
  if type(handler) ~= "function" then
    error("Handler from '" .. tostring(source) .. "' must be a function.")
  end
end

local function ensure_event_id(event_id)
  local event_type = type(event_id)
  if event_type ~= "number" and event_type ~= "string" then
    error("event_id must be a number or string.")
  end
end

local function ensure_tick(tick)
  if type(tick) ~= "number" or tick < 1 or tick % 1 ~= 0 then
    error("nth tick value must be an integer greater than zero.")
  end
end

local function sorted_keys(map)
  local keys = {}
  for key in pairs(map) do
    keys[#keys + 1] = key
  end

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

local function dispatch(handlers, payload)
  for _, entry in ipairs(handlers) do
    entry.handler(payload)
  end
end

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

local function append_source(base, suffix)
  return base .. ":" .. suffix
end

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

function EventBus:_register_on_init(handler, source)
  self:_assert_not_bound()
  ensure_source(source)
  ensure_function(handler, source)
  self._on_init[#self._on_init + 1] = { handler = handler, source = source }
end

function EventBus:_register_on_load(handler, source)
  self:_assert_not_bound()
  ensure_source(source)
  ensure_function(handler, source)
  self._on_load[#self._on_load + 1] = { handler = handler, source = source }
end

function EventBus:_register_on_configuration_changed(handler, source)
  self:_assert_not_bound()
  ensure_source(source)
  ensure_function(handler, source)
  self._on_configuration_changed[#self._on_configuration_changed + 1] = { handler = handler, source = source }
end

function EventBus:_register_event(event_id, handler, source)
  self:_assert_not_bound()
  ensure_event_id(event_id)
  ensure_source(source)
  ensure_function(handler, source)
  add_handler(self._events, event_id, handler, source)
end

function EventBus:_register_nth_tick(tick, handler, source)
  self:_assert_not_bound()
  ensure_tick(tick)
  ensure_source(source)
  ensure_function(handler, source)
  add_handler(self._nth_tick, tick, handler, source)
end

function EventBus:for_source(source)
  self:_assert_not_bound()
  ensure_source(source)

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
    script.on_event(event_id, function(event)
      dispatch(handlers, event)
    end)
  end

  for _, tick in ipairs(sorted_keys(self._nth_tick)) do
    local handlers = self._nth_tick[tick]
    script.on_nth_tick(tick, function(event)
      dispatch(handlers, event)
    end)
  end
end

function ScopedBinding:on_init(handler)
  self._bus:_register_on_init(handler, append_source(self._source, "on_init"))
end

function ScopedBinding:on_load(handler)
  self._bus:_register_on_load(handler, append_source(self._source, "on_load"))
end

function ScopedBinding:on_configuration_changed(handler)
  self._bus:_register_on_configuration_changed(handler, append_source(self._source, "on_configuration_changed"))
end

function ScopedBinding:on_event(event_id, handler)
  self._bus:_register_event(event_id, handler, append_source(self._source, "event(" .. tostring(event_id) .. ")"))
end

function ScopedBinding:on_nth_tick(tick, handler)
  self._bus:_register_nth_tick(tick, handler, append_source(self._source, "nth_tick(" .. tostring(tick) .. ")"))
end

function ScopedBinding:bind(registration)
  ensure_table(registration, "registration")

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
      self:on_event(event_id, registration.events[event_id])
    end
  end

  if registration.nth_tick ~= nil then
    ensure_table(registration.nth_tick, "registration.nth_tick")
    for _, tick in ipairs(sorted_keys(registration.nth_tick)) do
      self:on_nth_tick(tick, registration.nth_tick[tick])
    end
  end
end

return EventBus
