shared.stop = true
wait(5)
shared.stop = false

local str = shared.scr or "qw[er]ty"
local FinishTime = shared.ftime or 10

local vs = game:GetService("VirtualUser")

local nstr = string.gsub(str,"[[\]\n]","")

local delay = shared.tempo and (6 / shared.tempo) or shared.delay or FinishTime / (string.len(nstr) / 1.05)

print("Finishing in",math.floor((delay*#nstr)/60),"minute/s",tostring(tonumber(tostring((delay*#nstr)/60):sub(3,8))*60):sub(1,2),"second/s")

local queue = ""
local rem = true

for i=1, #str do
    if shared.stop == true then return end

    local c = str:sub(i,i)
    
    if c == "[" then
        rem = false
        continue
    elseif c == "]" then
        rem = true
        if string.find(queue," ") then
            for ii=1, #queue do
                local cc = queue:sub(ii,ii)
                vs:SetKeyDown(cc)
                wait(delay/2)
                vs:SetKeyUp(cc)
            end
        else
            for ii=1, #queue do
                local cc = queue:sub(ii,ii)
                vs:SetKeyDown(cc)
                wait()
            end
            wait()
            for ii=1, #queue do
                local cc = queue:sub(ii,ii)
                vs:SetKeyUp(cc)
                wait()
            end
        end
        queue = ""
        continue
    elseif c == " " then
        wait(delay)
        continue
    elseif c == "|" then
        wait(delay*2)
        continue
    end
    
    if not rem then
        queue=queue..c
        continue
    end
    
    vs:SetKeyDown(c)
    wait()
    vs:SetKeyUp(c)
    wait(delay)
end
