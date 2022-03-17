local config = {
StackableContainer = "Red Backpack",
Stackables =
{
"Gold Coin",
"Platinum Coin",
"Scroll of Heroic Deeds",
"Small Notebook",
"Small Ruby",
"Small Sapphire",
"Red Piece of Cloth",
"Book of Necromantic Rituals",
"Horoscope",
"Lancet",
"Incantation Notes",
"Mystic Turban",
"Pieces of Magic Chalk",
"Blood Tincture in a Vial",
"White Piece of Cloth",
"Red Gem",
"Might Ring",
"Black Pearl",
"White Pearl",
"Small Topaz",
"Small Emerald",
"Ring of Healing",
"Mind Stone",
"Yellow Gem",
"Small Amethyst",
"Small Diamond"
},

NonStackableContainer = "Glooth Backpack",
NonStackables =
{
"Crown Legs",
"Crown Armor",
"Crown Shield",
"Crown Helmet",
"Fire Sword",
"Spellbook of Mind Control",
"Boots of Haste",
"Skull Staff",
"Spellbook of Warding",
"Underworld Rod",
"Noble Axe",
"Blue Robe",
"Lightning Boots",
"Castle Shield",
"Maxilla Maximus",
"Guardian Shield",
"Knight Legs",
"Warrior Helmet"
}}

while true do
    for i = 0, #Container.GetIndexes() - 1 do
        local c = Container.GetFromIndex(i)
        if c:isOpen() and c:Name():find("Slain") or c:Name():find("Dead") then
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