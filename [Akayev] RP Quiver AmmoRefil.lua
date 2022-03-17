local AmmoBP = "Jewelled Backpack"
local QuiverBackpack = "blue quiver"

--------------- [QUIVER REFILER] -----------------
 
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