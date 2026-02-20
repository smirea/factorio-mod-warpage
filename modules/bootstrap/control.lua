local StorageSchema = require("core.storage_schema")
local Ship = require("modules.ship")

---@return boolean
local function is_debug_mode_enabled()
  local setting = settings.global["warpage-debug-mode"]
  return setting ~= nil and setting.value == true
end

---@param message string
local function debug_log(message)
  if is_debug_mode_enabled() then
    log("[warpage] " .. message)
  end
end

local function ensure_bootstrap_state()
  local root = StorageSchema.ensure()
  if root.features.bootstrap == nil then
    root.features.bootstrap = {
      initialized_at_tick = game.tick
    }
  elseif type(root.features.bootstrap) ~= "table" then
    error("storage.features.bootstrap must be a table.")
  end
end

local function assert_bootstrap_state()
  local root = StorageSchema.assert_ready()
  if type(root.features.bootstrap) ~= "table" then
    error("storage.features.bootstrap must be a table.")
  end
end

---@param context WarpageFeatureContext
return function(context)
  local events = context.events
  if events == nil then
    error(context.feature_id .. " requires context.events.")
  end

  events:bind({
    on_init = function()
      ensure_bootstrap_state()
      debug_log("Storage initialized.")
    end,
    on_configuration_changed = function()
      ensure_bootstrap_state()
      debug_log("Storage validated after configuration change.")
    end,
    on_load = function()
      assert_bootstrap_state()
    end
  })

  Ship.bind(events)
end
