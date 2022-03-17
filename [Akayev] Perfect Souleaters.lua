--------------- [LOCAL INFO] ------------------ Ezodus.net 2022 by Akayev ®

local MainBackpack = "Buggy Backpack"
local ManaBP = "Purple Backpack"
local AmmoBP = "Jewelled Backpack"
local RingBP = "Yellow Backpack"
local LootBP = "Glooth Backpack"
local StackBP = "Red Backpack"
local Supplies = {23373,3155} -- auto sort supplies (ManaBP)
local AreaRunes = {3191} -- auto sort area runes (AmmoBP)

--[[MANA POTIONS]]--
local ManaName = "Ultimate Mana Potion"
local maxManaPot = 300
local minManaPot = 70

--[[AREA RUNES]]--
local RuneName = "Great Fireball Rune"
local maxRune = 1600
local minRune = 150

--[[SUDDEN DEATH RUNES]]--
local SDName = "Sudden Death Rune" 
local maxSD = 200
local minSD = 50  

local count = 0

registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
displayInformationMessage("Spawn: ZAO Souleaters PG\n Vocation: [MS] 130+\n created by: Akayev")

function onWalkerSelectLabel(labelName)
local func = loadstring(labelName)
if (func) then func()
end
end

Module.New('stacking100gold', function(module)
useCoins(3031)
useCoins(3035)
module:Delay(200)
end)

Module.New("Sort Supplies + AreaRunes", function(module)
local bp1 = Container(MainBackpack)
local bp2 = Container(ManaBP)
for spot, item in bp1:iItems() do
if (table.contains(Supplies, item.id)) then
bp1:MoveItemToContainer(spot, Container.New(ManaBP):Index())
else
for spot, item in bp1:iItems() do
if (table.contains(AreaRunes, item.id)) then
bp1:MoveItemToContainer(spot, Container.New(AmmoBP):Index())
else
for spot, item in bp2:iItems() do
if (table.contains(AreaRunes, item.id)) then
bp2:MoveItemToContainer(spot, Container.New(AmmoBP):Index())
break
end
end
end
end
end
end
module:Delay(1000)
end)

Module.New('DynamicBpReset', function(module)
local NumBackpacks = 6
if #Container.GetAll() < NumBackpacks then
Walker.Delay(6000)
print("Perfect Ezodus.net by Akayev 2022\n Backpack Reset!")        
Self.CloseContainers()
Self.OpenMainBackpack(true):OpenChildren({ManaBP, true}, {AmmoBP, true}, {RingBP, true}, {LootBP, true}, {StackBP, true})
wait(500)
end
module:Delay(2000)
end)

Module.New("Drop UHP", function(module)
local MinCap = 100
local UhpID = 7643
if (Self.Cap() < MinCap) then
Self.DropItem(Self.Position().x, Self.Position().y, Self.Position().z, UhpID)
module:Delay(3000)
end
end)

---------------- [FUNCTIONS] ------------------

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

function CheckMage()
    if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(RuneName) <= minRune) or (Self.ItemCount(SDName) <= minSD)) then
		gotoLabel("Refil")
		else
		gotoLabel("StartHunt")
	end
end

function BuyMage()
Walker.Stop()
	Self.SayToNpc({"Hi", "Trade"}, 65)
	wait(1000)
	Self.ShopBuyItemsUpTo(ManaName, maxManaPot)
	wait(1000)
	Self.ShopBuyItemsUpTo(RuneName, maxRune)
	wait(1000)
	Self.ShopBuyItemsUpTo(SDName, maxSD)
	wait(1000)
	Self.SayToNpc({"bye"}, 65)
Walker.Start()
end

function ResetBp()
Walker.Delay(6000)
	Self.CloseContainers()
    Self.OpenMainBackpack(true):OpenChildren({ManaBP, true}, {AmmoBP, true}, {RingBP, true}, {LootBP, true}, {StackBP, true})
	wait(500)
end

----------------------- [BANK] ------------------------

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

function UpNorth() -- function on label exani hur up
    Self.Turn(NORTH)
	Self.Cast("exani hur up")
end

function UpSouth() -- function on label exani hur up
    Self.Turn(SOUTH)
	Self.Cast("exani hur up")
end

function UpWest() -- function on label exani hur up
    Self.Turn(WEST)
	Self.Cast("exani hur up")
end

function UpEast() -- function on label exani hur up
    Self.Turn(EAST)
	Self.Cast("exani hur up")
end

function DownNorth() -- function on label exani hur up
    Self.Turn(NORTH)
	Self.Cast("exani hur down")
end

function DownSouth() -- function on label exani hur up
    Self.Turn(SOUTH)
	Self.Cast("exani hur down")
end

function DownWest() -- function on label exani hur up
    Self.Turn(WEST)
	Self.Cast("exani hur down")
end

function DownEast() -- function on label exani hur up
    Self.Turn(EAST)
	Self.Cast("exani hur down")
end

function CheckFloor1() -- EXANI CHECK CITY 1
    if (Self.Position().z == 4) then
	    gotoLabel("CheckedFloor1")
        else
	    gotoLabel("StartExani1")
	end
end

function CheckFloor2() -- EXANI CHECK CITY 2
    if (Self.Position().z == 6) then
	    gotoLabel("CheckedFloor2")
        else
	    gotoLabel("StartExani2")
	end
end

function CheckFloor3() -- EXANI CHECK REFIL 1
    if (Self.Position().z == 5) then
	    gotoLabel("CheckedFloor3")
        else
	    gotoLabel("StartExani3")
	end
end

function CheckFloor4() -- EXANI CHECK REFIL 2
    if (Self.Position().z == 5) then
	    gotoLabel("CheckedFloor4")
        else
	    gotoLabel("StartExani4")
	end
end

function CheckResp1() -- EXANI CHECK RESPAWN !
    if (Self.Position().z == 6) then
	    gotoLabel("Checked GO EXP")
        else
	    gotoLabel("EXANI RESP UP")
	end
end

function CheckResp2() -- EXANI CHECK RESPAWN 2
    if (Self.Position().z == 7) then
	    gotoLabel("Checked REFIL")
        else
	    gotoLabel("EXANI RESP DOWN")
	end
end

function CheckLever1() -- LEVER CHECK EXP
    if (Self.Position().z == 4) then
	    gotoLabel("CheckedLever1")
        else
	    gotoLabel("StartLever1")
	end
end

function CheckLever2() -- LEVER CHECK REFIL
    if (Self.Position().z == 10) then
	    gotoLabel("CheckedLever2")
        else
	    gotoLabel("StartLever2")
	end
end