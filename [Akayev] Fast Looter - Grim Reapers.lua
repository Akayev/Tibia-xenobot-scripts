local config = {
StackableContainer = "Red Backpack",
Stackables =
{
"Gold Coin",
"Platinum Coin",
"Demonic Essence",
"Ultimate Health Potion",
"Mystical Hourglass"
},

NonStackableContainer = "Glooth Backpack",
NonStackables =
{
"Underworld Rod",
"Glacier Kilt",
"Skullcracker Armor",
"Nightmare Blade"
}}

while true do
    for i = 0, #Container.GetIndexes() - 1 do
        local c = Container.GetFromIndex(i)
        if c:isOpen() and c:Name():find("Slain") then
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