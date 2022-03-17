local config = {
StackableContainer = "Red Backpack",
Stackables =
{
"Gold Coin",
"Platinum Coin",
"Small Emerald",
"Strand of Medusa Hair",
"Small Sapphire",
"Snake Skin",
"Winged Tail",
"Life Ring",
"Behemoth Trophy",
"Strange Symbol",
"Behemoth Claw",
"Perfect Behemoth Fang",
"Battle Stone",
"Small Amethyst",
"Assassin Star",
"Stone Skin Amulet",
"Hydra Head",
"Ring of Healing",
"Ectoplasmic Sushi",
"Lizard Essence"
},

NonStackableContainer = "Glooth Backpack",
NonStackables =
{
"Medusa Shield",
"Terra Amulet",
"Terra Mantle",
"Terra Legs",
"Sacred Tree Amulet",
"Mercenary Sword",
"Tower Shield",
"Noble Axe",
"Crown Armor",
"Warrior Helmet",
"Royal Helmet",
"Swamplair Armor",
"Spellbook of Mind Control",
"War Axe",
"Steel Boots",
"Giant Sword",
"Boots of Haste",
"Spirit Container",
"Wand of Cosmic Energy"
}}

while true do
    for i = 0, #Container.GetIndexes() - 1 do
        local c = Container.GetFromIndex(i)
        if c:isOpen() and c:Name():find("Dead") or c:Name():find("Dissolved") then
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