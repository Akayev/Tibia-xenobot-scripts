----------------- [RP SCRIPT - Quiver] ----------------- Ezodus.net 2022 by Akayev ®

--[[BACKPACKS]]--
local MainBackpack = "Buggy Backpack"
local ManaBP = "Purple Backpack"
local AmmoBP = "Jewelled Backpack"
local RingBP = "Yellow Backpack"
local LootBP = "Glooth Backpack"
local StackBP = "Red Backpack"
local forcebp = true -- turn on/off if backpacks closed attempt dynamic reset
local items = {237,23374} -- [auto sort supplies - ManaBP]
local ammo = {15793}      -- [auto sort ammo - AmmoBP]

--[[MANA POTIONS]]--
local ManaName = "Strong Mana Potion"
local maxManaPot = 740
local minManaPot = 150
local ManaCost = 93

--[[HEALTH POTIONS]]--
local HealthName = "Ultimate Spirit Potion"
local maxHealthPot = 200
local minHealthPot = 100
local HealthCost = 438

--[[AMMUNITION]]--
local AmmoName = "Crystalline Arrow" -- Diamond Arrow (cost 100) or Crystalline Arrow (cost 20)
local maxAmmo = 2000
local minAmmo = 500
local AmmoCost = 20

--[[QUIVER]]--
local QuiverBackpack = "blue quiver"

local UseAmulet = false
local Amulet = 814 -- Terra Amulet
local UseRing = true
local Ring = 3052 -- Life Ring


------------------ [WITHDRAW AMMO DP 4] ---------------------- WORKS ON LABEL WithdrawAmmo()
local AmmoUse = "Assassin Star"
local AmmoMax = 500
local AmmoBp = "Jewelled Backpack"
------------------ [WITHDRAW RINGS DP 5] ---------------------- WORKS ON LABEL WithdrawRing()
local RingUse = "Life Ring"
local RingMax = 10
local RingBp = "Yellow Backpack"
------------------ [WITHDRAW AMULETS DP 6] ---------------------- WORKS ON LABEL WithdrawAmu()
local AmuUse = "Terra Amulet"
local AmuMax = 9
local AmuBp = "Yellow Backpack"


local count = 0
registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
displayInformationMessage("Spawn: Goroma Serpents BOW+ARROWS\n Vocation: [RP] 180+\n created by: Akayev")

function onWalkerSelectLabel(labelName)
    local func = loadstring(labelName)
    if (func) then func()
    end
end

---------------------------- [DYNAMIC SCRIPTS] ----------------------------
 
Module.New("Move Ammunition To Quiver", function() -- [DYNAMIC AMMO TO QUIVER]
local QuiverRefill = 400
local bp1 = Container(AmmoBP)
for spot, item in bp1:iItems() do
if ((Self.ItemCount(15793, QuiverBackpack) < QuiverRefill)) then
bp1:MoveItemToContainer(spot, Container.New(QuiverBackpack):Index())
                                        wait(1000)
break
end
end
end)

Module.New("Sort Supplies + Ammuniton", function() -- [DYNAMIC SORT SUPPLIES AND AMMO]
local bp1 = Container(MainBackpack)
    for spot, item in bp1:iItems() do
        if (table.contains(items, item.id)) then
        bp1:MoveItemToContainer(spot, Container.New(ManaBP):Index())
		else
		    for spot, item in bp1:iItems() do
                if (table.contains(ammo, item.id)) then
                bp1:MoveItemToContainer(spot, Container.New(AmmoBP):Index())
                break
                end
			end
		end
end
end)

Module.New('stacking100gold', function(mod) -- [DYNAMIC GOLD CHANGER]
    useCoins(3031)
    wait(500)
    useCoins(3035)
    mod:Delay(1000)
end)

Module.New('equip amulet', function(module) -- [DYNAMIC AMULET]
if (UseAmulet) and (Self.Amulet().id ~= Amulet) and (Self.ItemCount(Amulet) > 0) then
Self.Equip(Amulet, "amulet")
module:Delay(1000)
end
end)

Module.New('equip ring', function(module) -- [DYNAMIC RING]
if (UseRing) and (Self.Ring().id ~= Ring) and (Self.ItemCount(Ring) > 0) then
Self.Equip(Ring, "ring")
module:Delay(1000)
end
end)

Module.New('OpenContainers + Quiver RP', function(BpMod) -- [DYNAMIC BP RESET]
local NumBackpacks = 7 -- [bpreset - count]
    if forcebp then  
        if #Container.GetAll() < NumBackpacks then
            Walker.Delay(6000)
            print("Perfect Ezodus.net by Akayev 2022\n Backpack Reset!")        
            Self.CloseContainers()
            Self.OpenMainBackpack(true):OpenChildren({ManaBP, true}, {AmmoBP, true}, {RingBP, true}, {LootBP, true}, {StackBP, true})
		    Self.UseItemFromEquipment("shield")
            wait(200, 500)
            end
		end
    BpMod:Delay(1000)
end)

---------------------------- [FUNCTIONS] ----------------------------

function useCoins(id) -- [function on module stacking coins]
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

function ResetBp() -- [funtion on label backpacks reset]
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
wait(200, 400)
Self.UseItemFromEquipment("shield")	
wait(200, 400)
Walker.Start()
end

function Check1() -- [funtion on label REFIL CHECK 1]
	delayWalker(500)
		if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(AmmoName) <= minAmmo)) then
			gotoLabel("Refil")
			else
			wait(100, 500)
			gotoLabel("Next1")
		end
end

function Check2() -- [funtion on label REFIL CHECK 2]
	delayWalker(500)
		if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(AmmoName) <= minAmmo)) then
			gotoLabel("Refil")
			else
			wait(100, 500)
			gotoLabel("Next2")
		end
end

function Check3() -- [funtion on label REFIL CHECK 3]
	delayWalker(500)
		if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(AmmoName) <= minAmmo)) then
			gotoLabel("Refil")
			else
			wait(100, 500)
			gotoLabel("Next3")
		end
end

function Check4() -- [funtion on label REFIL CHECK 4]
	delayWalker(500)
		if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(AmmoName) <= minAmmo)) then
			gotoLabel("Refil")
			else
			wait(100, 500)
			gotoLabel("Next4")
		end
end

function Check5()
	delayWalker(500)
		if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(AmmoName) <= minAmmo)) then
			gotoLabel("Refil")
			else
			wait(100, 500)
			gotoLabel("Next5")
		end
end

function CheckRP() -- [function on label MAIN REFIL CHECK]
	delayWalker(1000)
		if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(AmmoName) <= minAmmo)) then
			gotoLabel("Refil")
			else
			wait(100, 1000)
			gotoLabel("StartHunt")
		end
end

function BankRP() -- [function on label withdraw cc for supplies]
	Walker.Stop()
		local amountMp = ((maxManaPot - Self.ItemCount(ManaName)) * ManaCost)
		local amountHp = ((maxHealthPot - Self.ItemCount(HealthName)) * HealthCost)
		local amountAmmo = ((maxAmmo - Self.ItemCount(AmmoName)) * AmmoCost)
		local countMp = math.ceil(amountMp / 1000) * 1000
		local countHp = math.ceil(amountHp / 1000) * 1000
		local countAmmo = math.ceil(amountAmmo / 1000) * 1000
		local count = count + 1
		
Self.SayToNpc({"hi", "deposit all", "yes", "withdraw " .. (countMp + countHp + countAmmo), "yes", "balance"}, 65)

	Walker.Start()
end

function BuyPotions() -- [function on label buy hp, mana]
    Walker.Stop()
		Self.SayToNpc({"Hi", "Trade"}, 65)
		wait(900, 1200)
		Self.ShopBuyItemsUpTo(HealthName, maxHealthPot)
		wait(900, 1200)
		Self.ShopBuyItemsUpTo(ManaName, maxManaPot)
		wait(900, 1200)
		Self.SayToNpc({"bye"}, 65)
	Walker.Start()
end

function BuyAmmo() -- [function on label buy ammo]
    Walker.Stop()
		Self.SayToNpc({"Hi", "Trade"}, 65)
		wait(900, 1200)
		Self.ShopBuyItemsUpTo(AmmoName, maxAmmo)
		wait(900, 1200)
		Self.SayToNpc({"bye"}, 65)
	Walker.Start()
end

function WithdrawAmmo() -- [function on label withdraw ammo from depot]
    if Self.ItemCount(Item.GetID(AmmoUse) < AmmoMax) then 
	    AmmoToWithdraw = (AmmoMax - Self.ItemCount(AmmoUse))
        Self.WithdrawItems(3, {Item.GetID(AmmoUse), AmmoBp, AmmoToWithdraw}) -- 4, Is the spot of bp on Depot.
    end
end

function WithdrawRing() -- [function on label withdraw rings from depot]
    if Self.ItemCount(Item.GetID(RingUse) < RingMax) then 
	    AmmoToWithdraw = (RingMax - Self.ItemCount(RingUse))
        Self.WithdrawItems(4, {Item.GetID(RingUse), RingBp, AmmoToWithdraw}) -- 5, Is the spot of bp on Depot.
    end
end

function WithdrawAmu() -- [function on label withdraw amulets from depot]
    if Self.ItemCount(Item.GetID(AmuUse) < AmuMax) then 
	    AmmoToWithdraw = (AmuMax - Self.ItemCount(AmuUse))
        Self.WithdrawItems(5, {Item.GetID(AmuUse), AmuBp, AmmoToWithdraw}) -- 6, Is the spot of bp on Depot.
    end
end

function Emberwing()
    Self.Cast("utevo gran res sac")
end

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

Map.GetUseItems = function (id) -- [find certain items on screen]
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

function Dedi_OpenNextBp(bp_name) -- [function to open bp inside backpack]
    local backpack = Container.GetByName(bp_name)
 
    for i = backpack:ItemCount()-1, 0, -1 do
        local item = backpack:GetItemData(i).id
 
        if (item == Item.GetID(bp_name)) then
            backpack:UseItem(i, true)
        end
    end
end
 
function Dedi_WindowCount(CONTAINER_NAME) -- [returns amount of backpack opened]
    local CONTAINER_NAME, WINDOW_COUNT, CONTAINER = tostring(CONTAINER_NAME or "all"):lower(), 0, Container.GetFirst()
 
    while (CONTAINER:isOpen()) do
        if (CONTAINER:Name():lower() == CONTAINER_NAME or CONTAINER_NAME == "all") then
            WINDOW_COUNT = WINDOW_COUNT + 1
        end
 
        CONTAINER = CONTAINER:GetNext()
    end
 
    return WINDOW_COUNT
end