local config = {
StackableContainer = "Red Backpack",
Stackables =
{
"Gold Coin",
"Platinum Coin",
"White Piece of Cloth",
"Silver Brooch",
"Demonic Essence",
"Shiny Stone",
"Shard",
"Spider Silk",
"Sapphire Hammer",
"Black Pearl",
"Frosty Heart",
"Small Diamond",
"Small Sapphire",
"Small Emerald",
"Small Ruby",
"Small Topaz",
"Small Amethyst",
"Essence of a Bad Dream",
"Scythe Leg",
"Fish Fin",
"Quara Bone",
"Quara Pincers",
"White Pearl",
"Quara Eye"
},

NonStackableContainer = "Glooth Backpack",
NonStackables =
{
"Wand of Cosmic Energy",
"Stealth Ring",
"Relic Sword",
"Demonbone Amulet",
"Shadow Sceptre",
"Glacier Mask",
"Time Ring",
"Crown Armor",
"Abyss Hammer",
"Skeleton Decoration",
"Boots of Haste",
"War Axe",
"Mysterious Voodoo Skull",
"Lightning Headband",
"Skull Helmet",
"Glacier Robe",
"Giant Shrimp",
"Ring of Healing"
}}

while true do
    for i = 0, #Container.GetIndexes() - 1 do
        local c = Container.GetFromIndex(i)
        if c:isOpen() and c:Name():find("Dead") or c:Name():find("Slain") or c:Name():find("Remains") then
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