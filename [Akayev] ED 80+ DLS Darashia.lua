--------------------- [LOCAL INFO] -------------------------- by Akayev ® 2022 Ezodus.net

--[[POTIONS]]--
local minCap = 60         -- MIN. CAPACITY
local manaPotID = 238     -- MANA POTION (ID)
local manaPotCost = 144   -- MANA POTION COST    -- mana potion (56), great mana potion (144),
local minManaPot = 70     -- MANA POTION MIN.
local maxManaPot = 500    -- MANA POTION MAX
local healthPotID = 23373 -- HEALTH POTION (ID)
local healthPotCost = 438 -- HEALTH POTION COST  -- ultimate health potion (379), 
local minHealthPot = 1   -- MIN. HEALTH POTION
local maxHealthPot = 3  -- HEALTH POTION MAX

--[[RUNES OR AMMO]]--     -- IF YOU DONT USE RUNES OR AMMO USE REFIL CHECK FOR EK LABEL
local SDID = 3155         -- RUNE/AMMO ID
local SDCoast = 135       -- RUNE/AMMO COST
local minSD = 25          -- RUNE/AMMO MIN.
local maxSD = 50         -- RUNE/AMMO MAX

--[[BACKPACKS]]--
local ManaBP = 2868       -- SUPPLIES      (purple backpack)
local AmmoBP = 5801       -- AMMO          (jewelled backpack)
local RingBP = 2866       -- RINGS         (yellow backpack)
local LootBP = 21295      -- RARE LOOT     (glooth backpack)
local StackBP = 2867      -- STACK LOOT    (red backpack)

--[[MAIN BACKPACK]]--
local MainBackpack = "Backpack"

--[[UTYLITY]]--
local usingSoftboots = false -- Using Softboots? (True Or False)
local minimizeEQ = false
local minimizeBPS = false


------------------ [WITHDRAW AMMO DP 4] ---------------------- WORKS ON LABEL WithdrawAmmo()

local AmmoUse = "Assassin Star"
local AmmoMax = 0
local AmmoBp = "Jewelled Backpack"

------------------ [WITHDRAW RING DP 5] ---------------------- WORKS ON LABEL WithdrawRing()

local RingUse = "Life Ring"
local RingMax = 19
local RingBp = "Yellow Backpack"

------------------ [AUTO BP RESET NUMBER] --------------------

local NumBackpacks = 6


--[[########################################################]]--
--[[##########NOTHING BELOW HERE SHOULD BE CHANGED##########]]--
--[[########################################################]]--
local count = 0

-------------------- [LABEL MANAGER] -------------------------

registerEventListener(WALKER_SELECTLABEL, "onWalkerSelectLabel")
displayInformationMessage("Spawn: LB Nightstalkers PROFIT\n Vocation: [EK] 130+\n created by: Akayev")

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

--------------------- [REFIL CHECKS] --------------------------

--[[StartHunt]]--
function StartHunt()
	
	Targeting.Start()
end

--[[CheckPotions + RUNE/AMMO]]--
function CheckPotionRune()
	delayWalker(1000)
		if ((Self.ItemCount(manaPotID) <= minManaPot) or (Self.ItemCount(healthPotID) <= minHealthPot) or (Self.ItemCount(SDID) <= minSD)) then
			gotoLabel("Refil")
			else
			wait(100, 1000)
			gotoLabel("StartHunt")
		end
end

--[[CheckPotions EK (MANA+HEALTH) - USE THIS LABEL IF YOU DONT WANT TO CHECK RUNES OR AMMO AT REFIL]]--
function CheckED()
	delayWalker(1000)
		if ((Self.ItemCount(manaPotID) <= minManaPot) or (Self.ItemCount(healthPotID) <= minHealthPot)) then
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

--[[EASY 3 BACKPACKS]]--
function Open()

        while Dedi_WindowCount("all") < 4 do
            Self.CloseContainers()
            wait(500,600)
            Self.OpenMainBackpack(true)
            wait(1500,1600)
            
          
            Container.GetByName(MainBackpack):OpenChildren({ManaBP, true})
            wait(500,600)
            Container:Minimize()
           
            wait(500,600)
            Container.GetByName(MainBackpack):OpenChildren({StackBP, true})
            wait(500,600)
            Container:Minimize()
           
            wait(500,600)
            Container.GetByName(MainBackpack):OpenChildren({LootBP, true})
            wait(500,600)
            Container:Minimize()

            
           
          end
 
        Walker.Start()
 
    end

--[[OPEN BIG 6 BACKPACKS]]--
function OpenBp()
Self.CloseContainers()
        while Dedi_WindowCount("all") < 2 do
            Self.CloseContainers()
            wait(500,600)
            Self.OpenMainBackpack(true)
            wait(500,600)
            Container.GetByName(MainBackpack):OpenChildren({ManaBP, true}, {AmmoBP, true}, {RingBP, true}, {LootBP, true}, {StackBP, true})
            wait(500,600)
            Container:Minimize()
        end
 
        Walker.Start()
 
    end
	
function OpenBps()

        while Dedi_WindowCount("all") < 6 do
            Self.CloseContainers()
            wait(500,600)
            Self.OpenMainBackpack(true)
            wait(1500,1600)
            
          
            Container.GetByName(MainBackpack):OpenChildren({ManaBP, true})
            wait(500,600)
            Container:Minimize()
           
            wait(500,600)
            Container.GetByName(MainBackpack):OpenChildren({AmmoBP, true})
            wait(500,600)
            Container:Minimize()
           
            wait(500,600)
            Container.GetByName(MainBackpack):OpenChildren({RingBP, true})
            wait(500,600)
            Container:Minimize()
            
            wait(500,600)
            Container.GetByName(MainBackpack):OpenChildren({LootBP, true})
            wait(500,600)
            
            Container:Minimize()
            wait(500,600)
            Container.GetByName(MainBackpack):OpenChildren({StackBP, true})
            wait(500,600)
          Container:Minimize()
          end
 
        Walker.Start()
 
    end
	
	--[[ResetBps]]--
function ResetBpdp()
	Walker.Stop()
			  
            
		  Self.CloseContainers()
			 while Dedi_WindowCount("all") < 3 do
                      Self.CloseContainers()
                  wait(500,600)
            Self.OpenMainBackpack(true)
            wait(1500,1600)
			Container.GetFirst():OpenChildren(stackBP)

		for x = 0, #Container.GetIndexes() - 1 do
					local bp = Container.GetFromIndex(x) 
					bp:Minimize()
					wait(200, 400)
				end
			
Container.GetFirst():OpenChildren(lootBP)
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

		Self.WithdrawMoney(120000)
	
	Walker.Start()
end

--[[SafeBank]]--
function SafeBank()
	Walker.Stop()
	Safe = ((math.ceil(((maxManaPot - Self.ItemCount(manaPotID)) * manaPotCost) / 1000) * 1000) + (math.ceil(((maxHealthPot - Self.ItemCount(healthPotID)) * healthPotCost) / 1000) * 1000)) + 200
		if (Self.Money() ~= Safe) and (count < 1) then
			gotoLabel("RefillPotion")
			Walker.Start()
		
		else
			local count = 0
			wait(500)
			Walker.Start()
		end
end

------------------ [TRAVEL/PASS] ----------------------

function Pass()
	Walker.Stop()

		
Self.SayToNpc({"hi", "pass"}, 65)

	
	Walker.Start()
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

function DepositAll()
    Walker.Stop()
		Self.SayToNpc({"Hi", "deposit all", "yes"}, 65)
		
Walker.Start()
end

function MovePots()
NormalManaType= "Great Mana Potion"
StrongManaType = "Supreme Health Potion"
GreatManaType = "Health Potion"
  
SdRuneType = "Sudden Death Rune"
  
AmmoType = "Crystalline Arrow"
  
SuppliesContainer = goldBP
  
--[[ DO NOT EDIT ANYTHING BELOW THIS LINE ]]--
NormalManaID = Item.GetID(NormalManaType)
StrongManaID = 7643
GreatManaID = Item.GetID(GreatManaType)
SdID = Item.GetID(SdRuneType)
AmmoID = Item.GetID(AmmoType)
  
  
Module('StackAmmo', function(mod)
    if (#Container.GetAll() >= 1) then
        if (Container(0):CountItemsOfID(NormalManaID) >=1 or Container(0):CountItemsOfID(StrongManaID) >=1 or Container(0):CountItemsOfID(GreatManaID) >=1 or Container(0):CountItemsOfID(SdID) >=1 or Container(0):CountItemsOfID(AmmoID) >=1) then
            for spot = Container(0):ItemCount()-1, 0, -1 do
                local item = Container(0):GetItemData(spot)           
                if (item.id == NormalManaID or item.id == StrongManaID or item.id == GreatManaID or item.id == SdID or item.id == AmmoID) then
                    Container(0):MoveItemToContainer(spot, Container.GetByName(SuppliesContainer):Index(), 0)
            break
                end
            end
        end
    end
end)
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

--[[BuyPotions]]--
function BuyUhp()
       Walker.Stop()
Self.SayToNpc({"Hi", "Trade"}, 65)
wait(900, 1200)
Self.ShopBuyItemsUpTo(15793, maxHealthPot)
wait(900, 1200)

	Walker.Start()

end

--[[CheckSofts]]--
function CheckSofts()
	delayWalker(3000)
		if (usingSoftboots == true) and (Self.ItemCount(6530) >= 1) then
			wait(500, 2500)
			else
			gotoLabel("ToHunt")
		end
end

--[[TalkSofts]]--
function TalkSofts()
    Walker.Stop()
		Self.SayToNpc({"hi", "soft boots", "yes"}, 65)
                Self.SayToNpc({"hi", "soft boots", "yes"}, 65)
	Walker.Start()
end

--------------------------------------------------------------------------------

--[[Minimize]]--
function Minimize()
	Walker.Stop()
		if minimizeEQ == true then
			Client.HideEquipment()
		end
		
	Walker.Start()
end

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