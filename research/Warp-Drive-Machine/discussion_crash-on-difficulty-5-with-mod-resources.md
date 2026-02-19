# Crash on difficulty 5 with +mod resources

- URL: https://mods.factorio.com/mod/Warp-Drive-Machine/discussion/65af3e806e6c79151e6c21b1
- Thread ID: 65af3e806e6c79151e6c21b1
- Started by: Honktown

---
**Honktown (op):** Yuoki's provokes a *crash*, (not your fault per-se, but it "half-is"). When warping to a new surface, get\_new\_random\_planet can cause map-gen-settings to have weird values:
["y-res2"] = {
frequency = -0.76822242001158516,
richness = -0.66768833074694953,
size = -0.85518064079689484
}

```
    elseif (not nauvis_like) then
        set_autoplace_value(autoplace,autoplace.frequency* rand_adjust(2)*crazy_adjust(6,2))
    end
```

after passing through this branch, because it's not a "normal" resource like it says in the branch a little above this one...

I am on difficulty 5 with 9 max resource types per planet.

Crash message:
Factorio crashed. Generating symbolized stacktrace, please wait ...
c:\users\build\appdata\local\temp\factorio-build-b8c3zr\src\floatcast.hpp (101): float\_cast<unsigned int>
c:\users\build\appdata\local\temp\factorio-build-b8c3zr\src\map\autoplacespecification.cpp (943): AutoplaceSpecification::Settings::set
c:\users\build\appdata\local\temp\factorio-build-b8c3zr\src\map\compiledmapgensettings.cpp (190): CompiledMapGenSettings::compileAutoplacersPass1<ID<EntityPrototype,unsigned short> >
c:\users\build\appdata\local\temp\factorio-build-b8c3zr\src\map\compiledmapgensettings.cpp (478): CompiledMapGenSettings::finalizeCompilation
c:\users\build\appdata\local\temp\factorio-build-b8c3zr\src\map\compiledmapgensettings.cpp (440): CompiledMapGenSettings::compile
....
1126.363 Error FloatCast.hpp:101: !std::isnan(input) was not true
1126.363 Error CrashHandler.cpp:641: Received 22

I'd suggest wrapping the parts of:
local function set\_autoplace\_value(autoplace,v)
autoplace.frequency = v
autoplace.size = v \* rand\_adjust(5)
autoplace.richness = v \* rand\_adjust(5)
end

with math.max( , 0), so it's always 0 or above, which wouldn't be expected to cause errors. Not quite sure how to report this on the forum, probably can reproduce it in some way and they can determine if it should be fixed or not
