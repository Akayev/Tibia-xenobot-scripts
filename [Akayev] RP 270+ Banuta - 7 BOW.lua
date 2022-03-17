----------------- [RP SCRIPT - Quiver] ----------------- Ezodus.net 2022 by Akayev ®

-- This script is recommended to run with imbu bow + diamond arrows (3 tier crit, life leech, mana leech)

--[[BACKPACKS]]--
local MainBackpack = "Buggy Backpack"
local ManaBP = "Purple Backpack"
local AmmoBP = "Jewelled Backpack"
local RingBP = "Yellow Backpack"
local LootBP = "Glooth Backpack"
local StackBP = "Red Backpack"
local forcebp = true -- force dynamic bp reset
local items = {238,23374,3202} -- [auto sort supplies - ManaBP]
local ammo = {35901}           -- [auto sort ammo - AmmoBP]

--[[MANA POTIONS]]--
local ManaName = "Great Mana Potion"
local maxManaPot = 500 -- 900 no imbu / 400 imbu
local minManaPot = 150

--[[HEALTH POTIONS]]--
local HealthName = "Ultimate Spirit Potion"
local maxHealthPot = 170 -- same for both
local minHealthPot = 100

--[[AREA RUNES]]--
local RuneName = "Thunderstorm Rune"
local maxRune = 1000 -- 700 no imbu / 1000 imbu
local minRune = 150

--[[AMMUNITION]]
local AmmoName = "Diamond Arrow" -- (cost 100)
local maxAmmo = 2700 -- 1700 no imbu / 2700 imbu
local minAmmo = 700

--[[QUIVER]]--
local QuiverBackpack = "blue quiver"

local UseAmulet = true
local Amulet = 814 -- Terra Amulet
local UseRing = true
local Ring = 3052 -- Life Ring

------------------ [WITHDRAW RINGS DP 5] ---------------------- WORKS ON LABEL WithdrawRing()
local RingUse = "Life Ring"
local RingMax = 6
local RingBp = "Yellow Backpack"
------------------ [WITHDRAW AMULETS DP 6] ---------------------- WORKS ON LABEL WithdrawAmu()
local AmuUse = "Terra Amulet"
local AmuMax = 13
local AmuBp = "Yellow Backpack"

local count = 0

registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
displayInformationMessage("Spawn: PH Banuta -7 BOW ARROWS+RUNES\n Vocation: [RP] 270+\n created by: Akayev")

function onWalkerSelectLabel(labelName)
local func = loadstring(labelName)
if (func) then func()
end
end

Module.New('Improved Gold Changer', function(module)
useCoins(3031)
useCoins(3035)
module:Delay(200)
end)

Module.New("Quiver Refiller", function(module) 
local QuiverRefill = 400
local bp1 = Container(AmmoBP)
for spot, item in bp1:iItems() do
if ((Self.ItemCount(35901, QuiverBackpack) < QuiverRefill)) then
bp1:MoveItemToContainer(spot, Container.New(QuiverBackpack):Index())
break
end
end
module:Delay(30000)
end)

Module.New("Sort Supplies + Ammuniton", function(module)
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
module:Delay(1000)
end)

Module.New('Equip Amulet', function(module)
if (UseAmulet) and (Self.Amulet().id ~= Amulet) and (Self.ItemCount(Amulet) > 0) then
Self.Equip(Amulet, "amulet")
end
module:Delay(2000)
end)

Module.New('Equip Ring', function(module)
if (UseRing) and (Self.Ring().id ~= Ring) and (Self.ItemCount(Ring) > 0) then
Self.Equip(Ring, "ring")
end
module:Delay(2000)
end)

Module.New('OpenContainers + Quiver RP', function(module)
local NumBackpacks = 7
if forcebp then  
if #Container.GetAll() < NumBackpacks then
Walker.Delay(6000)
print("Perfect Ezodus.net by Akayev 2022\n Backpack Reset!")        
Self.CloseContainers()
Self.OpenMainBackpack(true):OpenChildren({ManaBP, true}, {AmmoBP, true}, {RingBP, true}, {LootBP, true}, {StackBP, true})
Self.UseItemFromEquipment("shield")
wait(500)
end
end
module:Delay(2000)
end)

Module.New('LooterOnOff', function(module)
local _lootCap = 80
if (Self.Cap() <= _lootCap) then
Looter.Stop()
else
Looter.Start()
end
module:Delay(2000)
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
return true
end
end 
end 
cont = cont:GetNext()  
end 
return false 
end

function ResetBp()
Walker.Delay(6000)
    Self.CloseContainers()
    Self.OpenMainBackpack(true):OpenChildren({ManaBP, true}, {AmmoBP, true}, {RingBP, true}, {LootBP, true}, {StackBP, true})
    Self.UseItemFromEquipment("shield")
    wait(500)
end

function Check1() -- [funtion on label check supply]
	if ((Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(AmmoName) <= minAmmo) or (Self.ItemCount(RuneName) <= minRune)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next1")
	end
end

function Check2() -- [funtion on label check supply]
	if ((Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(AmmoName) <= minAmmo) or (Self.ItemCount(RuneName) <= minRune)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next2")
	end
end

function Check3() -- [funtion on label check supply]
	if ((Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(AmmoName) <= minAmmo) or (Self.ItemCount(RuneName) <= minRune)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next3")
	end
end

function Check4() -- [funtion on label check supply]
    if ((Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(AmmoName) <= minAmmo) or (Self.ItemCount(RuneName) <= minRune)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next5")
	end
end

function Check5() -- [funtion on label check supply]
	if ((Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(AmmoName) <= minAmmo) or (Self.ItemCount(RuneName) <= minRune)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next5")
	end
end

function Check6() -- [funtion on label check supply]
	if ((Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(AmmoName) <= minAmmo) or (Self.ItemCount(RuneName) <= minRune)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next6")
	end
end

function Check7() -- [funtion on label check supply]
	if ((Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(AmmoName) <= minAmmo) or (Self.ItemCount(RuneName) <= minRune)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next7")
	end
end

function CheckRP() -- [function on label MAIN REFIL CHECK]
	if ((Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(AmmoName) <= minAmmo) or (Self.ItemCount(RuneName) <= minRune)) then
		gotoLabel("Refil")
		else
		gotoLabel("StartHunt")
	end
end

function BuyPotions() -- [function on label buy hp, mana]
Walker.Stop()
	Self.SayToNpc({"Hi", "Trade"}, 65)
	wait(1000)
	Self.ShopBuyItemsUpTo(HealthName, maxHealthPot)
	wait(1000)
	Self.ShopBuyItemsUpTo(ManaName, maxManaPot)
	wait(1000)
	Self.ShopBuyItemsUpTo(RuneName, maxRune)
	wait(1000)
	Self.SayToNpc({"bye"}, 65)
Walker.Start()
end

function BuyAmmo() -- [function on label buy ammo]
Walker.Stop()
	Self.SayToNpc({"Hi", "Trade"}, 65)
	wait(1000)
	Self.ShopBuyItemsUpTo(AmmoName, maxAmmo)
	wait(1000)
	Self.SayToNpc({"bye"}, 65)
Walker.Start()
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

function TravelAdall()
Walker.Stop()
	Self.SayToNpc({"Hi", "east", "yes"}, 65)
Walker.Start()
end

function TravelLorek()
Walker.Stop()
	Self.SayToNpc({"Hi", "banuta", "yes"}, 65)	
Walker.Start()
end

function LosePz() 
    if (Self.isPzLocked() == true ) then
	    print ("Losing PZ, Please wait..")
	    wait(65000)
	end
end

function CheckPz()
    if (Self.isPzLocked() == false ) then
	    print ("Lost PZ Successfully ..")
        gotoLabel("Lost PZ")
        else
		print ("Unable to lose PZ. Trying again..")
	    gotoLabel("Losing PZ")
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
	    print ("You have withdrawn safe 300K for supplies. Continue.")
	end
end

function Check1Hole() -- jungle hole, shortcut
    if (Self.Position().z == 8) then
        gotoLabel("Checked1Hole")
        else
	    gotoLabel("Short1Hole")
    end
end

function CheckTP1() -- tp shortcut
    if (Self.Position().z == 9) then
        gotoLabel("CheckedTP1")
        else
	    gotoLabel("TP1")
	end
end

function Check2Hole() -- 2nd hole shortcut with dig
    if (Self.Position().z == 10) then
        gotoLabel("Checked2Hole")
        else
	    gotoLabel("Short2Hole")
	end
end

function CheckStairs1() -- stairs before banuta enter (shortcut doors)
    if (Self.Position().z == 11) then
        gotoLabel("CheckedStairs1")
        else
	    gotoLabel("Stairs1")
	end
end

function CheckStairs2() -- stairs on banuta 0 level inside respawn
    if (Self.Position().z == 12) then
        gotoLabel("CheckedStairs2")
        else
	    gotoLabel("Stairs2")
	end
end

function CheckStairs3() -- stairs on banuta EK level inside respawn
    if (Self.Position().z == 13) then
        gotoLabel("CheckedStairs3")
        else
	    gotoLabel("Stairs3")
	end
end

function CheckStairs4() -- stairs on banuta -7 level inside respawn
    if (Self.Position().z == 14) then
        gotoLabel("CheckedStairs4")
        else
	    gotoLabel("Stairs4")
	end
end

function CheckStairs5() -- stairs on REFIL -7
    if (Self.Position().z == 13) then
        gotoLabel("CheckedStairs5")
        else
	    gotoLabel("Stairs5")
	end
end

function CheckStairs6() -- stairs on REFIL EK level
    if (Self.Position().z == 12) then
        gotoLabel("CheckedStairs6")
        else
	    gotoLabel("Stairs6")
	end
end

function CheckStairs7() -- stairs on REFIL on 0 level
    if (Self.Position().z == 11) then
        gotoLabel("CheckedStairs7")
        else
	    gotoLabel("Stairs7")
	end
end

function CheckStairs8() -- stairs on monkeys
    if (Self.Position().z == 8) then
        gotoLabel("CheckedStairs8")
        else
	    gotoLabel("Stairs8")
	end
end

function CheckStairs8() -- stairs on monkeys 1
    if (Self.Position().z == 8) then
        gotoLabel("CheckedStairs8")
        else
	    gotoLabel("Stairs8")
	end
end

function CheckStairs9() -- stairs on monkeys 2
    if (Self.Position().z == 7) then
        gotoLabel("CheckedStairs9")
        else
	    gotoLabel("Stairs9")
	end
end

function CheckStairs10() -- stairs to bank
    if (Self.Position().z == 6) then
        gotoLabel("CheckedStairs10")
        else
	    gotoLabel("Stairs10")
	end
end

function CheckStairs11() -- stairs on depot
    if (Self.Position().z == 7) then
        gotoLabel("CheckedStairs11")
        else
	    gotoLabel("Stairs11")
	end
end

function CheckStairs12() -- stairs on ammo
    if (Self.Position().z == 6) then
        gotoLabel("CheckedStairs12")
        else
	    gotoLabel("Stairs12")
	end
end

function CheckStairs13() -- stairs on travel
    if (Self.Position().z == 7) then
        gotoLabel("CheckedStairs13")
        else
	    gotoLabel("Stairs13")
	end
end

function CheckLadder1() -- ladder on PZ
    if (Self.Position().z == 6) then
        gotoLabel("CheckedLadder1")
        else
	    gotoLabel("Ladder1")
	end
end

function CheckMonkey() -- stairs on REFIL TP on level 0
    if (Self.Position().z == 9) then
        gotoLabel("CheckedMonke")
        else
	    gotoLabel("MonkeysTP")
	end
end

function CheckDoor1()
    if(Self.Position().x == 32806 and Self.Position().y == 32637 and Self.Position().z == 11) then
        gotoLabel("CheckedDoor1")
        else
	    gotoLabel("BanutaDoor1")
	end
end