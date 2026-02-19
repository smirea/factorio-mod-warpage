# Warp loader throughput issue

- URL: https://mods.factorio.com/mod/warptorio2/discussion/6454a454e92a3479b82de7fb
- Thread ID: 6454a454e92a3479b82de7fb
- Started by: moonancient

---
**moonancient (op):** Edit: See <https://imgur.com/a/XgZeXyc>, the setup to reproduce the issue

When there are many warp loaders with different items, they don't reach the max throughput. Often times the input loaders are congested while the output loaders are still not saturated.

After looking into the code, I think there's some bug with enumerating the warp loaders (NextWarpLoader and \_next tables). So I rewrote it by removing everything about NextWarpLoader and \_next tables, and directly enumerating the loaders:

```
function warptorio.DistributeLoaderLine(line)
    if(not isvalid(line))then return end
    local inv=line.get_contents()
    for item_name,item_count in pairs(inv)do
        if(warptorio.OutputWarpLoader(item_name,item_count))then line.remove_item{name=item_name,count=1} return true end
    end
end
function warptorio.OutputWarpLoader(cv,c)
    local wpg=global.warploaders
    local ins=false
    if(wpg.outputf[cv])then
        local coutf=wpg.outputf[cv]
        for _,outline in pairs(coutf)do
            if (outline and warptorio.InsertWarpLane(outline,cv)) then ins=true break end
        end
        if(ins)then return true end
    end
    local cout=wpg.output
    for _,outline in pairs(cout)do
        if(outline and warptorio.InsertWarpLane(outline,cv))then ins=true break end
    end
    if(ins)then return true end
    return false
end

function warptorio.TickLogistics()
        ...
    if(global.warploaders)then
        for _,line in pairs(global.warploaders.input) do
            warptorio.DistributeLoaderLine(line)
        end
    end
end
```

Then in my local testing, the throughput issue is fixed, so I should have located the bug correctly.

A downside is that it doesn't evenly distribute items between all warp loaders, but favors those built earlier. So if the supply is lower than the demand, then some output loaders will starve. But at least I can now build a speghettiless megabase on the factory floor with warp loaders.

---
**moonancient (op):** I fixed/reimplemented the round robin matching between input and output loaders. Now all loaders are balanced.

```
...

function warptorio.InsertWarpLane(cv,item_name) if(cv.can_insert_at_back())then cv.insert_at_back({name=item_name,count=1}) return true end return false end
function warptorio.NextWarploader(tbl,key) local k,v=next(tbl,key) if(not k and not v)then return next(tbl,nil) end return k,v end

-- Calls func on each line with the given start, returns the last line on which func returns true
function warptorio.ForEachLoaderLine(lines,start,func)
    if(not lines)then return nil end
    local ret=nil
    local prev=start
    local count=0
    repeat
        local k,line=warptorio.NextWarploader(lines,prev)
        if(isvalid(line) and func(line))then ret=k end
        prev=k
        count=count+1
    until(count>=table_size(lines))
    return ret
end

-- Calls func on each line with the given start until first line on which func returns true; returns that line
function warptorio.FindFirstLoaderLine(lines,start,func)
    if(not lines)then return nil end
    local prev=start
    local count=0
    repeat
        local k,line=warptorio.NextWarploader(lines,prev)
        if(isvalid(line) and func(line))then return k end
        prev=k
        count=count+1
    until(count>=table_size(lines))
    return nil
end

function warptorio.DistributeLoaderLine(line)
    local wpg=global.warploaders
    local inv=line.get_contents()
    for item_name,item_count in pairs(inv)do
        function TryOutputLoaderLine(out)
            if(warptorio.InsertWarpLane(out, item_name))then
                line.remove_item{name=item_name,count=1}
                return true
            end
            return false
        end
        local ins=warptorio.FindFirstLoaderLine(wpg.outputf[item_name],wpg.outputf_next[item_name],TryOutputLoaderLine)
        if(ins)then
            wpg.outputf_next[item_name]=ins
            return true
        end
        ins=warptorio.FindFirstLoaderLine(wpg.output,wpg.output_next,TryOutputLoaderLine)
        if(ins)then
            wpg.output_next=ins
            return true
        end
    end
    return false
end

function warptorio.TickWarploaders()
    local wpg=global.warploaders if(not wpg)then return end
    local k=warptorio.ForEachLoaderLine(wpg.input,wpg.input_next,warptorio.DistributeLoaderLine)
    if(k)then wpg.input_next=k end
end

function warptorio.TickLogistics()
    ...
    if(global.warploaders)then warptorio.TickWarploaders() end
end
events.on_tick(1,0,"TickLogs",warptorio.TickLogistics)
```
