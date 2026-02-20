local common = require("core.utils.common")

---@class WarpageFlyingTextImpl: WarpageFloatingTextHandle
---@field _render_object unknown
---@field _destroyed boolean
local FlyingTextHandle = {}
FlyingTextHandle.__index = FlyingTextHandle

---@param options WarpageFloatingTextOptions
---@return WarpageFloatingTextHandle
local function create(options)
  common.ensure_table(options, "options")
  if options.text == nil then
    error("options.text is required.")
  end

  if options.surface == nil then
    error("options.surface is required.")
  end

  if options.target == nil then
    error("options.target is required.")
  end

  local render_object = rendering.draw_text(options)
  if render_object == nil then
    error("rendering.draw_text(options) must return a render object.")
  end

  local ok_valid, _ = pcall(function()
    return render_object.valid
  end)
  if not ok_valid then
    error("rendering.draw_text(options) must return a LuaRenderObject.")
  end

  local ok_destroy, destroy_method = pcall(function()
    return render_object.destroy
  end)
  if not ok_destroy or type(destroy_method) ~= "function" then
    error("rendering.draw_text(options) must return a LuaRenderObject with destroy().")
  end

  return setmetatable({
    _render_object = render_object,
    _destroyed = false
  }, FlyingTextHandle)
end

function FlyingTextHandle:destroy()
  if self._destroyed then
    return
  end

  self._destroyed = true
  pcall(function()
    if self._render_object.valid ~= true then
      return
    end

    self._render_object.destroy()
  end)
end

return {
  create = create
}
