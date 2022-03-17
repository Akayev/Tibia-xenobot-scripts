--[Mati]--


---[REFILL SETTINGS]--- 
local LeaveSD = 70
local BuySD = 450
--------------------------------------
local LeaveAva = 210
local BuyAva = 1100
--------------------------------------
local LeaveMana = 200
local BuyMana = 600
--------------------------------------
local AvaName = "Avalanche Rune" 
local SDName = "Sudden Death Rune" 
local ManaName = "Ultimate Mana Potion"

---[BP]---
local MainBP = "Backpack"
local LootBP = "Yellow Backpack"
local ManaBP = "Purple Backpack"
----------------------------------

local UseRing = true
local Ring = 3097 -- Life Ring

-- NOT EDIT MORE -- 
------------------------------------------  
local AvaID = Item.GetID(AvaName)
local ManaID = Item.GetID(ManaName)
local SDID = Item.GetID(SDName)
local ManaCost = 438
local SDCost = 135
local AvaCost = 57
Targeting.Start()
force = false

registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")

function onWalkerSelectLabel(labelName)
    if (labelName == "Checker") then
        Walker.ConditionalGoto((Self.ItemCount(SDID) <= LeaveSD) or (Self.ItemCount(ManaID) <= LeaveMana) or (Self.ItemCount(AvaID) <= LeaveAva), "Leave", "Hunt")


    elseif (labelName == "Hunt") then
    	force = true

    elseif (labelName == "Leave") then
    	force = false
   
    elseif (labelName == "BuyManas") then
        -- Buy Mana Potions
        Walker.Stop()
        if (Self.ItemCount(ManaID) < BuyMana) or (Self.ItemCount(SDID) < BuySD) or (Self.ItemCount(AvaID) < BuyAva)  then
            print("Kupywanie Manasow")
            Self.SayToNpc("hi", 100)
            wait(1500)
            Self.SayToNpc("trade", 100)
            wait(100)
            while (Self.ItemCount(ManaID) < BuyMana) do
                Self.ShopBuyItemsUpTo(ManaID, BuyMana)
                wait(300,500)
            end
            while (Self.ItemCount(SDID) < BuySD) do
                Self.ShopBuyItemsUpTo(SDID, BuySD)
                wait(500)
            end
            while (Self.ItemCount(AvaID) < BuyAva) do
                Self.ShopBuyItemsUpTo(AvaID, BuyAva)
                wait(500)
            end            
            wait(200, 500)
        end
        Walker.Start()
    end
end

Map.GetUseItems = function (id)
    if type(id) == "string" then
        id = Item.GetID(id)
    end
    local pos = Self.Position()
    local store = {}
    for x = -7, 7 do
        for y = -5, 5 do
            if Map.GetTopUseItem(pos.x + x, pos.y + y, pos.z).id == id then
                itemPos = {x = pos.x + x, y = pos.y + y, z = pos.z}
                table.insert(store, itemPos)
            end
        end
    end
    return store
end
 
 
 
-- Function to open bp inside backpack (all backpack must be same color!)
function Dedi_OpenNextBp(bp_name)
    local backpack = Container.GetByName(bp_name)
 
    for i = backpack:ItemCount()-1, 0, -1 do
        local item = backpack:GetItemData(i).id
 
        if (item == Item.GetID(bp_name)) then
            backpack:UseItem(i, true)
        end
    end
end
 
 
-- Returns amount of backpack opened
function Dedi_WindowCount(CONTAINER_NAME)
    local CONTAINER_NAME, WINDOW_COUNT, CONTAINER = tostring(CONTAINER_NAME or "all"):lower(), 0, Container.GetFirst()
 
    while (CONTAINER:isOpen()) do
        if (CONTAINER:Name():lower() == CONTAINER_NAME or CONTAINER_NAME == "all") then
            WINDOW_COUNT = WINDOW_COUNT + 1
        end
 
        CONTAINER = CONTAINER:GetNext()
    end
 
    return WINDOW_COUNT
end

Module.New('Force-Refil', function(module)
	if force then
	    if (Self.ItemCount(SDID) <= LeaveSD) or (Self.ItemCount(ManaID) <= LeaveMana) or (Self.ItemCount(AvaID) <= LeaveAva) then
	        setTargetingIgnoreEnabled(true)
	        Self.StopAttack()
	        Walker.Goto("Leave")
	        force = false
	    end
    end
end)

Module.New("Sort Supplies", function(module)
    local bp1 = Container(MainBP)
    for i = bp1:ItemCount() -1, 0, -1 do
     local id = bp1:GetItemData(i).id
        if  id == ManaID then
            bp1:MoveItemToContainer(i, Container(ManaBP):Index())
            wait(600,800)
        end
    end
module:Delay(800)
end)

Module.New("Sort Supplies1", function(module)
    local bp1 = Container(MainBP)
    for i = bp1:ItemCount() -1, 0, -1 do
     local id = bp1:GetItemData(i).id
        if  id == AvaID then
            bp1:MoveItemToContainer(i, Container(ManaBP):Index())
            wait(600,800)
        end
    end
module:Delay(800)
end)

local Reset_Amount = 3
local Offline_Time = 1
  
function Self.isOffline()
    local s = os.clock()
    wait(200)
    getSelfID()
    if ((os.clock() - s) > Offline_Time) then
        return true
    end
end
  
function OpenBackpacks(amount)
    Walker.Stop()
    Looter.Stop()
    Self.CloseContainers()
    Self.OpenMainBackpack(true)
    wait(500 + Self.Ping())
    if #Container.GetAll() == 1 then
        for slot, item in Container.GetFirst():iItems() do
            if Item.isContainer(item.id) then
                Container.GetFirst():UseItem(slot, false)
                wait(500 + Self.Ping())
                Container.GetLast():Minimize()
                wait(100 + Self.Ping())
            end
            if #Container.GetAll() == amount then break end
        end
    end
    if #Container.GetAll() ~= amount then
        print('Backpack reset not complete, recursing.')
        OpenBackpacks(amount)
    end
    Walker.Start()
end
  
Module.New('BP_RESET', function()
    if Self.isOffline() then OpenBackpacks(Reset_Amount) end
end)

Module.New('equip ring', function(module) -- [DYNAMIC RING]
if (UseRing) and (Self.Ring().id ~= Ring) and (Self.ItemCount(Ring) > 0) then
Self.Equip(Ring, "ring")
module:Delay(1000)
end
end)