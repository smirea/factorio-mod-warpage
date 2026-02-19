# Crash when using warploader

- URL: https://mods.factorio.com/mod/warptorio2/discussion/606df1269f8bb34d838abe66
- Thread ID: 606df1269f8bb34d838abe66
- Started by: thuejk

---
**thuejk (op):** I get a crash in the save <https://thuejk.dk/warptorio2_crash.zip> when I place the missing belt to feed the warploader.

The mod Warptorio2 (1.3.4) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
LuaTransportLine API call when LuaTransportLine was invalid.
stack traceback:
[C]: in function '**index'
\_\_warptorio2**/control\_main\_helpers.lua:757: in function 'InsertWarpLane'
**warptorio2**/control\_main\_helpers.lua:775: in function 'OutputWarpLoader'
**warptorio2**/control\_main\_helpers.lua:761: in function 'DistributeLoaderLine'
**warptorio2**/control\_main\_helpers.lua:785: in function 'TickWarploaders'
**warptorio2**/control\_main\_helpers.lua:817: in function 'b'
**warptorio2**/lib/lib\_control.lua:281: in function <**warptorio2**/lib/lib\_control.lua:281>

---
**PyroFire (mod author):** Have you placed warp loaders on previous planets set to output iron ore?

\*\* Duplicate of <https://mods.factorio.com/mod/warptorio2/discussion/5f69f72a8797194da1556e89> however this thread contains code work.

---
**thuejk (op):** I don't think so, but I might misremember. But note that the save puts the avatar on the homeworld, with the platform on a later planet.

---
**kevinma:** I found a bug in warp loader. You MUST config the out-loader first. Otherwise it will throw an exception.
I think it is the code cant' find loader to transfer input items
There's similar things in teleport to homeworld. If you don't set a homeworld. Teleporting to homeworld will cause an exception.

There will throw an exception too when there's no storage space for the output of warp loader.

The mod Warptorio2 (1.3.5) caused a non-recoverable error.
Please report this error to the mod author.

Error while running event warptorio2::on\_tick (ID 0)
LuaTransportLine API call when LuaTransportLine was invalid.
stack traceback:
[C]: in function 'index'
warptorio2/control\_main\_helpers.lua:757: in function 'InsertWarpLane'
warptorio2/control\_main\_helpers.lua:775: in function 'OutputWarpLoader'
warptorio2/control\_main\_helpers.lua:761: in function 'DistributeLoaderLine'
warptorio2/control\_main\_helpers.lua:785: in function 'TickWarploaders'
warptorio2/control\_main\_helpers.lua:817: in function 'b'
warptorio2/lib/lib\_control.lua:281: in function <warptorio2\_\_/lib/lib\_control.lua:281>

---
**PyroFire (mod author):** > I found a bug in warp loader. You MUST config the out-loader first. Otherwise it will throw an exception.
> I think it is the code cant' find loader to transfer input items
> There's similar things in teleport to homeworld. If you don't set a homeworld. Teleporting to homeworld will cause an exception.
>
> There will throw an exception too when there's no storage space for the output of warp loader.

All of this is incorrect.

Crash is caused by some problems with the cache, filters with loaders are not cleared from the cache correctly when they're destroyed or changed.

<https://gyazo.com/be75d0ae1927d6b142b88d44fcc37614>

I also found an unrelated problem where cloned warp loaders do not appear to be added to the cache.

So there's a bunch of cache problems with the warp loaders.

---
**shukolade:** I am getting this error too, otherwise great mod so far, my friends and I love it.

It seems to throw an error when I try to unload a mixed belt with more than one warp loader, as soon as the second unloader gets the first item -> crash.

---
**jrtc27:** I believe the issue is precisely with:

```
function warploader.dofilters(e)
        local tp=e.loader_type
        local wpg=global.warploaders
        if(tp~="output")then
                for i=1,2,1 do table.RemoveByValue(wpg.output,e.get_transport_line(i)) end
                for k,v in pairs(wpg.outputf)do for i=1,2,1 do table.RemoveByValue(v,e.get_transport_line(i)) end  end
                for a=1,2,1 do table.insertExclusive(global.warploaders.input,e.get_transport_line(a)) end
        else
                local ct=global.warploaders.outputf
                local hf=false
                for i=1,5,1 do local f=e.get_filter(i) if(f)then hf=true
                        ct[f]=ct[f] or {} ct=ct[f] for a=1,2,1 do table.insertExclusive(ct,e.get_transport_line(a)) end
                end end
                if(not hf)then
                        for a=1,2,1 do table.insertExclusive(global.warploaders.output,e.get_transport_line(a)) end
                end
                for a=1,2,1 do table.RemoveByValue(global.warploaders.input,e.get_transport_line(a)) end
        end
end
```

and it should instead be:

```
function warploader.dofilters(e)
        local tp=e.loader_type
        for a=1,2,1 do table.RemoveByValue(global.warploaders.input,e.get_transport_line(a)) end
        for i=1,2,1 do table.RemoveByValue(global.warploaders.output,e.get_transport_line(i)) end
        for k,v in pairs(global.warploaders.outputf) do for i=1,2,1 do table.RemoveByValue(v,e.get_transport_line(i)) end end
        if(tp~="output")then
                for a=1,2,1 do table.insertExclusive(global.warploaders.input,e.get_transport_line(a)) end
        else
                local ct=global.warploaders.outputf
                local hf=false
                for i=1,5,1 do local f=e.get_filter(i) if(f)then hf=true
                        ct[f]=ct[f] or {} ct=ct[f] for a=1,2,1 do table.insertExclusive(ct,e.get_transport_line(a)) end
                end end
                if(not hf)then
                        for a=1,2,1 do table.insertExclusive(global.warploaders.output,e.get_transport_line(a)) end
                end
        end
end
```

as, for example, adding a filter to a filterless warp loader doesn't currently remove it from the global filterless list, but does add it to the filtered item's list (as dofilters only sees the updated warp loader, not its previous state, and so should not be basing its removals on the current state). Then at destroy time it only gets moved from the filtered item's list as it shouldn't be in anything else, so it stays in the filterless list and then later on an incoming item is sent to the non-existent warp loader.

This also explains why filters aren't currently respected by warp loaders on overflow; even after adding a filter its presence in the global filterless list means it will still receive overflow items of any kind.

---
**MartianInvader:** I was able to fix it.

There were no fewer than *3* separate issues in control\_main\_helpers.lua that would cause crashes. jrtc27's post fixes one of them that reliably causes some issues/crashes, but there's another crash that happens when using multiple filters on one loader (see the "ct=ct[f]" statement in that same function), and another that unreliably causes crashes due to not correctly resetting the iterators used for distribution.

I have a fixed lua file now that makes the loaders work without crashing. Pyrofire, if you're reading this, is there a way I can send it to you?

---
**TSP:** Could you please send me the code for the fixes MartianInvader? I'm playing with my partner are also having this issue.

---
**TSP:** After using jrtc27's fix to the above error and playing a bit: <https://i.imgur.com/TXSewR3.png>

---
**TSP:** If there's anyway for me to delete existing warp loaders with a command, so I can just avoid playing with warp loaders until there's a fix?
Edit: Looks like the crash log is still identical after the other code was applied.

---
**PyroFire (mod author):** > as, for example, adding a filter to a filterless warp loader doesn't currently remove it from the global filterless list, but does add it to the filtered item's list (as dofilters only sees the updated warp loader, not its previous state, and so should not be basing its removals on the current state). Then at destroy time it only gets moved from the filtered item's list as it shouldn't be in anything else, so it stays in the filterless list and then later on an incoming item is sent to the non-existent warp loader.

This appears to be correct.

> This also explains why filters aren't currently respected by warp loaders on overflow; even after adding a filter its presence in the global filterless list means it will still receive overflow items of any kind.

Good catch.
I have implemented fixes based on the findings in this thread for next update.

```
function warploader.dofilters(e)
    local tp=e.loader_type
    local lanes={e.get_transport_line(1),e.get_transport_line(2)}
    for k,v in pairs(global.warploaders.outputf)do for i=1,2,1 do table.RemoveByValue(v,lanes[i]) end end
    if(tp~="output")then --if(tp=="input")then
        for i=1,2,1 do table.RemoveByValue(global.warploaders.output,lanes[i]) end
        for i=1,2,1 do table.insertExclusive(global.warploaders.input,lanes[i]) end
    else --if(tp=="output")then
        local ct=global.warploaders.outputf
        local hf=false
        for i=1,5,1 do local f=e.get_filter(i) if(f)then hf=true
            ct[f]=ct[f] or {} for a=1,2,1 do table.insertExclusive(ct[f],lanes[a]) end
        end end
        if(hf)then
            for i=1,2,1 do table.RemoveByValue(global.warploaders.output,lanes[i]) end
        else
            for a=1,2,1 do table.insertExclusive(global.warploaders.output,lanes[a]) end
        end
        for a=1,2,1 do table.RemoveByValue(global.warploaders.input,lanes[a]) end
    end
end
```

Additional reports list:
<https://mods.factorio.com/mod/warptorio2/discussion/620d0e46bd569c35732ad372>
<https://mods.factorio.com/mod/warptorio2/discussion/5f69f72a8797194da1556e89>
<https://mods.factorio.com/mod/warptorio2/discussion/5f45c3e5dbe18e4ef416e58f>
<https://mods.factorio.com/mod/warptorio2/discussion/61ddde7a0368d8cb0899395c>

It is likely all the crashes related to warp loaders stem from this same issue.
