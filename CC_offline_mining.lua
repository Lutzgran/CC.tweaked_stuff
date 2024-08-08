   --needed to make a mining script that didnt mess up just because the chunk got unloaded or the server restarted
   --first make a folder for the settings


local current_pos = { xPos = 0, y = 0, zPos = 0, dir = 0 }
local saved_pos   = { xPos = 0, y = 0, zPos = 0, dir = 0 }
local home_pos    = { xPos = 0, y = 0, zPos = 0, dir = 0 }

homeAmount = (saved_pos[1] + saved_pos[2] + saved_pos[3])*2


function getPos()
    local xPos, depth, zPos = gps.locate()
    local coords = {xPos ,depth ,zPos}
    return coords
end

function updateCoords(pos)

    
    
end
   
function excavateBetter(size)
    local nilBLevel = dig("d") and go("d")
    
    if restart then
        goToMiningSite()
        restart = false
    end
    while nilBLevel do
        for i = 1,size do
            for j = 1,size do
                dig(d)
                go(g)
            end
            if size ~= - 1 then
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
            current_pos  = saved_pos
            if inventoryCheck or fuelCheck then
                goOfLoad()
                reFuel()
            end
        end 
           if size % 2 == 1 then
               turn("r")
               turn("r")
           else
               turn("r")
           end
    end   
end

function saveData()

    if not fs.exists('/data') then
        fs.makeDir('/data')
    end
    
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
    rotate(0,2)
    for i = 1,16,1 do
        turtle.select(i)
        turtle.drop()
    end
    rotate(2,0)

end

function reFuel()

    local success = false
    goToPos(home_pos)
    rotate(0,3)
    turtle.select(1)
    turtle.suck()
    turtle.refuel()
    rotate(3,0)

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
            current_pos["y"] = current_pos["y"] - 1
            success = true
        else
            term.write("I'm stuck!")
            
        end
    end
    if string.lower(str) == "up" or string.lower(str) == "u" then
        if turtle.up() then
            current_pos["y"] = current_pos["y"] + 1
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


function rotate(s,e)
    local diff = s - e
    local dir = {}
    if (math.abs(diff) > 0) then
        if     diff == -3 or diff ==  1 then dir = {1, "l"}
        elseif diff ==  3 or diff == -1 then dir = {1, "r"}
        else dir = {2, "r"} end
        for i = 0,dir[0] do
            turn(dir[1])
        end
    end
end


function goToPos(pos)

    local s_dir = current_pos[4]
    local e_dir = pos[4]
    local copyPos = current_pos

    if copyPos[2] < pos[2] then
        for i in copyPos[2] do
            go(u)
        end
        rotate(s_dir,3)
        for i in copyPos[1] do
            go(f)
        end
        rotate(3,2)
        for i in copyPos[3] do
            go(f)
        end 
        rotate(2,e_dir)

    elseif copyPos[2] > pos[2] then
        rotate(s_dir,0)
        for i in pos[1] do
            go(f)
        end
        rotate(0,1)
        for i in pos[3] do
            go(f)
        end 
        rotate(0,e_dir)
        for i in pos[2] do
            go(d)
        end
    end
end
