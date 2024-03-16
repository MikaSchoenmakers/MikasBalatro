--- STEAMODDED HEADER
--- MOD_NAME: Mika's Mod Collection
--- MOD_ID: MikasMods
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: A collection of Mika's Mods. Check the mod description on GitHub for more information :)
----------------------------------------------
------------MOD CODE -------------------------

-- Config: DISABLE UNWANTED MODS HERE
local config = {
    -- Decks
    evenStevenDeck = true,
    oddToddDeck = true,
    fibonacciDeck = true,
    primeDeck = true, -- Do not enable without primeJoker
    midasDeck = true,
    jokersForHireDeck = true,
    -- Jokers
    primeJoker = true,
    straightNateJoker = true,
    fishermanJoker = true,
    impatientJoker = true,
    cultistJoker = true,
    sealCollectorJoker = true,
    camperJoker = true,
    luckyNumberSevenJoker = true,
    delayedJoker = true,
    showoffJoker = true,
    sniperJoker = true,
    blackjackJoker = true,
    batmanJoker = true,
    bombJoker = true,
    alphabetJoker = true,
    grudgefulJoker = true,
    finishingBlowJoker = true,
    planetaryAlignmentJoker = true,
    historicalJoker = true,
    suitAlleyJoker = true,
    printerJoker = true,
    shyJoker = true,
    gamblerJoker = true
}

-- Helper functions
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

local function get_random_letter(letter)
    -- 'A' to 'Z' is 65 to 95
    local random_ascii = math.random(65, 90)
    local new_letter = string.char(random_ascii)
    if letter ~= new_letter then
        return new_letter
    else
        return get_random_letter(letter)
    end
end

local function remove_prefix(name, prefix)
    local start_pos, end_pos = string.find(name, prefix)
    if start_pos == 1 then
        return string.sub(name, end_pos + 1)
    else
        return name
    end
end

local function count_letters(str, letter)
    local count = 0
    for i in str:gmatch(letter) do
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

local function get_random_in_table(table)
    local index = math.random(1, #table)
    return table[index]
end

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

-- Local variables
local for_hire_counter = 0

-- Initialize deck effect
local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(arg_56_0)
    Backapply_to_runRef(arg_56_0)

    -- Even Steven Deck
    if arg_56_0.effect.config.only_evens then
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
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_even_steven', nil)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end

    -- Odd Todd Deck
    if arg_56_0.effect.config.only_odds then
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
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_odd_todd', nil)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end

    -- Fibonacci Deck
    if arg_56_0.effect.config.only_fibo then
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
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_fibonacci', nil)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end

    -- Prime Deck
    if arg_56_0.effect.config.only_prime then
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
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mmc_prime', nil)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end

    -- Midas Deck
    if arg_56_0.effect.config.gold then
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
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_midas_mask', nil)
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end

    -- Jokers For Hire Deck
    if arg_56_0.effect.config.for_hire then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Set joker slots to 1
                G.jokers.config.card_limit = 1

                -- Add effect to starting params
                G.GAME.starting_params.mmc_for_hire = true

                -- Reset counter
                for_hire_counter = 0
                return true
            end
        }))
    end
end

-- Create Localization
local locs = {
    evenStevenDeck = {
        name = "Even Steven's Deck",
        text = {
            "Start run with only",
            "{C:attention}even cards{} and",
            "the {C:attention}Even Steven{} joker"
        }
    },
    oddToddDeck = {
        name = "Odd Todd's Deck",
        text = {
            "Start run with only",
            "{C:attention}odd cards{} and",
            "the {C:attention}Odd Todd{} joker"
        }
    },
    fibonacciDeck = {
        name = "Fibonacci Deck",
        text = {
            "Start run with only",
            "{C:attention}Fibonacci cards{} and",
            "the {C:attention}Fibonacci{} joker"
        }
    },
    primeDeck = {
        name = "Prime Deck",
        text = {
            "Start run with",
            "only {C:attention}prime cards{} and",
            "the {C:attention}Prime{} joker"
        }
    },
    midasDeck = {
        name = "Midas's Deck",
        text = {
            "Start run with only",
            "{C:attention}Gold Face cards{} and",
            "the {C:attention}Midas Mask{} joker"
        }
    },
    jokersForHireDeck = {
        name = "\"Jokers for Hire\" Deck",
        text = {
            "All Jokers give {C:dark_edition}+1{}",
            "Joker slot. Price of",
            "{C:attention}Jokers{} and {C:attention}Buffoon Packs",
            "increase {C:red}exponentially"
        }
    },
    primeJoker = {
        name = "Prime Joker",
        text = {
            "Each played {C:attention}2{},",
            "{C:attention}3{}, {C:attention}5{}, {C:attention}7{} or {C:attention}Ace{}, gives",
            "{X:mult,C:white}X#1#{} Mult when scored"
        }
    },
    straightNateJoker = {
        name = "Straight Nate",
        text = {
            "{X:mult,C:white} X#1# {} Mult if played hand",
            "contains a {C:attention}Straight{} and you have",
            "both {C:attention}Odd Todd{} and {C:attention}Even Steven{}.",
            "Also gives {C:dark_edition}+1{} Joker slot"
        }
    },
    fishermanJoker = {
        name = "The Fisherman",
        text = {
            "{C:attention}+#2#{} hand size per discard",
            "{C:attention}-#2#{} hand size per hand played",
            "Resets every round",
            "{C:inactive}(Currently {C:attention}+#1#{C:inactive} hand size)"
        }
    },
    impatientJoker = {
        name = "Impatient Joker",
        text = {
            "{C:mult}+#2#{} Mult per card discarded",
            "Resets every round",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
    },
    cultistJoker = {
        name = "Cultist",
        text = {
            "{X:mult,C:white}X#2#{} Mult per hand played",
            "Resets every round",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
    },
    sealCollectorJoker = {
        name = "Seal Collector",
        text = {
            "Gains {C:chips}+#2#{} Chips for",
            "every card with a {C:attention}seal",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
        }
    },
    camperJoker = {
        name = "Camper",
        text = {
            "Every discarded {C:attention}card{}",
            "permanently gains",
            "{C:chips}+#1#{} Chips"
        }
    },
    luckyNumberSevenJoker = {
        name = "Lucky Number Seven",
        text = {
            "Gain {C:money}$#1#{}, {C:money}$#2#{}, {C:money}$#3#{}, {C:money}$#4#{},",
            "{C:money}$#5#{} when 1, 2, 3, 4 or 5",
            "{C:attention}7 cards{} are played,",
            "respectively"
        }
    },
    delayedJoker = {
        name = "Delayed Joker",
        text = {
            "Gives {C:mult}+#1#{} Mult, {C:chips}+#2#{}",
            "Chips and {X:mult,C:white}X#3#{} Mult on",
            "the {C:attention}4th{} action",
            "{C:inactive}(Current action: {C:attention}#4#{C:inactive} )"
        }
    },
    showoffJoker = {
        name = "The Show-Off",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult when",
            "a blind is finished with",
            "{C:attention}2x{} the chip requirement",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
    },
    sniperJoker = {
        name = "The Sniper",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult when",
            "a blind is finished with",
            "the {C:attention}exact{} chip requirement",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
    },
    blackjackJoker = {
        name = "Blackjack Joker",
        text = {
            "Gives {X:mult,C:white}X#1#{} Mult when",
            "the ranks of all played",
            "cards is {C:attention}exactly 21{}"
        }
    },
    batmanJoker = {
        name = "Batman",
        text = {
            "Gains {C:mult}+#2#{} Mult for",
            "every {C:attention}non-lethal{} hand played.",
            "Mult gain increases for every",
            "Joker with {C:attention}\"Joker\"{} in the name",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
    },
    bombJoker = {
        name = "Bomb",
        text = {
            "Gains {C:mult}+#2#{} Mult per round",
            "self destructs after {C:attention}#3#{} rounds",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
    },
    alphabetJoker = {
        name = "Alphabet Joker",
        text = {
            "Gives {C:chips}+#1#{} Chips for every",
            "letter {C:attention}\"#2#\"{} in your Jokers.",
            "Letter changes when this",
            "Joker appears in the shop"
        }
    },
    grudgefulJoker = {
        name = "Grudgeful Joker",
        text = {
            "Adds {C:attention}excess Chips{} from last",
            "blind to the first hand",
            "of the current round. Caps",
            "at {C:attention}#2#%{} of current blind's Chips",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
        }
    },
    finishingBlowJoker = {
        name = "Finishing Blow",
        text = {
            "If a blind is finished",
            "with a {C:attention}High Card{}, randomly",
            "{C:attention}enhance{} the played card"
        }
    },
    planetaryAlignmentJoker = {
        name = "Planetary Alignment",
        text = {
            "Once every 2 rounds",
            "{C:attention}Blue Seals{} give 2 {C:planet}Planet{} cards,",
            "one of them will be for your",
            "most played {C:attention}poker hand{}"
        }
    },
    historicalJoker = {
        name = "Historical Joker",
        text = {
            "If scored cards have the",
            "same {C:attention}ranks{} and {C:attention}order{} as",
            "previous hand, add previous hands",
            "{C:chips}Chips{} to the current hand"
        }
    },
    suitAlleyJoker = {
        name = "Suit Alley",
        text = {
            "{C:diamonds}Diamond{} and {C:clubs}Club{} cards",
            "gain {C:chips}+#1#{} Chips when scored",
            "{C:hearts}Heart{} and {C:spades}Spade{} cards",
            "gain {C:mult}+#2#{} Mult when scored"
        }
    },
    printerJoker = {
        name = "The Printer",
        text = {
            "If hand scores more",
            "than the blind's Chips,",
            "{C:attention}duplicate{} your hand"
        }
    },
    shyJoker = {
        name = "Shy Joker",
        text = {
            "{X:mult,C:white}X#1#{} Mult,",
            "gains {X:mult,C:white}X#2#{} Mult",
            "per {C:attention}card{} played",
        }
    },
    gamblerJoker = {
        name = "The Gambler",
        text = {
            "Retrigger all",
            "played {C:attention}Lucky{} cards"
        }
    }
}

-- Create Decks
local decks = {
    evenStevenDeck = {
        name = "Even Steven's Deck",
        config = { only_evens = true },
        sprite = { x = 5, y = 2 }
    },
    oddToddDeck = {
        name = "Odd Todd's Deck",
        config = { only_odds = true },
        sprite = { x = 5, y = 2 }
    },
    fibonacciDeck = {
        name = "Fibonacci Deck",
        config = { only_fibo = true },
        sprite = { x = 5, y = 2 }
    },
    primeDeck = {
        name = "Prime Deck",
        config = { only_prime = true },
        sprite = { x = 5, y = 2 }
    },
    midasDeck = {
        name = "Midas's Deck",
        config = { gold = true },
        sprite = { x = 6, y = 0 }
    },
    jokersForHireDeck = {
        name = "Jokers for Hire",
        config = { for_hire = true },
        sprite = { x = 6, y = 0 }
    }
}

-- Create Jokers
local jokers = {
    primeJoker = {
        ability_name = "MMC Prime Joker",
        slug = "mmc_prime",
        ability = { extra = { Xmult = 1.2 } },
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    straightNateJoker = {
        ability_name = "MMC Straight Nate",
        slug = "mmc_straight_nate",
        ability = { extra = { Xmult = 4 } },
        rarity = 3,
        cost = 7,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    fishermanJoker = {
        ability_name = "MMC The Fisherman",
        slug = "mmc_fisherman",
        ability = { extra = { hand_size = 0, hand_add = 1 } },
        rarity = 2,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    impatientJoker = {
        ability_name = "MMC Impatient Joker",
        slug = "mmc_impatient",
        ability = { mult = 0, extra = { mult_add = 2 } },
        rarity = 2,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    cultistJoker = {
        ability_name = "MMC Cultist",
        slug = "mmc_cultist",
        ability = { extra = { Xmult = 1, Xmult_add = 1 } },
        rarity = 3,
        cost = 8,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    sealCollectorJoker = {
        ability_name = "MMC Seal Collector",
        slug = "mmc_seal_collector",
        ability = { extra = { chips = 25, chips_add = 25 } },
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    camperJoker = {
        ability_name = "MMC Camper",
        slug = "mmc_camper",
        ability = { extra = { chips_add = 4 } },
        rarity = 2,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    luckyNumberSevenJoker = {
        ability_name = "MMC Lucky Number Seven",
        slug = "mmc_lucky_number_seven",
        ability = {
            extra = {
                dollar_gain_one = 1,
                dollar_gain_two = 3,
                dollar_gain_three = 10,
                dollar_gain_four = 25,
                dollar_gain_five = 50,
                dollars = 0,
                seven_tally = 0,
                old_dollars = 0
            }
        },
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    delayedJoker = {
        ability_name = "MMC Delayed Joker",
        slug = "mmc_delayed",
        ability = { extra = { mult = 20, chips = 100, Xmult = 1.5, action_tally = 1 } },
        rarity = 2,
        cost = 7,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    showoffJoker = {
        ability_name = "MMC The Show-Off",
        slug = "mmc_showoff",
        ability = { extra = { Xmult = 1, Xmult_add = 1, total_chips = 0 } },
        rarity = 3,
        cost = 8,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    sniperJoker = {
        ability_name = "MMC The Sniper",
        slug = "mmc_sniper",
        ability = { extra = { Xmult = 1, Xmult_add = 4, total_chips = 0 } },
        rarity = 4,
        cost = 15,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    blackjackJoker = {
        ability_name = "MMC Blackjack Joker",
        slug = "mmc_blackjack",
        ability = { extra = { Xmult = 3, rank_tally = { 0 }, updated_rank_tally = {} } },
        rarity = 2,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    batmanJoker = {
        ability_name = "MMC Batman",
        slug = "mmc_batman",
        ability = { extra = { mult = 1, mult_add = 1, total_chips = 0 } },
        rarity = 3,
        cost = 8,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    bombJoker = {
        ability_name = "MMC Bomb",
        slug = "mmc_bomb",
        ability = { extra = { mult = 15, mult_add = 15, rounds_left = 3 } },
        rarity = 1,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    alphabetJoker = {
        ability_name = "MMC Alphabet Joker",
        slug = "mmc_alphabet",
        ability = { extra = { chips = 20, letter = 'A' } },
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    grudgefulJoker = {
        ability_name = "MMC Grudgeful Joker",
        slug = "mmc_grudgeful",
        ability = { extra = { chips = 0, total_chips = 0, old_chips = 0, chips_percentage = 25 } },
        rarity = 3,
        cost = 9,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    finishingBlowJoker = {
        ability_name = "MMC Finishing Blow",
        slug = "mmc_finishing_blow",
        ability = { extra = { high_card = false, card_ref = 0 } },
        rarity = 2,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    planetaryAlignmentJoker = {
        ability_name = "MMC Planetary Alignment",
        slug = "mmc_planetary_alignment",
        ability = { extra = { round = 1 } },
        rarity = 1,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    historicalJoker = {
        ability_name = "MMC Historical Joker",
        slug = "mmc_historical",
        ability = { extra = { prev_cards = {}, current_cards = {}, chips = 0 } },
        rarity = 2,
        cost = 7,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    suitAlleyJoker = {
        ability_name = "MMC Suit Alley",
        slug = "mmc_suit_alley",
        ability = { extra = { mult = 3, chips = 12 } },
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    printerJoker = {
        ability_name = "MMC The Printer",
        slug = "mmc_printer",
        ability = { extra = { hand = {}, chips = 0 } },
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    shyJoker = {
        ability_name = "MMC Shy Joker",
        slug = "mmc_shy",
        ability = { extra = { Xmult = 1, Xmult_add = 0.01 } },
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    gamblerJoker = {
        ability_name = "MMC The Gambler",
        slug = "mmc_gambler",
        ability = {},
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    }
}

function SMODS.INIT.MikasModCollection()
    -- Localization
    G.localization.misc.dictionary.k_mmc_upgrade = "Upgrade!"
    G.localization.misc.dictionary.k_mmc_charging = "Charging..."
    G.localization.misc.dictionary.k_mmc_bonus = "Bonus!"
    G.localization.misc.dictionary.k_mmc_reset = "Reset!"
    G.localization.misc.dictionary.k_mmc_hand_up = "+1 Hand Size!"
    G.localization.misc.dictionary.k_mmc_hand_down = "-1 Hand Size!"
    G.localization.misc.dictionary.k_mmc_tick = "Tick..."
    G.localization.misc.dictionary.k_mmc_planet = "Planet!"

    init_localization()

    -- Initialize Decks
    for key, value in pairs(decks) do
        if config[key] then
            local newDeck = SMODS.Deck:new(value.name, key, value.config, value.sprite, locs[key])
            newDeck:register()
        end
    end

    -- Initialize Jokers
    for key, value in pairs(jokers) do
        if config[key] then
            local joker = SMODS.Joker:new(value.ability_name, value.slug, value.ability, { x = 0, y = 0 }, locs[key],
                value.rarity, value.cost, value.unlocked, value.discovered, value.blueprint_compat, value.eternal_compat)
            joker:register()
            local sprite = SMODS.Sprite:new("j_" .. value.slug, SMODS.findModByID("MikasMods").path,
                "j_" .. value.slug .. ".png", 71, 95, "asset_atli")
            sprite:register()
        end
    end

    -- Joker calculations
    if config.primeJoker then
        SMODS.Jokers.j_mmc_prime.calculate = function(self, context)
            -- For each played card, if card is prime, add xmult
            if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 2 or
                    context.other_card:get_id() == 3 or
                    context.other_card:get_id() == 5 or
                    context.other_card:get_id() == 7 or
                    context.other_card:get_id() == 14) then
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = { self.ability.extra.Xmult }
                    },
                    x_mult = self.ability.extra.Xmult,
                    card = self
                }
            end
        end
    end

    if config.straightNateJoker then
        SMODS.Jokers.j_mmc_straight_nate.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
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
                                type = 'variable',
                                key = 'a_xmult',
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
        SMODS.Jokers.j_mmc_fisherman.calculate = function(self, context)
            -- Decrease hand size
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.hand_size > 0 then
                    self.ability.extra.hand_size = math.max(0, self.ability.extra.hand_size - 1)
                    G.hand:change_size(-self.ability.extra.hand_add)
                    -- Decrease message
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_hand_down') })
                end
            end

            -- Increase hand size
            if context.pre_discard then
                self.ability.extra.hand_size = self.ability.extra.hand_size + 1
                G.hand:change_size(self.ability.extra.hand_add)
                -- Increase message
                card_eval_status_text(self, 'extra', nil, nil, nil,
                    { message = localize('k_mmc_hand_up') })
            end

            -- Reset hand size
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.hand_size ~= 0 then
                    G.hand:change_size(-self.ability.extra.hand_size)
                    self.ability.extra.hand_size = 0
                    -- Reset message
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_reset') })
                end
            end
        end
    end

    if config.impatientJoker then
        SMODS.Jokers.j_mmc_impatient.calculate = function(self, context)
            -- Apply mult
            if SMODS.end_calculate_context(context) then
                if self.ability.mult > 0 then
                    return {
                        message = localize {
                            type = 'variable',
                            key = 'a_mult',
                            vars = { self.ability.mult }
                        },
                        mult_mod = self.ability.mult,
                        card = self
                    }
                end
            end

            -- Increase mult for each discarded card
            if context.discard then
                self.ability.mult = self.ability.mult + self.ability.extra.mult_add
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult_add } },
                    colour = G.C.RED,
                    card = self
                }
            end

            -- Reset mult
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.mult ~= 0 then
                    self.ability.mult = 0
                    -- Reset message
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_reset') })
                end
            end
        end
    end

    if config.cultistJoker then
        SMODS.Jokers.j_mmc_cultist.calculate = function(self, context)
            -- If hand played
            if SMODS.end_calculate_context(context) then
                -- Increment Xmult
                self.ability.extra.Xmult_old = self.ability.extra.Xmult
                self.ability.extra.Xmult = self.ability.extra.Xmult + self.ability.extra.Xmult_add

                -- Apply xmult
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = { self.ability.extra.Xmult_old }
                    },
                    Xmult_mod = self.ability.extra.Xmult_old,
                    card = self
                }
            end

            -- Reset mult
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.Xmult ~= 1 then
                    self.ability.extra.Xmult = 1
                    -- Reset message
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_reset') })
                end
            end
        end
    end

    if config.sealCollectorJoker then
        SMODS.Jokers.j_mmc_seal_collector.calculate = function(self, context)
            -- Apply chips
            if SMODS.end_calculate_context(context) then
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_chips',
                        vars = { self.ability.extra.chips }
                    },
                    chip_mod = self.ability.extra.chips,
                    card = self
                }
            end
        end
    end

    if config.camperJoker then
        SMODS.Jokers.j_mmc_camper.calculate = function(self, context)
            -- If discarded
            if context.discard then
                -- Add chips to card
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus +
                    self.ability.extra.chips_add
                return {
                    message = localize('k_mmc_upgrade'),
                    colour = G.C.CHIPS,
                    card = self
                }
            end
        end
    end

    if config.luckyNumberSevenJoker then
        SMODS.Jokers.j_mmc_lucky_number_seven.calculate = function(self, context)
            -- Count sevens
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
                self.ability.extra.seven_tally = self.ability.extra.seven_tally + 1
            end

            if SMODS.end_calculate_context(context) then
                -- Set dollars
                if self.ability.extra.seven_tally == 1 then
                    self.ability.extra.dollars = self.ability.extra.dollar_gain_one
                elseif self.ability.extra.seven_tally == 2 then
                    self.ability.extra.dollars = self.ability.extra.dollar_gain_two
                elseif self.ability.extra.seven_tally == 3 then
                    self.ability.extra.dollars = self.ability.extra.dollar_gain_three
                elseif self.ability.extra.seven_tally == 4 then
                    self.ability.extra.dollars = self.ability.extra.dollar_gain_four
                elseif self.ability.extra.seven_tally >= 5 then
                    self.ability.extra.dollars = self.ability.extra.dollar_gain_five
                end

                -- Give money and reset
                if self.ability.extra.seven_tally >= 1 then
                    ease_dollars(self.ability.extra.dollars)
                    self.ability.extra.old_dollars = self.ability.extra.dollars
                    self.ability.extra.dollars = 0
                    self.ability.extra.seven_tally = 0
                    return {
                        message = localize('$') .. self.ability.extra.old_dollars,
                        dollars = self.ability.extra.old_dollars,
                        colour = G.C.MONEY
                    }
                end
            end
        end
    end

    if config.delayedJoker then
        SMODS.Jokers.j_mmc_delayed.calculate = function(self, context)
            -- Apply mult, chips and xmult
            if SMODS.end_calculate_context(context) then
                self.ability.extra.action_tally = self.ability.extra.action_tally + 1
                if self.ability.extra.action_tally == 5 then
                    self.ability.extra.action_tally = 1
                    return {
                        -- Return bonus message and apply bonus
                        mult_mod = self.ability.extra.mult,
                        chip_mod = self.ability.extra.chips,
                        Xmult_mod = self.ability.extra.Xmult,
                        message = localize('k_mmc_bonus'),
                        card = self
                    }
                else
                    -- Return charging message
                    return {
                        message = localize('k_mmc_charging'),
                        colour = G.C.JOKER_GREY,
                        card = self
                    }
                end
            end

            -- Increment action tally
            if context.pre_discard then
                self.ability.extra.action_tally = (self.ability.extra.action_tally % 4) + 1
                if self.ability.extra.action_tally == 1 then
                    -- Reset message
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_reset') })
                else
                    -- Charging message
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_charging'), colour = G.C.JOKER_GREY })
                end
            end
        end
    end

    if config.showoffJoker then
        SMODS.Jokers.j_mmc_showoff.calculate = function(self, context)
            -- Apply xmult
            if SMODS.end_calculate_context(context) then
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = { self.ability.extra.Xmult }
                    },
                    Xmult_mod = self.ability.extra.Xmult,
                    card = self
                }
            end

            -- Add scored chips to total
            if context.scored_chips then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.scored_chips
            end

            -- See if total scored chips > 2 * blind chips, then increment xmult
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.total_chips > (2 * G.GAME.blind.chips) then
                    self.ability.extra.Xmult = self.ability.extra.Xmult + self.ability.extra.Xmult_add

                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_upgrade'), colour = G.C.RED })
                end
                -- Reset total chip count
                self.ability.extra.total_chips = 0
            end
        end
    end

    if config.sniperJoker then
        SMODS.Jokers.j_mmc_sniper.calculate = function(self, context)
            -- Apply xmult
            if SMODS.end_calculate_context(context) then
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = { self.ability.extra.Xmult }
                    },
                    Xmult_mod = self.ability.extra.Xmult,
                    card = self
                }
            end

            -- Add scored chips to total
            if context.scored_chips then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.scored_chips
            end

            -- See if total scored chips == blind chips, then increment xmult
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.total_chips == G.GAME.blind.chips then
                    self.ability.extra.Xmult = self.ability.extra.Xmult + self.ability.extra.Xmult_add

                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_upgrade'), colour = G.C.RED })
                end
                -- Reset total chip count
                self.ability.extra.total_chips = 0
            end
        end
    end

    if config.blackjackJoker then
        SMODS.Jokers.j_mmc_blackjack.calculate = function(self, context)
            -- For full hand
            if context.before and context.full_hand then
                -- For every played card
                for _, v in ipairs(context.full_hand) do
                    local id = v:get_id()
                    if id <= 10 then -- Numbered cards
                        for key, value in ipairs(self.ability.extra.rank_tally) do
                            self.ability.extra.rank_tally[key] = value + id
                        end
                    elseif id < 14 then -- Face cards
                        for key, value in ipairs(self.ability.extra.rank_tally) do
                            self.ability.extra.rank_tally[key] = value + 10
                        end
                    else -- Aces, need to be handled differently because they can either have a value of 1 or 11
                        for key, value in ipairs(self.ability.extra.rank_tally) do
                            -- If someone ever plays 32 aces in one hand, I'm doomed
                            self.ability.extra.rank_tally[key] = value + 11
                            table.insert(self.ability.extra.updated_rank_tally, value + 1)
                        end

                        -- Append updated_rank_tally to rank_tally
                        for _, value in ipairs(self.ability.extra.updated_rank_tally) do
                            table.insert(self.ability.extra.rank_tally, value)
                        end

                        -- Reset rank_tally
                        self.ability.extra.updated_rank_tally = {}
                    end
                end
            end

            -- When hand is played
            if SMODS.end_calculate_context(context) then
                -- For every rank_tally, check if we got 21
                for _, value in ipairs(self.ability.extra.rank_tally) do
                    if value == 21 then
                        -- Apply mult and reset rank_tally
                        self.ability.extra.rank_tally = { 0 }
                        return {
                            message = localize {
                                type = 'variable',
                                key = 'a_xmult',
                                vars = { self.ability.extra.Xmult }
                            },
                            Xmult_mod = self.ability.extra.Xmult,
                            card = self
                        }
                    end
                end

                -- Reset rank_tally
                self.ability.extra.rank_tally = { 0 }
            end
        end
    end

    if config.batmanJoker then
        SMODS.Jokers.j_mmc_batman.calculate = function(self, context)
            -- When hand is played
            if SMODS.end_calculate_context(context) then
                -- Apply mult
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } },
                    mult_mod = self.ability.extra.mult
                }
            end

            -- Add scored chips to total
            if context.scored_chips then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.scored_chips

                if self.ability.extra.total_chips < G.GAME.blind.chips then
                    self.ability.extra.mult = self.ability.extra.mult + self.ability.extra.mult_add
                end
            end

            -- Reset total chip count
            if context.end_of_round and not context.individual and not context.repetition then
                -- Reset total chip count
                self.ability.extra.total_chips = 0
            end
        end
    end

    if config.bombJoker then
        -- Apply mult
        SMODS.Jokers.j_mmc_bomb.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_mult',
                        vars = { self.ability.extra.mult }
                    },
                    mult_mod = self.ability.extra.mult,
                    card = self
                }
            end

            -- Decrease round_left counter or destroy
            if context.end_of_round and not context.individual and not context.repetition then
                self.ability.extra.rounds_left = self.ability.extra.rounds_left - 1

                if self.ability.extra.rounds_left == 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            self.T.r = -0.2
                            self:juice_up(0.3, 0.4)
                            self.states.drag.is = true
                            self.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    G.jokers:remove_card(self)
                                    self:remove()
                                    self = nil
                                    return true;
                                end
                            }))
                            return true
                        end
                    }))
                else
                    -- Increase mult
                    self.ability.extra.mult = self.ability.extra.mult + self.ability.extra.mult_add
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_tick'), colour = G.C.RED })
                end
            end
        end
    end

    if config.alphabetJoker then
        SMODS.Jokers.j_mmc_alphabet.calculate = function(self, context)
            -- Check if Joker name contains letter and apply chips
            if context.other_joker and context.other_joker ~= self then
                -- FOR OTHER MODS:
                -- If your mod uses ability names with a prefix and you want it to be compatible with this Joker,
                -- Send me a message on Discord and I will add your prefix here so that it will work correctly!

                -- Remove prefix from ability names
                local ability_name = context.other_joker.ability.name:lower()
                ability_name = remove_prefix(ability_name, 'mmc')

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
                        message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips * letter_tally } },
                        chip_mod = self.ability.extra.chips * letter_tally
                    }
                end
            end
        end
    end

    if config.grudgefulJoker then
        SMODS.Jokers.j_mmc_grudgeful.calculate = function(self, context)
            -- Apply chips and reset
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.chips > 0 then
                    self.ability.extra.old_chips = self.ability.extra.chips
                    self.ability.extra.chips = 0
                    return {
                        message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.old_chips } },
                        chip_mod = self.ability.extra.old_chips
                    }
                end
            end

            -- Add scored chips to total
            if context.scored_chips then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.scored_chips
            end

            if context.end_of_round and not context.individual and not context.repetition then
                -- Add excess chips to bonus
                if self.ability.extra.total_chips >= G.GAME.blind.chips then
                    self.ability.extra.chips = self.ability.extra.total_chips - G.GAME.blind.chips
                    self.ability.extra.chips = math.ceil(math.min(
                        G.GAME.blind.chips * self.ability.extra.chips_percentage / 100,
                        self.ability.extra.chips))
                end

                -- Reset chip count
                self.ability.extra.total_chips = 0
            end
        end
    end

    if config.finishingBlowJoker then
        SMODS.Jokers.j_mmc_finishing_blow.calculate = function(self, context)
            -- Check for high card and set card reference
            if context.cardarea == G.play and not context.repetition then
                if #context.scoring_hand == 1 then
                    self.ability.extra.high_card = true
                    self.ability.extra.card_ref = context.other_card
                else
                    self.ability.extra.high_card = false
                end
            end

            -- Give random enhancement if last hand was high card
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.high_card then
                    self.ability.extra.card_ref:set_ability(get_random_in_table(enhancements), nil, true)
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_upgrade') })
                end
            end
        end
    end

    if config.planetaryAlignmentJoker then
        SMODS.Jokers.j_mmc_planetary_alignment.calculate = function(self, context)
            -- Update round counter
            if context.end_of_round and not context.individual and not context.repetition then
                self.ability.extra.round = self.ability.extra.round + 1
            end
        end
    end

    if config.historicalJoker then
        SMODS.Jokers.j_mmc_historical.calculate = function(self, context)
            -- Save previous cards
            if context.cardarea == G.play and not context.repetition then
                table.insert(self.ability.extra.current_cards, context.other_card.base.id)
            end

            -- Calculate chip score
            if context.scored_chips then
                self.ability.extra.chips = context.scored_chips
            end

            -- Apply chips if previous cards are the same as the current cards
            if SMODS.end_calculate_context(context) then
                if tables_equal(self.ability.extra.prev_cards, self.ability.extra.current_cards) then
                    self.ability.extra.prev_cards = tables_copy(self.ability.extra.current_cards)
                    self.ability.extra.current_cards = {}
                    return {
                        message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                        chip_mod = self.ability.extra.chips
                    }
                else
                    self.ability.extra.prev_cards = tables_copy(self.ability.extra.current_cards)
                    self.ability.extra.current_cards = {}
                end
            end
        end
    end

    if config.suitAlleyJoker then
        SMODS.Jokers.j_mmc_suit_alley.calculate = function(self, context)
            if context.cardarea == G.play and not context.repetition then
                if context.other_card:is_suit('Diamonds') or context.other_card:is_suit('Clubs') then
                    -- Add chips if suit is Diamonds or Clubs
                    return {
                        message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                        chips = self.ability.extra.chips,
                        card = self
                    }
                elseif context.other_card:is_suit('Hearts') or context.other_card:is_suit('Spades') then
                    -- Add mult if Hearts or Spades
                    return {
                        message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } },
                        mult = self.ability.extra.mult,
                        card = self
                    }
                end
            end
        end
    end
end

-- Copied and modifed from LushMod
local generate_UIBox_ability_tableref = Card.generate_UIBox_ability_table
function Card.generate_UIBox_ability_table(self)
    local card_type, hide_desc = self.ability.set or "None", nil
    local loc_vars = nil
    local main_start, main_end = nil, nil
    local no_badge = nil

    if self.config.center.unlocked == false and not self.bypass_lock then    -- For everyting that is locked
    elseif card_type == 'Undiscovered' and not self.bypass_discovery_ui then -- Any Joker or tarot/planet/voucher that is not yet discovered
    elseif self.debuff then
    elseif card_type == 'Default' or card_type == 'Enhanced' then
    elseif self.ability.set == 'Joker' then
        local customJoker = true

        if self.ability.name == 'MMC Prime Joker' then
            loc_vars = { self.ability.extra.Xmult }
        elseif self.ability.name == 'MMC Straight Nate' then
            loc_vars = { self.ability.extra.Xmult }
        elseif self.ability.name == 'MMC The Fisherman' then
            loc_vars = { self.ability.extra.hand_size, self.ability.extra.hand_add }
        elseif self.ability.name == 'MMC Impatient Joker' then
            loc_vars = { self.ability.mult, self.ability.extra.mult_add }
        elseif self.ability.name == 'MMC Cultist' then
            loc_vars = { self.ability.extra.Xmult, self.ability.extra.Xmult_add }
        elseif self.ability.name == 'MMC Seal Collector' then
            loc_vars = { self.ability.extra.chips, self.ability.extra.chips_add }
        elseif self.ability.name == 'MMC Camper' then
            loc_vars = { self.ability.extra.chips_add }
        elseif self.ability.name == 'MMC Lucky Number Seven' then
            loc_vars = { self.ability.extra.dollar_gain_one, self.ability.extra.dollar_gain_two,
                self.ability.extra.dollar_gain_three, self.ability.extra.dollar_gain_four,
                self.ability.extra.dollar_gain_five }
        elseif self.ability.name == 'MMC Delayed Joker' then
            loc_vars = { self.ability.extra.mult, self.ability.extra.chips, self.ability.extra.Xmult,
                self.ability.extra.action_tally }
        elseif self.ability.name == 'MMC The Show-Off' then
            loc_vars = { self.ability.extra.Xmult, self.ability.extra.Xmult_add }
        elseif self.ability.name == 'MMC The Sniper' then
            loc_vars = { self.ability.extra.Xmult, self.ability.extra.Xmult_add }
        elseif self.ability.name == 'MMC Blackjack Joker' then
            loc_vars = { self.ability.extra.Xmult }
        elseif self.ability.name == 'MMC Batman' then
            loc_vars = { self.ability.extra.mult, self.ability.extra.mult_add }
        elseif self.ability.name == 'MMC Bomb' then
            loc_vars = { self.ability.extra.mult, self.ability.extra.mult_add, self.ability.extra.rounds_left }
        elseif self.ability.name == 'MMC Alphabet Joker' then
            loc_vars = { self.ability.extra.chips, self.ability.extra.letter }
        elseif self.ability.name == 'MMC Grudgeful Joker' then
            loc_vars = { self.ability.extra.chips, self.ability.extra.chips_percentage }
        elseif self.ability.name == 'MMC Finishing Blow' then
            loc_vars = { self.ability.extra.enhancement }
        elseif self.ability.name == 'MMC Planery Alignment' then
            loc_vars = {}
        elseif self.ability.name == 'MMC Historical Joker' then
            loc_vars = {}
        elseif self.ability.name == 'MMC Suit Alley' then
            loc_vars = { self.ability.extra.chips, self.ability.extra.mult }
        elseif self.ability.name == 'MMC The Printer' then
            loc_vars = {}
        elseif self.ability.name == 'MMC Shy Joker' then
            loc_vars = { self.ability.extra.Xmult, self.ability.extra.Xmult_add }
        elseif self.ability.name == 'MMC The Gambler' then
            loc_vars = {}
        else
            customJoker = false
        end

        if customJoker then
            local badges = {}
            if (card_type ~= 'Locked' and card_type ~= 'Undiscovered' and card_type ~= 'Default') or self.debuff then
                badges.card_type = card_type
            end
            if self.ability.set == 'Joker' and self.bypass_discovery_ui and (not no_badge) then
                badges.force_rarity = true
            end
            if self.edition then
                if self.edition.type == 'negative' and self.ability.consumeable then
                    badges[#badges + 1] = 'negative_consumable'
                else
                    badges[#badges + 1] = (self.edition.type == 'holo' and 'holographic' or self.edition.type)
                end
            end
            if self.seal then
                badges[#badges + 1] = string.lower(self.seal) .. '_seal'
            end
            if self.ability.eternal then
                badges[#badges + 1] = 'eternal'
            end
            if self.pinned then
                badges[#badges + 1] = 'pinned_left'
            end

            if self.sticker then
                loc_vars = loc_vars or {};
                loc_vars.sticker = self.sticker
            end

            return generate_card_ui(self.config.center, nil, loc_vars, card_type, badges, hide_desc, main_start,
                main_end)
        end
    end

    return generate_UIBox_ability_tableref(self)
end

-- Handle card addition/removing
local add_to_deckref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    if not self.added_to_deck then
        -- Straight Nate
        if self.ability.name == 'MMC Straight Nate' then
            -- Add Joker slot
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        end

        -- Jokers for Hire
        if G.GAME.starting_params.mmc_for_hire and self.ability.set == 'Joker' then
            -- Add Joker slot and increment counter
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            for_hire_counter = for_hire_counter + 1
        end
    end
    add_to_deckref(self, from_debuff)
end

local remove_from_deckref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    if self.added_to_deck then
        -- Straight Nate
        if self.ability.name == 'MMC Straight Nate' then
            -- Remove Joker slot
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        end

        -- Jokers for Hire
        if G.GAME.starting_params.mmc_for_hire and self.ability.set == 'Joker' then
            -- Remove Joker slot and decrement counter
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
            for_hire_counter = for_hire_counter - 1
        end
    end
    remove_from_deckref(self, from_debuff)
end

-- Handle cost increase
local set_costref = Card.set_cost
function Card.set_cost(self)
    set_costref(self)
    -- Alphabet Joker
    if self.ability.name == 'MMC Alphabet Joker' then
        self.ability.extra.letter = get_random_letter()
    end

    -- Jokers for Hire
    if G.GAME.starting_params.mmc_for_hire and (self.ability.set == 'Joker' or string.find(self.ability.name, 'Buffoon')) then
        -- Multiply cost exponentially with counter
        self.cost = self.cost * 2 ^ for_hire_counter
    end
end

-- Card updates
local card_updateref = Card.update
function Card.update(self, dt)
    if G.STAGE == G.STAGES.RUN then
        -- Seal Collector
        if self.ability.name == 'MMC Seal Collector' then
            self.ability.extra.chips = 25
            -- Count all seal cards
            for _, value in pairs(G.playing_cards) do
                if value.seal ~= nil then
                    -- Add chips to total
                    self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chips_add
                end
            end
        end
        -- Batman
        if self.ability.name == 'MMC Batman' then
            self.ability.extra.mult_add = 1
            -- Count all jokers with 'Joker' in the name
            for _, value in pairs(G.jokers.cards) do
                if string.find(value.ability.name, 'Joker') then
                    -- Increase mult gain
                    self.ability.extra.mult_add = self.ability.extra.mult_add + 1
                end
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
        local effects = eval_card(G.jokers.cards[i],
            { card = G.consumeables, after = true, scored_chips = hand_chips * mult })
        if effects.jokers then
            card_eval_status_text(G.jokers.cards[i], 'jokers', nil, 0.3, nil, effects.jokers)
        end
    end
end

-- Handle end of round card effects
local get_end_of_round_effectref = Card.get_end_of_round_effect
function Card:get_end_of_round_effect(context)
    -- Prevent red seals from crashing
    if self.seal == 'Red' then return {} end

    -- Planetary Alignment
    if self.seal == 'Blue' then
        for _, v in pairs(G.jokers.cards) do
            -- Check for Planetary Alignment Joker and consumable space
            if v.ability.name == 'MMC Planetary Alignment' and v.ability.extra.round % 2 == 0 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                -- Get most played hand
                local _planet, _hand, _tally = nil, nil, 0
                for _, v in ipairs(G.handlist) do
                    if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                        _hand = v
                        _tally = G.GAME.hands[v].played
                    end
                end
                if _hand then
                    for _, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == _hand then
                            _planet = v.key
                        end
                    end
                end

                -- Add card
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        local card = create_card('Planet', G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))

                -- Show message
                card_eval_status_text(v, 'extra', nil, nil, nil,
                    { message = localize('k_mmc_planet'), colour = G.C.SECONDARY_SET.Planet })
            end
        end
    end

    get_end_of_round_effectref(self, context)
end

----------------------------------------------
------------MOD CODE END----------------------
