------------ [LOCAL INFO] ------------ by Akayev ® 2022 Ezodus.net

local MainBackpack = "Crystal Backpack"
local ManaBP = "Purple Backpack"
local AmmoBP = "Jewelled Backpack"
local RingBP = "Yellow Backpack"
local LootBP = "Glooth Backpack"
local StackBP = "Red Backpack"
local Supplies = {237,23375} -- auto sort supplies (ManaBP)

--[[HEALTH POTIONS]]--
local HealthName = "Supreme Health Potion"
local maxHealthPot = 200
local minHealthPot = 100

--[[MANA POTIONS]]--
local ManaName = "Strong Mana Potion"
local maxManaPot = 1550
local minManaPot = 300

local UseRing = true -- use ring
local Ring = 3052 -- ring ID

local RingUse = "Life Ring" -- [WITHDRAW RINGS DP 5] -- works on label WithdrawRing()
local RingMax = 19
local RingBp = "Yellow Backpack"

local count = 0

registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
displayInformationMessage("Spawn: EDRON HERO CAVE\n Vocation: [EK] 150+\n created by: Akayev")

function onWalkerSelectLabel(labelName)
local func = loadstring(labelName)
if (func) then func()
end
end

Module.New('Improved gold stacking', function(module)
useCoins(3031)
useCoins(3035)
module:Delay(200)
end)

Module.New("Sort Supplies", function(module)
local bp1 = Container(MainBackpack)
for spot, item in bp1:iItems() do
if (table.contains(Supplies, item.id)) then
bp1:MoveItemToContainer(spot, Container.New(ManaBP):Index())
break
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

Module.New('equip ring', function(module)
if (UseRing) and (Self.Ring().id ~= Ring) and (Self.ItemCount(Ring) > 0) then
Self.Equip(Ring, "ring")
end
module:Delay(2000)
end)

--------------------- [FUNCTIONS] --------------------- 

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

function CheckEK()
if ((Self.ItemCount(HealthName) <= minHealthPot) or (Self.ItemCount(ManaName) <= minManaPot)) then
	gotoLabel("Refil")
    else
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

function BuyPotions() -- function on label buy supplies
Walker.Stop()
	Self.SayToNpc({"Hi", "Trade"}, 65)
	wait(1000)
	Self.ShopBuyItemsUpTo(HealthName, maxHealthPot)
	wait(1000)
	Self.ShopBuyItemsUpTo(ManaName, maxManaPot)
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

function WithdrawRing()
if Self.ItemCount(Item.GetID(RingUse) < RingMax) then 
	AmmoToWithdraw = (RingMax - Self.ItemCount(RingUse))
    Self.WithdrawItems(4, {Item.GetID(RingUse), RingBp, AmmoToWithdraw}) -- depot 5
    end
end