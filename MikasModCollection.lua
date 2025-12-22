--- STEAMODDED HEADER
--- MOD_NAME: Mika's Mod Collection
--- MOD_ID: MikasMods
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: A collection of Mika's Mods. Check the mod description on GitHub for more information :)
--- DISPLAY_NAME: Mika's Mod
--- BADGE_COLOUR: FD5DA8
----------------------------------------------
------------MOD CODE -------------------------

-- Config: DISABLE UNWANTED MODS HERE
local config = {
    -- Decks
    evenStevenDeck = true,
    oddToddDeck = true,
    fibonacciDeck = true,
    primeDeck = true, -- Do not enable without primeTimeJoker
    midasDeck = true,
    jokersForHireDeck = true,
    perfectPrecisionDeck = true, -- Do not enable without sniperJoker
    -- Tarot Cards
    aceOfPentaclesTarot = true,
    pageOfPentaclesTarot = true,
    kingOfCupsTarot = false, -- In Development, do not enable
    commonTarot = false,     -- In Development, do not enable
    uncommonTarot = false,   -- In Development, do not enable
    chipsTarot = false,      -- In Development, do not enable
    multTarot = false,       -- In Development, do not enable
    moneyTarot = false,      -- In Development, do not enable
    supportTarot = false,    -- In Development, do not enable
    cardChipsTarot = false,  -- In Development, do not enable
    cardMultTarot = false,   -- In Development, do not enable
    -- Spectral Cards
    incenseSpectral = true,
    -- Jokers
    primeTimeJoker = true,
    straightNateJoker = true,
    fishermanJoker = true,
    impatientJoker = true,
    cultistJoker = true,
    sealCollectorJoker = true,
    camperJoker = true,
    scratchCardJoker = true,
    delayedJoker = true,
    showoffJoker = true,
    sniperJoker = true,
    blackjackJoker = true,
    batmanJoker = true,
    bombJoker = true,
    eyeChartJoker = true,
    grudgefulJoker = true,
    finishingBlowJoker = true,
    auroraBorealisJoker = true,
    historicalJoker = true,
    suitAlleyJoker = true,
    printerJoker = true,
    trainingWheelsJoker = true,
    horseshoeJoker = true,
    incompleteJoker = true,
    abbeyRoadJoker = true,
    fishingLicenseJoker = true,
    goldBarJoker = true,
    riggedJoker = true,
    commanderJoker = true,
    blueMoonJoker = true,
    dagonetJoker = true,
    glueJoker = true,
    harpSealJoker = true,
    footballCardJoker = true,
    specialEditionJoker = true,
    stockpilerJoker = true,
    studentLoansJoker = true,
    brokeJoker = true,
    goForBrokeJoker = true,
    streetFighterJoker = true,
    checklistJoker = true,
    oneOfUsJoker = true,
    investorJoker = true,
    mountainClimberJoker = true,
    shacklesJoker = true,
    buyOneGetOneJoker = true,
    packAPunchJoker = true,
    sealStealJoker = true,
    taxCollectorJoker = true,
    glassCannonJoker = true,
    scoringTestJoker = true,
    ciceroJoker = true,
    dawnJoker = true,
    savingsJoker = true,
    monopolistJoker = true,
    nebulaJoker = true,
    cheapskateJoker = true,
    psychicJoker = true,
    cheatJoker = true,
    plusOneJoker = true,
}

-- Get the mod directory path using multiple fallback methods
local function get_mod_path()
    -- Get the source file path from debug info
    local source = debug.getinfo(1, "S").source

    -- Remove @ prefix if present
    if source:sub(1, 1) == "@" then
        source = source:sub(2)
    end

    -- Extract directory path (works for both Unix and Windows)
    local path = source:match("^(.+[/\\])[^/\\]+$")
    if path then
        return path
    end

    -- If no path separator found, check if we can use love.filesystem
    if love and love.filesystem then
        -- Try to get the save directory and construct mods path
        local save_dir = love.filesystem.getSaveDirectory()
        if save_dir then
            return save_dir .. "/Mods/MikasBalatro/"
        end
    end

    -- Last resort: return empty string (current directory)
    return ""
end

local mod_path = get_mod_path()

-- Ensure SMODS.INIT exists
SMODS.INIT = SMODS.INIT or {}

-- Defer module loading until SMODS is ready
SMODS.INIT.MikasModCollection = function()
    -- Load helper functions
    local helpers = assert(loadfile(mod_path .. "mmc_helpers.lua"))()

    -- Initialize modules with config and helpers
    assert(loadfile(mod_path .. "mmc_decks.lua"))()(config, helpers)
    assert(loadfile(mod_path .. "mmc_tarot.lua"))()(config, helpers)
    assert(loadfile(mod_path .. "mmc_spectral.lua"))()(config, helpers)
    assert(loadfile(mod_path .. "mmc_jokers.lua"))()(config, helpers)
    assert(loadfile(mod_path .. "mmc_overrides.lua"))()(config, helpers)
end
