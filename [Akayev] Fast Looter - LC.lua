local config = {
StackableContainer = "Red Backpack",
Stackables =
{
"Gold Coin",
"Platinum Coin",
"Dragon Priest's Wandtip",
"Spiked Iron Ball",
"High Guard Shoulderplates",
"Small Amethyst",
"Small Emerald",
"Small Diamond",
"High Guard Flag",
"Lizard Scale",
"Lizard Leather",
"Yellow Gem",
"Zaogun Shoulderplates",
"Zaogun Flag",
"Red Lantern"
},

NonStackableContainer = "Glooth Backpack",
NonStackables =
{
"Zaoan Armor",
"Zaoan Robe",
"Zaoan Legs",
"Drakinata",
"Tower Shield",
"Focus Cape",
"Zaoan Armor",
}}

while true do
    for i = 0, #Container.GetIndexes() - 1 do
        local c = Container.GetFromIndex(i)
        if c:isOpen() and c:Name():find("Dead") then
            for s = 0, c:ItemCount() - 1 do
                local item = Item.GetName(c:GetItemData(s).id):titlecase()
				    if table.contains(config.Stackables, item) then
                    local destCont = Container.GetByName(config.StackableContainer)
                    c:MoveItemToContainer(s, destCont:Index(), math.min(destCont:ItemCount() + 1, destCont:ItemCapacity() - 1))
                    break
                    elseif table.contains(config.NonStackables, item) then
                    local destCont = Container.GetByName(config.NonStackableContainer)
                    c:MoveItemToContainer(s, destCont:Index(), math.min(destCont:ItemCount() + 1, destCont:ItemCapacity() - 1))
                    break
		        end
		    end
		end
    end
end