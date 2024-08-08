   --needed to make a mining script that didnt mess up just because the chunk got unloaded or the server restarted
   --first make a folder for the settings

local area = 0
depth = 0
d = 0
xPos,zPos = 0,0
local current_pos = { xPos = 0, depth = 0, zPos = 0, dir = 0 }
local saved_pos   = { xPos = 0, depth = 0, zPos = 0, dir = 0 }
local home_pos    = { xPos = 0, depth = 0, zPos = 0, dir = 0 }

local goToPos
local Fuel
local fuel_amount 


function excavateBetter(size,height)
   local isFinished = False
   local usehHeight = height ~= nil and heaight > 0
   local heightCount = 0

   if useHeight then
      if startNextLevel() then
         heightCount = heightCount + 1
         isFinished = height >= heightCount
      end
   else
      isFinisshed = startNextLevel()
   end

    while isFinished do
        for i = 0,size -1 do
            for j = 0,size-1 do
                dig(f)
                go(f)
            end
            if size ~= 
               if i % 2 == 0 then
                   trun(r)
                   dig(f)
                   go(f)
                   trun(r)
               else
                   trun(l)
                   dig(f)
                   go(f)
                   trun(l)
               end
            end  
        end
        nilBLevel = dig("d") and go("d")
        if size % 2 == 1 then
            turn("r")
            turn("r")
        else
            turn("r")
        end
        if useHeight then
            if startNexyLevel() then
            heightCount = heightCount + 1
            isFinished = heaightCount >= heightCount
            end
         else
            isFinisshed = startNextLevel()
         end    
         
        nilBLevel = dig("d") and go("d")
   end
   
   local function startNextlevel()
      local atNext = go("d")
      if not atNext then
         dig("d")
         atNext = go("d")
      end
   end 
   return atNext
end


function dig(str)
    local success = false
    if string.lower(str) == "forward" or string.lower(str)  == "f" then success = turtle.dig()
    elseif  string.lower(str) == "up" or string.lower(str)  == "u" then success = turtle.digUp()
    elseif string.lower(str) == "down" or string.lower(str) == "d" then success = turtle.digDown()
    end
    return success
end


function go(str)
    local success = false
    if string.lower(str) == "down" or string.lower(str) == "d" then
        if turtle.down() then
            current_pos["depth"] = current_pos["depth"] - 1
            success = true
        else
            term.write("I'm stuck!")
            
        end
    end
    if string.lower(str) == "up" or string.lower(str) == "u" then
        if turtle.up() then
            current_pos["depth"] = current_pos["depth"] + 1
            success = true
        else
            term.write("I'm stuck!")
            
        end
    end
    if string.lower(str) == "forward" or string.lower(str) == "f" then
        if turtle.forward() then
            if d == o then current_pos["xPos"] = current_pos["xPos"] + 1 end
            if d == 1 then current_pos["zPos"] = current_pos["zPos"] - 1 end
            if d == 2 then current_pos["xPos"] = current_pos["xPos"] - 1 end
            if d == 3 then current_pos["zPos"] = current_pos["zPos"] + 1 end
            success = true
        else
            term.write("I'm stuck!")
            
        end
    end
    if string.lower(str) == "back" or string.lower(str) == "" then
        if turtle.back() then
            if d == o then current_pos["xPos"] = current_pos["xPos"] - 1 end
            if d == 1 then current_pos["zPos"] = current_pos["zPos"] + 1 end
            if d == 2 then current_pos["xPos"] = current_pos["xPos"] + 1 end
            if d == 3 then current_pos["zPos"] = current_pos["zPos"] - 1 end
            success = true
        else
            term.write("I'm stuck!")
            
        end
    end
    return success
end


function turn(str)

    if string.lower(str) == "right" or string.lower(str) == "r" then
        turtle.turnRight()
        current_pos["d"] = (current_pos["d"] + 1) % 4    
    end
    if string.lower(str) == "left" or string.lower(str) == "l" then
        turtle.turnLeft()
        current_pos["d"] = (current_pos["d"] - 1) % 4    
    end
end


function goToPos(pos, order, canDig)
   local isFinished = false
   if order == nil then order = { "x", "z", "y" } end
   if canDig == nil then canDig = false end

   for f in order
      if     f == string.lower("x") then moveX()
      elseif f == string.lower("z") then moveZ()
      else   f == string.lower("y") then moveY() end
   end

   local function moveX()
      local xVector = [[]]

   local function rotate(s,e)
      local diff = s - e
      local dir = {}
      if (math.abs(dif) > 0) then
         if     diff == -3 or diff ==  1 then dir = {1, "l"}
         elseif diff ==  3 or diff == -1 then dir = {1, "r"}
         else dir = {2, "r"}
         for i = 0,dir[0] do
            turn(dir[1])
   end
function copyPos(pos)
   copy = { 1, 2, 3}
   for k,v in current_pos do
       
end





























