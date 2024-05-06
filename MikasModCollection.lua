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

-- Helper functions
local function init_joker(joker, no_sprite)
    no_sprite = no_sprite or false

    local new_joker = SMODS.Joker:new(
        joker.ability_name,
        joker.slug,
        joker.ability,
        { x = 0, y = 0 },
        joker.loc,
        joker.rarity,
        joker.cost,
        joker.unlocked,
        joker.discovered,
        joker.blueprint_compat,
        joker.eternal_compat,
        joker.effect,
        joker.atlas,
        joker.soul_pos
    )
    new_joker:register()

    if not no_sprite then
        local sprite = SMODS.Sprite:new(
            new_joker.slug,
            SMODS.findModByID("MikasMods").path,
            new_joker.slug .. ".png",
            71,
            95,
            "asset_atli"
        )
        sprite:register()
    end
end

local function init_tarot(tarot, no_sprite)
    no_sprite = no_sprite or false

    local new_tarot = SMODS.Tarot:new(
        tarot.name,
        tarot.slug,
        tarot.config,
        { x = 0, y = 0 },
        tarot.loc,
        tarot.cost,
        tarot.cost_mult,
        tarot.effect,
        tarot.consumeable,
        tarot.discovered,
        tarot.atlas
    )
    new_tarot:register()

    if not no_sprite then
        local sprite = SMODS.Sprite:new(
            new_tarot.slug,
            SMODS.findModByID("MikasMods").path,
            new_tarot.slug .. ".png",
            71,
            95,
            "asset_atli"
        )
        sprite:register()
    end
end

local function init_spectral(spectral, no_sprite)
    no_sprite = no_sprite or false

    local new_spectral = SMODS.Spectral:new(
        spectral.name,
        spectral.slug,
        spectral.config,
        { x = 0, y = 0 },
        spectral.loc,
        spectral.cost,
        spectral.consumeable,
        spectral.discovered,
        spectral.atlas
    )
    new_spectral:register()

    if not no_sprite then
        local sprite = SMODS.Sprite:new(
            new_spectral.slug,
            SMODS.findModByID("MikasMods").path,
            new_spectral.slug .. ".png",
            71,
            95,
            "asset_atli"
        )
        sprite:register()
    end
end

local function create_tarot(joker, seed)
    -- Check consumeable space
    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        -- Add card
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 0.0,
            func = (function()
                local card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, nil, seed)
                card:add_to_deck()
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
                return true
            end)
        }))
        -- Show message
        card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = localize("k_plus_tarot"),
            colour = G.C.PURPLE
        })
    else
        card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = localize("k_no_space_ex")
        })
    end
end

local function create_planet(joker, seed, edition, other_joker)
    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit or (edition and edition["negative"]) then
        local card_type = "Planet"
        if not (edition and edition["negative"]) then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        end
        G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 0.0,
            func = (function()
                if G.GAME.last_hand_played then
                    local _planet = 0
                    for _, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == G.GAME.last_hand_played then
                            _planet = v.key
                        end
                    end

                    local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, seed)
                    if edition then
                        card:set_edition(edition, true)
                    end
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    if not (edition and edition["negative"]) then
                        G.GAME.consumeable_buffer = 0
                    end

                    if other_joker then
                        other_joker:juice_up(0.5, 0.5)
                    end
                end
                return true
            end)
        }))

        -- Show message
        card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = localize("k_plus_planet"),
            colour = G.C.SECONDARY_SET.Planet
        })
    else
        card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = localize("k_no_space_ex")
        })
    end
end

local function is_even(card)
    local id = card:get_id()
    return id <= 10 and id % 2 == 0
end

local function is_odd(card)
    local id = card:get_id()
    return (id % 2 ~= 0 and id < 10) or id == 14
end

local function is_fibo(card)
    local id = card:get_id()
    return id == 2 or id == 3 or id == 5 or id == 8 or id == 14
end

local function is_prime(card)
    local id = card:get_id()
    return id == 2 or id == 3 or id == 5 or id == 7 or id == 14
end

local function is_face(card)
    local id = card:get_id()
    return id == 11 or id == 12 or id == 13
end

local function remove_prefix(name, prefix)
    local start_pos, end_pos = string.find(name, prefix)
    if start_pos == 1 then
        return string.sub(name, end_pos + 1)
    else
        return name
    end
end

local letters = { "a", "b", "c", "d", "e", "é", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
    "t", "u", "v", "w", "x", "y", "z" }

local function count_letters(str, letter)
    local count = 0
    for _ in str:gmatch(letter) do
        count = count + 1
    end
    return count
end

local enhancements = {
    G.P_CENTERS.m_bonus,
    G.P_CENTERS.m_mult,
    G.P_CENTERS.m_wild,
    G.P_CENTERS.m_glass,
    G.P_CENTERS.m_steel,
    G.P_CENTERS.m_stone,
    G.P_CENTERS.m_gold,
    G.P_CENTERS.m_lucky
}

local seals = {
    "Gold",
    "Red",
    "Blue",
    "Purple"
}

local function tables_equal(a, b)
    return table.concat(a) == table.concat(b)
end

local function tables_copy(t)
    local t2 = {}
    for k, v in pairs(t) do
        t2[k] = v
    end
    return t2
end

-- Save attributes
local attributes = {
    mult = {
        key = "mult_dagonet",
        prev_key = "prev_mult_dagonet",
        min = 0
    },
    mult_mod = {
        key = "mult_mod_dagonet",
        prev_key = "prev_mult_mod_dagonet",
        min = 0
    },
    chips = {
        key = "chips_dagonet",
        prev_key = "prev_chips_dagonet",
        min = 0
    },
    chip_mod = {
        key = "chip_mod_dagonet",
        prev_key = "prev_chips_mod_dagonet",
        min = 0
    },
    Xmult = {
        key = "Xmult_dagonet",
        prev_key = "prev_Xmult_dagonet",
        min = 1
    },
    Xmult_mod = {
        key = "Xmult_mod_dagonet",
        prev_key = "prev_Xmult_mod_dagonet",
        min = 0
    },
    x_mult = {
        key = "x_mult_dagonet",
        prev_key = "prev_x_mult_dagonet",
        min = 1
    },
    t_mult = {
        key = "t_mult_dagonet",
        prev_key = "prev_t_mult_dagonet",
        min = 0
    },
    t_chips = {
        key = "t_chips_dagonet",
        prev_key = "prev_t_chips_dagonet",
        min = 0
    },
    s_mult = {
        key = "s_mult_dagonet",
        prev_key = "prev_s_mult_dagonet",
        min = 0
    },
    dollars = {
        key = "dollars_dagonet",
        prev_key = "prev_dollars_dagonet",
        min = 0
    },
    hand_add = {
        key = "hand_add_dagonet",
        prev_key = "prev_hand_add_dagonet",
        min = 0
    },
    discard_sub = {
        key = "discard_sub_dagonet",
        prev_key = "prev_discard_sub_dagonet",
        min = 0
    },
    odds = {
        key = "odds_dagonet",
        prev_key = "prev_odds_dagonet",
        min = 0
    },
    faces = {
        key = "faces_dagonet",
        prev_key = "prev_faces_dagonet",
        min = 0
    },
    max = {
        key = "max_dagonet",
        prev_key = "prev_max_dagonet",
        min = 0
    },
    min = {
        key = "min_dagonet",
        prev_key = "prev_min_dagonet",
        min = 0
    },
    every = {
        key = "every_dagonet",
        prev_key = "prev_every_dagonet",
        min = 0
    },
    increase = {
        key = "increase_dagonet",
        prev_key = "prev_increase_dagonet",
        min = 0
    },
    d_size = {
        key = "d_size_dagonet",
        prev_key = "prev_d_size_dagonet",
        min = 0
    },
    h_mod = {
        key = "h_mod_dagonet",
        prev_key = "prev_h_mod_dagonet",
        min = 0
    },
    h_plays = {
        key = "h_plays_dagonet",
        prev_key = "prev_h_plays_dagonet",
        min = 0
    },
    discards = {
        key = "discards_dagonet",
        prev_key = "prev_discards_dagonet",
        min = 0
    },
    req = {
        key = "req_dagonet",
        prev_key = "prev_req_dagonet",
        min = 0
    },
    percentage = {
        key = "percentage_dagonet",
        prev_key = "prev_percentage_dagonet",
        min = 0
    },
    base = {
        key = "base_dagonet",
        prev_key = "prev_base_dagonet",
        min = 0
    },
    extra = {
        key = "extra_dagonet",
        prev_key = "prev_extra_dagonet",
        min = 0
    }
}

local dagonet_blacklist = {
    "Credit Card",
    "Juggler",
    "Turtle Bean",
    "Drunkard",
    "Troubadour",
    "Merry Andy"
}

-- Increase base attributes
local function increase_attributes(k, v, place, multiplier)
    local attr = attributes[k]

    if not attr or type(v) == "string" then
        return
    end

    -- Handle extra seperately
    if type(v) == "table" then
        for k2, v2 in pairs(place.extra) do
            increase_attributes(k2, v2, place.extra, multiplier)
        end
    elseif v > attr.min then
        if place[attr.prev_key] == nil then
            place[attr.prev_key] = multiplier
        end
        if place[attr.key] == nil then
            -- Save base value
            place[attr.key] = v
        else
            if not (v / multiplier == place[attr.key] and place[attr.prev_key] == multiplier) then
                if not (v / multiplier == place[attr.key] or v / place[attr.prev_key] == place[attr.key]) then
                    if v / multiplier ~= place[attr.key] and place[attr.prev_key] == multiplier then
                        -- Update base based on current multiplier
                        local increase = (v / multiplier - place[attr.key]) * multiplier
                        place[attr.key] = place[attr.key] + increase
                    else
                        -- Update base based on previous multiplier
                        local increase = (v / place[attr.prev_key] - place[attr.key]) * place[attr.prev_key]
                        place[attr.key] = place[attr.key] + increase
                    end
                end
            end
        end
        -- Multiply attribute
        place[k] = place[attr.key] * multiplier
        place[attr.prev_key] = multiplier
    end
end

local cicero_blacklist = {
    ["Misprint"] = true,
}

local cicero_whitelist = {
    ["Mr. Bones"] = true,
    ["MMC Printer"] = true,
}

-- Initialize joker type lists
local mikas_jokers = {}
local chips_jokers = {}
local mult_jokers = {}
local xmult_jokers = {}
local money_jokers = {}
local support_jokers = {}

-- Get lists of different joker types
local function get_mikas_jokers()
    if next(mikas_jokers) ~= nil then
        return mikas_jokers
    end

    for k, v in pairs(G.P_CENTERS) do
        if string.find(k, "j_mmc") and v.rarity ~= 4 then
            table.insert(mikas_jokers, k)
        end
    end

    return mikas_jokers
end

local function get_chips_jokers()
    if next(chips_jokers) ~= nil then
        return chips_jokers
    end

    for k, v in pairs(G.P_CENTERS) do
        if string.find(k, "j_") and v.rarity ~= 4 then
            local chips = false
            for _, v2 in ipairs(G.localization.descriptions.Joker[k].text) do
                chips = chips or string.find(v2:lower(), "chips")
            end
            if chips and v.rarity ~= 4 then
                table.insert(chips_jokers, k)
            end
        end
    end

    return chips_jokers
end

local function get_mult_jokers()
    if next(mult_jokers) ~= nil then
        return mult_jokers
    end

    for k, v in pairs(G.P_CENTERS) do
        if string.find(k, "j_") and v.rarity ~= 4 then
            local mult = false
            for _, v2 in ipairs(G.localization.descriptions.Joker[k].text) do
                mult = mult or (string.find(v2:lower(), "mult") and not string.find(v2:lower(), "x"))
            end
            if mult or v.ability.name == "Misprint" then
                table.insert(mult_jokers, k)
            end
        end
    end

    return mult_jokers
end

local function get_xmult_jokers()
    if next(xmult_jokers) ~= nil then
        return xmult_jokers
    end

    for k, v in pairs(G.P_CENTERS) do
        if string.find(k, "j_") and v.rarity ~= 4 then
            local xmult = false
            for _, v2 in ipairs(G.localization.descriptions.Joker[k].text) do
                xmult = xmult or (string.find(v2:lower(), "mult") and string.find(v2:lower(), "x"))
            end
            if xmult then
                table.insert(xmult_jokers, k)
            end
        end
    end

    return xmult_jokers
end

local function get_money_jokers()
    if next(money_jokers) ~= nil then
        return money_jokers
    end

    for k, v in pairs(G.P_CENTERS) do
        if string.find(k, "j_") and v.rarity ~= 4 then
            local money = false
            for _, v2 in ipairs(G.localization.descriptions.Joker[k].text) do
                money = money or string.find(v2:lower(), "$")
            end
            if money then
                table.insert(money_jokers, k)
            end
        end
    end

    return money_jokers
end

local function get_support_jokers()
    if next(support_jokers) ~= nil then
        return support_jokers
    end

    for k, v in pairs(G.P_CENTERS) do
        if string.find(k, "j_") and v.rarity ~= 4 then
            local support = true
            for _, v2 in ipairs(G.localization.descriptions.Joker[k].text) do
                support = support and
                    not (string.find(v2:lower(), "chips") or string.find(v2:lower(), "mult" or string.find(v2:lower(), "$")))
            end
            if cicero_whitelist[v.ability.name] ~= nil or (support and cicero_blacklist[v.ability.name] == nil) then
                table.insert(money_jokers, k)
            end
        end
    end

    return support_jokers
end

-- Create Decks
local decks = {
    evenStevenDeck = {
        loc = {
            name = "Even Steven's Deck",
            text = {
                "Start run with only",
                "{C:attention}even cards{} and",
                "the {C:attention}Even Steven{} joker"
            }
        },
        name = "Even Steven's Deck",
        config = {
            mmc_only_evens = true
        },
        sprite = {
            x = 5,
            y = 2
        }
    },
    oddToddDeck = {
        loc = {
            name = "Odd Todd's Deck",
            text = {
                "Start run with only",
                "{C:attention}odd cards{} and",
                "the {C:attention}Odd Todd{} joker"
            }
        },
        name = "Odd Todd's Deck",
        config = {
            mmc_only_odds = true
        },
        sprite = {
            x = 5,
            y = 2
        }
    },
    fibonacciDeck = {
        loc = {
            name = "Fibonacci Deck",
            text = {
                "Start run with only",
                "{C:attention}Fibonacci cards{} and",
                "the {C:attention}Fibonacci{} joker"
            }
        },
        name = "Fibonacci Deck",
        config = {
            mmc_only_fibo = true
        },
        sprite = {
            x = 5,
            y = 2
        }
    },
    primeDeck = {
        loc = {
            name = "Prime Deck",
            text = {
                "Start run with",
                "only {C:attention}prime cards{} and",
                "the {C:attention}Prime Time{} joker"
            }
        },
        name = "Prime Deck",
        config = {
            mmc_only_prime = true
        },
        sprite = {
            x = 5,
            y = 2
        }
    },
    midasDeck = {
        loc = {
            name = "Midas's Deck",
            text = {
                "Start run with only",
                "{C:attention}Gold Face cards{} and",
                "the {C:attention}Midas Mask{} joker"
            }
        },
        name = "Midas's Deck",
        config = {
            mmc_gold = true
        },
        sprite = {
            x = 6,
            y = 0
        }
    },
    jokersForHireDeck = {
        loc = {
            name = "\"Jokers for Hire\" Deck",
            text = {
                "All Jokers give {C:dark_edition}+1{}",
                "Joker slot. Price of",
                "{C:attention}Jokers{} and {C:attention}Buffoon Packs",
                "{C:red}increases{} per Joker"
            }
        },
        name = "Jokers for Hire",
        config = {
            mmc_for_hire = true
        },
        sprite = {
            x = 6,
            y = 0
        }
    },
    perfectPrecisionDeck = {
        loc = {
            name = "Perfect Precision Deck",
            text = {
                "+1 {C:blue}hands{}, {C:red}discards{} and",
                "{C:attention}hand size{}. Start with",
                "a {C:dark_edition}negative {C:attention}The Sniper{}",
                "Joker. Ante scales {C:attention}X1.5{}",
                "as fast"
            }
        },
        name = "Perfect Precision",
        config = {
            mmc_precision = true,
            ante_scaling = 1.5,
            discards = 1,
            hands = 1,
            hand_size = 1
        },
        sprite = {
            x = 5,
            y = 2
        },
    }
}

-- Local variables
local for_hire_counter = 1

-- Initialize deck effect
local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(arg_56_0)
    Backapply_to_runRef(arg_56_0)

    if arg_56_0.effect.config.mmc_only_evens then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Loop over all cards
                for i = #G.playing_cards, 1, -1 do
                    -- Remove odd cards
                    if not is_even(G.playing_cards[i]) then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                end

                -- Add Even Steven Joker
                add_joker("j_even_steven", nil, true, false)

                -- Return
                G.GAME.starting_deck_size = 20
                return true
            end
        }))
    end

    if arg_56_0.effect.config.mmc_only_odds then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Loop over all cards
                for i = #G.playing_cards, 1, -1 do
                    -- Remove even cards
                    if not is_odd(G.playing_cards[i]) then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                end

                -- Add Odd Todd Joker
                add_joker("j_odd_todd", nil, true, false)

                -- Return
                G.GAME.starting_deck_size = 20
                return true
            end
        }))
    end

    if arg_56_0.effect.config.mmc_only_fibo then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Loop over all cards
                for i = #G.playing_cards, 1, -1 do
                    -- Remove non fibonacci cards
                    if not is_fibo(G.playing_cards[i]) then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                end

                -- Add Fibonacci Joker
                add_joker("j_fibonacci", nil, true, false)

                -- Return
                G.GAME.starting_deck_size = 20
                return true
            end
        }))
    end

    if arg_56_0.effect.config.mmc_only_prime then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Loop over all cards
                for i = #G.playing_cards, 1, -1 do
                    -- Remove non prime cards
                    if not is_prime(G.playing_cards[i]) then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                end

                -- Add Prime Joker
                add_joker("j_mmc_prime_time", nil, true, false)

                -- Return
                G.GAME.starting_deck_size = 20
                return true
            end
        }))
    end

    if arg_56_0.effect.config.mmc_gold then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Loop over all cards
                for i = #G.playing_cards, 1, -1 do
                    if not is_face(G.playing_cards[i]) then
                        -- Remove non face cards
                        G.playing_cards[i]:start_dissolve(nil, true)
                    else
                        -- Set to gold
                        G.playing_cards[i]:set_ability(G.P_CENTERS.m_gold)
                    end
                end

                -- Add Midas Mask Joker
                add_joker("j_midas_mask", nil, true, false)

                -- Return
                G.GAME.starting_deck_size = 12
                return true
            end
        }))
    end

    if arg_56_0.effect.config.mmc_for_hire then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Set joker slots to 1
                G.jokers.config.card_limit = 1

                -- Add effect to starting params
                G.GAME.starting_params.mmc_for_hire = true

                -- Reset counter
                for_hire_counter = 1
                return true
            end
        }))
    end

    if arg_56_0.effect.config.mmc_precision then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Add The Sniper Joker
                add_joker("j_mmc_sniper", "negative", true, false)
                return true
            end
        }))
    end
end

function SMODS.INIT.MikasModCollection()
    -- Localization
    G.localization.descriptions.Other.card_extra_mult = { text = { "{C:mult}+#1#{} extra Mult" } }
    G.localization.misc.dictionary.k_mmc_charging = "Charging..."
    G.localization.misc.dictionary.k_mmc_bonus = "Bonus!"
    G.localization.misc.dictionary.k_mmc_hand_up = "+ Hand Size!"
    G.localization.misc.dictionary.k_mmc_hand_down = "- Hand Size!"
    G.localization.misc.dictionary.k_mmc_tick = "Tick..."
    G.localization.misc.dictionary.k_mmc_plus_card = "Card!"
    G.localization.misc.dictionary.k_mmc_luck = "+ Luck!"
    G.localization.misc.dictionary.k_mmc_destroy = "Destroy!"

    init_localization()

    -- Initialize Decks
    for k, v in pairs(decks) do
        if config[k] then
            local newDeck = SMODS.Deck:new(v.name, k, v.config, v.sprite, v.loc)
            newDeck:register()
        end
    end

    -- Tarot Cards
    if config.aceOfPentaclesTarot then
        -- Create Tarot
        local ace_of_pentacles = {
            loc = {
                name = "Ace Of Pentacles",
                text = {
                    "{C:red}#2# in #1#{} chance",
                    "to set money to",
                    "{C:money}$0{}, otherwise",
                    "{C:attention}double{} your money",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Ace Of Pentacles",
            slug = "mmc_ace_of_pentacles",
            config = { extra = { odds = 4 } },
            cost = 4,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Tarot
        init_tarot(ace_of_pentacles)

        -- Set local variables
        function SMODS.Tarots.c_mmc_ace_of_pentacles.loc_def(card)
            return { card.config.extra.odds, "" .. (G.GAME and G.GAME.probabilities.normal or 1) }
        end

        -- Set can_use
        function SMODS.Tarots.c_mmc_ace_of_pentacles.can_use(card)
            return true
        end

        -- Use effect
        function SMODS.Tarots.c_mmc_ace_of_pentacles.use(card, area, copier)
            if pseudorandom("ace_of_pentacles") < G.GAME.probabilities.normal / card.ability.extra.odds then
                -- Nope!
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        attention_text({
                            text = localize("k_nope_ex"),
                            scale = 1.3,
                            hold = 1.4,
                            major = card,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or
                                "cm",
                            offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0 },
                            silent = true
                        })
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound("tarot2", 0.76, 0.4); return true
                            end
                        }))
                        play_sound("tarot2", 1, 0.4)
                        card:juice_up(0.3, 0.5)
                        ease_dollars(-G.GAME.dollars)
                        return true
                    end
                }))
                delay(0.6)
            else
                -- Double money
                delay(0.6)
                ease_dollars(G.GAME.dollars)
            end
        end
    end

    if config.pageOfPentaclesTarot then
        -- Create Tarot
        local page_of_pentacles = {
            loc = {
                name = "Page Of Pentacles",
                text = {
                    "Multiply",
                    "money by {C:red}-1",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Page Of Pentacles",
            slug = "mmc_page_of_pentacles",
            config = {},
            cost = 1,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Tarot
        init_tarot(page_of_pentacles)

        -- Set local variables
        function SMODS.Tarots.c_mmc_page_of_pentacles.loc_def(card)
            return {}
        end

        -- Set can_use
        function SMODS.Tarots.c_mmc_page_of_pentacles.can_use(card)
            return true
        end

        -- Use effect
        function SMODS.Tarots.c_mmc_page_of_pentacles.use(card, area, copier)
            -- Turn money into negative
            if G.GAME.dollars ~= 0 then
                delay(0.6)
                ease_dollars(-G.GAME.dollars * 2)
            end
        end
    end

    if config.kingOfCupsTarot then
        -- Create Tarot
        local king_of_cups = {
            loc = {
                name = "King Of Cups",
                text = {
                    "Create a random",
                    "{X:mikas,C:white}Mika's-Mod{} Joker"
                }
            },
            ability_name = "MMC King Of Cups",
            slug = "mmc_king_of_cups",
            config = {},
            cost = 1,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Tarot
        init_tarot(king_of_cups, true)

        -- Set local variables
        function SMODS.Tarots.c_mmc_king_of_cups.loc_def(card)
            return {}
        end

        -- Set can_use
        function SMODS.Tarots.c_mmc_king_of_cups.can_use(card)
            return G.jokers.config.card_limit > #G.jokers.cards
        end

        -- Use effect
        function SMODS.Tarots.c_mmc_king_of_cups.use(card, area, copier)
            -- Add random Mika's Mod Joker
            local joker_list = get_mikas_jokers()
            local joker = pseudorandom_element(joker_list, pseudoseed("king_of_cups"))
            add_joker(joker, nil, true, false)
        end
    end

    if config.chipsTarot then
        -- Create Tarot
        local chips = {
            loc = {
                name = "Chips",
                text = {
                    "Get a random Chips Joker"
                }
            },
            ability_name = "MMC Chips",
            slug = "mmc_chips",
            config = {},
            cost = 1,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Tarot
        init_tarot(chips, true)

        -- Set local variables
        function SMODS.Tarots.c_mmc_chips.loc_def(card)
            return {}
        end

        -- Set can_use
        function SMODS.Tarots.c_mmc_chips.can_use(card)
            return G.jokers.config.card_limit > #G.jokers.cards
        end

        -- Use effect
        function SMODS.Tarots.c_mmc_chips.use(card, area, copier)
            -- Add random Chips Joker
            local joker_list = get_chips_jokers()
            local joker = pseudorandom_element(joker_list, pseudoseed("chips"))
            add_joker(joker, nil, true, false)
        end
    end

    if config.multTarot then
        -- Create Tarot
        local mult = {
            loc = {
                name = "Mult",
                text = {
                    "Get a random Mult Joker"
                }
            },
            ability_name = "MMC Mult",
            slug = "mmc_mult",
            config = {},
            cost = 1,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Tarot
        init_tarot(mult, true)

        -- Set local variables
        function SMODS.Tarots.c_mmc_mult.loc_def(card)
            return {}
        end

        -- Set can_use
        function SMODS.Tarots.c_mmc_mult.can_use(card)
            return G.jokers.config.card_limit > #G.jokers.cards
        end

        -- Use effect
        function SMODS.Tarots.c_mmc_mult.use(card, area, copier)
            -- Add random Mult Joker
            local joker_list = get_mult_jokers()
            local joker = pseudorandom_element(joker_list, pseudoseed("mult"))
            add_joker(joker, nil, true, false)
        end
    end

    if config.moneyTarot then
        -- Create Tarot
        local xmult = {
            loc = {
                name = "XMult",
                text = {
                    "Get a random XMult Joker"
                }
            },
            ability_name = "MMC Xmult",
            slug = "mmc_xmult",
            config = {},
            cost = 1,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Tarot
        init_tarot(xmult, true)

        -- Set local variables
        function SMODS.Tarots.c_mmc_xmult.loc_def(card)
            return {}
        end

        -- Set can_use
        function SMODS.Tarots.c_mmc_xmult.can_use(card)
            return G.jokers.config.card_limit > #G.jokers.cards
        end

        -- Use effect
        function SMODS.Tarots.c_mmc_xmult.use(card, area, copier)
            -- Add random XMult Joker
            local joker_list = get_xmult_jokers()
            local joker = pseudorandom_element(joker_list, pseudoseed("xmult"))
            add_joker(joker, nil, true, false)
        end
    end

    if config.moneyTarot then
        -- Create Tarot
        local money = {
            loc = {
                name = "Money",
                text = {
                    "Get a random Money Joker"
                }
            },
            ability_name = "MMC Money",
            slug = "mmc_money",
            config = {},
            cost = 1,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Tarot
        init_tarot(money, true)

        -- Set local variables
        function SMODS.Tarots.c_mmc_money.loc_def(card)
            return {}
        end

        -- Set can_use
        function SMODS.Tarots.c_mmc_money.can_use(card)
            return G.jokers.config.card_limit > #G.jokers.cards
        end

        -- Use effect
        function SMODS.Tarots.c_mmc_money.use(card, area, copier)
            -- Add random money Joker
            local joker_list = get_money_jokers()
            local joker = pseudorandom_element(joker_list, pseudoseed("money"))
            add_joker(joker, nil, true, false)
        end
    end

    if config.supportTarot then
        -- Create Tarot
        local support = {
            loc = {
                name = "Support",
                text = {
                    "Get a random Support Joker",
                    "(Not Chips, Mult or Money)"
                }
            },
            ability_name = "MMC Support",
            slug = "mmc_support",
            config = {},
            cost = 1,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Tarot
        init_tarot(support, true)

        -- Set local variables
        function SMODS.Tarots.c_mmc_support.loc_def(card)
            return {}
        end

        -- Set can_use
        function SMODS.Tarots.c_mmc_support.can_use(card)
            return G.jokers.config.card_limit > #G.jokers.cards
        end

        -- Use effect
        function SMODS.Tarots.c_mmc_support.use(card, area, copier)
            -- Add random support Joker
            local joker_list = get_support_jokers()
            local joker = pseudorandom_element(joker_list, pseudoseed("support"))
            add_joker(joker, nil, true, false)
        end
    end

    if config.cardChipsTarot then
        -- Create Tarot
        local card_chips = {
            loc = {
                name = "Card Chips",
                text = {
                    "3 Random cards gain",
                    "+25 chips permenantly"
                }
            },
            ability_name = "MMC Card Chips",
            slug = "mmc_card_chips",
            config = {},
            cost = 1,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Tarot
        init_tarot(card_chips, true)

        -- Set local variables
        function SMODS.Tarots.c_mmc_card_chips.loc_def(card)
            return {}
        end

        -- Set can_use
        function SMODS.Tarots.c_mmc_card_chips.can_use(card)
            return true
        end

        -- Use effect
        function SMODS.Tarots.c_mmc_card_chips.use(card, area, copier)

        end
    end

    if config.cardMultTarot then
        -- Create Tarot
        local card_mult = {
            loc = {
                name = "Card Mult",
                text = {
                    "3 Random cards gain",
                    "+5 Mult permenantly"
                }
            },
            ability_name = "MMC Card Mult",
            slug = "mmc_card_mult",
            config = {},
            cost = 1,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Tarot
        init_tarot(card_mult, true)

        -- Set local variables
        function SMODS.Tarots.c_mmc_card_mult.loc_def(card)
            return {}
        end

        -- Set can_use
        function SMODS.Tarots.c_mmc_card_mult.can_use(card)
            return true
        end

        -- Use effect
        function SMODS.Tarots.c_mmc_card_mult.use(card, area, copier)

        end
    end

    -- Spectral Cards
    if config.incenseSpectral then
        -- Create Spectral
        local incense = {
            loc = {
                name = "Incense",
                text = {
                    "Add {C:dark_edition}Negative{} to",
                    "a random {C:attention}Joker{},",
                    "{C:red}-$#1#{}, ignores",
                    "spending limit",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Incense",
            slug = "mmc_incense",
            config = { extra = { dollars = 50, j_slots = 1, increase = 25 } },
            cost = 4,
            cost_mult = 1,
            discovered = true
        }

        -- Initialize Spectral
        init_spectral(incense)

        -- Set local variables
        function SMODS.Spectrals.c_mmc_incense.loc_def(card)
            return { G.GAME.mmc_incense_cost or card.config.extra.dollars, card.config.extra.j_slots }
        end

        -- Set can_use
        function SMODS.Spectrals.c_mmc_incense.can_use(card)
            for _, v in pairs(G.jokers.cards) do
                if v.ability.set == "Joker" and (not v.edition) then
                    return true
                end
            end
            return false
        end

        -- Use effect
        function SMODS.Spectrals.c_mmc_incense.use(card, area, copier)
            -- Get cost
            G.GAME.mmc_incense_cost = G.GAME.mmc_incense_cost or card.ability.extra.dollars
            -- Get editionless Jokers
            local editionless_jokers = {}
            for _, v in pairs(G.jokers.cards) do
                if v.ability.set == "Joker" and (not v.edition) then
                    table.insert(editionless_jokers, v)
                end
            end
            -- Add negative to random Joker
            if #editionless_jokers > 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        -- Set joker edition
                        local joker = pseudorandom_element(editionless_jokers, pseudoseed("incense"))
                        ease_dollars(-G.GAME.mmc_incense_cost)
                        card:juice_up(0.3, 0.5)
                        joker:set_edition({ negative = true }, true)
                        -- Change Cost
                        G.GAME.mmc_incense_cost = G.GAME.mmc_incense_cost + card.ability.extra.increase
                        return true
                    end
                }))
            end
            delay(0.6)
        end
    end

    -- Jokers
    if config.primeTimeJoker then
        -- Create Joker
        local prime_time = {
            loc = {
                name = "Prime Time",
                text = {
                    "Each played {C:attention}2{},",
                    "{C:attention}3{}, {C:attention}5{}, {C:attention}7{} or {C:attention}Ace{}, gives",
                    "{X:mult,C:white}X#1#{} Mult when scored",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Prime Time",
            slug = "mmc_prime_time",
            ability = {
                extra = {
                    Xmult = 1.2
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(prime_time)

        -- Set local variables
        function SMODS.Jokers.j_mmc_prime_time.loc_def(card)
            return { card.ability.extra.Xmult }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_prime_time.calculate = function(self, context)
            -- For each played card, if card is prime, add xmult
            if context.individual and context.cardarea == G.play and
                (context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() ==
                    5 or context.other_card:get_id() == 7 or context.other_card:get_id() == 14) then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { self.ability.extra.Xmult }
                    },
                    x_mult = self.ability.extra.Xmult,
                    card = self
                }
            end
        end
    end

    if config.straightNateJoker then
        -- Create Joker
        local straight_nate = {
            loc = {
                name = "Straight Nate",
                text = {
                    "{X:mult,C:white} X#1# {} Mult if played hand",
                    "contains a {C:attention}Straight{} and you have",
                    "both {C:attention}Odd Todd{} and {C:attention}Even Steven{}",
                    "Gives {C:dark_edition}+#2#{} Joker slot"
                }
            },
            ability_name = "MMC Straight Nate",
            slug = "mmc_straight_nate",
            ability = {
                extra = {
                    Xmult = 4,
                    j_slots = 1
                }
            },
            rarity = 3,
            cost = 7,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(straight_nate)

        -- Set local variables
        function SMODS.Jokers.j_mmc_straight_nate.loc_def(card)
            return { card.ability.extra.Xmult, card.ability.extra.j_slots }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_straight_nate.calculate = function(self, context)
            if SMODS.end_calculate_context(context) and context.poker_hands then
                -- If hand played is a straight
                if next(context.poker_hands["Straight"]) then
                    -- Check for Todd and Steven Jokers
                    local todd = false;
                    local steven = false;
                    for _, v in pairs(G.jokers.cards) do
                        if v.ability.name == "Odd Todd" then
                            todd = true
                        end
                        if v.ability.name == "Even Steven" then
                            steven = true
                        end
                    end

                    -- Add xmult
                    if todd and steven then
                        return {
                            message = localize {
                                type = "variable",
                                key = "a_xmult",
                                vars = { self.ability.extra.Xmult }
                            },
                            Xmult_mod = self.ability.extra.Xmult
                        }
                    end
                end
            end
        end
    end

    if config.fishermanJoker then
        -- Create Joker
        local fisherman = {
            loc = {
                name = "The Fisherman",
                text = {
                    "{C:attention}+#2#{} hand size per discard",
                    "{C:attention}-#2#{} hand size per hand played",
                    "Resets every round",
                    "{C:inactive}(Currently {C:attention}+#1#{C:inactive} hand size)"
                }
            },
            ability_name = "MMC The Fisherman",
            slug = "mmc_fisherman",
            ability = {
                extra = {
                    current_h_size = 0,
                    h_mod = 1
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(fisherman)

        -- Set local variables
        function SMODS.Jokers.j_mmc_fisherman.loc_def(card)
            return { card.ability.extra.current_h_size, card.ability.extra.h_mod }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_fisherman.calculate = function(self, context)
            -- Decrease hand size
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.current_h_size > 0 then
                    self.ability.extra.current_h_size = math.max(0, self.ability.extra.current_h_size -
                        self.ability.extra.h_mod)
                    G.hand:change_size(-self.ability.extra.h_mod)
                    -- Decrease message
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_mmc_hand_down")
                    })
                end
            end

            -- Increase hand size
            if context.pre_discard then
                self.ability.extra.current_h_size = self.ability.extra.current_h_size + self.ability.extra.h_mod
                G.hand:change_size(self.ability.extra.h_mod)
                -- Increase message
                card_eval_status_text(self, "extra", nil, nil, nil, {
                    message = localize("k_mmc_hand_up")
                })
            end

            -- Reset hand size
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.current_h_size ~= 0 then
                    G.hand:change_size(-self.ability.extra.current_h_size)
                    self.ability.extra.current_h_size = 0
                    -- Reset message
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_reset")
                    })
                end
            end
        end
    end

    if config.impatientJoker then
        -- Create Joker
        local impatient = {
            loc = {
                name = "Impatient Joker",
                text = {
                    "{C:mult}+#2#{} Mult per card discarded",
                    "Resets every round",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                }
            },
            ability_name = "MMC Impatient Joker",
            slug = "mmc_impatient",
            ability = {
                extra = {
                    mult_mod = 3,
                    current_mult = 0
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(impatient)

        -- Set local variables
        function SMODS.Jokers.j_mmc_impatient.loc_def(card)
            return { card.ability.extra.current_mult, card.ability.extra.mult_mod }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_impatient.calculate = function(self, context)
            -- Apply mult
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.current_mult > 0 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_mult",
                            vars = { self.ability.extra.current_mult }
                        },
                        mult_mod = self.ability.extra.current_mult,
                        card = self
                    }
                end
            end

            -- Increase mult for each discarded card
            if context.discard and not context.blueprint then
                self.ability.extra.current_mult = self.ability.extra.current_mult + self.ability.extra.mult_mod
                return {
                    message = localize {
                        type = "variable",
                        key = "a_mult",
                        vars = { self.ability.extra.mult_mod }
                    },
                    colour = G.C.RED,
                    card = self
                }
            end

            -- Reset mult
            if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
                if self.ability.extra.current_mult ~= 0 then
                    self.ability.extra.current_mult = 0
                    -- Reset message
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_reset")
                    })
                end
            end
        end
    end

    if config.cultistJoker then
        -- Create Joker
        local cultist = {
            loc = {
                name = "Cultist",
                text = {
                    "{X:mult,C:white}X#2#{} Mult per hand played",
                    "Resets every round",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Cultist",
            slug = "mmc_cultist",
            ability = {
                extra = {
                    current_Xmult = 1,
                    Xmult_mod = 1,
                    old = 0
                }
            },
            rarity = 3,
            cost = 8,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(cultist)

        -- Set local variables
        function SMODS.Jokers.j_mmc_cultist.loc_def(card)
            return { card.ability.extra.current_Xmult, card.ability.extra.Xmult_mod }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_cultist.calculate = function(self, context)
            -- Increment Xmult
            if context.before and not context.blueprint then
                self.ability.extra.old = self.ability.extra.current_Xmult
                self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra.Xmult_mod
            end

            -- Apply xmult
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.old > 1 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { self.ability.extra.old }
                        },
                        Xmult_mod = self.ability.extra.old,
                        card = self
                    }
                end
            end

            -- Reset mult
            if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
                if self.ability.extra.current_Xmult ~= 1 then
                    self.ability.extra.current_Xmult = 1
                    -- Reset message
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_reset")
                    })
                end
            end
        end
    end

    if config.sealCollectorJoker then
        -- Create Joker
        local seal_collector = {
            loc = {
                name = "Seal Collector",
                text = {
                    "Gains {C:chips}+#2#{} Chips for",
                    "every card with a {C:attention}seal",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            ability_name = "MMC Seal Collector",
            slug = "mmc_seal_collector",
            ability = {
                extra = {
                    current_chips = 25,
                    chip_mod = 25
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(seal_collector)

        -- Set local variables
        function SMODS.Jokers.j_mmc_seal_collector.loc_def(card)
            return { card.ability.extra.current_chips, card.ability.extra.chip_mod }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_seal_collector.calculate = function(self, context)
            -- Apply chips
            if SMODS.end_calculate_context(context) then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_chips",
                        vars = { self.ability.extra.current_chips }
                    },
                    chip_mod = self.ability.extra.current_chips,
                    card = self
                }
            end
        end
    end

    if config.camperJoker then
        -- Create Joker
        local camper = {
            loc = {
                name = "Camper",
                text = {
                    "Every discarded {C:attention}card{}",
                    "permanently gains",
                    "{C:chips}+#1#{} Chips"
                }
            },
            ability_name = "MMC Camper",
            slug = "mmc_camper",
            ability = {
                extra = {
                    chip_mod = 4
                }
            },
            rarity = 2,
            cost = 5,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(camper)

        -- Set local variables
        function SMODS.Jokers.j_mmc_camper.loc_def(card)
            return { card.ability.extra.chip_mod }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_camper.calculate = function(self, context)
            -- If discarded
            if context.discard then
                -- Add chips to card
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus +
                    self.ability.extra.chip_mod
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.CHIPS,
                    card = self
                }
            end
        end
    end

    if config.scratchCardJoker then
        -- Create Joker
        local scratch_card = {
            loc = {
                name = "Scratch Card",
                text = {
                    "Gain {C:money}$#1#{}, {C:money}$#2#{}, {C:money}$#3#{}, {C:money}$#4#{},",
                    "{C:money}$#5#{} when 1, 2, 3, 4 or 5",
                    "{C:attention}7 cards{} are scored,",
                    "respectively",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Scratch Card",
            slug = "mmc_scratch_card",
            ability = {
                extra = {
                    base = 1,
                    dollars = 0,
                    seven_tally = 0
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(scratch_card)

        -- Set local variables
        function SMODS.Jokers.j_mmc_scratch_card.loc_def(card)
            return { card.ability.extra.base, card.ability.extra.base * 3, card.ability.extra.base * 10,
                card.ability.extra.base * 25, card.ability.extra.base * 50 }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_scratch_card.calculate = function(self, context)
            -- Count sevens
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 and
                not context.blueprint then
                self.ability.extra.seven_tally = self.ability.extra.seven_tally + 1
            end

            if SMODS.end_calculate_context(context) then
                -- Set dollars depending on amount of 7s
                if self.ability.extra.seven_tally == 1 then
                    self.ability.extra.dollars = self.ability.extra.base
                elseif self.ability.extra.seven_tally == 2 then
                    self.ability.extra.dollars = self.ability.extra.base * 3
                elseif self.ability.extra.seven_tally == 3 then
                    self.ability.extra.dollars = self.ability.extra.base * 10
                elseif self.ability.extra.seven_tally == 4 then
                    self.ability.extra.dollars = self.ability.extra.base * 25
                elseif self.ability.extra.seven_tally >= 5 then
                    self.ability.extra.dollars = self.ability.extra.base * 50
                end

                -- Give money
                if self.ability.extra.seven_tally >= 1 then
                    ease_dollars(self.ability.extra.dollars)
                    return {
                        message = localize("$") .. self.ability.extra.dollars,
                        dollars = self.ability.extra.dollars,
                        colour = G.C.MONEY
                    }
                end
            end

            -- Reset
            if context.after and not context.blueprint and context.cardarea == G.jokers then
                self.ability.extra.dollars = 0
                self.ability.extra.seven_tally = 0
            end
        end
    end

    if config.delayedJoker then
        -- Create Joker
        local delayed = {
            loc = {
                name = "Delayed Joker",
                text = {
                    "Gives {C:mult}+#1#{} Mult, {C:chips}+#2#{}",
                    "Chips and {X:mult,C:white}X#3#{} Mult on",
                    "the {C:attention}#5#th{} action",
                    "{C:inactive}(Current action: {C:attention}#4#{C:inactive} )"
                }
            },
            ability_name = "MMC Delayed Joker",
            slug = "mmc_delayed",
            ability = {
                extra = {
                    mult = 20,
                    chips = 100,
                    Xmult = 1.5,
                    every = 4,
                    action_tally = 1
                }
            },
            rarity = 2,
            cost = 7,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(delayed)

        -- Set local variables
        function SMODS.Jokers.j_mmc_delayed.loc_def(card)
            return { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.Xmult,
                card.ability.extra.action_tally, card.ability.extra.every }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_delayed.calculate = function(self, context)
            -- Increment action tally
            if context.before and not context.blueprint then
                self.ability.extra.action_tally = self.ability.extra.action_tally + 1
            end

            -- Apply mult, chips and xmult
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.action_tally == self.ability.extra.every + 1 then
                    return {
                        -- Return bonus message and apply bonus
                        mult_mod = self.ability.extra.mult,
                        chip_mod = self.ability.extra.chips,
                        Xmult_mod = self.ability.extra.Xmult,
                        message = localize("k_mmc_bonus"),
                        card = self
                    }
                elseif not context.blueprint then
                    -- Return charging message
                    return {
                        message = localize("k_mmc_charging"),
                        colour = G.C.JOKER_GREY,
                        card = self
                    }
                end
            end

            -- Reset action tally
            if context.after and not context.blueprint and context.cardarea == G.jokers then
                if self.ability.extra.action_tally == self.ability.extra.every + 1 then
                    self.ability.extra.action_tally = 1
                end
            end

            -- Increment action tally
            if context.pre_discard and not context.blueprint and not context.hook then
                self.ability.extra.action_tally = (self.ability.extra.action_tally % self.ability.extra.every) + 1
                if self.ability.extra.action_tally == 1 then
                    -- Reset message
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_reset")
                    })
                else
                    -- Charging message
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_mmc_charging"),
                        colour = G.C.JOKER_GREY
                    })
                end
            end
        end
    end

    if config.showoffJoker then
        -- Create Joker
        local showoff = {
            loc = {
                name = "The Show-Off",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult when",
                    "a blind is finished with",
                    "{C:attention}X#3#{} the chip requirement",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                }
            },
            ability_name = "MMC The Show-Off",
            slug = "mmc_showoff",
            ability = {
                extra = {
                    current_Xmult = 1,
                    Xmult_mod = 0.25,
                    req = 2,
                    total_chips = 0
                }
            },
            rarity = 3,
            cost = 8,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(showoff)

        -- Set local variables
        function SMODS.Jokers.j_mmc_showoff.loc_def(card)
            return { card.ability.extra.current_Xmult, card.ability.extra.Xmult_mod, card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_showoff.calculate = function(self, context)
            -- Apply xmult
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.current_Xmult > 1 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { self.ability.extra.current_Xmult }
                        },
                        Xmult_mod = self.ability.extra.current_Xmult,
                        card = self
                    }
                end
            end

            -- Add scored chips to total
            if context.mmc_scored_chips and not context.blueprint then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.mmc_scored_chips
            end

            -- See if total scored chips > 2 * blind chips, then increment xmult
            if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
                if self.ability.extra.total_chips > (self.ability.extra.req * G.GAME.blind.chips) then
                    self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra.Xmult_mod

                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.RED
                    })
                end
                -- Reset total chip count
                self.ability.extra.total_chips = 0
            end
        end
    end

    if config.sniperJoker then
        -- Create Joker
        local sniper = {
            loc = {
                name = "The Sniper",
                text = {
                    "Gains {X:mult,C:white}X#2#{} Mult when a",
                    "blind is finished within {C:attention}#3#%{} of",
                    "the {C:attention}exact{} chip requirement",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC The Sniper",
            slug = "mmc_sniper",
            ability = {
                extra = {
                    current_Xmult = 1,
                    Xmult_mod = 2,
                    percentage = 10,
                    total_chips = 0
                }
            },
            rarity = 3,
            cost = 10,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(sniper)

        -- Set local variables
        function SMODS.Jokers.j_mmc_sniper.loc_def(card)
            return { card.ability.extra.current_Xmult, card.ability.extra.Xmult_mod, card.ability.extra.percentage }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_sniper.calculate = function(self, context)
            -- Apply xmult
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.current_Xmult > 1 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { self.ability.extra.current_Xmult }
                        },
                        Xmult_mod = self.ability.extra.current_Xmult,
                        card = self
                    }
                end
            end

            -- Add scored chips to total
            if context.mmc_scored_chips and not context.blueprint then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.mmc_scored_chips
            end

            -- See if total scored chips == blind chips, then increment xmult
            if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
                if self.ability.extra.total_chips <= G.GAME.blind.chips * (1 + self.ability.extra.percentage / 100) then
                    self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra.Xmult_mod

                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.RED
                    })
                end
                -- Reset total chip count
                self.ability.extra.total_chips = 0
            end
        end
    end

    if config.blackjackJoker then
        -- Create Joker
        local blackjack = {
            loc = {
                name = "Blackjack Joker",
                text = {
                    "Gives {X:mult,C:white}X#1#{} Mult when",
                    "the ranks of all played",
                    "cards is {C:attention}exactly #2#",
                    "Gives {X:mult,C:white}X#3#{} Mult less for",
                    "every point below #2#"
                }
            },
            ability_name = "MMC Blackjack Joker",
            slug = "mmc_blackjack",
            ability = {
                extra = {
                    Xmult = 3,
                    rank_tally = { 0 },
                    updated_rank_tally = {},
                    req = 21,
                    Xmult_mod = 0.5
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(blackjack)

        -- Set local variables
        function SMODS.Jokers.j_mmc_blackjack.loc_def(card)
            return { card.ability.extra.Xmult, card.ability.extra.req, card.ability.extra.Xmult_mod }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_blackjack.calculate = function(self, context)
            -- For full hand
            if context.before and not context.blueprint then
                -- For every played card
                for _, v in ipairs(context.full_hand) do
                    local id = v:get_id()
                    if id <= 10 then -- Numbered cards
                        for k, v in ipairs(self.ability.extra.rank_tally) do
                            self.ability.extra.rank_tally[k] = v + id
                        end
                    elseif id < 14 then -- Face cards
                        for k, v in ipairs(self.ability.extra.rank_tally) do
                            self.ability.extra.rank_tally[k] = v + 10
                        end
                    else -- Aces, need to be handled differently because they can either have a value of 1 or 11
                        for k, v in ipairs(self.ability.extra.rank_tally) do
                            -- If someone ever plays 32 aces in one hand, I'm doomed
                            self.ability.extra.rank_tally[k] = v + 11
                            table.insert(self.ability.extra.updated_rank_tally, v + 1)
                        end

                        -- Append updated_rank_tally to rank_tally
                        for _, v in ipairs(self.ability.extra.updated_rank_tally) do
                            table.insert(self.ability.extra.rank_tally, v)
                        end

                        -- Reset updated_rank_tally
                        self.ability.extra.updated_rank_tally = {}
                    end
                end
            end

            -- When hand is played
            if SMODS.end_calculate_context(context) then
                -- For every rank_tally, check if we got 21
                local Xmult = 1
                for _, v in ipairs(self.ability.extra.rank_tally) do
                    local diff = self.ability.extra.req - v
                    local new_Xmult = self.ability.extra.Xmult - diff * self.ability.extra.Xmult_mod
                    -- Update Xmult if it is higher than saved Xmult, and score is not above the required score
                    if diff >= 0 and new_Xmult > Xmult then
                        Xmult = new_Xmult
                    end
                end

                -- Apply Xmult
                if Xmult > 1 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { Xmult }
                        },
                        Xmult_mod = Xmult,
                        card = self
                    }
                end
            end

            -- Reset rank_tally
            if context.after and not context.blueprint and context.cardarea == G.jokers then
                self.ability.extra.rank_tally = { 0 }
            end
        end
    end

    if config.batmanJoker then
        -- Create Joker
        local batman = {
            loc = {
                name = "Batman",
                text = {
                    "Gains {C:mult}+#2#{} Mult for",
                    "every {C:attention}non-lethal{} hand played",
                    "Mult gain increases for every",
                    "Joker with {C:attention}\"Joker\"{} in the name",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                }
            },
            ability_name = "MMC Batman",
            slug = "mmc_batman",
            ability = {
                extra = {
                    current_mult = 1,
                    mult_mod = 1,
                    total_chips = 0,
                    base = 1
                }
            },
            rarity = 3,
            cost = 8,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(batman)

        -- Set local variables
        function SMODS.Jokers.j_mmc_batman.loc_def(card)
            return { card.ability.extra.current_mult, card.ability.extra.mult_mod }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_batman.calculate = function(self, context)
            -- When hand is played
            if SMODS.end_calculate_context(context) then
                -- Apply mult
                return {
                    message = localize {
                        type = "variable",
                        key = "a_mult",
                        vars = { self.ability.extra.current_mult }
                    },
                    mult_mod = self.ability.extra.current_mult
                }
            end

            -- Add scored chips to total
            if context.mmc_scored_chips and not context.blueprint then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.mmc_scored_chips

                if self.ability.extra.total_chips < G.GAME.blind.chips then
                    self.ability.extra.current_mult = self.ability.extra.current_mult + self.ability.extra.mult_mod
                end
            end

            -- Reset total chip count
            if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
                -- Reset total chip count
                self.ability.extra.total_chips = 0
            end
        end
    end

    if config.bombJoker then
        -- Create Joker
        local bomb = {
            loc = {
                name = "Bomb",
                text = {
                    "Gains {C:mult}+#2#{} Mult per round",
                    "self destructs after {C:attention}#3#{} rounds",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Bomb",
            slug = "mmc_bomb",
            ability = {
                extra = {
                    current_mult = 15,
                    mult_mod = 15,
                    _every = 3
                }
            },
            rarity = 1,
            cost = 5,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = false
        }

        -- Initialize Joker
        init_joker(bomb)

        -- Set local variables
        function SMODS.Jokers.j_mmc_bomb.loc_def(card)
            return { card.ability.extra.current_mult, card.ability.extra.mult_mod, card.ability.extra._every }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_bomb.calculate = function(self, context)
            -- Apply mult
            if SMODS.end_calculate_context(context) then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_mult",
                        vars = { self.ability.extra.current_mult }
                    },
                    mult_mod = self.ability.extra.current_mult,
                    card = self
                }
            end

            -- Decrease round_left counter or destroy
            if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
                self.ability.extra._every = self.ability.extra._every - 1

                if self.ability.extra._every <= 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("tarot1")
                            self:start_dissolve()
                            return true
                        end
                    }))
                else
                    -- Increase mult
                    self.ability.extra.current_mult = self.ability.extra.current_mult + self.ability.extra.mult_mod
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_mmc_tick"),
                        colour = G.C.RED
                    })
                end
            end
        end
    end

    if config.eyeChartJoker then
        -- Create Joker
        local eye_chart = {
            loc = {
                name = "Eye Chart",
                text = {
                    "Gives {C:chips}+#1#{} Chips for every",
                    "letter {C:attention}\"#2#\"{} in your Jokers",
                    "Letter changes when this",
                    "Joker appears in the shop",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy" }
            },
            ability_name = "MMC Eye Chart",
            slug = "mmc_eye_chart",
            ability = {
                extra = {
                    chips = 20,
                    letter = "A"
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(eye_chart)

        -- Set local variables
        function SMODS.Jokers.j_mmc_eye_chart.loc_def(card)
            return { card.ability.extra.chips, card.ability.extra.letter }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_eye_chart.calculate = function(self, context)
            -- Check if Joker name contains letter and apply chips
            if context.other_joker and context.other_joker.ability.set == "Joker" then
                -- FOR OTHER MODS:
                -- If your mod uses ability names with a prefix and you want it to be compatible with this Joker,
                -- Send me a message on Discord and I will add your prefix here so that it will work correctly!

                -- Remove prefix from ability names
                local ability_name = context.other_joker.ability.name:lower()
                ability_name = remove_prefix(ability_name, "mmc")

                -- Count letters
                local letter_tally = count_letters(ability_name, self.ability.extra.letter:lower())

                -- Check if Joker name contains letter
                if letter_tally > 0 then
                    -- Animate other Joker
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.other_joker:juice_up(0.5, 0.5)
                            return true
                        end
                    }))
                    -- Apply chips
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_chips",
                            vars = { self.ability.extra.chips * letter_tally }
                        },
                        chip_mod = self.ability.extra.chips * letter_tally
                    }
                end
            end
        end
    end

    if config.grudgefulJoker then
        -- Create Joker
        local grudgeful = {
            loc = {
                name = "Grudgeful Joker",
                text = {
                    "Lowers blind requirement",
                    "with {C:attention}excess Chips{} from",
                    "last round. Caps at {C:attention}#2#%",
                    "of current blind's Chips",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
                }
            },
            ability_name = "MMC Grudgeful Joker",
            slug = "mmc_grudgeful",
            ability = {
                extra = {
                    current_chips = 0,
                    total_chips = 0,
                    old_chips = 0,
                    percentage = 25
                }
            },
            rarity = 3,
            cost = 9,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(grudgeful)

        -- Set local variables
        function SMODS.Jokers.j_mmc_grudgeful.loc_def(card)
            return { card.ability.extra.current_chips, card.ability.extra.percentage }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_grudgeful.calculate = function(self, context)
            -- Add scored chips to total
            if context.mmc_scored_chips and not context.blueprint then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.mmc_scored_chips
            end

            -- Apply chips
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.current_chips > 0 then
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize {
                            type = "variable",
                            key = "a_chips",
                            vars = { self.ability.extra.current_chips }
                        },
                        colour = G.C.CHIPS
                    })
                    -- Special thanks to Codex Arcanum
                    G.GAME.blind.chips = math.max(G.GAME.blind.chips - self.ability.extra.current_chips, 0)
                    G.E_MANAGER:add_event(Event({
                        delay = 0.0,
                        func = function()
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            local chips_UI = G.hand_text_area.blind_chips
                            G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                            G.HUD_blind:recalculate()
                            chips_UI:juice_up()
                            return true
                        end
                    }))
                end
            end

            -- Reset chips
            if context.after and not context.blueprint and context.cardarea == G.jokers then
                self.ability.extra.current_chips = 0
            end

            if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
                -- Add excess chips to bonus
                if self.ability.extra.total_chips >= G.GAME.blind.chips then
                    self.ability.extra.current_chips = self.ability.extra.total_chips - G.GAME.blind.chips
                    self.ability.extra.current_chips = math.ceil(math.min(G.GAME.blind.chips *
                        self.ability.extra.percentage / 100,
                        self.ability.extra.current_chips))
                    -- Return message
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize {
                            type = "variable",
                            key = "a_chips",
                            vars = { self.ability.extra.current_chips }
                        },
                        colour = G.C.CHIPS
                    })
                end
            end
        end
    end

    if config.finishingBlowJoker then
        -- Create Joker
        local finishing_blow = {
            loc = {
                name = "Finishing Blow",
                text = {
                    "If a blind is finished",
                    "with a {C:attention}High Card{}, randomly",
                    "{C:attention}Enhance{} scored cards"
                }
            },
            ability_name = "MMC Finishing Blow",
            slug = "mmc_finishing_blow",
            ability = {
                extra = {
                    high_card = false,
                    card_refs = {}
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(finishing_blow)

        -- Set local variables
        function SMODS.Jokers.j_mmc_finishing_blow.loc_def(card)
            return { card.ability.extra.enhancement }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_finishing_blow.calculate = function(self, context)
            -- Check for high card and set card reference
            if context.cardarea == G.play and not context.repetition then
                if context.scoring_name == "High Card" then
                    if context.other_card.ability.effect == "Base" then
                        self.ability.extra.high_card = true
                        table.insert(self.ability.extra.card_refs, context.other_card)
                    end
                else
                    self.ability.extra.high_card = false
                end
            end

            -- Give random enhancement if last hand was high card
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.high_card then
                    for _, v in ipairs(self.ability.extra.card_refs) do
                        v:set_ability(pseudorandom_element(enhancements, pseudoseed("finishing_blow")), nil, true)
                        card_eval_status_text(self, "extra", nil, nil, nil, {
                            message = localize("k_upgrade_ex"),
                            delay = 0.45
                        })
                    end
                end
                -- Reset card_refs
                self.ability.extra.card_refs = {}
            end
        end
    end

    if config.auroraBorealisJoker then
        -- Create Joker
        local aurora_borealis = {
            loc = {
                name = "Aurora Borealis",
                text = {
                    "{C:attention}Blue Seals{} give an",
                    "extra {C:dark_edition}negative {C:planet}Planet{} card",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Aurora Borealis",
            slug = "mmc_aurora_borealis",
            ability = {},
            rarity = 1,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(aurora_borealis)

        -- Set local variables
        function SMODS.Jokers.j_mmc_aurora_borealis.loc_def(card)
            return {}
        end
    end

    if config.historicalJoker then
        -- Create Joker
        local historical = {
            loc = {
                name = "Historical Joker",
                text = {
                    "If scored cards have the same",
                    "{C:attention}ranks{} and {C:attention}order{} as previous",
                    "hand, reduce blind requirement",
                    "by previous hands {C:chips}Chips{}. Caps at",
                    "{C:attention}#1#%{} of current blind's Chips",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Historical Joker",
            slug = "mmc_historical",
            ability = {
                extra = {
                    prev_cards = {},
                    current_cards = {},
                    current_chips = 0,
                    percentage = 25
                }
            },
            rarity = 3,
            cost = 9,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(historical)

        -- Set local variables
        function SMODS.Jokers.j_mmc_historical.loc_def(card)
            return { card.ability.extra.percentage }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_historical.calculate = function(self, context)
            -- Save previous cards
            if context.before and not context.blueprint then
                for _, v in ipairs(context.full_hand) do
                    table.insert(self.ability.extra.current_cards, v.base.id)
                end
            end

            -- Calculate chip score
            if context.mmc_scored_chips and not context.blueprint then
                self.ability.extra.current_chips = context.mmc_scored_chips
                self.ability.extra.current_chips = math.ceil(math.min(
                    G.GAME.blind.chips * self.ability.extra.percentage / 100, self.ability.extra.current_chips))
            end

            -- Apply chips if previous cards are the same as the current cards
            if SMODS.end_calculate_context(context) then
                if tables_equal(self.ability.extra.prev_cards, self.ability.extra.current_cards) then
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize {
                            type = "variable",
                            key = "a_chips",
                            vars = { self.ability.extra.current_chips }
                        },
                        colour = G.C.CHIPS
                    })
                    -- Special thanks to Codex Arcanum
                    G.GAME.blind.chips =  math.max(G.GAME.blind.chips - self.ability.extra.current_chips, 0)
                    G.E_MANAGER:add_event(Event({
                        delay = 0.0,
                        func = function()
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            local chips_UI = G.hand_text_area.blind_chips
                            G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                            G.HUD_blind:recalculate()
                            chips_UI:juice_up()
                            return true
                        end
                    }))
                end
            end

            -- Save previous hand
            if context.after and not context.blueprint and context.cardarea == G.jokers then
                self.ability.extra.prev_cards = tables_copy(self.ability.extra.current_cards)
                self.ability.extra.current_cards = {}
            end
        end
    end

    if config.suitAlleyJoker then
        -- Create Joker
        local suit_alley = {
            loc = {
                name = "Suit Alley",
                text = {
                    "{C:diamonds}Diamond{} and {C:clubs}Club{} cards",
                    "gain {C:chips}+#1#{} Chips when scored",
                    "{C:hearts}Heart{} and {C:spades}Spade{} cards",
                    "gain {C:mult}+#2#{} Mult when scored"
                }
            },
            ability_name = "MMC Suit Alley",
            slug = "mmc_suit_alley",
            ability = {
                extra = {
                    mult = 3,
                    chips = 12
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(suit_alley)

        -- Set local variables
        function SMODS.Jokers.j_mmc_suit_alley.loc_def(card)
            return { card.ability.extra.chips, card.ability.extra.mult }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_suit_alley.calculate = function(self, context)
            if context.cardarea == G.play and not context.repetition then
                local mult = 0
                local chips = 0
                if context.other_card:is_suit("Diamonds") or context.other_card:is_suit("Clubs") then
                    -- Add chips if suit is Diamonds or Clubs
                    chips = self.ability.extra.chips
                end
                if context.other_card:is_suit("Hearts") or context.other_card:is_suit("Spades") then
                    -- Add mult if Hearts or Spades
                    mult = self.ability.extra.mult
                end

                if mult > 0 and chips > 0 then
                    return {
                        chips = chips,
                        mult = mult,
                        card = self
                    }
                elseif chips > 0 then
                    return {
                        chips = chips,
                        card = self
                    }
                elseif mult > 0 then
                    return {
                        mult = mult,
                        card = self
                    }
                end
            end
        end
    end

    if config.printerJoker then
        -- Create Joker
        local printer = {
            loc = {
                name = "The Printer",
                text = {
                    "If hand scores more than",
                    "blind's Chips, {C:attention}duplicate{}",
                    "played cards"
                }
            },
            ability_name = "MMC The Printer",
            slug = "mmc_printer",
            ability = {
                extra = {
                    hand = {}
                }
            },
            rarity = 3,
            cost = 9,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(printer)

        -- Set local variables
        function SMODS.Jokers.j_mmc_printer.loc_def(card)
            return {}
        end

        -- Calculate
        SMODS.Jokers.j_mmc_printer.calculate = function(self, context)
            -- Save cards
            if context.before then
                for _, v in ipairs(context.full_hand) do
                    table.insert(self.ability.extra.hand, v)
                end
            end

            -- Calculate chip score and duplicate cards
            if context.mmc_scored_chips then
                if context.mmc_scored_chips >= G.GAME.blind.chips then
                    -- Loop over hand
                    for _, v in ipairs(self.ability.extra.hand) do
                        -- Copy card
                        local _card = copy_card(v, nil, nil, G.playing_card)
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.deck:emplace(_card)
                        _card.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:start_materialize()
                                return true
                            end
                        }))
                        -- Show message
                        card_eval_status_text(self, "extra", nil, nil, nil, {
                            message = localize("k_copied_ex"),
                            colour = G.C.CHIPS,
                            card = self,
                            playing_cards_created = { true }
                        })
                    end
                end
                -- Reset hand
                self.ability.extra.hand = {}
            end
        end
    end

    if config.trainingWheelsJoker then
        -- Create Joker
        local training_wheels = {
            loc = {
                name = "Training Wheels",
                text = {
                    "{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X#2#{}",
                    "Mult per {C:attention}#4# cards{} scored",
                    "{C:inactive}Currently {C:attention}#3# {C:inactive}cards scored",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Training Wheels",
            slug = "mmc_training_wheels",
            ability = {
                extra = {
                    current_Xmult = 1,
                    Xmult_mod = 0.1,
                    card_count = 0,
                    req = 10
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(training_wheels)

        -- Set local variables
        function SMODS.Jokers.j_mmc_training_wheels.loc_def(card)
            return { card.ability.extra.current_Xmult, card.ability.extra.Xmult_mod, card.ability.extra.card_count,
                card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_training_wheels.calculate = function(self, context)
            -- Add xmult for every played card
            if context.individual and context.cardarea == G.play and not context.blueprint then
                self.ability.extra.card_count = self.ability.extra.card_count + 1
                if self.ability.extra.card_count >= 10 then
                    self.ability.extra.card_count = 0
                    self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra.Xmult_mod
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { self.ability.extra.current_Xmult }
                        },
                        colour = G.C.MULT
                    })
                end
            end

            -- Apply xmult
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.current_Xmult > 1 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { self.ability.extra.current_Xmult }
                        },
                        Xmult_mod = self.ability.extra.current_Xmult,
                        card = self
                    }
                end
            end
        end
    end

    if config.horseshoeJoker then
        -- Create Joker
        local horseshoe = {
            loc = {
                name = "Horseshoe",
                text = {
                    "Retrigger all",
                    "scored {C:attention}Lucky{} cards",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Horseshoe",
            slug = "mmc_horseshoe",
            ability = {
                extra = 1
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(horseshoe)

        -- Set local variables
        function SMODS.Jokers.j_mmc_horseshoe.loc_def(card)
            return {}
        end

        -- Calculate
        SMODS.Jokers.j_mmc_horseshoe.calculate = function(self, context)
            -- Retrigger lucky cards
            if context.repetition and context.cardarea == G.play then
                if context.other_card.ability.effect == "Lucky Card" then
                    return {
                        message = localize("k_again_ex"),
                        repetitions = self.ability.extra,
                        card = self
                    }
                end
            end
        end
    end

    if config.incompleteJoker then
        -- Create Joker
        local incomplete = {
            loc = {
                name = "Incomplete Joker",
                text = {
                    "{C:chips}+#1#{} Chips if played",
                    "hand contains",
                    "{C:attention}#2#{} or fewer cards"
                }
            },
            ability_name = "MMC Incomplete Joker",
            slug = "mmc_incomplete",
            ability = {
                extra = {
                    chips = 100,
                    req = 3
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(incomplete)

        -- Set local variables
        function SMODS.Jokers.j_mmc_incomplete.loc_def(card)
            return { card.ability.extra.chips, card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_incomplete.calculate = function(self, context)
            -- Check if hand is less than 3 cards, then apply chips
            if SMODS.end_calculate_context(context) and context.full_hand then
                if #context.full_hand <= self.ability.extra.req then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_chips",
                            vars = { self.ability.extra.chips }
                        },
                        chip_mod = self.ability.extra.chips
                    }
                end
            end
        end
    end

    if config.abbeyRoadJoker then
        -- Create Joker
        local abbey_road = {
            loc = {
                name = "Abbey Road",
                text = {
                    "If at least {C:attention}#2#{} poker hands",
                    "have been played the same",
                    "amount of times, give {X:mult,C:white}X#1#{} Mult",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Abbey Road",
            slug = "mmc_abbey_road",
            ability = {
                extra = {
                    Xmult = 4,
                    req = 5,
                    hand_equal_count = {},
                    should_trigger = false
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(abbey_road)

        -- Set local variables
        function SMODS.Jokers.j_mmc_abbey_road.loc_def(card)
            return { card.ability.extra.Xmult, card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_abbey_road.calculate = function(self, context)
            if context.after and not context.blueprint and context.cardarea == G.jokers then
                -- Reset
                self.ability.extra.should_trigger = false
                self.ability.extra.hand_equal_count = {}

                -- Count occurance of all hands
                for _, v in ipairs(G.handlist) do
                    if G.GAME.hands[v].played > 0 then
                        if self.ability.extra.hand_equal_count[G.GAME.hands[v].played] == nil then
                            self.ability.extra.hand_equal_count[G.GAME.hands[v].played] = 1
                        else
                            self.ability.extra.hand_equal_count[G.GAME.hands[v].played] = self.ability.extra
                                .hand_equal_count[G.GAME
                                .hands[v].played] + 1
                        end
                    end
                end

                -- If any count is higher than req, apply mult
                for _, v in pairs(self.ability.extra.hand_equal_count) do
                    if v >= self.ability.extra.req then
                        self.ability.extra.should_trigger = true
                    end
                end
            end

            -- Apply Xmult
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.should_trigger then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { self.ability.extra.Xmult }
                        },
                        Xmult_mod = self.ability.extra.Xmult,
                        card = self
                    }
                end
            end
        end
    end

    if config.fishingLicenseJoker then
        -- Create Joker
        local fishing_license = {
            loc = {
                name = "Fishing License",
                text = {
                    "{C:attention}Copies{} effects of all",
                    "scored {C:attention}Enhanced{} cards",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Fishing License",
            slug = "mmc_fishing_license",
            ability = {},
            rarity = 3,
            cost = 8,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(fishing_license)

        -- Set local variables
        function SMODS.Jokers.j_mmc_fishing_license.loc_def(card)
            return {}
        end

        -- Calculate
        SMODS.Jokers.j_mmc_fishing_license.calculate = function(self, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card.ability.effect == "Bonus Card" or context.other_card.ability.effect ==
                    "Stone Card" then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_chips",
                            vars = { context.other_card.ability.bonus }
                        },
                        chips = context.other_card.ability.bonus,
                        card = self
                    }
                elseif context.other_card.ability.effect == "Mult Card" then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_mult",
                            vars = { context.other_card.ability.mult }
                        },
                        mult = context.other_card.ability.mult,
                        card = self
                    }
                elseif context.other_card.ability.effect == "Glass Card" then
                    return {
                        message = localize {
                            type = "variable",
                            key = "Xmult",
                            vars = { context.other_card.ability.Xmult }
                        },
                        Xmult = context.other_card.ability.Xmult,
                        card = self
                    }
                elseif context.other_card.ability.effect == "Lucky Card" then
                    if pseudorandom("lucky_money") < G.GAME.probabilities.normal / 15 then
                        ease_dollars(context.other_card.ability.p_dollars)
                        card_eval_status_text(self, "extra", nil, nil, nil, {
                            message = localize("$") .. context.other_card.ability.p_dollars,
                            dollars = context.other_card.ability.p_dollars,
                            colour = G.C.MONEY,
                            delay = 0.45
                        })
                    end
                    if pseudorandom("lucky_mult") < G.GAME.probabilities.normal / 5 then
                        return {
                            message = localize {
                                type = "variable",
                                key = "a_mult",
                                vars = { context.other_card.ability.mult }
                            },
                            mult = context.other_card.ability.mult,
                            card = self
                        }
                    end
                end
            end
        end
    end

    if config.goldBarJoker then
        -- Create Joker
        local gold_bar = {
            loc = {
                name = "Gold Bar",
                text = {
                    "Earn {C:money}$#1#{} for every",
                    "{C:attention}Gold Seal{} and {C:attention}Gold card{}",
                    "at end of round",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Gold Bar",
            slug = "mmc_gold_bar",
            ability = {
                extra = {
                    dollars = 2
                }
            },
            rarity = 1,
            cost = 5,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(gold_bar)

        -- Set local variables
        function SMODS.Jokers.j_mmc_gold_bar.loc_def(card)
            return { card.ability.extra.dollars }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_gold_bar.calculate = function(self, context)
            if context.end_of_round and not context.individual and not context.repetition then
                local gold_tally = 0
                -- Count all Gold Cards and Gold Seals
                for _, v in pairs(G.playing_cards) do
                    if v.ability.name == "Gold Card" then
                        gold_tally = gold_tally + 1
                    end
                    if v.seal == "Gold" then
                        gold_tally = gold_tally + 1
                    end
                end

                -- Give money and reset
                if gold_tally > 0 then
                    ease_dollars(gold_tally * self.ability.extra.dollars)
                    return {
                        message = localize("$") .. gold_tally * self.ability.extra.dollars,
                        dollars = gold_tally * self.ability.extra.dollars,
                        colour = G.C.MONEY
                    }
                end
            end
        end
    end

    if config.riggedJoker then
        -- Create Joker
        local rigged = {
            loc = {
                name = "Rigged Joker",
                text = {
                    "Once per hand, add {C:attention}+#1#{} to all",
                    "listed {C:green,E:1,S:1.1}probabilities{} whenever a",
                    "{C:attention}Lucky{} card does not trigger",
                    "Resets every round"
                }
            },
            ability_name = "MMC Rigged Joker",
            slug = "mmc_rigged",
            ability = {
                extra = {
                    probability = 0,
                    increase = 1,
                    has_triggered = false
                }
            },
            rarity = 1,
            cost = 5,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(rigged)

        -- Set local variables
        function SMODS.Jokers.j_mmc_rigged.loc_def(card)
            return { card.ability.extra.increase }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_rigged.calculate = function(self, context)
            -- Check if lucky card does not trigger
            if context.individual and context.cardarea == G.play and context.other_card.ability.effect == "Lucky Card" and
                not context.blueprint then
                if not context.other_card.lucky_trigger and not self.ability.extra.has_triggered then
                    self.ability.extra.has_triggered = true
                end
            end

            -- Increase probabilities and reset has_triggered
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.has_triggered then
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_mmc_luck"),
                        colour = G.C.GREEN
                    })
                    self.ability.extra.probability = self.ability.extra.probability + self.ability.extra.increase
                    for k, v in pairs(G.GAME.probabilities) do
                        G.GAME.probabilities[k] = v + self.ability.extra.increase
                    end
                end
                self.ability.extra.has_triggered = false
            end

            -- Reset probabilities
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.probability > 0 then
                    for k, v in pairs(G.GAME.probabilities) do
                        G.GAME.probabilities[k] = v - self.ability.extra.probability
                    end
                    self.ability.extra.probability = 0
                    -- Reset message
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_reset")
                    })
                end
            end
        end
    end

    if config.commanderJoker then
        -- Create Joker,
        local commander = {
            loc = {
                name = "The Commander",
                text = {
                    "If {C:attention}first hand{} of round",
                    "has only {C:attention}#1#{} card, give it a",
                    "random {C:attention}Enhancement{}, {C:attention}Seal",
                    "and {C:attention}Edition"
                }
            },
            ability_name = "MMC The Commander",
            slug = "mmc_commander",
            ability = { extra = { req = 1 } },
            rarity = 3,
            cost = 9,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(commander)

        -- Set local variables
        function SMODS.Jokers.j_mmc_commander.loc_def(card)
            return { card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_commander.calculate = function(self, context)
            -- Animate card
            if context.first_hand_drawn then
                local eval = function()
                    return G.GAME.current_round.hands_played == 0
                end
                juice_card_until(self, eval, true)
            end

            -- If first hand is single card, upgrade
            if G.GAME.current_round.hands_played == 0 then
                if context.before then
                    if #context.full_hand == self.ability.extra.req then
                        for _, card in ipairs(context.full_hand) do
                            -- Animate card
                            G.E_MANAGER:add_event(Event({
                                delay = 0.5,
                                func = function()
                                    card:juice_up(0.3, 0.5)
                                    -- Add seal and edition
                                    if card.ability.seal == nil then
                                        card:set_seal(pseudorandom_element(seals, pseudoseed("commander")), nil, true)
                                    end
                                    if card.edition == nil then
                                        local edition = poll_edition("commander", nil, true, true)
                                        card:set_edition(edition)
                                    end
                                    return true
                                end
                            }))

                            -- Add enhancement, outside of animate because this has a delay for some reason
                            if card.ability.effect == "Base" then
                                card:set_ability(pseudorandom_element(enhancements, pseudoseed("commander")), nil, true)
                            end

                            -- Return message
                            card_eval_status_text(self, "extra", nil, nil, nil, {
                                message = localize("k_upgrade_ex")
                            })
                        end
                    end
                end
            end
        end
    end

    if config.blueMoonJoker then
        -- Create Joker,
        local blue_moon = {
            loc = {
                name = "Blue Moon",
                text = {
                    "If {C:attention}#1# Lucky cards{} trigger",
                    "in one hand, create a",
                    "random {C:dark_edition}negative{} Joker",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Blue Moon",
            slug = "mmc_blue_moon",
            ability = {
                extra = {
                    req = 3,
                    lucky_tally = 0
                }
            },
            rarity = 2,
            cost = 8,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(blue_moon)

        -- Set local variables
        function SMODS.Jokers.j_mmc_blue_moon.loc_def(card)
            return { card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_blue_moon.calculate = function(self, context)
            -- Count lucky triggers
            if context.individual and context.cardarea == G.play and not context.blueprint then
                for _, v in ipairs(context.full_hand) do
                    if v.lucky_trigger then
                        self.ability.extra.lucky_tally = self.ability.extra.lucky_tally + 1
                    end
                end
            end

            -- Check for 5 lucky triggers
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.lucky_tally >= self.ability.extra.req then
                    -- Create new negative Joker
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "blue_moon")
                            card:set_edition({
                                negative = true
                            })
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            return true
                        end
                    }))
                    -- Return message
                    return {
                        message = localize("k_plus_joker"),
                        colour = G.C.BLUE
                    }
                else
                    -- Nope!
                    return {
                        message = localize("k_nope_ex"),
                        colour = G.C.SECONDARY_SET.Tarot
                    }
                end
            end

            -- Reset tally
            if context.after and not context.blueprint and context.cardarea == G.jokers then
                self.ability.extra.lucky_tally = 0
            end
        end
    end

    if config.dagonetJoker then
        -- Create Joker,
        local dagonet = {
            loc = {
                name = "Dagonet",
                text = {
                    "{C:attention}Doubles{} all base values",
                    "on other Jokers",
                    "{C:inactive}(If possible)"
                }
            },
            ability_name = "MMC Dagonet",
            slug = "mmc_dagonet",
            ability = {
                extra = {
                    _mult = 2,
                    _base = 2,
                    triggered = false
                }
            },
            rarity = 4,
            cost = 20,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true,
            soul_pos = { x = 1, y = 0 }
        }

        -- Initialize Joker
        init_joker(dagonet)

        -- Set local variables
        function SMODS.Jokers.j_mmc_dagonet.loc_def(card)
            return {}
        end

        -- Calculate
        SMODS.Jokers.j_mmc_dagonet.calculate = function(self, context)
            if not context.repetition or context.individual then
                -- Reset defaults
                local other_dagonet_trigger = false
                self.ability.extra.triggered = false

                -- Increase multiplier based on how many Dagonets there are
                self.ability.extra._mult = self.ability.extra._base
                for _, v in ipairs(find_joker("MMC Dagonet")) do
                    if v ~= self then
                        if v.ability.extra.triggered then
                            other_dagonet_trigger = true
                        end
                        self.ability.extra._mult = self.ability.extra._mult * 2
                    end
                end

                -- Loop over all jokers (excluding self)
                if not other_dagonet_trigger then
                    self.ability.extra.triggered = true
                    for _, v in ipairs(G.jokers.cards) do
                        if v ~= self and dagonet_blacklist[v.ability.name] == nil then
                            for k2, v2 in pairs(v.ability) do
                                -- Increase attributes
                                increase_attributes(k2, v2, v.ability, self.ability.extra._mult)
                            end
                        end
                    end
                end
            end
        end
    end

    if config.glueJoker then
        -- Create Joker,
        local glue = {
            loc = {
                name = "Glue",
                text = {
                    "If you have both {C:attention}Half",
                    "and {C:attention}Incomplete Joker{}, give",
                    "{C:dark_edition}+#2#{} Joker slots and {X:mult,C:white}X#1#{} Mult",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Glue",
            slug = "mmc_glue",
            ability = {
                extra = {
                    Xmult = 5,
                    j_slots = 2,
                    half = false,
                    incomplete = false,
                    triggered = false
                }
            },
            rarity = 1,
            cost = 5,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(glue)

        -- Set local variables
        function SMODS.Jokers.j_mmc_glue.loc_def(card)
            return { card.ability.extra.Xmult, card.ability.extra.j_slots }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_glue.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                -- Add xmult if we have both Half and Incomplete Joker
                if self.ability.extra.half and self.ability.extra.incomplete then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { self.ability.extra.Xmult }
                        },
                        Xmult_mod = self.ability.extra.Xmult
                    }
                end
            end
        end
    end

    if config.harpSealJoker then
        -- Create Joker,
        local harp_seal = {
            loc = {
                name = "Harp Seal",
                text = {
                    "{C:attention}Doubles{} the effect",
                    "of all {C:attention}Seals",
                    "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
                }
            },
            ability_name = "MMC Harp Seal",
            slug = "mmc_harp_seal",
            ability = {},
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(harp_seal)

        -- Set local variables
        function SMODS.Jokers.j_mmc_harp_seal.loc_def(card)
            return {}
        end

        -- Calculate
        SMODS.Jokers.j_mmc_harp_seal.calculate = function(self, context)
            -- Give $3 for each Gold Seal
            if context.individual and context.cardarea == G.play and not context.repetition then
                if context.other_card.seal == "Gold" and not context.other_card.debuff then
                    ease_dollars(3)
                    return {
                        message = localize("$") .. 3,
                        dollars = 3,
                        colour = G.C.MONEY,
                        card = self
                    }
                end
            end

            -- Repeat Red Seals
            if context.repetition and context.cardarea == G.play then
                if context.other_card.seal == "Red" and not context.other_card.debuff then
                    return {
                        message = localize("k_again_ex"),
                        repetitions = 1,
                        card = self
                    }
                end
            end
            if context.repetition and context.cardarea == G.hand then
                if context.other_card.seal == "Red" and (next(context.card_effects[1]) or #context.card_effects > 1) and not context.other_card.debuff then
                    return {
                        message = localize("k_again_ex"),
                        repetitions = 1,
                        card = self
                    }
                end
            end

            -- Create tarot card for each Purple Seal
            if context.discard then
                if context.other_card.seal == "Purple" and not context.other_card.debuff then
                    -- Check consumeable space
                    create_tarot(self, "harp_seal")
                end
            end
        end
    end

    if config.footballCardJoker then
        -- Create Joker,
        local football_card = {
            loc = {
                name = "Football Card",
                text = {
                    "{C:blue}Common{} Jokers",
                    "each give {C:chips}+#1#{} Chips"
                }
            },
            ability_name = "MMC Football Card",
            slug = "mmc_football_card",
            ability = {
                extra = {
                    chips = 50
                }
            },
            rarity = 2,
            cost = 7,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(football_card)

        -- Set local variables
        function SMODS.Jokers.j_mmc_football_card.loc_def(card)
            return { card.ability.extra.chips }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_football_card.calculate = function(self, context)
            if context.other_joker and context.other_joker ~= self then
                if context.other_joker.config.center.rarity == 1 then
                    -- Animate
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.other_joker:juice_up(0.5, 0.5)
                            return true
                        end
                    }))
                    -- Apply chips
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_chips",
                            vars = { self.ability.extra.chips }
                        },
                        chip_mod = self.ability.extra.chips
                    }
                end
            end
        end
    end

    if config.specialEditionJoker then
        -- Create Joker
        local special_edition = {
            loc = {
                name = "Special Edition Joker",
                text = {
                    "Gains {C:mult}+#2#{} Mult per {C:attention}Seal{}, {C:chips}+#4#{}",
                    "Chips per {C:attention}Enhancement{} and {X:mult,C:white}X#6#{} Mult",
                    "per {C:attention}Edition{} for every card in deck",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult, {C:chips}+#3#{C:inactive}, Chips and {X:mult,C:white}X#5#{C:inactive} Mult)"
                }
            },
            ability_name = "MMC Special Edition Joker",
            slug = "mmc_special_edition",
            ability = {
                extra = {
                    current_mult = 0,
                    mult_mod = 2,
                    current_chips = 0,
                    chip_mod = 10,
                    current_Xmult = 1,
                    Xmult_mod = 0.1,
                    base = 0
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(special_edition)

        -- Set local variables
        function SMODS.Jokers.j_mmc_special_edition.loc_def(card)
            return { card.ability.extra.current_mult, card.ability.extra.mult_mod, card.ability.extra.current_chips,
                card.ability.extra.chip_mod, card.ability.extra.current_Xmult, card.ability.extra.Xmult_mod }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_special_edition.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.current_mult > 0 or self.ability.extra.current_chips > 0 or
                    self.ability.extra.current_Xmult > 1 then
                    return {
                        -- Return bonus message and apply bonus
                        mult_mod = self.ability.extra.current_mult,
                        chip_mod = self.ability.extra.current_chips,
                        Xmult_mod = self.ability.extra.current_Xmult,
                        message = localize("k_mmc_bonus"),
                        card = self
                    }
                end
            end
        end
    end

    if config.stockpilerJoker then
        -- Create Joker
        local stockpiler = {
            loc = {
                name = "The Stockpiler",
                text = {
                    "{C:attention}+#2#{} hand size for every #4#",
                    "cards in deck above {C:attention}#3#{}",
                    "Caps at the current Ante",
                    "{C:inactive}(Currently {C:attention}+#1#{C:inactive} hand size)"
                }
            },
            ability_name = "MMC The Stockpiler",
            slug = "mmc_stockpiler",
            ability = {
                extra = {
                    current_h_size = 0,
                    h_mod = 1,
                    base = 52,
                    every = 4
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(stockpiler)

        -- Set local variables
        function SMODS.Jokers.j_mmc_stockpiler.loc_def(card)
            return { card.ability.extra.current_h_size, card.ability.extra.h_mod, card.ability.extra.base,
                card.ability.extra.every }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_stockpiler.calculate = function(self, context)
            if not context.repetition or context.individual then
                -- Increase hand size based on number of cards in deck
                local extra_cards = #G.playing_cards - self.ability.extra.base
                if extra_cards > 0 then
                    local bonus = math.floor(extra_cards / self.ability.extra.every) * self.ability.extra.h_mod
                    bonus = math.min(bonus, G.GAME.round_resets.ante)
                    if bonus ~= self.ability.extra.current_h_size then
                        G.hand:change_size(bonus - self.ability.extra.current_h_size)
                        self.ability.extra.current_h_size = bonus
                    end
                else
                    -- Reset hand size
                    if self.ability.extra.current_h_size > 0 then
                        G.hand:change_size(-self.ability.extra.current_h_size)
                        self.ability.extra.current_h_size = 0
                    end
                end
            end
        end
    end

    if config.studentLoansJoker then
        -- Create Joker
        local student_loans = {
            loc = {
                name = "Student Loans",
                text = {
                    "Go up to {C:red}-$#1#{} in debt",
                    "Gives -#4# {C:red}discard{}",
                    "for every {C:red}-$#2#{} in debt",
                    "{C:inactive}(Currently {C:attention}#3#{C:inactive} discards)"
                }
            },
            ability_name = "MMC Student Loans",
            slug = "mmc_student_loans",
            ability = {
                extra = {
                    negative_bal = 100,
                    every = 25,
                    discards = 0,
                    discard_sub = 1
                }
            },
            rarity = 2,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(student_loans)

        -- Set local variables
        function SMODS.Jokers.j_mmc_student_loans.loc_def(card)
            return { card.ability.extra.negative_bal, card.ability.extra.every, card.ability.extra.discards,
                card.ability.extra.discard_sub }
        end
    end

    if config.brokeJoker then
        -- Create Joker
        local broke = {
            loc = {
                name = "Broke Joker",
                text = {
                    "Gains {C:mult}+#1#{} Mult",
                    "per {C:red}-$#3#",
                    "{C:inactive}(Currently {C:mult}#2#{C:inactive} Mult)"
                }
            },
            ability_name = "MMC Broke Joker",
            slug = "mmc_broke",
            ability = {
                extra = {
                    current_mult = 0,
                    mult_mod = 1,
                    every = 2
                }
            },
            rarity = 1,
            cost = 2,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(broke)

        -- Set local variables
        function SMODS.Jokers.j_mmc_broke.loc_def(card)
            return { card.ability.extra.mult_mod, card.ability.extra.current_mult, card.ability.extra.every }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_broke.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                -- Apply mult
                if self.ability.extra.current_mult > 0 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_mult",
                            vars = { self.ability.extra.current_mult }
                        },
                        mult_mod = self.ability.extra.current_mult,
                        card = self
                    }
                end
            end
        end
    end

    if config.goForBrokeJoker then
        -- Create Joker
        local go_for_broke = {
            loc = {
                name = "Go For Broke",
                text = {
                    "Gains {C:chips}+#1#{} Chips",
                    "per {C:red}-$#3#",
                    "{C:inactive}(Currently {C:chips}#2#{C:inactive} Chips)"
                }
            },
            ability_name = "MMC Go For Broke",
            slug = "mmc_go_for_broke",
            ability = {
                extra = {
                    current_chips = 0,
                    every = 1,
                    chip_mod = 4
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(go_for_broke)

        -- Set local variables
        function SMODS.Jokers.j_mmc_go_for_broke.loc_def(card)
            return { card.ability.extra.chip_mod, card.ability.extra.current_chips, card.ability.extra.every }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_go_for_broke.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                -- Apply chips
                if self.ability.extra.current_chips > 0 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_chips",
                            vars = { self.ability.extra.current_chips }
                        },
                        chip_mod = self.ability.extra.current_chips,
                        card = self
                    }
                end
            end
        end
    end

    if config.streetFighterJoker then
        -- Create Joker
        local street_fighter = {
            loc = {
                name = "Street Fighter",
                text = {
                    "Gives {X:mult,C:white}X#1#{} Mult",
                    "when balance is",
                    "at or below {C:red}-$#2#"
                }
            },
            ability_name = "MMC Street Fighter",
            slug = "mmc_street_fighter",
            ability = {
                extra = {
                    Xmult = 4,
                    req = 20
                }
            },
            rarity = 2,
            cost = 7,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(street_fighter)

        -- Set local variables
        function SMODS.Jokers.j_mmc_street_fighter.loc_def(card)
            return { card.ability.extra.Xmult, card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_street_fighter.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                -- Apply xmult if balance is below negative requirement
                if G.GAME.dollars <= -1 * self.ability.extra.req then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { self.ability.extra.Xmult }
                        },
                        Xmult_mod = self.ability.extra.Xmult
                    }
                end
            end
        end
    end

    if config.checklistJoker then
        -- Create Joker
        local checklist = {
            loc = {
                name = "Checklist",
                text = {
                    "Playing {C:attention}#1#{} upgrades",
                    "it by #2# level,",
                    "poker hand changes",
                    "at end of round"
                }
            },
            ability_name = "MMC Checklist",
            slug = "mmc_checklist",
            ability = {
                extra = {
                    poker_hand = "High Card",
                    increase = 1
                }
            },
            rarity = 2,
            cost = 7,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(checklist)

        -- Set local variables
        function SMODS.Jokers.j_mmc_checklist.loc_def(card)
            return { localize(card.ability.extra.poker_hand, "poker_hands"), card.ability.extra.increase }
        end

        -- Set ability
        function SMODS.Jokers.j_mmc_checklist.set_ability(card, initial, delay_sprites)
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible then _poker_hands[#_poker_hands + 1] = k end
            end
            local old_hand = card.ability.extra.poker_hand
            card.ability.extra.poker_hand = nil
            while not card.ability.extra.poker_hand do
                card.ability.extra.poker_hand = pseudorandom_element(_poker_hands,
                    pseudoseed((card.area and card.area.config.type == "title") and "false_checklist" or "checklist"))
                if card.ability.extra.poker_hand == old_hand then card.ability.extra.poker_hand = nil end
            end
        end

        -- Calculate
        SMODS.Jokers.j_mmc_checklist.calculate = function(self, context)
            -- Level up poker hand
            if context.before and context.scoring_name == self.ability.extra.poker_hand then
                card_eval_status_text(self, "extra", nil, nil, nil, {
                    message = localize("k_upgrade_ex")
                })
                level_up_hand(self, context.scoring_name, false, self.ability.extra.increase)
            end

            -- Get new random poker hand at end of round
            if context.end_of_round and not context.individual and
                not context.repetition and not context.blueprint then
                local _poker_hands = {}
                for k, v in pairs(G.GAME.hands) do
                    if v.visible and k ~= self.ability.extra.poker_hand then _poker_hands[#_poker_hands + 1] = k end
                end
                self.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed("checklist"))
                return {
                    message = localize("k_reset")
                }
            end
        end
    end

    if config.oneOfUsJoker then
        -- Create Joker
        local one_of_us = {
            loc = {
                name = "One Of Us",
                text = {
                    "If played hand",
                    "contains {C:attention}#1# Enhanced cards,",
                    "give a random Joker",
                    "a random {C:attention}Edition"
                }
            },
            ability_name = "MMC One Of Us",
            slug = "mmc_one_of_us",
            ability = {
                extra = {
                    req = 5
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(one_of_us)

        -- Set local variables
        function SMODS.Jokers.j_mmc_one_of_us.loc_def(card)
            return { card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_one_of_us.calculate = function(self, context)
            if SMODS.end_calculate_context(context) and context.full_hand then
                -- Count enhanced cards
                local enhanced_tally = 0
                for _, v in ipairs(context.full_hand) do
                    if v.ability.set == "Enhanced" then
                        enhanced_tally = enhanced_tally + 1
                    end
                end

                -- Check for required enhanced cards
                if enhanced_tally >= self.ability.extra.req then
                    -- Get editionless Jokers
                    local editionless_jokers = {}
                    for _, v in pairs(G.jokers.cards) do
                        if v.ability.set == "Joker" and (not v.edition) then
                            table.insert(editionless_jokers, v)
                        end
                    end
                    -- Add edition to random Joker
                    if #editionless_jokers > 0 then
                        local joker = pseudorandom_element(editionless_jokers, pseudoseed("one_of_us"))
                        local edition = poll_edition("one_of_us", nil, false, true)
                        -- Animate card
                        G.E_MANAGER:add_event(Event({
                            delay = 0.5,
                            func = function()
                                joker:juice_up(0.3, 0.5)
                                joker:set_edition(edition, true)
                                return true
                            end
                        }))
                        -- Return message
                        return {
                            message = localize("k_upgrade_ex"),
                            colour = G.C.SECONDARY_SET.Tarot
                        }
                    end
                end
            end
        end
    end

    if config.investorJoker then
        -- Create Joker
        local investor = {
            loc = {
                name = "The Investor",
                text = {
                    "Gives {C:money}$#1#{} at end of",
                    "round. {C:green}#3# in #2#{} chance to",
                    "give {C:red}-$#1#{} instead"
                }
            },
            ability_name = "MMC The Investor",
            slug = "mmc_investor",
            ability = {
                extra = {
                    dollars = 5,
                    odds = 4
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(investor)

        -- Set local variables
        function SMODS.Jokers.j_mmc_investor.loc_def(card)
            return { card.ability.extra.dollars, card.ability.extra.odds,
                "" .. (G.GAME and G.GAME.probabilities.normal or 1) }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_investor.calculate = function(self, context)
            if context.end_of_round and not context.individual and not context.repetition then
                -- Give money between min and max
                local dollars = self.ability.extra.dollars
                if pseudorandom("investor") < G.GAME.probabilities.normal / self.ability.extra.odds then
                    dollars = dollars * -1
                end
                ease_dollars(dollars)
                -- Return message
                return {
                    message = localize("$") .. dollars,
                    dollars = dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end

    if config.mountainClimberJoker then
        -- Create Joker
        local mountain_climber = {
            loc = {
                name = "Mountain Climber",
                text = {
                    "Every played {C:attention}card{}",
                    "permanently gains",
                    "{C:mult}+#1#{} Mult when scored"
                }
            },
            ability_name = "MMC Mountain Climber",
            slug = "mmc_mountain_climber",
            ability = { extra = { mult = 1 } },
            rarity = 2,
            cost = 7,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(mountain_climber)

        -- Set local variables
        function SMODS.Jokers.j_mmc_mountain_climber.loc_def(card)
            return { card.ability.extra.mult }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_mountain_climber.calculate = function(self, context)
            if context.individual and context.cardarea == G.play then
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + self.ability.extra.mult
                card_eval_status_text(self, "extra", nil, nil, nil, {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.MULT,
                })
            end
        end
    end

    if config.shacklesJoker then
        -- Create Joker
        local shackles = {
            loc = {
                name = "Shackles",
                text = {
                    "{C:blue}+#1#{} hand, {C:red}+#2#{} discard,",
                    "{C:attention}+#3#{} hand size. Destroyed",
                    "if you play more than",
                    "{C:attention}#4#{} cards in one hand"
                }
            },
            ability_name = "MMC Shackles",
            slug = "mmc_shackles",
            ability = {
                extra = {
                    _hand_add = 1,
                    _h_size = 1,
                    _discards = 1,
                    req = 4
                }
            },
            rarity = 1,
            cost = 5,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(shackles)

        -- Set local variables
        function SMODS.Jokers.j_mmc_shackles.loc_def(card)
            return { card.ability.extra._hand_add, card.ability.extra._discards, card.ability.extra._h_size,
                card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_shackles.calculate = function(self, context)
            if SMODS.end_calculate_context(context) and context.full_hand then
                -- Destroy if more cards than required are played
                if #context.full_hand > self.ability.extra.req then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("tarot1")
                            self:start_dissolve()
                            return true
                        end
                    }))
                end
            end
        end
    end

    if config.buyOneGetOneJoker then
        -- Create Joker
        local buy_one_get_one = {
            loc = {
                name = "Buy One Get One",
                text = {
                    "{C:green}#2# in #1#{} chance to",
                    "get a random {C:attention}extra card{}",
                    "of whatever you're buying",
                    "{C:inactive}(Must have room)"
                }
            },
            ability_name = "MMC Buy One Get One",
            slug = "mmc_buy_one_get_one",
            ability = {
                extra = {
                    odds = 4
                }
            },
            rarity = 1,
            cost = 5,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(buy_one_get_one)

        -- Set local variables
        function SMODS.Jokers.j_mmc_buy_one_get_one.loc_def(card)
            return { card.ability.extra.odds, "" .. (G.GAME and G.GAME.probabilities.normal or 1) }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_buy_one_get_one.calculate = function(self, context)
            if context.buying_card then
                -- Calculate odds
                if pseudorandom("buy_one_get_one") < G.GAME.probabilities.normal / self.ability.extra.odds then
                    if context.card.ability.set == "Joker" then
                        -- Give extra Joker
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if #G.jokers.cards < G.jokers.config.card_limit then
                                    local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil,
                                        "buy_one_get_one")
                                    card:add_to_deck()
                                    G.jokers:emplace(card)
                                    card:start_materialize()
                                    card_eval_status_text(self, "extra", nil, nil, nil, {
                                        message = localize("k_plus_joker"),
                                        colour = G.C.BLUE
                                    })
                                else
                                    card_eval_status_text(self, "extra", nil, nil, nil, {
                                        message = localize("k_no_space_ex")
                                    })
                                end
                                return true
                            end
                        }))
                    elseif context.card.ability.set == "Tarot" then
                        -- Give extra Tarot card
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if G.consumeables.config.card_limit > #G.consumeables.cards then
                                    play_sound("timpani")
                                    local card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, nil,
                                        "buy_one_get_one")
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    card_eval_status_text(self, "extra", nil, nil, nil, {
                                        message = localize("k_plus_tarot"),
                                        colour = G.C.SECONDARY_SET.Tarot
                                    })
                                else
                                    card_eval_status_text(self, "extra", nil, nil, nil, {
                                        message = localize("k_no_space_ex")
                                    })
                                end
                                return true
                            end
                        }))
                    elseif context.card.ability.set == "Spectral" then
                        -- Give extra Spectral card
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if G.consumeables.config.card_limit > #G.consumeables.cards then
                                    play_sound("timpani")
                                    local card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil,
                                        "buy_one_get_one")
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    card_eval_status_text(self, "extra", nil, nil, nil, {
                                        message = localize("k_plus_spectral"),
                                        colour = G.C.SECONDARY_SET.Spectral
                                    })
                                else
                                    card_eval_status_text(self, "extra", nil, nil, nil, {
                                        message = localize("k_no_space_ex")
                                    })
                                end
                                return true
                            end
                        }))
                    elseif context.card.ability.set == "Planet" then
                        G.E_MANAGER:add_event(Event({
                            -- Give extra Planet card
                            func = (function()
                                if G.consumeables.config.card_limit > #G.consumeables.cards then
                                    local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, nil,
                                        "buy_one_get_one")
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    card_eval_status_text(self, "extra", nil, nil, nil, {
                                        message = localize("k_plus_planet"),
                                        colour = G.C.SECONDARY_SET.Planet
                                    })
                                else
                                    card_eval_status_text(self, "extra", nil, nil, nil, {
                                        message = localize("k_no_space_ex")
                                    })
                                end
                                return true
                            end)
                        }))
                    elseif context.card.ability.set == "Default" then
                        -- Give extra Playing Card
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local _card = create_playing_card({
                                    front = pseudorandom_element(G.P_CARDS, pseudoseed("buy_one_get_one")),
                                    center = G.P_CENTERS.c_base
                                }, G.deck, nil, nil, { G.C.SECONDARY_SET.Enhanced })
                                _card:add_to_deck()
                                G.deck.config.card_limit = G.deck.config.card_limit + 1
                                card_eval_status_text(self, "extra", nil, nil, nil, {
                                    message = localize("k_mmc_plus_card"),
                                    colour = G.C.Blue
                                })
                                return true
                            end
                        }))
                    end
                else
                    -- Nope!
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_nope_ex"),
                        colour = G.C.SECONDARY_SET.Tarot
                    })
                end
            end
        end
    end

    if config.packAPunchJoker then
        -- Create Joker
        local pack_a_punch = {
            loc = {
                name = "Pack A Punch",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "lose {C:money}$#1#{} and give the",
                    "{C:attention}left-most{} Joker",
                    "a random {C:attention}Edition",
                    "{C:inactive}(Will replace current edition)"
                }
            },
            ability_name = "MMC Pack A Punch",
            slug = "mmc_pack_a_punch",
            ability = {
                extra = {
                    dollars = 20
                }
            },
            rarity = 3,
            cost = 10,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(pack_a_punch)

        -- Set local variables
        function SMODS.Jokers.j_mmc_pack_a_punch.loc_def(card)
            return { card.ability.extra.dollars }
        end

        -- -- Calculate
        SMODS.Jokers.j_mmc_pack_a_punch.calculate = function(self, context)
            if context.setting_blind and not self.getting_sliced then
                local joker = G.jokers.cards[1]
                if joker then
                    ease_dollars(-self.ability.extra.dollars)
                    local edition = poll_edition("pack_a_punch", nil, false, true)
                    -- Animate card
                    G.E_MANAGER:add_event(Event({
                        delay = 0.5,
                        func = function()
                            -- Set Joker edition
                            joker:juice_up(0.3, 0.5)
                            if joker.edition and joker.edition.negative then
                                G.jokers.config.card_limit = G.jokers.config.card_limit - 1
                            end
                            joker:set_edition(edition, true)
                            -- Show message
                            card_eval_status_text(self, "extra", nil, nil, nil, {
                                message = localize("k_upgrade_ex")
                            })
                            -- Delete self if over Joker limit
                            if G.jokers.config.card_limit < #G.jokers.cards then
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        play_sound("tarot1")
                                        self:start_dissolve()
                                        return true
                                    end
                                }))
                            end
                            return true
                        end
                    }))
                    -- Return message
                    return {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.SECONDARY_SET.Tarot
                    }
                end
            end
        end
    end

    if config.sealStealJoker then
        -- Create Joker
        local seal_steal = {
            loc = {
                name = "Seal Steal",
                text = {
                    "Played {C:purple}Purple{} and",
                    "{C:blue}Blue{} Seals trigger",
                    "when {C:attention}scored"
                }
            },
            ability_name = "MMC Seal Steal",
            slug = "mmc_seal_steal",
            ability = {},
            rarity = 1,
            cost = 5,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(seal_steal)

        -- Set local variables
        function SMODS.Jokers.j_mmc_seal_steal.loc_def(card)
            return {}
        end

        -- Calculate
        SMODS.Jokers.j_mmc_seal_steal.calculate = function(self, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card.seal == "Purple" and not context.other_card.debuff then
                    -- Check for Harp Seal
                    local harp_seal
                    for _, v in ipairs(find_joker("MMC Harp Seal")) do
                        harp_seal = v
                        break
                    end
                    create_tarot(self, "seal_steal")

                    -- Repeat for Harp Seal
                    if harp_seal then
                        -- Show Harp Seal message
                        card_eval_status_text(harp_seal, "extra", nil, nil, nil, {
                            message = localize("k_again_ex")
                        })
                        create_tarot(self, "seal_steal")
                    end
                elseif context.other_card.seal == "Blue" and not context.other_card.debuff then
                    -- Check for Harp Seal and Aurora Borealis
                    local harp_seal
                    local aurora_borealis
                    for _, v in ipairs(G.jokers.cards) do
                        if v.ability.name == "MMC Harp Seal" then
                            harp_seal = v
                        elseif v.ability.name == "MMC Aurora Borealis" then
                            aurora_borealis = v
                        end
                    end

                    -- Add card
                    create_planet(self, "seal_steal")
                    if aurora_borealis then
                        create_planet(aurora_borealis, "seal_steal", { negative = true }, self)
                    end

                    -- Repeat for harp seal
                    if harp_seal then
                        -- Show Harp Seal message
                        card_eval_status_text(harp_seal, "extra", nil, nil, nil, {
                            message = localize("k_again_ex")
                        })

                        -- Add card
                        create_planet(self, "seal_steal")
                        if aurora_borealis then
                            create_planet(aurora_borealis, "seal_steal", { negative = true }, self)
                        end
                    end
                end
            end
        end
    end

    if config.taxCollectorJoker then
        -- Create Joker
        local tax_collector = {
            loc = {
                name = "Tax Collector",
                text = {
                    "Gives {C:green}$#1#{}, {C:red}$#2#{} or {C:legendary}$#3#",
                    "per Joker with the",
                    "respective {C:attention}rarity",
                    "at end of round"
                }
            },
            ability_name = "MMC Tax Collector",
            slug = "mmc_tax_collector",
            ability = {
                extra = {
                    dollars = 1
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(tax_collector)

        -- Set local variables
        function SMODS.Jokers.j_mmc_tax_collector.loc_def(card)
            return { card.ability.extra.dollars, card.ability.extra.dollars * 2, card.ability.extra.dollars * 4 }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_tax_collector.calculate = function(self, context)
            if context.end_of_round and not context.individual and not context.repetition then
                for _, v in ipairs(G.jokers.cards) do
                    -- Give dollars for every Joker, based on their rarity
                    if v ~= self and v.config.center.rarity > 1 then
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.7,
                            func = (function()
                                -- Give dollars
                                local dollars = self.ability.extra.dollars * (v.config.center.rarity - 1)
                                if v.config.center.rarity == 4 then
                                    dollars = dollars + 1
                                end
                                ease_dollars(dollars, true)

                                -- Show message
                                card_eval_status_text(v, "extra", nil, nil, nil, {
                                    message = localize("$") .. dollars,
                                    dollars = dollars,
                                    colour = G.C.MONEY,
                                    instant = true
                                })

                                -- Animate cards
                                if v ~= self then
                                    v:juice_up(0.5, 0.5)
                                end
                                self:juice_up(0.5, 0.5)
                                return true
                            end)
                        }))
                    end
                end
            end
        end
    end

    if config.glassCannonJoker then
        -- Create Joker
        local glass_cannon = {
            loc = {
                name = "Glass Cannon",
                text = {
                    "{C:attention}Retrigger{} all {C:attention}Glass",
                    "{C:attention}Cards{}, but they are",
                    "{C:red}guaranteed{} to break"
                }
            },
            ability_name = "MMC Glass Cannon",
            slug = "mmc_glass_cannon",
            ability = {
                extra = {
                    repetitions = 1,
                    trash_list = {}
                }
            },
            rarity = 2,
            cost = 7,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(glass_cannon)

        -- Set local variables
        function SMODS.Jokers.j_mmc_glass_cannon.loc_def(card)
            return {}
        end

        -- Calculate
        SMODS.Jokers.j_mmc_glass_cannon.calculate = function(self, context)
            -- Retrigger glass cards
            if context.repetition and context.cardarea == G.play then
                if context.other_card.ability.effect == "Glass Card" then
                    return {
                        message = localize("k_again_ex"),
                        repetitions = self.ability.extra.repetitions,
                        card = self
                    }
                end
            end

            -- Mark played glass cards
            if context.individual and context.cardarea == G.play and not context.repetition then
                if context.other_card.ability.effect == "Glass Card" then
                    context.other_card.played = true
                end
            end

            -- Destroy played glass cards
            if SMODS.end_calculate_context(context) and context.full_hand then
                for _, v in ipairs(context.full_hand) do
                    if v.played then
                        G.E_MANAGER:add_event(Event({
                            trigger = "before",
                            delay = 0.9,
                            func = (function()
                                card_eval_status_text(self, "extra", nil, nil, nil, {
                                    message = localize("k_mmc_destroy"),
                                    colour = G.C.RED,
                                    instant = true
                                })
                                table.insert(self.ability.extra.trash_list, v)
                                v:shatter()
                                return true
                            end)
                        }))
                    end
                end
            end

            -- Clean up trash
            if context.end_of_round and not context.individual and not context.repetition then
                for _, v in ipairs(self.ability.extra.trash_list) do
                    v:start_dissolve(nil, true, 0, true)
                end
                self.ability.extra.trash_list = {}
            end
        end
    end

    if config.scoringTestJoker then
        -- Create Joker
        local scoring_test = {
            loc = {
                name = "Scoring Test",
                text = {
                    "If played hand",
                    "scores less than {C:attention}#1#%",
                    "of blind requirement",
                    "{C:red}destroy{} it"
                }
            },
            ability_name = "MMC Scoring Test",
            slug = "mmc_scoring_test",
            ability = {
                extra = {
                    percentage = 1,
                    played_hand = {},
                    trash_list = {}
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(scoring_test)

        -- Set local variables
        function SMODS.Jokers.j_mmc_scoring_test.loc_def(card)
            return { card.ability.extra.percentage }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_scoring_test.calculate = function(self, context)
            if SMODS.end_calculate_context(context) and context.full_hand then
                -- Get played hand
                self.ability.extra.played_hand = {}
                for _, v in ipairs(context.full_hand) do
                    table.insert(self.ability.extra.played_hand, v)
                end
            end

            if context.mmc_scored_chips then
                if context.mmc_scored_chips < G.GAME.blind.chips * self.ability.extra.percentage / 100 then
                    -- Destroy played hand if it's less than 1% of blind requirement
                    for _, v in ipairs(self.ability.extra.played_hand) do
                        G.E_MANAGER:add_event(Event({
                            trigger = "before",
                            delay = 0.9,
                            func = (function()
                                card_eval_status_text(self, "extra", nil, nil, nil, {
                                    message = localize("k_mmc_destroy"),
                                    colour = G.C.RED,
                                    instant = true
                                })
                                table.insert(self.ability.extra.trash_list, v)
                                v:start_dissolve()
                                return true
                            end)
                        }))
                    end
                end
            end

            -- Clean up trash
            if context.end_of_round and not context.individual and not context.repetition then
                for _, v in ipairs(self.ability.extra.trash_list) do
                    v:start_dissolve(nil, true, 0, true)
                end
                self.ability.extra.trash_list = {}
            end
        end
    end

    if config.ciceroJoker then
        -- Create Joker
        local cicero = {
            loc = {
                name = "Cicero",
                text = {
                    "Jokers that do not",
                    "give {C:mult}Mult{}, {C:chips}Chips{} or",
                    "{C:attention}retriggers{} will be",
                    "{C:dark_edition}negative{} in the shop"
                }
            },
            ability_name = "MMC Cicero",
            slug = "mmc_cicero",
            ability = {},
            rarity = 4,
            cost = 20,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true,
            soul_pos = { x = 1, y = 0 }
        }

        -- Initialize Joker
        init_joker(cicero)

        -- Set local variables
        function SMODS.Jokers.j_mmc_cicero.loc_def(card)
            return {}
        end
    end

    if config.dawnJoker then
        -- Create Joker
        local dawn = {
            loc = {
                name = "Dawn",
                text = {
                    "Retrigger all played",
                    "cards in {C:attention}first",
                    "{C:attention}hand{} of round"
                }
            },
            ability_name = "MMC Dawn",
            slug = "mmc_dawn",
            ability = { extra = { repetitions = 1 } },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(dawn)

        -- Set local variables
        function SMODS.Jokers.j_mmc_dawn.loc_def(card)
            return {}
        end

        -- Calculate
        SMODS.Jokers.j_mmc_dawn.calculate = function(self, context)
            -- Retrigger first hand
            if context.repetition and context.cardarea == G.play then
                if context.other_card and G.GAME.current_round.hands_played == 0 then
                    return {
                        message = localize("k_again_ex"),
                        repetitions = self.ability.extra.repetitions,
                        card = self
                    }
                end
            end
        end
    end

    if config.savingsJoker then
        -- Create Joker
        local savings = {
            loc = {
                name = "Savings",
                text = {
                    "{C:mult}+#1#{} Mult per round",
                    "Resets when",
                    "buying a {C:attention}card",
                    "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
                }
            },
            ability_name = "MMC Savings",
            slug = "mmc_savings",
            ability = {
                extra = {
                    mult_mod = 5,
                    current_mult = 0
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(savings)

        -- Set local variables
        function SMODS.Jokers.j_mmc_savings.loc_def(card)
            return { card.ability.extra.mult_mod, card.ability.extra.current_mult }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_savings.calculate = function(self, context)
            -- Reset mult on purchase
            if context.buying_card and not context.blueprint then
                if self.ability.extra.current_mult ~= 0 then
                    self.ability.extra.current_mult = 0
                    -- Reset message
                    card_eval_status_text(self, "extra", nil, nil, nil, {
                        message = localize("k_reset")
                    })
                end
            end

            -- Apply mult
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.current_mult > 0 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_mult",
                            vars = { self.ability.extra.current_mult }
                        },
                        mult_mod = self.ability.extra.current_mult,
                        card = self
                    }
                end
            end

            -- Increase mult
            if context.end_of_round and not context.individual and
                not context.repetition and not context.blueprint then
                self.ability.extra.current_mult = self.ability.extra.current_mult + self.ability.extra.mult_mod
                return {
                    message = localize {
                        type = "variable",
                        key = "a_mult",
                        vars = { self.ability.extra.mult_mod }
                    },
                    colour = G.C.RED,
                    card = self
                }
            end
        end
    end

    if config.monopolistJoker then
        -- Create Joker
        local monopolist = {
            loc = {
                name = "Monopolist",
                text = {
                    "{X:mult,C:white}X#1#{} Mult, gains",
                    "{X:mult,C:white}X#2#{} Mult at {C:money}$#3#{},",
                    "requirement doubles",
                    "when met"
                }
            },
            ability_name = "MMC Monopolist",
            slug = "mmc_monopolist",
            ability = {
                extra = {
                    current_Xmult = 1,
                    _Xmult_mod = 0.5,
                    _req = 10,
                    _base = 10,
                }
            },
            rarity = 3,
            cost = 10,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(monopolist)

        -- Set local variables
        function SMODS.Jokers.j_mmc_monopolist.loc_def(card)
            return { card.ability.extra.current_Xmult, card.ability.extra._Xmult_mod, card.ability.extra._req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_monopolist.calculate = function(self, context)
            -- Apply xmult
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.current_Xmult > 1 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { self.ability.extra.current_Xmult }
                        },
                        Xmult_mod = self.ability.extra.current_Xmult,
                        card = self
                    }
                end
            end
        end
    end

    if config.nebulaJoker then
        -- Create Joker
        local nebula = {
            loc = {
                name = "Nebula",
                text = {
                    "Adds all {C:attention}poker",
                    "{C:attention}hand{} levels above",
                    "#1# to {C:mult}Mult"
                }
            },
            ability_name = "MMC Nebula",
            slug = "mmc_nebula",
            ability = { extra = { req = 1 } },
            rarity = 1,
            cost = 5,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(nebula)

        -- Set local variables
        function SMODS.Jokers.j_mmc_nebula.loc_def(card)
            return { card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_nebula.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                -- Get level of all hands
                local _tally = 0
                for _, v in ipairs(G.handlist) do
                    if G.GAME.hands[v].visible and G.GAME.hands[v].level > self.ability.extra.req then
                        _tally = _tally + G.GAME.hands[v].level - self.ability.extra.req
                    end
                end
                -- Apply mult
                if _tally > 0 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_mult",
                            vars = { _tally }
                        },
                        mult_mod = _tally,
                        card = self
                    }
                end
            end
        end
    end

    if config.cheapskateJoker then
        -- Create Joker
        local cheapskate = {
            loc = {
                name = "Cheapskate",
                text = {
                    "If a {C:attention}Booster Pack",
                    "is skipped, earn",
                    "half of it's {C:money}cost"
                }
            },
            ability_name = "MMC Cheapskate",
            slug = "mmc_cheapskate",
            ability = {
                extra = {
                    cost = 0
                }
            },
            rarity = 1,
            cost = 4,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(cheapskate)

        -- Set local variables
        function SMODS.Jokers.j_mmc_cheapskate.loc_def(card)
            return {}
        end

        -- Calculate
        SMODS.Jokers.j_mmc_cheapskate.calculate = function(self, context)
            if context.open_booster then
                self.ability.extra.cost = math.floor(context.card.cost / 2)
            end

            if context.skipping_booster then
                ease_dollars(self.ability.extra.cost)
                card_eval_status_text(self, "extra", nil, nil, nil, {
                    message = localize("$") .. self.ability.extra.cost,
                    dollars = self.ability.extra.cost,
                    colour = G.C.MONEY
                })
            end
        end
    end

    if config.psychicJoker then
        -- Create Joker
        local psychic = {
            loc = {
                name = "Psychic Joker",
                text = {
                    "{C:chips}+#1#{} Chips, destroyed",
                    "if you play less",
                    "than {C:attention}#2#{} cards",
                    "in one hand"
                }
            },
            ability_name = "MMC Psychic Joker",
            slug = "mmc_psychic",
            ability = {
                extra = {
                    chips = 150,
                    req = 5
                }
            },
            rarity = 1,
            cost = 5,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(psychic)

        -- Set local variables
        function SMODS.Jokers.j_mmc_psychic.loc_def(card)
            return { card.ability.extra.chips, card.ability.extra.req }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_psychic.calculate = function(self, context)
            if SMODS.end_calculate_context(context) and context.full_hand then
                -- Destroy if less cards than required are played
                if #context.full_hand < self.ability.extra.req then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound("tarot1")
                            self:start_dissolve()
                            return true
                        end
                    }))
                else
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_chips",
                            vars = { self.ability.extra.chips }
                        },
                        chip_mod = self.ability.extra.chips
                    }
                end
            end
        end
    end

    if config.cheatJoker then
        -- Create Joker
        local cheat = {
            loc = {
                name = "Cheat",
                text = {
                    "Retrigger all cards",
                    "if played hand",
                    "contains a {C:attention}Straight{}",
                }
            },
            ability_name = "MMC Cheat",
            slug = "mmc_cheat",
            ability = {
                extra = {
                    repetitions = 1
                }
            },
            rarity = 2,
            cost = 6,
            unlocked = true,
            discovered = true,
            blueprint_compat = true,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(cheat)

        -- Set local variables
        function SMODS.Jokers.j_mmc_cheat.loc_def(card)
            return {}
        end

        -- Calculate
        SMODS.Jokers.j_mmc_cheat.calculate = function(self, context)
            -- Retrigger hand if it contains a straight
            if context.repetition and context.cardarea == G.play then
                if context.other_card and context.poker_hands and next(context.poker_hands["Straight"]) then
                    return {
                        message = localize("k_again_ex"),
                        repetitions = self.ability.extra.repetitions,
                        card = self
                    }
                end
            end
        end
    end

    if config.plusOneJoker then
        -- Create Joker
        local plus_one = {
            loc = {
                name = "Plus One",
                text = {
                    "Increases rank",
                    "of scored cards by",
                    "{C:attention}#1#{} on the {C:attention}first",
                    "{C:attention}hand{} of round"
                }
            },
            ability_name = "MMC Plus One",
            slug = "mmc_plus_one",
            ability = {
                extra = {
                    increase = 1
                }
            },
            rarity = 3,
            cost = 8,
            unlocked = true,
            discovered = true,
            blueprint_compat = false,
            eternal_compat = true
        }

        -- Initialize Joker
        init_joker(plus_one)

        -- Set local variables
        function SMODS.Jokers.j_mmc_plus_one.loc_def(card)
            return { card.ability.extra.increase }
        end

        -- Calculate
        SMODS.Jokers.j_mmc_plus_one.calculate = function(self, context)
            -- Upgrade ranks of first hand
            if context.individual and context.cardarea == G.play then
                if G.GAME.current_round.hands_played == 0 then
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.0,
                        func = (function()
                            -- Increase rank
                            local card = context.other_card
                            local suit_prefix = string.sub(card.base.suit, 1, 1) .. "_"
                            local rank_suffix = card.base.id == 14 and 2 or math.min(card.base.id + 1, 14)
                            if rank_suffix < 10 then
                                rank_suffix = tostring(rank_suffix)
                            elseif rank_suffix == 10 then
                                rank_suffix = "T"
                            elseif rank_suffix == 11 then
                                rank_suffix = "J"
                            elseif rank_suffix == 12 then
                                rank_suffix = "Q"
                            elseif rank_suffix == 13 then
                                rank_suffix = "K"
                            elseif rank_suffix == 14 then
                                rank_suffix = "A"
                            end
                            card:set_base(G.P_CARDS[suit_prefix .. rank_suffix])
                            -- Show message
                            card_eval_status_text(self, "extra", nil, nil, nil, {
                                message = localize("k_upgrade_ex"),
                                instant = true
                            })
                            return true
                        end)
                    }))
                end
            end
        end
    end
end

-- Stretch card back of odd shaped Jokers
local flip_ref = Card.flip
function Card:flip()
    local scale = 1
    local H = G.CARD_H
    local W = G.CARD_W

    if self.ability.name == "MMC Historical Joker" then
        if self.facing == "front" then
            self.T.h = H * scale
            self.T.w = W * scale / 1.5 * scale
        else
            self.T.h = H * scale
            self.T.w = W * scale
        end
    end

    flip_ref(self)
end

-- Center odd shaped Jokers
local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self, _center, _front)

    local X, Y, W, H = self.T.x, self.T.y, self.T.w, self.T.h

    if _center then
        if _center.set then
            if _center.name == "MMC Incomplete Joker" and (_center.discovered or self.bypass_discovery_center) then
                self.children.center.scale.y = self.children.center.scale.y / 1.7
                H = H / 1.7
                self.T.h = H
            end
        end
    end
end

-- Handle card addition/removing
local add_to_deckref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    if not self.added_to_deck then
        if self.ability.name == "MMC Straight Nate" then
            -- Add Joker slot
            G.jokers.config.card_limit = G.jokers.config.card_limit + self.ability.extra.j_slots
        end

        if G.GAME.starting_params.mmc_for_hire and self.ability.set == "Joker" then
            -- Add Joker slot and increment counter
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            for_hire_counter = for_hire_counter + 1
        end

        if self.ability.name == "Half Joker" then
            -- Check for Glue Joker
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == "MMC Glue" then
                    -- Update Glue variables
                    v.ability.extra.half = true
                    if v.ability.extra.incomplete then
                        v.ability.extra.triggered = true
                        G.jokers.config.card_limit = G.jokers.config.card_limit + v.ability.extra.j_slots
                    end
                end
            end
        end

        if self.ability.name == "MMC Incomplete Joker" then
            -- Check for Glue  Joker
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == "MMC Glue" then
                    -- Update Glue variables
                    v.ability.extra.incomplete = true
                    if v.ability.extra.half then
                        v.ability.extra.triggered = true
                        G.jokers.config.card_limit = G.jokers.config.card_limit + v.ability.extra.j_slots
                    end
                end
            end
        end

        if self.ability.name == "MMC Glue" then
            -- Check for Half and Incomplete Jokers
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == "Half Joker" then
                    self.ability.extra.half = true
                end
                if v.ability.name == "MMC Incomplete Joker" then
                    self.ability.extra.incomplete = true
                end
            end
            -- Update Glue Variables
            if self.ability.extra.half and self.ability.extra.incomplete then
                self.ability.extra.triggered = true
                G.jokers.config.card_limit = G.jokers.config.card_limit + self.ability.extra.j_slots
            end
        end

        if self.ability.name == "MMC Student Loans" then
            -- Lower bankrupt limit and discards
            G.GAME.bankrupt_at = G.GAME.bankrupt_at - self.ability.extra.negative_bal
        end

        if self.ability.name == "MMC Shackles" then
            -- Add hands, discards and hand size
            ease_hands_played(self.ability.extra._hand_add)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + self.ability.extra._hand_add
            ease_discard(self.ability.extra._discards)
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + self.ability.extra._discards
            G.hand:change_size(self.ability.extra._h_size)
        end
    end

    add_to_deckref(self, from_debuff)
end

local remove_from_deckref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    if self.added_to_deck then
        if self.ability.name == "MMC Straight Nate" then
            -- Remove Joker slot
            G.jokers.config.card_limit = G.jokers.config.card_limit - self.ability.extra.j_slots
        end

        if G.GAME.starting_params.mmc_for_hire and self.ability.set == "Joker" then
            -- Remove Joker slot and decrement counter
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
            for_hire_counter = for_hire_counter - 1
        end

        if self.ability.name == "MMC The Fisherman" then
            -- Reset hand size
            if self.ability.extra.current_h_size ~= 0 then
                G.hand:change_size(-self.ability.extra.current_h_size)
                self.ability.extra.current_h_size = 0
            end
        end

        if self.ability.name == "MMC Rigged Joker" then
            -- Reset probabilities
            if self.ability.extra.probability > 0 then
                for k, v in pairs(G.GAME.probabilities) do
                    G.GAME.probabilities[k] = v - self.ability.extra.probability
                end
                self.ability.extra.probability = 0
            end
        end

        if self.ability.name == "MMC Dagonet" then
            -- Return attributes to defaults
            for _, v in ipairs(G.jokers.cards) do
                if v ~= self then
                    if v.ability.name == 'MMC Dagonet' and v.ability.extra._mult ~= 2 then
                        v.ability.extra._mult = v.ability.extra._mult / 2
                    end
                    for k2, v2 in pairs(v.ability) do
                        increase_attributes(k2, v2, v.ability, self.ability.extra._mult / 2)
                    end
                end
            end
        end

        if self.ability.name == "Half Joker" then
            -- Check for Glue Joker
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == "MMC Glue" then
                    -- Reset Glue variables
                    v.ability.extra.half = false
                    if v.ability.extra.triggered then
                        v.ability.extra.triggered = false
                        G.jokers.config.card_limit = G.jokers.config.card_limit - v.ability.extra.j_slots
                    end
                end
            end
        end

        if self.ability.name == "MMC Incomplete Joker" then
            -- Check for Glue Joker
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == "MMC Glue" then
                    -- Reset Glue variables
                    v.ability.extra.incomplete = false
                    if v.ability.extra.triggered then
                        v.ability.extra.triggered = false
                        G.jokers.config.card_limit = G.jokers.config.card_limit - v.ability.extra.j_slots
                    end
                end
            end
        end

        if self.ability.name == "MMC Glue" then
            -- Reset Glue variables
            if self.ability.extra.triggered then
                self.ability.extra.triggered = false
                G.jokers.config.card_limit = G.jokers.config.card_limit - self.ability.extra.j_slots
            end
        end

        if self.ability.name == "MMC The Stockpiler" then
            -- Reset hand size
            G.hand:change_size(-self.ability.extra.current_h_size)
        end

        if self.ability.name == "MMC Student Loans" then
            -- Reset bankrupt limit and discards
            G.GAME.bankrupt_at = G.GAME.bankrupt_at + self.ability.extra.negative_bal
            ease_discard(-self.ability.extra.discards)
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - self.ability.extra.discards
        end

        if self.ability.name == "MMC Shackles" then
            -- Remove hands, discards and hand size
            ease_hands_played(-self.ability.extra._hand_add)
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - self.ability.extra._hand_add
            ease_discard(-self.ability.extra._discards)
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - self.ability.extra._discards
            G.hand:change_size(-self.ability.extra._h_size)
        end
    end

    remove_from_deckref(self, from_debuff)
end

-- Handle cost increase
local set_costref = Card.set_cost
function Card.set_cost(self)
    set_costref(self)

    if self.ability.name == "MMC Eye Chart" and not self.added_to_deck then
        -- Generate new letter
        self.ability.extra.letter = string.upper(pseudorandom_element(letters, pseudoseed("eye_chart")))
    end

    if G.GAME.starting_params.mmc_for_hire and
        (self.ability.set == "Joker" or string.find(self.ability.name, "Buffoon")) then
        -- Multiply cost linearly with counter
        self.cost = self.cost * for_hire_counter

        if self.ability.name == "Riff-raff" then
            -- No fun allowed
            self.cost = 1000000000
        end
    end
end

-- Set card edition
local set_edition_ref = Card.set_edition
function Card.set_edition(self, edition, immediate, silent)
    set_edition_ref(self, edition, immediate, silent)
    if G.jokers then
        if not self.added_to_deck and self.ability.set == "Joker" and (self.edition == nil or not edition.negative) then
            if next(find_joker("MMC Cicero")) then
                local support = true
                for _, v in ipairs(G.localization.descriptions.Joker[self.config.center.key].text) do
                    support = support and
                        not (string.find(v:lower(), "mult") or string.find(v:lower(), "chips") or string.find(v:lower(), "retrigger"))
                end
                if (support and cicero_blacklist[self.ability.name] == nil) or cicero_whitelist[self.ability.name] ~= nil then
                    self:set_edition({ negative = true })
                end
            end
        end
    end
end

-- Card updates
local card_updateref = Card.update
function Card.update(self, dt)
    if G.STAGE == G.STAGES.RUN then
        if self.ability.name == "MMC Seal Collector" then
            self.ability.extra.current_chips = 0
            -- Count all seal cards
            for _, v in pairs(G.playing_cards) do
                if v.seal ~= nil then
                    -- Add chips to total
                    self.ability.extra.current_chips = self.ability.extra.current_chips + self.ability.extra.chip_mod
                end
            end
        end

        if self.ability.name == "MMC Batman" then
            self.ability.extra.mult_mod = self.ability.extra.base
            -- Count all jokers with "Joker" in the name
            for _, v in pairs(G.jokers.cards) do
                if string.find(v.ability.name, "Joker") then
                    -- Increase mult gain
                    self.ability.extra.mult_mod = self.ability.extra.mult_mod + 1
                end
            end
        end

        if self.ability.name == "MMC Special Edition Joker" then
            -- Reset defaults
            self.ability.extra.current_mult = 0
            self.ability.extra.current_chips = 0
            self.ability.extra.current_Xmult = 1
            -- Count all special cards
            for _, v in pairs(G.playing_cards) do
                if v.seal ~= nil then
                    self.ability.extra.current_mult = self.ability.extra.current_mult + self.ability.extra.mult_mod
                end
                if v.ability.set == "Enhanced" then
                    self.ability.extra.current_chips = self.ability.extra.current_chips + self.ability.extra.chip_mod
                end
                if v.edition ~= nil then
                    self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra.Xmult_mod
                end
            end
        end

        if self.ability.name == "MMC Broke Joker" then
            -- Update mult based on negative balance
            local negative_bal = G.GAME.dollars
            if negative_bal < 0 then
                local new_mult = -1 * math.ceil(negative_bal / self.ability.extra.every) *
                    self.ability.extra.mult_mod
                if self.ability.extra.current_mult ~= new_mult then
                    self.ability.extra.current_mult = new_mult
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.0,
                        func = (function()
                            if self.added_to_deck then
                                card_eval_status_text(self, "extra", nil, nil, nil, {
                                    message = localize {
                                        type = "variable",
                                        key = "a_mult",
                                        vars = { self.ability.extra.current_mult }
                                    },
                                    colour = G.C.MULT
                                })
                            end
                            return true
                        end)
                    }))
                end
            elseif self.ability.extra.current_mult ~= 0 then
                -- Reset mult
                self.ability.extra.current_mult = 0
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.0,
                    func = (function()
                        if self.added_to_deck then
                            card_eval_status_text(self, "extra", nil, nil, nil, {
                                message = localize {
                                    type = "variable",
                                    key = "a_mult",
                                    vars = { self.ability.extra.current_mult }
                                },
                                colour = G.C.MULT
                            })
                        end
                        return true
                    end)
                }))
            end
        end

        if self.ability.name == "MMC Go For Broke" then
            -- Update chips based on negative balance
            local negative_bal = G.GAME.dollars
            if negative_bal < 0 then
                local new_chips = -1 * math.ceil(negative_bal / self.ability.extra.every) *
                    self.ability.extra.chip_mod
                if self.ability.extra.current_chips ~= new_chips then
                    self.ability.extra.current_chips = new_chips
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.0,
                        func = (function()
                            if self.added_to_deck then
                                card_eval_status_text(self, "extra", nil, nil, nil, {
                                    message = localize {
                                        type = "variable",
                                        key = "a_chips",
                                        vars = { self.ability.extra.current_chips },
                                        delay = 0.0
                                    },
                                    colour = G.C.CHIPS
                                })
                            end
                            return true
                        end)
                    }))
                end
            elseif self.ability.extra.current_chips ~= 0 then
                -- Reset chips
                self.ability.extra.current_chips = 0
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.0,
                    func = (function()
                        if self.added_to_deck then
                            card_eval_status_text(self, "extra", nil, nil, nil, {
                                message = localize {
                                    type = "variable",
                                    key = "a_chips",
                                    vars = { self.ability.extra.current_chips },
                                    delay = 0.0
                                },
                                colour = G.C.CHIPS
                            })
                        end
                        return true
                    end)
                }))
            end
        end

        if self.ability.name == "MMC Monopolist" then
            local bal = G.GAME.dollars
            if bal >= self.ability.extra._req then
                -- Increase Xmult and req
                self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra._Xmult_mod
                self.ability.extra._req = self.ability.extra._req * 2
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.0,
                    func = (function()
                        if self.added_to_deck then
                            card_eval_status_text(self, "extra", nil, nil, nil, {
                                message = localize {
                                    type = "variable",
                                    key = "a_xmult",
                                    vars = { self.ability.extra.current_Xmult }
                                },
                                colour = G.C.MULT
                            })
                        end
                        return true
                    end)
                }))
            elseif self.ability.extra._req ~= self.ability.extra._base and
                bal < (self.ability.extra._req / 2) then
                -- Decrease Xmult and req
                self.ability.extra.current_Xmult = self.ability.extra.current_Xmult - self.ability.extra._Xmult_mod
                self.ability.extra._req = self.ability.extra._req / 2
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.0,
                    func = (function()
                        if self.added_to_deck then
                            card_eval_status_text(self, "extra", nil, nil, nil, {
                                message = localize {
                                    type = "variable",
                                    key = "a_xmult",
                                    vars = { self.ability.extra.current_Xmult }
                                },
                                colour = G.C.MULT
                            })
                        end
                        return true
                    end)
                }))
            end
        end

        if self.ability.name == "MMC Student Loans" and self.added_to_deck then
            -- Decrease discards based on negative balance
            local negative_bal = G.GAME.dollars
            if negative_bal < 0 then
                local debuffs = math.floor(negative_bal / self.ability.extra.every) * self.ability.extra.discard_sub
                if debuffs ~= self.ability.extra.discards then
                    debuffs = debuffs - self.ability.extra.discards
                    ease_discard(debuffs)
                    G.GAME.round_resets.discards = G.GAME.round_resets.discards + debuffs
                    self.ability.extra.discards = self.ability.extra.discards + debuffs
                end
            elseif self.ability.extra.discards ~= 0 then
                -- Reset discards
                ease_discard(1)
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
                self.ability.extra.discards = 0
            end
        end
    end
    card_updateref(self, dt)
end

-- Calculate Chips
local evaluate_playref = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play(self, e)
    evaluate_playref(self, e)

    for i = 1, #G.jokers.cards do
        local effects = eval_card(G.jokers.cards[i], {
            card = G.consumeables,
            after = true,
            mmc_scored_chips = hand_chips * mult
        })
        if effects.jokers then
            card_eval_status_text(G.jokers.cards[i], "jokers", nil, 0.3, nil, effects.jokers)
        end
    end
end

-- Handle end of round card effects
local get_end_of_round_effectref = Card.get_end_of_round_effect
function Card.get_end_of_round_effect(self, context)
    -- Call base function
    local ret = get_end_of_round_effectref(self, context)

    if self.seal == "Blue" and not self.debuff then
        for _, v in pairs(G.jokers.cards) do
            -- Check for Aurora Borealis Joker and consumeable space
            if v.ability.name == "MMC Aurora Borealis" then
                -- Add card
                create_planet(v, "aurora_borealis", { negative = true })

                for _, v2 in pairs(G.jokers.cards) do
                    if v2.ability.name == "MMC Harp Seal" then
                        create_planet(v, "aurora_borealis", { negative = true }, v2)
                    end
                end
            end

            -- Create planet for each Blue Seal
            if v.ability.name == "MMC Harp Seal" then
                create_planet(v, "harp_seal")
            end
        end
    end

    -- Return result
    return ret
end

local get_chip_mult_ref = Card.get_chip_mult
function Card:get_chip_mult()
    if self.ability.perma_mult then
        return self.ability.mult + self.ability.perma_mult
    end
    return get_chip_mult_ref(self)
end

local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
    loc_colour_ref(_c, _default)
    G.ARGS.LOC_COLOURS["mikas"] = HEX("FD5DA8")
    return G.ARGS.LOC_COLOURS[_c] or _default or G.C.UI.TEXT_DARK
end

----------------------------------------------
------------MOD CODE END----------------------
