--------------------- [LOCAL INFO] -------------------------- by Akayev ® 2022 Ezodus.net

--[[POTIONS]]--
local minCap = 60         -- MIN. CAPACITY
local manaPotID = 237     -- MANA POTION (ID)
local manaPotCost = 93    -- MANA POTION COST    -- mana potion (56),
local minManaPot = 150    -- MANA POTION MIN.
local maxManaPot = 740    -- MANA POTION MAX
local healthPotID = 7642  -- HEALTH POTION (ID)
local healthPotCost = 228 -- HEALTH POTION COST  -- ultimate health potion (379), 
local minHealthPot = 50   -- MIN. HEALTH POTION
local maxHealthPot = 150  -- HEALTH POTION MAX

--[[RUNES OR AMMO]]--     -- IF YOU DONT USE RUNES OR AMMO USE REFIL CHECK FOR EK LABEL
local SDID = 7368         -- RUNE/AMMO ID
local SDCost = 100        -- RUNE/AMMO COST
local minSD = 150         -- RUNE/AMMO MIN.
local maxSD = 700         -- RUNE/AMMO MAX

--[[BACKPACKS]]--
local ManaBP = 2868       -- SUPPLIES      (purple backpack)
local AmmoBP = 5801       -- AMMO          (jewelled backpack)
local RingBP = 2866       -- RINGS         (yellow backpack)
local LootBP = 21295      -- RARE LOOT     (glooth backpack)
local StackBP = 2867      -- STACK LOOT    (red backpack)


--[[MAIN BACKPACK]]--
local MainBackpack = "Buggy Backpack"

---------------- [SORT SUPPLIES] -------------------- / Purple Backpack

local items = {237,7642} -- Strong Mana Potion, Great Spirit Potion

------------------- [RELOAD] ------------------------ 

local UseAmulet = false
local Amulet = 814 -- Item ID of the amulet, with the most priority, that you want to equip. (Default: Terra Amulet

local UseRing = true
local Ring = 3052 -- Life Ring

------------------ [WITHDRAW AMMO DP 4] ---------------------- WORKS ON LABEL WithdrawAmmo()

local AmmoUse = "Assassin Star"
local AmmoMax = 500
local AmmoBp = "Jewelled Backpack"

------------------ [WITHDRAW RING DP 5] ---------------------- WORKS ON LABEL WithdrawRing()

local RingUse = "Life Ring"
local RingMax = 19
local RingBp = "Yellow Backpack"

------------------ [WITHDRAW RING DP 6] ---------------------- WORKS ON LABEL WithdrawAmu()

local AmuUse = "Terra Amulet"
local AmuMax = 15
local AmuBp = "Jewelled Backpack"

------------------ [AUTO BP RESET NUMBER] --------------------

local NumBackpacks = 6


--[[########################################################]]--
--[[##########NOTHING BELOW HERE SHOULD BE CHANGED##########]]--
--[[########################################################]]--
local count = 0

-------------------- [LABEL MANAGER] -------------------------

registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
displayInformationMessage("Spawn: GOROMA SERPENTS PROFIT\n Vocation: [RP] 180+\n created by: Akayev")

function onWalkerSelectLabel(labelName)
    local func = loadstring(labelName)
    if (func) then func()
    end
end

----------------- - [BP RESETTING] -----------------------

Module.New('OpenContainers', function(BpMod)
    if #Container.GetAll() < NumBackpacks then
        Walker.Delay(6000)
        print("Perfect Ezodus.net by Akayev 2022\n Backpack Reset!")        
        Self.CloseContainers()
        Self.OpenMainBackpack(true):OpenChildren({ManaBP, true}, {AmmoBP, true}, {RingBP, true}, {LootBP, true}, {StackBP, true})
        wait(200, 500)
    end
    BpMod:Delay(1000)
end)

--------------- [DYNAMIC MOVE SUPPLIES] ------------------

Module.New("Sort Supplies", function()
local bp1 = Container(MainBackpack)
for spot, item in bp1:iItems() do
if (table.contains(items, item.id)) then
bp1:MoveItemToContainer(spot, Container.New(ManaBP):Index())
break
end
end
end)

--------------- [DYNAMIC GOLD CHANGER] -------------------

Module.New('stacking100gold', function(mod)
    useCoins(3031)
    wait(500)
    useCoins(3035)
    mod:Delay(1000)
end)

--------------- [DYNAMIC RING AMULET] --------------------

Module.New('equip amulet', function(module)
if (UseAmulet) and (Self.Amulet().id ~= Amulet) and (Self.ItemCount(Amulet) > 0) then
Self.Equip(Amulet, "amulet")
module:Delay(1000)
end
end)

Module.New('equip ring', function(module)
if (UseRing) and (Self.Ring().id ~= Ring) and (Self.ItemCount(Ring) > 0) then
Self.Equip(Ring, "ring")
module:Delay(1000)
end
end)

--------------------- [REFIL CHECKS] --------------------------

--[[CheckPotions + RUNE/AMMO]]--
function CheckPotions()
	delayWalker(1000)
		if ((Self.ItemCount(manaPotID) <= minManaPot) or (Self.ItemCount(healthPotID) <= minHealthPot) or (Self.ItemCount(SDID) <= minSD)) then
			gotoLabel("Refil")
			else
			wait(100, 1000)
			gotoLabel("StartHunt")
		end
end

------------------ [DEPOT WITHDRAW] ----------------------

function WithdrawAmmo()
    if Self.ItemCount(Item.GetID(AmmoUse) < AmmoMax)
      then AmmoToWithdraw = (AmmoMax - Self.ItemCount(AmmoUse))
           Self.WithdrawItems(3, {Item.GetID(AmmoUse), AmmoBp, AmmoToWithdraw}) -- 4, Is the spot of bp on Depot.
end
end

function WithdrawRing()
    if Self.ItemCount(Item.GetID(RingUse) < RingMax)
      then AmmoToWithdraw = (RingMax - Self.ItemCount(RingUse))
           Self.WithdrawItems(4, {Item.GetID(RingUse), RingBp, AmmoToWithdraw}) -- 5, Is the spot of bp on Depot.
end
end

function WithdrawAmu()
    if Self.ItemCount(Item.GetID(AmuUse) < AmuMax)
      then AmmoToWithdraw = (AmuMax - Self.ItemCount(AmuUse))
           Self.WithdrawItems(5, {Item.GetID(AmuUse), AmuBp, AmmoToWithdraw}) -- 6, Is the spot of bp on Depot.
end
end

--------------------- [BP OPEN] --------------------------

--[[BIG 6 BACKPACKS + RESET]]-- MAIN
function ResetBp()
	Walker.Stop()
			  
            
		  Self.CloseContainers()
			 while Dedi_WindowCount("all") < 4 do
                      Self.CloseContainers()
                  wait(500,600)
            Self.OpenMainBackpack(true)
            wait(1500,1600)
			Container.GetFirst():OpenChildren(ManaBP)

		for x = 0, #Container.GetIndexes() - 1 do
					local bp = Container.GetFromIndex(x) 
					bp:Minimize()
					wait(200, 400)
				end
			
Container.GetFirst():OpenChildren(AmmoBP)
for x = 0, #Container.GetIndexes() - 1 do
					local bp = Container.GetFromIndex(x) 
					bp:Minimize()
					wait(200, 400)
				end
				
				Container.GetFirst():OpenChildren(RingBP)
for x = 0, #Container.GetIndexes() - 1 do
					local bp = Container.GetFromIndex(x) 
					bp:Minimize()
					wait(200, 400)
				end
				
				Container.GetFirst():OpenChildren(LootBP)
for x = 0, #Container.GetIndexes() - 1 do
					local bp = Container.GetFromIndex(x) 
					bp:Minimize()
					wait(200, 400)
				end
				
Container.GetFirst():OpenChildren(StackBP)
for x = 0, #Container.GetIndexes() - 1 do
					local bp = Container.GetFromIndex(x) 
					bp:Minimize()
					wait(200, 400)
				end
end
	
Walker.Start()
end

------------------ [BANK] ----------------------

function Bank()
	Walker.Stop()
		local amountMp = ((maxManaPot - Self.ItemCount(manaPotID)) * manaPotCost)
		local amountHp = ((maxHealthPot - Self.ItemCount(healthPotID)) * healthPotCost)
		local countMp = math.ceil(amountMp / 1000) * 1000
		local countHp = math.ceil(amountHp / 1000) * 1000
		local count = count + 1
		
Self.SayToNpc({"hi", "deposit all", "yes", "withdraw " .. (countMp + countHp), "yes", "balance"}, 65)

	Walker.Start()
end

function useCoins(id)  
    local cont = Container.GetFirst()  
 
    while (cont:isOpen()) do 
        for spot = 0, cont:ItemCount() do 
            local item = cont:GetItemData(spot)  
            if (item.id == id) then 
                if (item.count == 100) then
                    cont:UseItem(spot, True)
                    sleep(100)
                    return true
                end
            end 
        end 
 
        cont = cont:GetNext()  
    end 
      
    return false 
end

------------------ [TRAVEL/PASS] ----------------------

function TravelCity()
    Walker.Stop()
		Self.SayToNpc({"Hi", "passage", "yes"}, 65)
		
Walker.Start()
end

function TravelGoroma()
    Walker.Stop()
		Self.SayToNpc({"Hi", "Goroma", "yes"}, 65)
		
Walker.Start()
end

--[[BuyPotions]]--
function BuyPotions()
    Walker.Stop()
		Self.SayToNpc({"Hi", "Trade"}, 65)
		wait(900, 1200)
		Self.ShopBuyItemsUpTo(healthPotID, maxHealthPot)
		wait(900, 1200)
		Self.ShopBuyItemsUpTo(manaPotID, maxManaPot)
		wait(900, 1200)
                Self.ShopBuyItemsUpTo(manaPotID, maxManaPot)
		wait(900, 1200)
		Self.ShopBuyItemsUpTo(manaPotID, maxManaPot)
		wait(900, 1200)
                Self.ShopBuyItemsUpTo(manaPotID, maxManaPot)
		wait(900, 1200)
		Self.SayToNpc({"bye"}, 65)
	Walker.Start()
end

--[[Buy Assassin Stars]]--
function BuyAs()
       Walker.Stop()
Self.SayToNpc({"Hi", "Trade"}, 65)
wait(900, 1200)
Self.ShopBuyItemsUpTo(7368, maxSD)
wait(900, 1200)

	Walker.Start()

end

--------------------------------------------------------------------------------

--[[Find Certain Items On Screen]]--
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