--- [LOCAL INFO] --- [MAGE - Shooter auto vocation] 200+ Farmine Lizard City by Akayev ® 2022 Ezodus.net

-- It's recommended to run this script on 220+ mage with imbuement wand (critical strike, magic level)
-- This script automaticly using dynamic utamo vita if 2 players on screen (disable it after 15 seconds), auto selling looted zao items
-- Added configurations: force refil, force wand, force enemy alarm, sort supplies (ManaBP)
-- Always double check wands configuration, ED wands are basic, gold changer is included

local MainBackpack = "Buggy Backpack"
local ManaBP = "Purple Backpack"
local AmmoBP = "Jewelled Backpack"
local RingBP = "Yellow Backpack"
local LootBP = "Glooth Backpack"
local StackBP = "Red Backpack"
local Supplies = {23373,3155} -- auto sort supplies (ManaBP)
local AreaRunes = {3161} -- auto sort area runes (AmmoBP)

--[[MANA POTIONS]]--
local ManaName = "Ultimate Mana Potion"
local maxManaPot = 450
local minManaPot = 130

--[[AREA RUNES]]--
local RuneName = "Avalanche Rune"
local maxRune = 1700
local minRune = 300

--[[SUDDEN DEATH RUNES]]--
local SDName = "Sudden Death Rune" 
local maxSD = 400
local minSD = 150

-- [Advanced configuration] --
local forcerefil = false -- Force refil if low supplies
local forcewand = true  -- Equip imbuement wand on respawn
local wand1 = "Glacial Rod"        -- Normal wand in use
local wand2 = "Rod of Destruction" -- Imbuement wand on respawn

-- [Alarm on listed player - configuration]
local forcealarm = true -- play alarm if listed player on screen
local enemies = {"Death Is Coming", "Debug"}   -- list of enemies

-- do not touch
local SpellA = "Utamo Vita"
local SpellB = "Exana Vita"
local LastCastA = 0

local count = 0

registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
displayInformationMessage("Spawn: LIZARD CITY\n Vocation: [ED] 210+\n created by: Akayev")

function onWalkerSelectLabel(labelName)
local func = loadstring(labelName)
if (func) then func()
end
end

Module.New('DynamicUtamo', function(module)
if (playersAround(7) > 1) then
if (Self.isManaShielded() == false ) and (Self.isInPz() == false ) then
Self.Cast("Utamo Vita")
end
end
module:Delay(200)
end)

Module.New('DynamicExana', function(module)
if (Self.isManaShielded() == true ) then
if os.time() - LastCastA >= 15 then
Self.Cast(SpellB)
LastCastA = os.time()
end
end
module:Delay(200)
end)

Module.New('Improved gold changer', function(module)
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

Module.New('Alarm enemy list', function(module)
if forcealarm then
for _, enemy in ipairs(enemies) do
local creature = Creature.New(enemy)
if (creature:isOnScreen(multiFloor) and creature:isVisible() and creature:isAlive()) then
alert()	
break
end
end
end
module:Delay(2000)
end)

Module.New('Force-Refil', function(module)
if forcerefil then
if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(RuneName) <= minRune) or (Self.ItemCount(SDName) <= minSD)) then
Looter.Stop()
Targeting.Stop()
else
Targeting.Start()
Looter.Start()
end
end
module:Delay(3000)
end)

Module.New("Drop Tower Shields", function(module)
local MinCap = 100
local TowerID = 3428
if (Self.Cap() < MinCap) then
Self.DropItem(Self.Position().x, Self.Position().y, Self.Position().z, TowerID)
end
module:Delay(3000)
end)

------------------------- [FUNCTIONS] -------------------------

function playersAround(radius, ...)
if getPlayersAround(radius, ...) then
return #getPlayersAround(radius, ...)
else
return 0
end
end

function getPlayersAround(radius, ...)
local t = {...}
local players = {}
if (radius == 0) then
radius = 8
end
for i = CREATURES_LOW, CREATURES_HIGH do
local creature = Creature.GetFromIndex(i)
if (creature:isValid()) and creature:ID() ~= Self.ID() then
if (creature:isOnScreen() and creature:isVisible() and creature:isAlive()) then
if creature:isPlayer() then
local name = creature:Name()
if (creature:DistanceFromSelf() <= radius) then
if (not table.contains(t, name)) then
table.insert(players, creature)
end
end
end
end
end
end
return players
end

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

function NormalWand()
Walker.Delay(500)
if forcewand then
Self.Equip(wand1, "weapon")
end
end

function CritWand()
Walker.Delay(500)
if forcewand then
Self.Equip(wand2, "weapon")
end
end

function BuySupplies()
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

function SellZao()
Walker.Stop()
	Self.SayToNpc({"hi", "trade"}, 65)
	wait(500)
 	Self.ShopSellAllItems(10386) -- zao shoes
	wait(500)
	Self.ShopSellAllItems(10387) -- zao legs
	wait(500)
    Self.ShopSellAllItems(10388) -- drakinata
	wait(500)
	Self.ShopSellAllItems(10384) -- zaoan armor
	wait(500)
	Self.ShopSellAllItems(10416) -- high guard's shoulderplates
	wait(500)
	Self.ShopSellAllItems(10408) -- spiked iron
	wait(500)
	Self.ShopSellAllItems(10414) -- zaogun shoulderplates
    wait(500)		
Walker.Start()
end

function SellFlags()
Walker.Stop()
	Self.SayToNpc({"hi", "trade"}, 65)
	wait(500)
	Self.ShopSellAllItems(10415) -- flags
	wait(500)
Walker.Start()  
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

function LosePz() -- function on label if pz locked wait 60 seconds
    if (Self.isPzLocked() == true ) then
	    print ("Losing PZ, Please wait..")
	    wait(65000)
	end
end

function CheckPz() -- function on label check if pz locked
    if (Self.isPzLocked() == false ) then
		print ("Lost PZ Successfully ..")
        gotoLabel("Lost PZ")
        else
		print ("Unable to lose PZ. Trying again..")
	    gotoLabel("Losing PZ")
	end
end

function LosePz2()  -- function on label if pz locked wait 60 seconds (2)
    if (Self.isPzLocked() == true ) then
	    print ("Losing PZ, Please wait..")
	    wait(65000)
	end
end

function CheckPz2() -- function on label check if pz locked (2)
    if (Self.isPzLocked() == false ) then
		print ("Lost PZ Successfully ..")
        gotoLabel("Lost PZ2")
        else
		print ("Unable to lose PZ. Trying again..")
	    gotoLabel("Losing PZ2")
	end
end

function CheckPZDoors() -- function on label check PZ before going ladder
	if (Self.isPzLocked() == true ) then
		gotoLabel("GOING LOSE PZ")
		print ("PZ locked.. going back.")
		else
		gotoLabel("GOING LADDER")
		print ("No PZ lock, going teleports..")
	end
end

function Check1()
	if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(RuneName) <= minRune) or (Self.ItemCount(SDName) <= minSD)) then
	    gotoLabel("Refil")
		else
		gotoLabel("Next1")
	end
end

function Check2()
	if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(RuneName) <= minRune) or (Self.ItemCount(SDName) <= minSD)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next2")
	end
end

function Check3()
	if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(RuneName) <= minRune) or (Self.ItemCount(SDName) <= minSD)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next3")
	end
end

function Check4()
	if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(RuneName) <= minRune) or (Self.ItemCount(SDName) <= minSD)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next4")
	end
end

function Check5()
	if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(RuneName) <= minRune) or (Self.ItemCount(SDName) <= minSD)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next5")
	end
end

function Check6()
	if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(RuneName) <= minRune) or (Self.ItemCount(SDName) <= minSD)) then
		gotoLabel("Refil")
		else
	    gotoLabel("Next6")
	end
end

function Check7()
	if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(RuneName) <= minRune) or (Self.ItemCount(SDName) <= minSD)) then
		gotoLabel("Refil")
		else
		gotoLabel("Next7")
	end
end

function CheckMage()
	if ((Self.ItemCount(ManaName) <= minManaPot) or (Self.ItemCount(RuneName) <= minRune) or (Self.ItemCount(SDName) <= minSD)) then
		gotoLabel("Refil")
		else
		gotoLabel("StartHunt")
	end
end

function Lever1() -- check lever 1 
    if (Self.Position().z == 4) then
        gotoLabel("Lever1Checked")
        else
	    gotoLabel("Lever1")
	end
end

function Lever2() -- check lever 2
	if (Self.Position().z == 10) then
        gotoLabel("Lever2Checked")
        else
	    gotoLabel("Lever2")
	end
end

function LeverShort() -- check lever shortcut
	if (Self.Position().z == 1) then
        gotoLabel("LeverShortChecked")
        else
	    gotoLabel("LeverShort")
	end
end

function Exani1() -- function on label check after exani hur up
	if (Self.Position().z == 5) then
        gotoLabel("Exani1Checked")
        else
	    gotoLabel("Exani 1")
	end
end

function Exani2() -- function on label check after exani hur up
	if (Self.Position().z == 5) then
        gotoLabel("Exani2Checked")
        else
	    gotoLabel("Exani 2")
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