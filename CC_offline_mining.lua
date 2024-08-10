--needed to make a mining script that didnt mess up just because the chunk got unloaded or the server restarted
--first make a folder for the settings
-- { 0 = "n", 1 = "e", 2 = "s", 3 = "w" }
-- { "xPos", "y", "zPos", "dir" }


-- lag ein funksjon for å samanligne kordinater


local current_pos = {}
local saved_pos   = {}
local home_pos    = {}
local homeAmount = 0


local function excavateBetter(size)

    local check = unserialize("last_known")
    
    if check then
        saved_pos = unserialize("saved_pos")
        home_pos = unserialize("home_pos")
        homeAmount = (saved_pos[1] + saved_pos[2] + saved_pos[3])*2
        goOfLoad()
        reFuel()
        goToPos(saved_pos)
    else

        home_pos = updateCoords(home_pos)
        current_pos = updateCoords(current_pos)
        current_pos[4] = findDir()
        --serialize(true,"last_known")
        home_pos[4] = current_pos[4]
        serialize(home_pos,"home_pos")
        reFuel()
    end

    while current_pos[2] ~= (-60) do
        for i = 1,size do
            for j = 1,size do
                dig("f")
                go("f")
            end
            if size ~= - 1 then
                if i % 2 == 0 then
                    turn("r")
                    dig("f")
                    go("f")
                    turn("r")
                else
                    turn("l")
                    dig("l")
                    go("f")
                    turn("l")
                end
            end
        end 
        if size % 2 == 1 then
            turn("r")
            turn("r")
        else
            turn("r")
        end
        updateCoords(current_pos)
        saved_pos = current_pos
        homeAmount = (saved_pos[1] + saved_pos[2] + saved_pos[3])*2
        serialize(saved_pos,"saved_pos")
        if inventoryCheck or fuelCheck then
            goOfLoad()
            reFuel()
            goToPos(saved_pos)
        end
        dig("d")
        go("d")
    end

    goToPos(home_pos)
    print("Finished mining")

end


function updateCoords(pos)

    local x , y , z = gps.locate()

    pos[1]=x
    pos[2]=y
    pos[3]=z

    return pos
    
end 


function findDir()

    local coords = { x=0, y=0, z=0 }
    local currentPos = { x=0, y=0, z=0 }
    local axis = 0
    local check = false
    local atHome = false
    local dir = 0
    updateCoords(currentPos)

    if currentPos == home_pos then
        return atHome
    end

    local function probe()
        dig("f")
        go("f")
        coords = updateCoords(coords)
        go("b")
    end

    probe()
    if coords[1] ~= currentPos[1] then 
        axis = coords[1]
        check = true
    else 
        axis = coords[3]
    end

    if check then
        if axis > currentPos[1] then
            dir = 1
        else 
            dir = 3
        end
    else
        if axis > currentPos[3] then
            dir = 2
        else 
            dir = 0
        end
    end
    return dir
end

    
function inventoryCheck()  
    local full = false

    if turtle.getItemCount(turtle.select(16)) == 0 then
        full = true
    end
    return full
end


function fuelCheck(size)  
    local enoughFuel = false
    local fuelAmount = homeAmount + ((size*size)*5)
        
    if getFuelLevel() >= fuelAmount then
        enoughFuel = true
    end
    return enoughFuel
end


function goOfLoad()

    goToPos(home_pos)
    turn("r")
    turn("r")
    for i = 1,16,1 do
        turtle.select(i)
        turtle.drop()
    end
    turn("r")
    turn("r")

end


function reFuel()

    local success = false
    goToPos(home_pos)
    turn("l")
    turtle.select(16)
    turtle.suck()
    turtle.refuel()
    turn("r")

    if fuelCheck == false then
        print("no more fuel!")
    else
        success = true
    end
    return success
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
            success = true
        else
            term.write("I'm stuck!")       
        end
    end
    if string.lower(str) == "up" or string.lower(str) == "u" then
        if turtle.up() then
            success = true
        else
            term.write("I'm stuck!")
            
        end
    end
    if string.lower(str) == "forward" or string.lower(str) == "f" then
        if turtle.forward() then
            success = true
        else
            term.write("I'm stuck!")
            
        end
    end
    if string.lower(str) == "back" or string.lower(str) == "" then
        if turtle.back() then
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
        current_pos["dir"] = (current_pos["dir"] + 1) % 4    
    end
    if string.lower(str) == "left" or string.lower(str) == "l" then
        turtle.turnLeft()
        current_pos["dir"] = (current_pos["dir"] - 1) % 4    
    end
end


function rotate(s,e)
    local diff = s - e
    local dir = {}
    if (math.abs(diff) > 0) then
        if     diff == -3 or diff ==  1 then dir = {1, "l"}
        elseif diff ==  3 or diff == -1 then dir = {1, "r"}
        else dir = {2, "r"} end
        for i = 1,dir[0] do
            turn(dir[1])
        end
    end
end

-- this dose not use the first direction to go forward so not fully optimised
-- this has no dig function in it so it cant go through blocks

function goToPos(pos)

    if pos ~= current_pos then
        local s_dir = saved_pos[4]
        local e_dir = pos[4]
        local diff = 0
        local x_dir = 0
        local z_dir = 0
        local success = false

        local function findDiff(axis)

            if saved_pos[axis] <= 0 then
                if pos[axis] <= 0 then
                    diff = math.abs(saved_pos[axis] - pos[axis])
                else
                    diff = math.abs(saved_pos[axis] + pos[axis])
                end
            else
                if pos[axis] >= 0 then
                    diff = math.abs(saved_pos[axis] - pos[axis])
                else
                    diff = math.abs(saved_pos[axis] + pos[axis])
                end
            return diff
            end
        end

        if saved_pos[2] <= pos[2] then
            for i = 1,findDiff(2) do
                go("u")
            end
            if saved_pos[1] <= pos[1] then
                rotate(s_dir,1)
                x_dir = 1
            else
                rotate(s_dir,3)
                x_dir = 3
            end
            for i = 1,findDiff(1) do
                go("f")
            end
            if saved_pos[3] <= pos[3] then
                rotate(x_dir,2)
                z_dir = 2
            else
                rotate(x_dir,0)
                z_dir = 0
            end
            for i = 1,findDiff(3) do
                go("f")
            end
            rotate(z_dir,e_dir)
        else
            if saved_pos[1] <= pos[1] then
                rotate(s_dir,1)
                x_dir = 1
            else
                rotate(s_dir,3)
                x_dir = 3
            end
            for i = 1,findDiff(1) do
                go("f")
            end
            if saved_pos[3] <= pos[3] then
                rotate(x_dir,2)
                z_dir = 2
            else
                rotate(x_dir,0)
                z_dir = 0
            end
            for i = 1,findDiff(3) do
                go("f")
            end
            for i = 1,findDiff(2) do
                go("u")
            end
            rotate(z_dir,e_dir)
        end
        local x , y , z = gps.locate()
        updateCoords(pos)
        if pos[1] == x and pos[2] == y and pos [3] == z then
            success = true
        end
    end
    return success
end


function serialize(data, name)
    if not fs.exists('/data') then
        fs.makeDir('/data')
    end
    fs.delete('/data/'..name)
    local f = fs.open('/data/'..name, 'w')
    f.write(textutils.serialize(data))
    f.close()
end


function unserialize(name)
    if fs.exists('/data/'..name) then
        local f = fs.open('/data/'..name, 'r')
        data = textutils.unserialize(f.readAll())
        f.close()
    end
    return data
end

excavateBetter(5)
