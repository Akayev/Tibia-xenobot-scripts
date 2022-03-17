----------- [DYNAMIC UTAMO VITA IF 2 PLAYERS] ----------- by Akayev ® 2022 Ezodus.net

local SpellA = "Utamo Vita"
local LastCastA = 0
local SpellB = "Exana Vita"

-------------------------------------------

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

-------------------------------------

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