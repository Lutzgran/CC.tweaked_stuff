   --needed to make a mining script that didnt mess up just because the chunk got unloaded or the server restarted
   --first make a folder for the settings

local area = 0
local depth = 0
local dir = 0
local xPos,zPos = 0,0

local goTo
local Fuel
local fuel_amount = ((2*xPos+zPos+depth)7200)


local function trunRight()
   if dir == 3 then
      dir = 0
   else
      dir = dir +1
   turtle.turnRight()
    end
end
local function trunLeft()
   if dir == 0 then
      dir = 3
   else
      dir = dir -1
   turtle.turnRight()
    end
end



    
local function refuel(lowFuel,returned)

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






function offline_mining(area)
