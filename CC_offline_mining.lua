   --needed to make a mining script that didnt mess up just because the chunk got unloaded or the server restarted
   --first make a folder for the settings

local area = 0
depth = 0
d = 0
xPos,zPos = 0,0
local current_pos = { xPos = 0, depth = 0, zPos = 0, dir = 0 }
local saved_pos   = { xPos = 0, depth = 0, zPos = 0, dir = 0 }
local home_pos    = { xPos = 0, depth = 0, zPos = 0, dir = 0 }

local goTo
local Fuel
local fuel_amount = ((2*xPos+zPos+depth)+7200)

function dig(size)

    local nilBLevel = dig("d") and go("d")
    while nilBLevel do
        for i = 0,size -1 do
            
            for j = 0,size-1 do
                turtle.dig()
                goForward()
            end
            if then
                trunRight()
                turtle.dig()
                goForward()
                trunRight()
            else
                trunLeft()
                turtle.dig()
                goForward
                trunLeft()
            turtle.digDown()
            goDown()
            end       
        end
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


function refuel(lowFuel,returned)

    if lowFuel then
    goTo(0,0,0,0)
    Fuel = true

    elseif returned then
    Fuel = true
    end
    
    if Fuel then
    trunRight()
    turtle.select(1)
    turrle.suck()
    turtle.refuel()
    trunRight()
   end

    if turtle.getFuelLevel() < fuel_amount then
        return
            print("need more fuel!!!")
    
    end
end




