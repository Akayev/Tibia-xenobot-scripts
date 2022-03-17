--- [LOCAL INFO] --- [MS] 300+ INQ 3 Ushuriel seals --- by Akayev ® 2022 Ezodus.net

local MainBackpack = "Buggy Backpack"
local ManaBP = "Purple Backpack"
local AmmoBP = "Jewelled Backpack"
local RingBP = "Yellow Backpack"
local LootBP = "Glooth Backpack"
local StackBP = "Red Backpack"
local Supplies = {23373,3155} -- auto sort supplies (ManaBP)
local AreaRunes = {3202,3191} -- auto sort area runes (AmmoBP)

--[[MANA POTIONS]]--
local ManaPotion = "ultimate mana potion"
local maxMana = 500
local minMana = 130

----[[STORMS]]-----
local Storms = "thunderstorm rune"
local maxStorms = 1500
local minStorms = 300

--[[BROWN MUSHROOMS]]--
local Food = "brown mushroom"
local maxFood = 300
local minFood = 20

-- [Advanced configuration] --
local forcewand = false  -- Equip imbuement wand on respawn
local wand1 = "Dream Blossom Staff"
local wand2 = "Wand of Destruction"

--- [WITHDRAW RINGS DP 6] --- WORKS ON LABEL WithdrawRing()
local RingWithdraw = "Dwarven Ring"
local RingMax = 5

local DwarvenEquip = true
local Ring = 3097-- Dwarven Ring ID

registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
displayInformationMessage("Spawn: Spider+Phantasm+Quara INQ\n Vocation: [MS] 300+\n created by: Akayev")

function onWalkerSelectLabel(labelName)
local func = loadstring(labelName)
if (func) then func()
end
end

Module.New('Improved gold changer', function(module)
useCoins(3031)
useCoins(3035)
module:Delay(500)
end)

Module.New('Equip Dwarven Ring', function(module)
if (DwarvenEquip) and (Self.Ring().id ~= Ring) and (Self.ItemCount(Ring) > 0) then
Self.Equip(Ring, "ring")
end
module:Delay(2000)
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
module:Delay(2000)
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

------------------------- [FUNCTIONS] -------------------------

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
wait(500)
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

function BuyMana()
Walker.Stop()
    Self.SayToNpc({"Hi", "Trade"}, 65)
	wait(1000)
	Self.ShopBuyItemsUpTo(ManaPotion, maxMana)
	wait(1000)
	Self.SayToNpc({"bye"}, 65)
Walker.Start()
end

function BuyStorms()
Walker.Stop()
    Self.SayToNpc({"Hi", "Trade"}, 65)
	wait(1000)
	Self.ShopBuyItemsUpTo(Storms, maxStorms)
	wait(1000)
	Self.SayToNpc({"bye"}, 65)
Walker.Start()
end

function BuyMushroom()
Walker.Stop()
    Self.SayToNpc({"Hi", "Trade"}, 65)
	wait(1000)
	Self.ShopBuyItemsUpTo(Food, maxFood)
	wait(1000)
	Self.SayToNpc({"bye"}, 65)
Walker.Start()
end

function CheckMage()
	if ((Self.ItemCount(ManaPotion) <= minMana) or (Self.ItemCount(Storms) <= minStorms) or (Self.ItemCount(Food) <= minFood)) then
		gotoLabel("REFILL")
		else
		gotoLabel("START HUNT")
	end
end

function WithdrawRing()
    if Self.ItemCount(Item.GetID(RingWithdraw) < RingMax) then
	    AmmoToWithdraw = (RingMax - Self.ItemCount(RingWithdraw))
        Self.WithdrawItems(5, {Item.GetID(RingWithdraw), RingBP, AmmoToWithdraw}) -- 6, Is the spot of bp on Depot.
    end
end

function CheckUtamo()
	if (Self.isManaShielded() == true ) then
        gotoLabel("CheckedUtamo")
        else
	    gotoLabel("StartUtamo")
		Self.Cast("Utamo Vita")
	end
end

function CheckExana()
	if (Self.isManaShielded() == false ) then
        gotoLabel("CheckedExana")
        else
	    gotoLabel("StartExana")
		Self.Cast("Exana Vita")
	end
end

function CheckUtamo2()
	if (Self.isManaShielded() == true ) then
        gotoLabel("CheckedUtamo2")
        else
	    gotoLabel("StartUtamo2")
		Self.Cast("Utamo Vita")
	end
end

function CheckExana2()
	if (Self.isManaShielded() == false ) then
        gotoLabel("CheckedExana2")
        else
	    gotoLabel("StartExana2")
		Self.Cast("Exana Vita")
	end
end

function CheckStair1()
	if (Self.Position().z == 6) then
        gotoLabel("CheckedStair1")
        else
	    gotoLabel("Stair1")
	end
end

function CheckStair2()
	if (Self.Position().z == 7) then
        gotoLabel("CheckedStair2")
        else
	    gotoLabel("Stair2")
	end
end

function CheckStair3()
	if (Self.Position().z == 14) then
        gotoLabel("CheckedStair3")
        else
	    gotoLabel("Stair3")
	end
end

function CheckStair4()
	if (Self.Position().z == 14) then
        gotoLabel("CheckedStair4")
        else
	    gotoLabel("Stair4")
	end
end

function CheckStair5()
	if (Self.Position().z == 12) then
        gotoLabel("CheckedStair5")
        else
	    gotoLabel("Stair5")
	end
end

function CheckStair6()
	if (Self.Position().z == 11) then
        gotoLabel("CheckedStair6")
        else
	    gotoLabel("Stair6")
	end
end

function CheckStair7()
	if (Self.Position().z == 12) then
        gotoLabel("CheckedStair7")
        else
	    gotoLabel("Stair7")
	end
end

function CheckStair8()
	if (Self.Position().z == 11) then
        gotoLabel("CheckedStair8")
        else
	    gotoLabel("Stair8")
	end
end

function CheckStair9()
	if (Self.Position().z == 12) then
        gotoLabel("CheckedStair9")
        else
	    gotoLabel("Stair9")
	end
end

function CheckStair10()
	if (Self.Position().z == 11) then
        gotoLabel("CheckedStair10")
        else
	    gotoLabel("Stair10")
	end
end

function CheckStair11()
	if (Self.Position().z == 12) then
        gotoLabel("CheckedStair11")
        else
	    gotoLabel("Stair11")
	end
end

function CheckStair12()
	if (Self.Position().z == 11) then
        gotoLabel("CheckedStair12")
        else
	    gotoLabel("Stair12")
	end
end

function CheckStair13()
	if (Self.Position().z == 10) then
        gotoLabel("CheckedStair13")
        else
	    gotoLabel("Stair13")
	end
end

function CheckStair14()
	if (Self.Position().z == 13) then
        gotoLabel("CheckedStair14")
        else
	    gotoLabel("Stair14")
	end
end

function CheckStair15()
	if (Self.Position().z == 6) then
        gotoLabel("CheckedStair15")
        else
	    gotoLabel("Stair15")
	end
end

function CheckStair16()
	if (Self.Position().z == 7) then
        gotoLabel("CheckedStair16")
        else
	    gotoLabel("Stair16")
	end
end

function CheckRope1()
	if (Self.Position().z == 11) then
        gotoLabel("CheckedRope1")
        else
	    gotoLabel("Rope1")
	end
end

function CheckRope2()
	if (Self.Position().z == 10) then
        gotoLabel("CheckedRope2")
        else
	    gotoLabel("Rope2")
	end
end

function CheckRope3()
	if (Self.Position().z == 9) then
        gotoLabel("CheckedRope3")
        else
	    gotoLabel("Rope3")
	end
end

function CheckRope4()
	if (Self.Position().z == 8) then
        gotoLabel("CheckedRope4")
        else
	    gotoLabel("Rope4")
	end
end

function CheckRope5()
	if (Self.Position().z == 7) then
        gotoLabel("CheckedRope5")
        else
	    gotoLabel("Rope5")
	end
end

function CheckHole1()
	if (Self.Position().z == 8) then
        gotoLabel("CheckedHole1")
        else
	    gotoLabel("Hole1")
	end
end

function CheckHole2()
	if (Self.Position().z == 9) then
        gotoLabel("CheckedHole2")
        else
	    gotoLabel("Hole2")
	end
end

function CheckHole3()
	if (Self.Position().z == 10) then
        gotoLabel("CheckedHole3")
        else
	    gotoLabel("Hole3")
	end
end

function CheckHole4()
	if (Self.Position().z == 11) then
        gotoLabel("CheckedHole4")
        else
	    gotoLabel("Hole4")
	end
end

function CheckHole5()
	if (Self.Position().z == 12) then
        gotoLabel("CheckedHole5")
        else
	    gotoLabel("Hole5")
	end
end

function CheckHole6()
	if (Self.Position().z == 13) then
        gotoLabel("CheckedHole6")
        else
	    gotoLabel("Hole6")
	end
end

function CheckLadder1()
	if (Self.Position().z == 12) then
        gotoLabel("CheckedLadder1")
        else
	    gotoLabel("Ladder1")
	end
end