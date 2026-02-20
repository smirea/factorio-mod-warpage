local EventBus = require("core.event_bus")
local FeatureLoader = require("core.feature_loader")

local Runtime = {}

function Runtime.bootstrap()
  local bus = EventBus.new()
  FeatureLoader.run_stage("control", {
    event_bus = bus
  })
  bus:bind()
end

return Runtime
