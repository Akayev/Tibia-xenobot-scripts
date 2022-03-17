-- Parameters to the HUD that should not be visible to the regular user,
-- but that the developer might want to change in the future
HiddenConfig =
{
    panelWidth = 200,
    timeTick = 1,
    yInset = 30,
    xDescWidth = 145,
    xTitleInset = 60,
    xHeaderInset = 80,
    xImageOffset = -25,
    yImageOffset = -5,
    yStandardHeight = 15,
    imageSize = 10,
    headerColor = {r=240, g=240, b=240},
    keyColor    = {r=200, g=200, b=200},
    valColor    = {r=150, g=150, b=150},
    goldChangeLimit = 300,
    stackableChangeLimit = 10,
    nonStackableChangeLimit = 3,
    WasteMod = 10000,
}

Config = (function()
    local marketPrices = {}

    local function getMarketPrice(item)
        local id = Item.GetItemIDFromDualInput(item)
        return marketPrices[id]
    end


    local function fileExists(name)
        local f = io.open(name)
        if not f then
            return false
        end
        f:close()
        return true
    end


    local configText = [[
-- Accurate market prices are necessary for correct profits calculations.
-- Some examples have been provided to demonstrate the format, but you should probably edit them to fit your world.
MarketPrices = {
    ["sword ring"] = 500,
    ["great health potion"] = 150,
    ["life ring"] = 900,
    ["spider silk"] = 7000,
}]]
    local configName = "../Configs/shAdOwHUD.ini"

    local function loadConfig()
        -- If the config file does not exist, create it
        if not fileExists(configName) then
            local f = io.open(configName, "w+")
            if f then
                f:write(configText)
                f:close()
                local noConfigMsg = "This is the first time you're using this HUD. A config file has been created for you, use it to change market prices of items that you won't sell to npcs."
                print(noConfigMsg)
            end
        end

        dofile(configName)

        for name, price in pairs(MarketPrices) do
            marketPrices[Item.GetID(name)] = price
        end
    end

    return
    {
        getMarketPrice = getMarketPrice,
        loadConfig = loadConfig,
    }
end)()

Data = (function() 
    local wornSoftID = 6530
    local activeSoftID = 3549
    local passiveSoftID = 6529
        
    local durations = 
    {
        [Item.GetID("Sword Ring")] = 30 * 60,
        [Item.GetID("Club Ring")] = 30 * 60,
        [Item.GetID("Axe Ring")] = 30 * 60,
        [Item.GetID("Energy Ring")] = 10 * 60,
        [Item.GetID("Stealth Ring")] = 10 * 60,
        [Item.GetID("Life Ring")] = 20 * 60,
        [Item.GetID("Ring of Healing")] = 7.5 * 60,
        [Item.GetID("Prismatic Ring")] = 60 * 60,
        [Item.GetID("Time Ring")] = 10 * 60,
    }

    -- Translation map for getting the passive id from an active id
    local passiveIDs = {[activeSoftID] = passiveSoftID, [wornSoftID] = passiveSoftID}
    for passive, _ in pairs(durations) do
        passiveIDs[Item.GetRingActiveID(passive)] = passive
    end

    -- Add the soft boots duration after doing the ring translations
    durations[passiveSoftID] = 4 * 60 * 60


    -- If we loot one of these items something fishy is going on, so invalidate the whole count.
    local invalidationIDs = 
    {
        Item.GetID("shovel"),
        Item.GetID("light shovel"),
        Item.GetID("rope"),
        Item.GetID("elvenhair rope"),
        Item.GetID("fishing rod"),
        SoftID,
        WornSoftID,
        PassiveSoftID
    }

    -- These are items whose count may decrease, and should then be counted as waste
    local supplies = 
    {
        -- Arrows
        [Item.GetID("arrow")] = true,
        [Item.GetID("burst arrow")] = true,
        [Item.GetID("crystalline arrow")] = true,
        [Item.GetID("earth arrow")] = true,
        [Item.GetID("envenomed arrow")] = true,
        [Item.GetID("flaming arrow")] = true,
        [Item.GetID("flash arrow")] = true,
        [Item.GetID("onyx arrow")] = true,
        [Item.GetID("poison arrow")] = true,
        [Item.GetID("shiver arrow")] = true,
        [Item.GetID("simple arrow")] = true,
        [Item.GetID("sniper arrow")] = true,
        [Item.GetID("tarsal arrow")] = true,

        -- Bolts
        [Item.GetID("bolt")] = true,
        [Item.GetID("drill bolt")] = true,
        [Item.GetID("infernal bolt")] = true,
        [Item.GetID("piercing bolt")] = true,
        [Item.GetID("power bolt")] = true,
        [Item.GetID("prismatic bolt")] = true,
        [Item.GetID("vortex bolt")] = true,

        -- Throwing weapons
        [Item.GetID("enchanted spear")] = true,
        [Item.GetID("glooth spear")] = true,
        [Item.GetID("hunting spear")] = true,
        [Item.GetID("mean paladin spear")] = true,
        [Item.GetID("royal spear")] = true,
        [Item.GetID("spear")] = true,
        [Item.GetID("assassin star")] = true,
        [Item.GetID("snowball")] = true,
        [Item.GetID("small stone")] = true,
        [Item.GetID("throwing knife")] = true,
        [Item.GetID("throwing star")] = true,
        [Item.GetID("viper star")] = true,

        -- Amulets
        [Item.GetID("gill necklace")] = true,
        [Item.GetID("prismatic necklace")] = true,
        [Item.GetID("protection amulet")] = true,

        -- Misc
        [Item.GetID("scarab coin")] = true,
    }

    local supplyPatterns = 
    {
        "rune",
        "mana",
        "health",
        "spirit potion",
    }

    local function isSupply(item)
        local name = Item.GetName(item):lower()
        local matchesSupplyPattern = false
        for _, pattern in ipairs(supplyPatterns) do
            matchesSupplyPattern = matchesSupplyPattern or name:match(pattern)
        end

        local id = Item.GetItemIDFromDualInput(item)
        return matchesSupplyPattern or supplies[id]
    end


    function getCost(id)
        local shopCost = Item.GetCost(id)
        return id == passiveSoftID and 10000 or (shopCost == 0 and Config.getMarketPrice(id) or shopCost)
    end

    function getValue(id)
        return Config.getMarketPrice(id) or (isSupply(id) and getCost(id)) or Item.GetValue(id)
    end


    return 
    {
        wornSoftID = wornSoftID,
        activeSoftID = activeSoftID,
        passiveSoftID = passiveSoftID,

        durations = durations,
        passiveIDs = passiveIDs,
        invalidationIDs = invalidationIDs,

        isSupply = isSupply,
        getCost = getCost,
        getValue = getValue,
    }
end)()

HUDData = (function()
    -- Initial data
    local startTime = os.time()
    local startExp = Self.Experience()
    local startStamina = Self.Stamina()

    -- The data that will be visible to the rest of the HUD
    local data = { countsAreValid = true, general = { lastTick = os.time() } }
    -- The functions that update the data, in the order they will be called.
    local updateFunctions = {}

    -- Helper functions and their accumulative data
    data.general.balance = 0
    NpcMessageProxy.OnReceive("Gets Bank Balance", function(proxy, npcName, message)
        local balance = string.match(message, "Your account balance is (.+) gold.")
        if balance and tonumber(balance) then
            data.general.balance = tonumber(balance)
        end
    end)

    local function isEmptyFlask(id)
        return table.find({283, 284, 285}, id)
    end

    local function ignoreItem(id)
        return id == 0 or isEmptyFlask(id) or Item.isContainer(id)
    end
    
    local corpseNames = {"the", "demonic", "dead", "slain", "dissolved", "remains", "elemental", "split"}
    local function isCorpse(cont)
        if Item.isCorpse(cont:ID()) then return true end
        local name = cont:Name():lower()
        for _, CPartName in ipairs(corpseNames) do
            if name:find(CPartName) then
                return true
            end
        end
        return false
    end

    local function countItems()
        newCounts = {}
        
        veryUnsafeFunctionEnterCriticalMode()
        
        -- Count equipped
        local slots = {Self.Head, Self.Armor, Self.Legs, Self.Amulet, Self.Feet, Self.Ring, Self.Weapon, Self.Shield, Self.Ammo}
        for i = 1, #slots do
            local slot = slots[i]()
            
            if not ignoreItem(slot.id) then
                newCounts[slot.id] = (newCounts[slot.id] or 0) +  math.max(slot.count, 1)
            end
        end
        
        -- Count in backpacks
        for i = 0, 16 do
            local cont = Container(i)
            if cont:isOpen() and not isCorpse(cont) and cont:Name() ~= "Browse Field" then
                for spot = 0, cont:ItemCount() - 1 do
                    local item = cont:GetItemData(spot)
                    if not ignoreItem(item.id) then
                        newCounts[item.id] = (newCounts[item.id] or 0) + item.count
                    end
                end
            end
        end

        veryUnsafeFunctionExitCriticalMode()
        
        -- Handle changing ring and feet ids
        for activeID, passiveID in pairs(Data.passiveIDs) do
            newCounts[passiveID] = (newCounts[passiveID] or 0) + (newCounts[activeID] or 0)
            newCounts[activeID] = nil
        end

        -- Handle worn soft boots
        newCounts[Data.passiveSoftID] = (newCounts[Data.passiveSoftID] or 0) + (newCounts[Data.wornSoftID] or 0)

        return newCounts
    end

    local function changeIsWithinLimits(id, change)
        if id == Item.GetID("gold coin") then
            return change < HiddenConfig.goldChangeLimit
        elseif Item.isStackable(id) then
            return change < HiddenConfig.stackableChangeLimit
        else
            return change < HiddenConfig.nonStackableChangeLimit
        end
    end
    
    -- We only want to update the diff if it contains reasonable values
    local totalNewItemLimit = (Self.Level() < 100 and 5 or (Self.Level() < 200 and 7 or 9))
    local lastBpCount = 0
    local function validateDiff(diff, new)
        local totalNewCount = 0
        -- If we discovered too many of any one item we invalidate the diff
        for id, count in pairs(diff) do
            if (count > 0 and not changeIsWithinLimits(id, count)) or 
               (count < 0 and Data.isSupply(id) and not changeIsWithinLimits(id, -1*count)) or 
               (count < 0 and not Data.isSupply(id) and new[id] and not changeIsWithinLimits(id, new[id])) then
                return false
            end
            if count > 0 then
                totalNewCount = totalNewCount + (Item.isStackable(id) and 1 or count)
            elseif count < 0 and not Data.isSupply(id) then
                totalNewCount = totalNewCount + (Item.isStackable(id) and 1 or new[id] or 0)
            end
        end
        -- If we discovered too many new items in total we invalidate the diff
        if totalNewCount > totalNewItemLimit then
            return false
        end
        -- If we discovered a new tool we invalidate the diff
        for _, id in ipairs(Data.invalidationIDs) do
            local change = diff[id]
            if change and change ~= 0 then
                return false
            end
        end

        local goldID = Item.GetID("gold coin")
        local platID = Item.GetID("platinum coin")
        -- If we're on an OT and lost gold or plats we invalidate the diff, because of gold changing
        if not XenoBot.IsInRealTibia() and 
           ((diff[goldID] and diff[goldID] < 0) or
            (diff[platID] and diff[platID] < 0)) then
            return false
        end

        -- If the number of open backpacks have changed we invalidate
        local bpCount = 0
        for i = 0, 16 do
            local cont = Container(i)
            if cont:isOpen() and not isCorpse(cont) and cont:Name() ~= "Browse Field" then
                bpCount = bpCount + 1
            end
        end
        if bpCount ~= lastBpCount then
            lastBpCount = bpCount
            return false
        end

        -- Otherwise we're valid
        return true
    end

    local function idOnScreen(ids)
        local myPos = Self.Position()
        for dx = -7, 7 do
            for dy = -5, 5 do
                local pos = {x = myPos.x + dx, y = myPos.y + dy, z = myPos.z}
                if table.find(ids, Map.GetTopUseItem(pos.x, pos.y, pos.z).id) then
                    return true
                end
            end
        end
        return false
    end 
    
    local function trainerOnScreen()
        return idOnScreen({16201, 16198, 16202, 16199, 16200})
    end
    
    local function depotOnScreen()
        return idOnScreen({3497, 3498, 3499, 3500})
    end
    
    local function hasCloseNPC()
        for _, c in Creature.iNpcs() do
            if c:isOnScreen() then
                return true
            end
        end
        return false
    end
    
    local lastTalkedToNPC = 0
    NpcMessageProxy:OnReceive("Spoke With NPC Detector", function(_)
        lastTalkedToNPC = os.time()
    end)
    
    -- We don't want to update the diff while doing certain things
    -- that are normally done when refilling
    local function isRefilling()
        return (XenoBot.IsInRealTibia() and hasCloseNPC()) or 
               os.difftime(os.time(), lastTalkedToNPC) < 10 or 
               depotOnScreen() or 
               trainerOnScreen()
    end 

    data.itemCounts = countItems()
    local function updateDiffs()
        local newCounts = countItems()

        -- Calculate the diff
        local diff = {}    
        for id, count in pairs(newCounts) do
            diff[id] = count
        end
        
        for id, count in pairs(data.itemCounts) do
            diff[id] = (diff[id] or 0) - count
        end
        
        for id, count in pairs(diff) do
            if diff[id] == 0 then 
                diff[id] = nil 
            end
        end

        -- Store the new counts
        data.itemCounts = newCounts

        -- Validate the diff
        data.countsAreValid = validateDiff(diff, data.itemCounts) and (not isRefilling())

        -- Filter the diff into loot and waste
        local newLoot = {}
        local newWaste = {}
        for id, count in pairs(diff) do
            if count > 0 then 
                newLoot[id] = count
            -- Do not accept count based waste of active items
            elseif Data.isSupply(id) then
                newWaste[id] = 0-count
            end
        end

        -- Check for active items
        local slots = {Self.Head, Self.Armor, Self.Legs, Self.Feet, Self.Amulet, Self.Weapon, Self.Ring, Self.Shield, Self.Ammo}
        for i = 1, #slots do
            local slot = slots[i]()
            local passiveID = Data.passiveIDs[slot.id]
            if (passiveID and Data.durations[passiveID]) then
                -- The count for an active item is the time it was active for
                newWaste[passiveID] = os.time() - data.general.lastTick
            end
        end
        data.general.lastTick = os.time()

        -- Store the filtered diffs
        data.newLoot = newLoot
        data.newWaste = newWaste
    end
    table.insert(updateFunctions, updateDiffs)

    data.general.totalLoot = 0
    data.general.totalWaste = 0
    data.general.totalProfit = 0
    local function updateProfits()
        if data.countsAreValid then
            for id, num in pairs(data.newLoot) do
                data.general.totalLoot = data.general.totalLoot + Data.getValue(id) * num
            end
            for id, num in pairs(data.newWaste) do
                if Data.durations[id] then
                    data.general.totalWaste = data.general.totalWaste + Data.getCost(id) * num / Data.durations[id]
                else
                    data.general.totalWaste = data.general.totalWaste + Data.getCost(id) * num
                end
            end
            data.general.totalProfit = data.general.totalLoot - data.general.totalWaste
        end
    end
    table.insert(updateFunctions, updateProfits)

    local function updateLevel()
        data.general.level = Self.Level()
    end
    table.insert(updateFunctions, updateLevel)

    local function updateExp()
        data.general.gainedExp = Self.Experience() - startExp
    end
    table.insert(updateFunctions, updateExp)

    local previously = os.time()
    data.general.usedSeconds = 1
    data.general.usedHours = 0
    local function updateTime()
        local now = os.time()
        local diff = now - previously
        -- If the time since the last tick was too long we've very likely been offline
        if diff < 30 then
            data.general.usedSeconds = data.general.usedSeconds + diff
            data.general.usedHours = data.general.usedSeconds / 3600
        end
        previously = now
    end
    table.insert(updateFunctions, updateTime)

    local previousStamina = Self.Stamina()
    data.general.usedStaminaMinutes = 0
    data.general.usedStaminaHours = 0
    local function updateStamina()
        local current = Self.Stamina()
        data.general.stamina = current
        local diff = previousStamina - current
        -- Stamina cannot increase while we are online, and
        -- we dont want being offlane to corrupt the stats
        if diff >= 0 then
            data.general.usedStaminaMinutes = data.general.usedStaminaMinutes + diff
            data.general.usedStaminaHours = data.general.usedStaminaMinutes / 60
        end
        previousStamina = current
    end
    table.insert(updateFunctions, updateStamina)

    local function updateRates()
        data.general.expS = data.general.gainedExp / data.general.usedSeconds
        data.general.expH = data.general.gainedExp / data.general.usedHours
        data.general.expSH = data.general.usedStaminaHours < 0.017 and data.general.expH or data.general.gainedExp / data.general.usedStaminaHours
        data.general.profitsH = data.general.totalProfit / data.general.usedHours
        data.general.profitsSH = data.general.usedStaminaHours < 0.017 and data.general.profitsH or data.general.totalProfit / data.general.usedStaminaHours
    end
    table.insert(updateFunctions, updateRates)

    local function expForLevel(x)
        return 50/3*(x*x*x - 6*x*x + 17*x - 12)
    end

    local function updateTimeToLevel()
        local nextLevelExp = expForLevel(Self.Level() + 1)
        local missingExp = nextLevelExp - Self.Experience()
        data.general.timeToLevel = data.general.expS == 0 and -1 or math.floor(missingExp / data.general.expS)
    end
    table.insert(updateFunctions, updateTimeToLevel)

    data.general.ping = 0
    local function updatePing()
        data.general.ping = Self.Ping()
    end
    table.insert(updateFunctions, updatePing)    

    local function getStats()
        for _, f in ipairs(updateFunctions) do
            f()
        end
        return data
    end

    return 
    {
        getStats = getStats,
    }
end)()

Events = (function()

    local topics = {}

    local function subscribe(topic, callback)
        local subs = topics[topic] or {}
        table.insert(subs, callback)
        topics[topic] = subs
    end

    local function publish(topic, data)
        local subs = topics[topic] or {}
        for _, callback in ipairs(subs) do
            callback(data)
        end
    end

    local function keyset(tab)
        local set = {}
        for key, _ in pairs(tab) do
            table.insert(set, key)
        end
        return set
    end

    Module("Update HUD", function(module)
        local stats = HUDData.getStats()

        -- Notify general subscribers
        publish("general", stats.general)

        -- Only notify count based subscribers when the counts are valid
        if stats.countsAreValid then
            -- Notify about new possible new ids
            local newLootIDs = keyset(stats.newLoot)
            publish("newLootIDs", newLootIDs)
            local newWasteIDs = keyset(stats.newWaste)
            publish("newWasteIDs", newWasteIDs)

            -- Notify about new counts
            for id, count in pairs(stats.newLoot) do
                publish(id, count)
            end

            for id, count in pairs(stats.newWaste) do
                publish(id + HiddenConfig.WasteMod, count)
            end
        end

        module:Delay(1000)
    end)

    -- Let main scripts stop the HUD when they logout.
    Signal.OnReceive("Stop HUD", function(_, Msg)
        if Msg == "Stop" then
            Module.Stop("Update HUD")
        end
    end)

    return 
    {
        publish = publish,
        subscribe = subscribe,
    }
end)()


-- HUDContainer is an abstract super class
HUDContainer = {}
HUDContainer_mt = {__index = HUDContainer}

function HUDContainer:move(newx, newy)
    self.y = newy
    self.x = newx
    for inset, hud in pairs(self.huds) do
        hud:SetPosition(self.x + inset, self.y)
    end
end

function HUDContainer:moveRelative(diffx, diffy)
    self:move(self.x + diffx, self.y + diffy)
end

HeaderHUDContainer = {}
HeaderHUDContainer_mt = {__index = HeaderHUDContainer}

function HeaderHUDContainer.new(title, parent, inset, signalkey)
    local c = {}
    setmetatable(c, HeaderHUDContainer_mt)

    c.x = 0
    c.y = 0 
    c.height = HiddenConfig.yStandardHeight

    c.huds = {}

    local inset = inset or HiddenConfig.xHeaderInset

    c.headerHUD = HUD.New(c.x + inset, c.y, title, HiddenConfig.headerColor.r, HiddenConfig.headerColor.g, HiddenConfig.headerColor.b)
    c.huds[inset] = c.headerHUD

    parent:addChild(c)
    if signalkey then
        Signal.OnReceive(signalkey, function(_, name)
            c.headerHUD:SetText(name)
        end)
    end

    return c
end

setmetatable(HeaderHUDContainer, { __index = HUDContainer, __call = function(_, ...) return HeaderHUDContainer.new(...) end })

ScriptNameHUDContainer = {}
ScriptNameHUDContainer_mt = {__index = ScriptNameHUDContainer}

function ScriptNameHUDContainer.new(title, parent, inset, signalkey, transformer)
    local c = {}
    setmetatable(c, ScriptNameHUDContainer_mt)

    c.id = -1 -- To be set by the parent
    c.x = 0
    c.y = 0 
    c.height = 0
    c.parent = parent

    c.huds = {}

    local inset = inset or HiddenConfig.xHeaderInset

    c.headerHUD = HUD.New(c.x + inset, c.y, title, HiddenConfig.keyColor.r, HiddenConfig.keyColor.g, HiddenConfig.keyColor.b)
    c.huds[inset] = c.headerHUD

    parent:addChild(c)
    Signal.OnReceive(signalkey, function(self, name)
        local name = transformer and transformer(name) or name
        c.headerHUD:SetText(name)
        local size = 3 * (name:len() - 3) + 13
        local inset = 95-size
        c.headerHUD:SetPosition(c.x + inset, c.y)
        c:grow(HiddenConfig.yStandardHeight)
        self:Close()
    end)

    return c
end

function ScriptNameHUDContainer:grow(diffy)
    self.height = self.height + diffy
    if self.parent then
        for id = self.id + 1, self.parent.nextChildID - 1 do
            self.parent.children[id]:moveRelative(0, diffy)
        end
        self.parent:grow(diffy)
    end
end


setmetatable(ScriptNameHUDContainer, { __index = HUDContainer, __call = function(_, ...) return ScriptNameHUDContainer.new(...) end })

EmptyHUDContainer = {}
EmptyHUDContainer_mt = {__index = EmptyHUDContainer}

function EmptyHUDContainer.new(parent, height)
    local c = {}
    setmetatable(c, EmptyHUDContainer_mt)

    c.x = 0
    c.y = 0 
    c.height = height or HiddenConfig.yStandardHeight

    c.huds = {}

    parent:addChild(c)

    return c
end

setmetatable(EmptyHUDContainer, { __index = HUDContainer, __call = function(_, ...) return EmptyHUDContainer.new(...) end })

KeyValHUDContainer = {}
KeyValHUDContainer_mt = {__index = KeyValHUDContainer}

function KeyValHUDContainer.new(desc, parent)
    local c = {}
    setmetatable(c, KeyValHUDContainer_mt)

    c.x = 0
    c.y = 0 
    c.height = HiddenConfig.yStandardHeight
    c.accum = 0

    c.huds = {}

    c.keyHUD = HUD.New(c.x , c.y, desc, HiddenConfig.keyColor.r, HiddenConfig.keyColor.g, HiddenConfig.keyColor.b)
    c.huds[0] = c.keyHUD
    c.valHUD = HUD.New(c.x + HiddenConfig.xDescWidth, c.y, "", HiddenConfig.valColor.r, HiddenConfig.valColor.g, HiddenConfig.valColor.b)
    c.huds[HiddenConfig.xDescWidth] = c.valHUD

    parent:addChild(c)

    return c
end

setmetatable(KeyValHUDContainer, {__index = HUDContainer, __call = function(_, ...) return KeyValHUDContainer.new(...) end})

function KeyValHUDContainer:setValText(newText)
    self.valHUD:SetText(newText)
end

function KeyValHUDContainer:incAccum(val)
    self.accum = self.accum + val
end

function KeyValHUDContainer:getAccum(newText)
    return self.accum
end

ContainerContainer = {}
ContainerContainer_mt = {__index = ContainerContainer}

function ContainerContainer.new(x, y, parent)
    local c = {}
    setmetatable(c, ContainerContainer_mt)

    c.id = -1 -- To be set by the parent
    c.x = x
    c.y = y
    c.height = 0
    c.parent = parent
    -- Only used by those containers that contain item huds
    c.containedItemIDs = {}

    c.children = {}
    c.nextChildID = 1

    if parent then
        parent:addChild(c)
    end

    return c
end
setmetatable(ContainerContainer, {__call = function(_, ...) return ContainerContainer.new(...) end})

function ContainerContainer:addChild(child)
    child.id = self.nextChildID
    self.nextChildID = self.nextChildID + 1
    table.insert(self.children, child)
    child:move(self.x, self.y + self.height)
    self:grow(child.height)
end

function ContainerContainer:grow(diffy)
    self.height = self.height + diffy
    if self.parent then
        for id = self.id + 1, self.parent.nextChildID - 1 do
            self.parent.children[id]:moveRelative(0, diffy)
        end
        self.parent:grow(diffy)
    end
end

function ContainerContainer:moveRelative(x, y)
    for _, child in ipairs(self.children) do
        child:moveRelative(x, y)
    end
    self.x = self.x + x
    self.y = self.y + y
end

function ContainerContainer:move(x, y)
    local diffx = x - self.x
    local diffy = y - self.y
    self:moveRelative(diffx, diffy)
end

ItemHUDContainer = {}
ItemHUDContainer_mt = {__index = ItemHUDContainer}

function ItemHUDContainer.new(id, parent, formatFunc)
    local c = {}
    setmetatable(c, ItemHUDContainer_mt)

    c.formatFunc = formatFunc
    c.x = 0
    c.y = 0
    c.itemID = id
    c.height = HiddenConfig.yStandardHeight
    c.accum = 0

    c.imageHUD = HUD.New(c.x - HiddenConfig.xImageOffset, c.y + HiddenConfig.yImageOffset, id, 0, 0, 0)
    c.imageHUD:SetItemSize(HiddenConfig.imageSize)
    c.keyHUD = HUD.New(c.x , c.y, Item.GetName(id), HiddenConfig.keyColor.r, HiddenConfig.keyColor.g, HiddenConfig.keyColor.b)
    c.valHUD = HUD.New(c.x + HiddenConfig.xDescWidth, c.y, "", HiddenConfig.valColor.r, HiddenConfig.valColor.g, HiddenConfig.valColor.b)
    c:addCount(0)
    parent:addChild(c)

    return c
end

setmetatable(ItemHUDContainer, {__index = HUDContainer, __call = function(_, ...) return ItemHUDContainer.new(...) end})

function ItemHUDContainer:addCount(num)
    self.accum = self.accum + num
    self.valHUD:SetText(self.formatFunc(self.itemID, self.accum))
end

function ItemHUDContainer:move(newx, newy)
    self.y = newy
    self.x = newx
    self.imageHUD:SetPosition(self.x + HiddenConfig.xImageOffset, self.y + HiddenConfig.yImageOffset)
    self.keyHUD:SetPosition(self.x, self.y)
    self.valHUD:SetPosition(self.x + HiddenConfig.xDescWidth, self.y)
end

function ItemHUDContainer:moveRelative(diffx, diffy)
    self:move(self.x + diffx, self.y + diffy)
end

local function lootFormatFunc(id, count)
    return string.format("%d (%d gp)", count, count * Data.getValue(id))
end

local function wasteFormatFunc(id, count)
    return string.format("%d (%d gp)", count, count * Data.getCost(id))
end

local function activeWasteFormatFunc(id, count)
    local hour = math.floor(count / 3600)
    local min = math.floor((count / 60) % 60)
    local sec = math.floor(count % 60)
    return string.format("%02.f:%02.f:%02.f (%d gp)", hour, min, sec, count * Data.getCost(id) / Data.durations[id])
end

function LootItemHUDContainer(id, parent)
    local c = ItemHUDContainer(id, parent, lootFormatFunc)
    Events.subscribe(id, function(diff)
        c:addCount(diff)
    end)
    return c
end

function WasteItemHUDContainer(id, parent)
    local c = ItemHUDContainer(id, parent, wasteFormatFunc)
    Events.subscribe(id + HiddenConfig.WasteMod, function(diff)
        c:addCount(diff)
    end)
    return c
end

function ActiveWasteItemHUDContainer(id, parent)
    local c = ItemHUDContainer(id, parent, activeWasteFormatFunc)
    Events.subscribe(id + HiddenConfig.WasteMod, function(diff)
        c:addCount(diff)
    end)
    return c
end

Config.loadConfig()

local function formatGain(total)
    if total > 1e+6 then
        return string.format("%.01fkk", total/1e+6)
    elseif total > 1e+3 then
        return string.format("%.01fk", total/1e+3)
    else
        return tostring(math.floor(total))
    end
end

local function leftX(screen)
    return math.max(math.floor((screen.gamewindowx - HiddenConfig.panelWidth) / 2), 10)
end

local function rightX(screen)
    local xRightBase = screen.gamewindowx + screen.gamewindoww
    return math.floor((screen.eqwindowx - HiddenConfig.panelWidth - xRightBase) / 2) + xRightBase
end

local screen = HUD.GetMainWindowDimensions()
local leftx = leftX(screen)
local rightx = rightX(screen)

-- Create the left column of the HUD
local leftColumn = ContainerContainer(leftx, HiddenConfig.yInset)
local title = HeaderHUDContainer("[HUD] Akayev", leftColumn, HiddenConfig.xTitleInset)
local script = ScriptNameHUDContainer("", leftColumn, 0, "script name")
local script = ScriptNameHUDContainer("", leftColumn, 0, "script author", function(author)
    return "by " .. author
end)

-- General statistics
local ping = KeyValHUDContainer("Ping:", leftColumn)
Events.subscribe("general", function(general)
    ping:setValText(general.ping .. " ms")
end)

local level = KeyValHUDContainer("Level:", leftColumn)
Events.subscribe("general", function(general)
    level:setValText(tostring(general.level))
end)

local stamina = KeyValHUDContainer("Stamina:", leftColumn)
Events.subscribe("general", function(general)
    local totalStamina = general.stamina
    local staminaH = math.floor(totalStamina/60)
    local staminaM = totalStamina % 60
    stamina:setValText(string.format("%02.f:%02.f", staminaH, staminaM))
end)

local session = KeyValHUDContainer("Session Length:", leftColumn)
Events.subscribe("general", function(general)
    local totalSeconds = general.usedSeconds
    local seconds = math.floor(totalSeconds % 60)
    local minutes = math.floor(totalSeconds/60 % 60)
    local hours = math.floor(totalSeconds/3600)
    local formatted = string.format("%02.f:%02.f:%02.f", hours, minutes, seconds)
    session:setValText(formatted)
end)

local bankBalance = KeyValHUDContainer("Balance:", leftColumn)
Events.subscribe("general", function(general)
    bankBalance:setValText(string.format("%s gp", formatGain(general.balance)))
end)

local timeToLevel = KeyValHUDContainer("Time to level:", leftColumn)
Events.subscribe("general", function(general)
    local totalSeconds = general.timeToLevel
    local minutes = math.floor(totalSeconds/60 % 60)
    local hours = math.floor(totalSeconds/3600)
    local formatted = string.format("%02.f:%02.f", hours, minutes)
    timeToLevel:setValText(totalSeconds == -1 and "--" or formatted)
end)

-- Exp gain
EmptyHUDContainer(leftColumn)
local expPerH = KeyValHUDContainer("Exp:", leftColumn)
Events.subscribe("general", function(general)
    local expHK = general.expH / 1000
    expPerH:setValText(string.format("%.01f k/h", expHK))
end)
local expPerSH = KeyValHUDContainer("", leftColumn)
Events.subscribe("general", function(general)
    local expSHK = general.expSH / 1000
    expPerSH:setValText(string.format("%.01f k/sh", expSHK))
end)

-- Profit gain
EmptyHUDContainer(leftColumn)
local profitsPerH = KeyValHUDContainer("Profits:", leftColumn)
Events.subscribe("general", function(general)
    local profitsHK = general.profitsH / 1000
    profitsPerH:setValText(string.format("%.01f k/h", profitsHK))
end)
local profitsPerSH = KeyValHUDContainer("", leftColumn)
Events.subscribe("general", function(general)
    local profitsSHK = general.profitsSH / 1000
    profitsPerSH:setValText(string.format("%.01f k/sh", profitsSHK))
end)

-- Totals
EmptyHUDContainer(leftColumn)
local expTotal = KeyValHUDContainer("Totals:", leftColumn)
Events.subscribe("general", function(general) 
    expTotal:setValText(string.format("%s exp", formatGain(general.gainedExp)))
end)
local profitsTotal = KeyValHUDContainer("", leftColumn)
Events.subscribe("general", function(general)
    profitsTotal:setValText(string.format("%s gp", formatGain(general.totalProfit)))
end)

-- Right Column
local rightColumn = ContainerContainer(rightx, HiddenConfig.yInset)
local loot = ContainerContainer(0, 0, rightColumn)
local waste = ContainerContainer(0, 0, rightColumn)

-- Waste
EmptyHUDContainer(waste)
local wasteHeader = HeaderHUDContainer("WASTE", waste)
EmptyHUDContainer(waste, 10)

local wasteParts = ContainerContainer(0, 0, waste)
Events.subscribe("newWasteIDs", function(newids)
    for _, id in ipairs(newids) do
        if not wasteParts.containedItemIDs[id] then
            if Data.durations[id] then
                ActiveWasteItemHUDContainer(id, wasteParts)
            else
                WasteItemHUDContainer(id, wasteParts)
            end
            wasteParts.containedItemIDs[id] = true
        end
    end
end)

local wasteSum = ContainerContainer(0, 0, waste)
EmptyHUDContainer(wasteSum)
local totalWaste = KeyValHUDContainer("Wasted:", wasteSum)
Events.subscribe("general", function(general)
    totalWaste:setValText(string.format("%d gp", general.totalWaste))
end)

-- Loot
local lootHeader = HeaderHUDContainer("LOOT", loot)
EmptyHUDContainer(waste, 10)

local lootParts = ContainerContainer(0, 0, loot)
Events.subscribe("newLootIDs", function(newids)
    for _, id in ipairs(newids) do
        if not lootParts.containedItemIDs[id] then
            LootItemHUDContainer(id, lootParts)
            lootParts.containedItemIDs[id] = true
        end
    end
end)

local lootSum = ContainerContainer(0, 0, loot)
EmptyHUDContainer(lootSum)
local totalLoot = KeyValHUDContainer("Looted:", lootSum)
Events.subscribe("general", function(general)
    totalLoot:setValText(string.format("%d gp", general.totalLoot))
end)


Module("Resizer", function(module)
    local newScreen = HUD.GetMainWindowDimensions()

    local newLeftx = leftX(newScreen)
    if newLeftx ~= leftx then
        leftx = newLeftx
        leftColumn:move(leftx, HiddenConfig.yInset)
    end

    local newRightx = rightX(newScreen)
    if newRightx ~= rightx then
        rightx = newRightx
        rightColumn:move(rightx, HiddenConfig.yInset)
    end

    module:Delay(1000)
end)