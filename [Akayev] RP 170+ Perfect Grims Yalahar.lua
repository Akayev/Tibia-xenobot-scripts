----------------- [RP SCRIPT - Quiver] ----------------- Ezodus.net 2022 by Akayev ®

--[[BACKPACKS]]--
local MainBackpack = "Buggy Backpack"
local ManaBP = "Purple Backpack"
local AmmoBP = "Jewelled Backpack"
local RingBP = "Yellow Backpack"
local LootBP = "Glooth Backpack"
local StackBP = "Red Backpack"
local forcebp = true -- turn on/off if backpacks closed attempt dynamic reset
local items = {238,23374,3191} -- [auto sort supplies - ManaBP]
local ammo = {15793}           -- [auto sort ammo - AmmoBP]

--[[MANA POTIONS]]--
local ManaName = "Great Mana Potion"
local maxManaPot = 600
local minManaPot = 150

--[[HEALTH POTIONS]]--
local HealthName = "Ultimate Spirit Potion"
local maxHealthPot = 100
local minHealthPot = 50

--[[AREA RUNES]]--
local RuneName = "Great Fireball Rune"
local maxRune = 400
local minRune = 100

--[[AMMUNITION]]
local AmmoName = "Crystalline Arrow"
local maxAmmo = 1700
local minAmmo = 500

--[[QUIVER]]--
local QuiverBackpack = "blue quiver"

local UseRing = true
local Ring = 3052 -- Life Ring

--[WITHDRAW RINGS DP 5] -- works on label WithdrawRing()
local RingUse = "Life Ring"
local RingMax = 19
local RingBp = "Yellow Backpack"

local count = 0
registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
displayInformationMessage("Spawn: Yalahar Grim Reapers + Hardcore\n Vocation: [RP] 170+\n created by: Akayev")

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
             break
        end
    end
end)

Module.New("Sort Supplies + Ammuniton", function() -- [DYNAMIC SORT SUPPLIES AND AMMO]
local bp1 = Container(MainBackpack)
local bp2 = Container(AmmoBP)
    for spot, item in bp1:iItems() do
        if (table.contains(items, item.id)) then
        bp1:MoveItemToContainer(spot, Container.New(ManaBP):Index())
		else
		    for spot, item in bp1:iItems() do
                if (table.contains(ammo, item.id)) then
                bp1:MoveItemToContainer(spot, Container.New(AmmoBP):Index())
				else
		            for spot, item in bp2:iItems() do
                        if (table.contains(items, item.id)) then
                        bp2:MoveItemToContainer(spot, Container.New(ManaBP):Index())
					    break
					end
	            end
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

Module.New('LooterOnOff', function()
    local _lootCap = 50
    if (Self.Cap() <= _lootCap) then
        Looter.Stop()
        else
        Looter.Start()
    end
end)

---------------------------- [FUNCTIONS] ----------------------------

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

function ResetBp() -- function on label reset backpacks
    Walker.Delay(6000)
	    Self.CloseContainers()
        Self.OpenMainBackpack(true):OpenChildren({ManaBP, true}, {AmmoBP, true}, {RingBP, true}, {LootBP, true}, {StackBP, true})
		Self.UseItemFromEquipment("shield")
	wait(200, 500)
end

function CheckRP() -- [function on label MAIN REFIL CHECK]
	delayWalker(1000)
		if ((Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(AmmoName) <= minAmmo) or (Self.ItemCount(RuneName) <= minRune)) then
			gotoLabel("Refil")
			else
			wait(100, 1000)
			gotoLabel("StartHunt")
		end
end

function DepositAll()
    Walker.Stop()
		Self.SayToNpc({"Hi", "deposit all", "yes", "balance"}, 65)
        Self.WithdrawMoney(300000)
Walker.Start()
end

function CheckMoney()
    if Self.Money() < 300000 then
	    Walker.Stop()
	    print ("You don't have 300K for supplies.\n Bot stopped. Deposit gold in the bank.")
	    else
	    Walker.Start()
	    print ("You have withdrawn safe 300K for supplies. Going shop.")
	end
end

function BuyPotions() -- [function on label buy hp, mana]
    Walker.Stop()
		Self.SayToNpc({"Hi", "Trade"}, 65)
		wait(900, 1200)
		Self.ShopBuyItemsUpTo(HealthName, maxHealthPot)
		wait(900, 1200)
		Self.ShopBuyItemsUpTo(ManaName, maxManaPot)
		wait(900, 1200)
		Self.ShopBuyItemsUpTo(RuneName, maxRune)
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

function WithdrawRing() -- [function on label withdraw rings from depot]
    if Self.ItemCount(Item.GetID(RingUse) < RingMax) then 
	    AmmoToWithdraw = (RingMax - Self.ItemCount(RingUse))
        Self.WithdrawItems(4, {Item.GetID(RingUse), RingBp, AmmoToWithdraw}) -- 5, Is the spot of bp on Depot.
    end
end

function Cemetery()
    Walker.Stop()
		Self.SayToNpc({"Hi", "pass", "cemetery"}, 65)	
Walker.Start()
end


function Magician()
    Walker.Stop()
		Self.SayToNpc({"Hi", "pass", "magician", "yes"}, 65)	
Walker.Start()
end

function LosePz() 
    delayWalker(1000)
        if (Self.isPzLocked() == true ) then
	    print ("Losing PZ, Please wait..")
	    wait(65000)
	end
end

function CheckPz()
    delayWalker(1000)
        if (Self.isPzLocked() == false ) then
		print ("Lost PZ Successfully ..")
        gotoLabel("Lost PZ")
        else
		wait(100, 1000)
		print ("Unable to lose PZ. Trying again..")
	    gotoLabel("Losing PZ")
		end
end