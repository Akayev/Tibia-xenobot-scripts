local config = {
StackableContainer = "Red Backpack",
Stackables =
{
"Gold Coin",
"Platinum Coin",
"Ectoplasmic Sushi",
"Lizard Essence",
"Ultimate Health Potion",
"Mutated Bat Ear",
"Small Amethyst",
"Black Pearl",
"Bat Wing",
"Sabretooth",
"Striped Fur"
},

NonStackableContainer = "Glooth Backpack",
NonStackables =
{
"Spirit Container",
"Wand of Cosmic Energy",
"Mercenary Sword",
"Souleater Trophy",
"Batwing Hat",
"Angelic Axe",
"Guardian Shield",
"Glorious Axe",
"Life Ring"
}}

while true do
    for i = 0, #Container.GetIndexes() - 1 do
        local c = Container.GetFromIndex(i)
        if c:isOpen() and c:Name():find("Dissolved") or c:Name():find("Dead") then
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