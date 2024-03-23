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
    primeDeck = true, -- Do not enable without primeTimeJoker
    midasDeck = true,
    jokersForHireDeck = true,
    perfectPrecisionDeck = true, -- Do not enable without sniperJoker
    -- Jokers
    primeTimeJoker = true,
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
    gamblerJoker = true,
    incompleteJoker = true,
    abbeyRoadJoker = true,
    boatingLicenseJoker = true,
    bankerJoker = true,
    riggedJoker = true,
    commanderJoker = true,
    whatAreTheOddsJoker = true,
    dagonetJoker = true,
    glueJoker = true,
    harpSealJoker = true,
    footballCardJoker = true,
    specialEditionJoker = true,
    stockpilerJoker = true,
    studentLoansJoker = true,
    brokeJoker = true
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

local card_editions = {
    { foil = true },
    { holo = true },
    { polychrome = true }
}

local seals = {
    "Gold",
    "Red",
    "Blue",
    "Purple"
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

-- Save attributes
local attributes = {
    mult = { key = 'mult_dagonet', min = 0 },
    mult_mod = { key = 'mult_mod_dagonet', min = 0 },
    chips = { key = 'chips_dagonet', min = 0 },
    chip_mod = { key = 'chip_mod_dagonet', min = 0 },
    Xmult = { key = 'Xmult_dagonet', min = 1 },
    Xmult_mod = { key = 'Xmult_mod_dagonet', min = 0 },
    x_mult = { key = 'x_mult_dagonet', min = 1 },
    t_mult = { key = 't_mult_dagonet', min = 0 },
    t_chips = { key = 't_chips_dagonet', min = 0 },
    s_mult = { key = 's_mult_dagonet', min = 0 },
    dollars = { key = 'dollars_dagonet', min = 0 },
    hand_add = { key = 'hand_add_dagonet', min = 0 },
    discard_sub = { key = 'discard_sub_dagonet', min = 0 },
    odds = { key = 'odds_dagonet', min = 0 },
    faces = { key = 'faces_dagonet', min = 0 },
    max = { key = 'max_dagonet', min = 0 },
    min = { key = 'min_dagonet', min = 0 },
    every = { key = 'every_dagonet', min = 0 },
    increase = { key = 'increase_dagonet', min = 0 },
    h_size = { key = 'h_size_dagonet', min = 0 },
    d_size = { key = 'd_size_dagonet', min = 0 },
    h_mod = { key = 'h_mod_dagonet', min = 0 },
    h_plays = { key = 'h_plays_dagonet', min = 0 },
    discards = { key = 'discards_dagonet', min = 0 },
    req = { key = 'req_dagonet', min = 0 },
    percentage = { key = 'percentage_dagonet', min = 0 },
    base = { key = 'base_dagonet', min = 0 },
    repetitions = { key = 'repetitions_dagonet', min = 0 },
    dollar_gain_one = { key = 'dollar_gain_one_dagonet', min = 0 },
    dollar_gain_two = { key = 'dollar_gain_two_dagonet', min = 0 },
    dollar_gain_three = { key = 'dollar_gain_three_dagonet', min = 0 },
    dollar_gain_four = { key = 'dollar_gain_four_dagonet', min = 0 },
    dollar_gain_five = { key = 'dollar_gain_five_dagonet', min = 0 },
    extra = { key = 'extra_dagonet', min = 0 }
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
        if place["prev_mult_dagonet"] == nil then place["prev_mult_dagonet"] = multiplier end
        if place[attr.key] == nil then
            -- Save base value
            place[attr.key] = v
        else
            if not (v / multiplier == place[attr.key] and place["prev_mult_dagonet"] == multiplier) then
                if not (v / multiplier == place[attr.key] or v / place["prev_mult_dagonet"] == place[attr.key]) then
                    if v / multiplier ~= place[attr.key] and place["prev_mult_dagonet"] == multiplier then
                        -- Update base based on current multiplier
                        local increase = (v / multiplier - place[attr.key]) * multiplier
                        place[attr.key] = place[attr.key] + increase
                    else
                        -- Update base based on previous multiplier
                        local increase = (v / place["prev_mult_dagonet"] - place[attr.key]) * place["prev_mult_dagonet"]
                        place[attr.key] = place[attr.key] + increase
                    end
                end
            end
        end
        -- Multiply attribute
        place[k] = place[attr.key] * multiplier
        place["prev_mult_dagonet"] = multiplier
    end
end

-- Create Localization
local locs = {
    -- Decks
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
            "the {C:attention}Prime Time{} joker"
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
    perfectPrecisionDeck = {
        name = "Perfect Precision Deck",
        text = {
            "+1 {C:blue}hands{}, {C:red}discards{} and",
            "{C:attention}hand size{}. Start with",
            "a {C:dark_edition}negative {C:attention}The Sniper{}",
            "Joker. Ante scales {C:attention}X1.5{}",
            "as fast"
        }
    },
    -- Jokers
    primeTimeJoker = {
        name = "Prime Time",
        text = {
            "Each played {C:attention}2{},",
            "{C:attention}3{}, {C:attention}5{}, {C:attention}7{} or {C:attention}Ace{}, gives",
            "{X:mult,C:white}X#1#{} Mult when scored",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
    },
    straightNateJoker = {
        name = "Straight Nate",
        text = {
            "{X:mult,C:white} X#1# {} Mult if played hand",
            "contains a {C:attention}Straight{} and you have",
            "both {C:attention}Odd Todd{} and {C:attention}Even Steven{}.",
            "Also gives {C:dark_edition}+#2#{} Joker slot"
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
            "{C:attention}7 cards{} are scored,",
            "respectively"
        }
    },
    delayedJoker = {
        name = "Delayed Joker",
        text = {
            "Gives {C:mult}+#1#{} Mult, {C:chips}+#2#{}",
            "Chips and {X:mult,C:white}X#3#{} Mult on",
            "the {C:attention}#5#th{} action",
            "{C:inactive}(Current action: {C:attention}#4#{C:inactive} )"
        }
    },
    showoffJoker = {
        name = "The Show-Off",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult when",
            "a blind is finished with",
            "{C:attention}X#3#{} the chip requirement",
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
            "cards is {C:attention}exactly #2#"
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
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
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
            "{C:attention}Enhance{} scored cards"
        }
    },
    planetaryAlignmentJoker = {
        name = "Planetary Alignment",
        text = {
            "Once every #1# rounds",
            "{C:attention}Blue Seals{} give 2 {C:planet}Planet{} cards,",
            "one of them will be for your",
            "most played {C:attention}poker hand{}"
        }
    },
    historicalJoker = {
        name = "Historical Joker",
        text = {
            "If scored cards have the same",
            "{C:attention}ranks{} and {C:attention}order{} as previous",
            "hand, add previous hands {C:chips}Chips{}",
            "to the current hand. Caps at",
            "{C:attention}#1#%{} of current blind's Chips",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
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
            "If hand scores more than",
            "blind's Chips, {C:attention}duplicate{}",
            "your hand and add duplicated",
            "cards to your hand"
        }
    },
    shyJoker = {
        name = "Shy Joker",
        text = {
            "{X:mult,C:white}X#1#{} Mult,",
            "gains {X:mult,C:white}X#2#{} Mult",
            "per {C:attention}card{} scored",
        }
    },
    gamblerJoker = {
        name = "The Gambler",
        text = {
            "Retrigger all",
            "scored {C:attention}Lucky{} cards"
        }
    },
    incompleteJoker = {
        name = "Incomplete Joker",
        text = {
            "{C:chips}+#1#{} Chips if played",
            "hand contains",
            "{C:attention}#2#{} or fewer cards"
        }
    },
    abbeyRoadJoker = {
        name = "Abbey Road",
        text = {
            "If at least {C:attention}#2#{} poker hands",
            "have been played the same",
            "amount of times, give {X:mult,C:white}X#1#{} Mult",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
    },
    boatingLicenseJoker = {
        name = "Boating License",
        text = {
            "{C:attention}Copies{} effects of all",
            "scored {C:attention}Enhanced{} cards"
        }
    },
    bankerJoker = {
        name = "The Banker",
        text = {
            "Earn {C:money}$#1#{} for every",
            "{C:attention}Gold Seal{} and {C:attention}Gold card{}",
            "at end of round"
        }
    },
    riggedJoker = {
        name = "Rigged Joker",
        text = {
            "Once per hand, add {C:attention}+#1#{} to all",
            "listed {C:green,E:1,S:1.1}probabilities{} whenever a",
            "{C:attention}Lucky{} card does not trigger.",
            "Resets every round"
        }
    },
    commanderJoker = {
        name = "The Commander",
        text = {
            "If {C:attention}first hand{} of round",
            "has only {C:attention}1{} card, give it a",
            "random {C:attention}Enhancement{}, {C:attention}Seal",
            "and {C:attention}Edition"
        }
    },
    whatAreTheOddsJoker = {
        name = "What Are The Odds",
        text = {
            "If {C:attention}#1# Lucky cards{} trigger",
            "in one hand, create a",
            "random {C:dark_edition}negative{} Joker"
        }
    },
    dagonetJoker = {
        name = "Dagonet",
        text = {
            "{C:attention}Doubles{} all base values",
            "on other Jokers",
            "{C:inactive}(If possible)"
        }
    },
    glueJoker = {
        name = "Glue",
        text = {
            "If you have both {C:attention}Half",
            "and {C:attention}Incomplete Joker{}, give",
            "{C:dark_edition}+#2#{} Joker slots and {X:mult,C:white}X#1#{} Mult"
        }
    },
    harpSealJoker = {
        name = "Harp Seal",
        text = {
            "{C:attention}Doubles{} the effect",
            "of all {C:attention}Seals",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
    },
    footballCardJoker = {
        name = "Football Card",
        text = {
            "{C:blue}Common{} Jokers",
            "each give {C:chips}+#1#{} Chips"
        }
    },
    specialEditionJoker = {
        name = "Special Edition Joker",
        text = {
            "Gains {C:mult}+#2#{} Mult per {C:attention}Seal{}, {C:chips}+#4#{}",
            "Chips per {C:attention}Enhancement{} and {X:mult,C:white}X#6#{} Mult",
            "per {C:attention}Edition{} for every card in deck",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult, {C:chips}+#3#{C:inactive}, Chips and {X:mult,C:white}X#5#{C:inactive} Mult)"
        }
    },
    stockpilerJoker = {
        name = "The Stockpiler",
        text = {
            "{C:attention}+#2#{} hand size for every #4#",
            "cards in deck above {C:attention}#3#{}.",
            "Caps at the current Ante",
            "{C:inactive}(Currently {C:attention}+#1#{C:inactive} hand size)"
        }
    },
    studentLoansJoker = {
        name = "Student Loans",
        text = {
            "Go up to {C:red}-$#1#{} in debt.",
            "Gives -#4# {C:red}discard{}",
            "for every {C:red}-$#2#{} in debt",
            "{C:inactive}(Currently {C:attention}#3#{C:inactive} discards)"
        }
    },
    brokeJoker = {
        name = "Broke Joker",
        text = {
            "Gains {C:mult}+#1#{} Mult",
            "per {C:red}-$#3#",
            "{C:inactive}(Currently {C:mult}#2#{C:inactive} Mult)"
        }
    }
}

-- Create Decks
local decks = {
    evenStevenDeck = {
        name = "Even Steven's Deck",
        config = { mmc_only_evens = true },
        sprite = { x = 5, y = 2 }
    },
    oddToddDeck = {
        name = "Odd Todd's Deck",
        config = { mmc_only_odds = true },
        sprite = { x = 5, y = 2 }
    },
    fibonacciDeck = {
        name = "Fibonacci Deck",
        config = { mmc_only_fibo = true },
        sprite = { x = 5, y = 2 }
    },
    primeDeck = {
        name = "Prime Deck",
        config = { mmc_only_prime = true },
        sprite = { x = 5, y = 2 }
    },
    midasDeck = {
        name = "Midas's Deck",
        config = { mmc_gold = true },
        sprite = { x = 6, y = 0 }
    },
    jokersForHireDeck = {
        name = "Jokers for Hire",
        config = { mmc_for_hire = true },
        sprite = { x = 6, y = 0 }
    },
    perfectPrecisionDeck = {
        name = "Perfect Precision",
        config = { mmc_precision = true, ante_scaling = 1.5, discards = 1, hands = 1, hand_size = 1 },
        sprite = { x = 5, y = 2 }
    }
}

-- Create Jokers
local jokers = {
    primeTimeJoker = {
        ability_name = "MMC Prime Time",
        slug = "mmc_prime_time",
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
        ability = { extra = { Xmult = 4, j_slots = 1 } },
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
        ability = { extra = { current_h_size = 0, h_mod = 1 } },
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
        ability = { extra = { mult_mod = 3, current_mult = 0 } },
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
        ability = { extra = { current_Xmult = 1, Xmult_mod = 1, old = 0 } },
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
        ability = { extra = { current_chips = 25, chip_mod = 25, base = 25 } },
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
        ability = { extra = { chip_mod = 4 } },
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
                old = 0
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
        ability = { extra = { mult = 20, chips = 100, Xmult = 1.5, every = 4, action_tally = 1 } },
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
        ability = { extra = { current_Xmult = 1, Xmult_mod = 1, req = 2, total_chips = 0 } },
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
        ability = { extra = { current_Xmult = 1, Xmult_mod = 4, total_chips = 0 } },
        rarity = 3,
        cost = 10,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    blackjackJoker = {
        ability_name = "MMC Blackjack Joker",
        slug = "mmc_blackjack",
        ability = { extra = { Xmult = 3, rank_tally = { 0 }, updated_rank_tally = {}, req = 21 } },
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
        ability = { extra = { current_mult = 1, mult_mod = 1, total_chips = 0, base = 1 } },
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
        ability = { extra = { current_mult = 15, mult_mod = 15, _every = 3 } },
        rarity = 1,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = false
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
        ability = { extra = { current_chips = 0, total_chips = 0, old_chips = 0, percentage = 10 } },
        rarity = 3,
        cost = 9,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    finishingBlowJoker = {
        ability_name = "MMC Finishing Blow",
        slug = "mmc_finishing_blow",
        ability = { extra = { high_card = false, card_refs = {} } },
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
        ability = { extra = { round = 0, every = 2 } },
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
        ability = { extra = { prev_cards = {}, current_cards = {}, current_chips = 0, percentage = 10 } },
        rarity = 3,
        cost = 9,
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
        ability = { extra = { hand = {} } },
        rarity = 3,
        cost = 9,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    shyJoker = {
        ability_name = "MMC Shy Joker",
        slug = "mmc_shy",
        ability = { extra = { current_Xmult = 1, Xmult_mod = 0.01 } },
        rarity = 2,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    gamblerJoker = {
        ability_name = "MMC The Gambler",
        slug = "mmc_gambler",
        ability = { extra = 1 },
        rarity = 2,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    incompleteJoker = {
        ability_name = "MMC Incomplete Joker",
        slug = "mmc_incomplete",
        ability = { extra = { chips = 100, req = 3 } },
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    abbeyRoadJoker = {
        ability_name = "MMC Abbey Road",
        slug = "mmc_abbey_road",
        ability = { extra = { Xmult = 4, req = 4, hand_equal_count = {}, should_trigger = false } },
        rarity = 2,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    boatingLicenseJoker = {
        ability_name = "MMC Boating License",
        slug = "mmc_boating_license",
        ability = {},
        rarity = 3,
        cost = 8,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    bankerJoker = {
        ability_name = "MMC The Banker",
        slug = "mmc_banker",
        ability = { extra = { dollars = 2 } },
        rarity = 1,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    riggedJoker = {
        ability_name = "MMC Rigged Joker",
        slug = "mmc_rigged",
        ability = { extra = { probability = 0, increase = 1, has_triggered = false } },
        rarity = 1,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    commanderJoker = {
        ability_name = "MMC The Commander",
        slug = "mmc_commander",
        ability = {},
        rarity = 3,
        cost = 9,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    whatAreTheOddsJoker = {
        ability_name = "MMC What Are The Odds",
        slug = "mmc_what_are_the_odds",
        ability = { extra = { req = 4, lucky_tally = 0 } },
        rarity = 2,
        cost = 8,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    dagonetJoker = {
        ability_name = "MMC Dagonet",
        slug = "mmc_dagonet",
        ability = { extra = { _mult = 2, _base = 2, triggered = false } },
        rarity = 4,
        cost = 20,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    glueJoker = {
        ability_name = "MMC Glue",
        slug = "mmc_glue",
        ability = { extra = { Xmult = 5, j_slots = 2, half = false, incomplete = false, triggered = false } },
        rarity = 1,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    harpSealJoker = {
        ability_name = "MMC Harp Seal",
        slug = "mmc_harp_seal",
        ability = {},
        rarity = 2,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    footballCardJoker = {
        ability_name = "MMC Football Card",
        slug = "mmc_football_card",
        ability = { extra = { chips = 50 } },
        rarity = 2,
        cost = 7,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    specialEditionJoker = {
        ability_name = "MMC Special Edition Joker",
        slug = "mmc_special_edition",
        ability = { extra = { current_mult = 0, mult_mod = 2, current_chips = 0, chip_mod = 10, current_Xmult = 1, Xmult_mod = 0.1, base = 0 } },
        rarity = 2,
        cost = 6,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    stockpilerJoker = {
        ability_name = "MMC The Stockpiler",
        slug = "mmc_stockpiler",
        ability = { extra = { current_h_size = 0, h_mod = 1, base = 52, every = 4 } },
        rarity = 1,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    },
    studentLoansJoker = {
        ability_name = "MMC Student Loans",
        slug = "mmc_student_loans",
        ability = { extra = { negative_bal = 100, every = 25, discards = 0, discard_sub = 1 } },
        rarity = 2,
        cost = 4,
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true
    },
    brokeJoker = {
        ability_name = "MMC Broke Joker",
        slug = "mmc_broke",
        ability = { extra = { current_mult = 0, mult_mod = 1, every = 2 } },
        rarity = 1,
        cost = 2,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true
    }
}

-- Local variables
local for_hire_counter = 0

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
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_even_steven', nil)
                card:add_to_deck()
                G.jokers:emplace(card)

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
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_odd_todd', nil)
                card:add_to_deck()
                G.jokers:emplace(card)

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
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_fibonacci', nil)
                card:add_to_deck()
                G.jokers:emplace(card)

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
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mmc_prime_time', nil)
                card:add_to_deck()
                G.jokers:emplace(card)

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
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_midas_mask', nil)
                card:add_to_deck()
                G.jokers:emplace(card)

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
                for_hire_counter = 0
                return true
            end
        }))
    end

    if arg_56_0.effect.config.mmc_precision then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Add The Sniper Joker
                local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mmc_sniper', nil)
                card:set_edition({ negative = true })
                card:add_to_deck()
                G.jokers:emplace(card)
                return true
            end
        }))
    end
end

function SMODS.INIT.MikasModCollection()
    -- Localization
    G.localization.misc.dictionary.k_mmc_upgrade = "Upgrade!"
    G.localization.misc.dictionary.k_mmc_charging = "Charging..."
    G.localization.misc.dictionary.k_mmc_bonus = "Bonus!"
    G.localization.misc.dictionary.k_mmc_reset = "Reset!"
    G.localization.misc.dictionary.k_mmc_hand_up = "+ Hand Size!"
    G.localization.misc.dictionary.k_mmc_hand_down = "- Hand Size!"
    G.localization.misc.dictionary.k_mmc_tick = "Tick..."
    G.localization.misc.dictionary.k_mmc_planet = "Planet!"
    G.localization.misc.dictionary.k_mmc_luck = "+ Luck!"

    init_localization()

    -- Initialize Decks
    for k, v in pairs(decks) do
        if config[k] then
            local newDeck = SMODS.Deck:new(v.name, k, v.config, v.sprite, locs[k])
            newDeck:register()
        end
    end

    -- Initialize Jokers
    for k, v in pairs(jokers) do
        if config[k] then
            local joker = SMODS.Joker:new(v.ability_name, v.slug, v.ability, { x = 0, y = 0 }, locs[k],
                v.rarity, v.cost, v.unlocked, v.discovered, v.blueprint_compat, v.eternal_compat)
            joker:register()
            local sprite = SMODS.Sprite:new("j_" .. v.slug, SMODS.findModByID("MikasMods").path,
                "j_" .. v.slug .. ".png", 71, 95, "asset_atli")
            sprite:register()
        end
    end

    -- Joker calculations
    if config.primeTimeJoker then
        SMODS.Jokers.j_mmc_prime_time.calculate = function(self, context)
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
                if self.ability.extra.current_h_size > 0 then
                    self.ability.extra.current_h_size = math.max(0,
                        self.ability.extra.current_h_size - self.ability.extra.h_mod)
                    G.hand:change_size(-self.ability.extra.h_mod)
                    -- Decrease message
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_hand_down') })
                end
            end

            -- Increase hand size
            if context.pre_discard then
                self.ability.extra.current_h_size = self.ability.extra.current_h_size + self.ability.extra.h_mod
                G.hand:change_size(self.ability.extra.h_mod)
                -- Increase message
                card_eval_status_text(self, 'extra', nil, nil, nil,
                    { message = localize('k_mmc_hand_up') })
            end

            -- Reset hand size
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.current_h_size ~= 0 then
                    G.hand:change_size(-self.ability.extra.current_h_size)
                    self.ability.extra.current_h_size = 0
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
                if self.ability.extra.current_mult > 0 then
                    return {
                        message = localize {
                            type = 'variable',
                            key = 'a_mult',
                            vars = { self.ability.extra.current_mult }
                        },
                        mult_mod = self.ability.extra.current_mult,
                        card = self
                    }
                end
            end

            -- Increase mult for each discarded card
            if context.discard then
                self.ability.extra.current_mult = self.ability.extra.current_mult + self.ability.extra.mult_mod
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult_mod } },
                    colour = G.C.RED,
                    card = self
                }
            end

            -- Reset mult
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.current_mult ~= 0 then
                    self.ability.extra.current_mult = 0
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
                self.ability.extra.old = self.ability.extra.current_Xmult
                self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra.Xmult_mod

                -- Apply xmult
                if self.ability.extra.old > 1 then
                    return {
                        message = localize {
                            type = 'variable',
                            key = 'a_xmult',
                            vars = { self.ability.extra.old }
                        },
                        Xmult_mod = self.ability.extra.old,
                        card = self
                    }
                end
            end

            -- Reset mult
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.current_Xmult ~= 1 then
                    self.ability.extra.current_Xmult = 1
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
                        vars = { self.ability.extra.current_chips }
                    },
                    chip_mod = self.ability.extra.current_chips,
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
                    self.ability.extra.chip_mod
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
                    self.ability.extra.old = self.ability.extra.dollars
                    self.ability.extra.dollars = 0
                    self.ability.extra.seven_tally = 0
                    return {
                        message = localize('$') .. self.ability.extra.old,
                        dollars = self.ability.extra.old,
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
                if self.ability.extra.action_tally == self.ability.extra.every + 1 then
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
                self.ability.extra.action_tally = (self.ability.extra.action_tally % self.ability.extra.every) + 1
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
                if self.ability.extra.current_Xmult > 1 then
                    return {
                        message = localize {
                            type = 'variable',
                            key = 'a_xmult',
                            vars = { self.ability.extra.current_Xmult }
                        },
                        Xmult_mod = self.ability.extra.current_Xmult,
                        card = self
                    }
                end
            end

            -- Add scored chips to total
            if context.mmc_scored_chips then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.mmc_scored_chips
            end

            -- See if total scored chips > 2 * blind chips, then increment xmult
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.total_chips > (self.ability.extra.req * G.GAME.blind.chips) then
                    self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra.Xmult_mod

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
                if self.ability.extra.current_Xmult > 1 then
                    return {
                        message = localize {
                            type = 'variable',
                            key = 'a_xmult',
                            vars = { self.ability.extra.current_Xmult }
                        },
                        Xmult_mod = self.ability.extra.current_Xmult,
                        card = self
                    }
                end
            end

            -- Add scored chips to total
            if context.mmc_scored_chips then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.mmc_scored_chips
            end

            -- See if total scored chips == blind chips, then increment xmult
            if context.end_of_round and not context.individual and not context.repetition then
                if self.ability.extra.total_chips == G.GAME.blind.chips then
                    self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra.Xmult_mod

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
            if context.before then
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

                        -- Reset rank_tally
                        self.ability.extra.updated_rank_tally = {}
                    end
                end
            end

            -- When hand is played
            if SMODS.end_calculate_context(context) then
                -- For every rank_tally, check if we got 21
                for _, v in ipairs(self.ability.extra.rank_tally) do
                    if v == self.ability.extra.req then
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
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.current_mult } },
                    mult_mod = self.ability.extra.current_mult
                }
            end

            -- Add scored chips to total
            if context.mmc_scored_chips then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.mmc_scored_chips

                if self.ability.extra.total_chips < G.GAME.blind.chips then
                    self.ability.extra.current_mult = self.ability.extra.current_mult + self.ability.extra.mult_mod
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
                        vars = { self.ability.extra.current_mult }
                    },
                    mult_mod = self.ability.extra.current_mult,
                    card = self
                }
            end

            -- Decrease round_left counter or destroy
            if context.end_of_round and not context.individual and not context.repetition then
                self.ability.extra._every = self.ability.extra._every - 1

                if self.ability.extra._every <= 0 then
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
                    self.ability.extra.current_mult = self.ability.extra.current_mult + self.ability.extra.mult_mod
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_tick'), colour = G.C.RED })
                end
            end
        end
    end

    if config.alphabetJoker then
        SMODS.Jokers.j_mmc_alphabet.calculate = function(self, context)
            -- Check if Joker name contains letter and apply chips
            if context.other_joker and context.other_joker ~= self and context.other_joker.ability.set == 'Joker' then
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
                if self.ability.extra.current_chips > 0 then
                    self.ability.extra.old_chips = self.ability.extra.current_chips
                    self.ability.extra.current_chips = 0
                    return {
                        message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.old_chips } },
                        chip_mod = self.ability.extra.old_chips
                    }
                end
            end

            -- Add scored chips to total
            if context.mmc_scored_chips then
                self.ability.extra.total_chips = self.ability.extra.total_chips + context.mmc_scored_chips
            end

            if context.end_of_round and not context.individual and not context.repetition then
                -- Add excess chips to bonus
                if self.ability.extra.total_chips >= G.GAME.blind.chips then
                    self.ability.extra.current_chips = self.ability.extra.total_chips - G.GAME.blind.chips
                    self.ability.extra.current_chips = math.ceil(math.min(
                        G.GAME.blind.chips * self.ability.extra.percentage / 100,
                        self.ability.extra.current_chips))
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
                if context.scoring_name == 'High Card' then
                    if context.other_card.ability.effect == 'Base' then
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
                        v:set_ability(get_random_in_table(enhancements), nil, true)
                        card_eval_status_text(self, 'extra', nil, nil, nil,
                            {
                                message = localize('k_mmc_upgrade'),
                                delay = 0.45
                            })
                    end
                end
                -- Reset card_refs
                self.ability.extra.card_refs = {}
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
            if context.before then
                for _, v in ipairs(context.full_hand) do
                    table.insert(self.ability.extra.current_cards, v.base.id)
                end
            end

            -- Calculate chip score
            if context.mmc_scored_chips then
                self.ability.extra.current_chips = context.mmc_scored_chips
                self.ability.extra.current_chips = math.ceil(math.min(
                    G.GAME.blind.chips * self.ability.extra.percentage / 100,
                    self.ability.extra.current_chips))
            end

            -- Apply chips if previous cards are the same as the current cards
            if SMODS.end_calculate_context(context) then
                if tables_equal(self.ability.extra.prev_cards, self.ability.extra.current_cards) then
                    self.ability.extra.prev_cards = tables_copy(self.ability.extra.current_cards)
                    self.ability.extra.current_cards = {}
                    return {
                        message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.current_chips } },
                        chip_mod = self.ability.extra.current_chips
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

    if config.printerJoker then
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
                        G.hand:emplace(_card)
                        _card.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:start_materialize()
                                return true
                            end
                        }))
                        -- Show message
                        card_eval_status_text(self, 'extra', nil, nil, nil, {
                            message = localize('k_copied_ex'),
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

    if config.shyJoker then
        SMODS.Jokers.j_mmc_shy.calculate = function(self, context)
            -- Add xmult for every played card
            if context.individual and context.cardarea == G.play then
                self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra.Xmult_mod
                card_eval_status_text(self, 'extra', nil, nil, nil,
                    {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.current_Xmult } },
                        colour = G.C.MULT
                    })
            end

            -- Apply xmult
            if SMODS.end_calculate_context(context) then
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = { self.ability.extra.current_Xmult }
                    },
                    Xmult_mod = self.ability.extra.current_Xmult,
                    card = self
                }
            end
        end
    end

    if config.gamblerJoker then
        SMODS.Jokers.j_mmc_gambler.calculate = function(self, context)
            -- Retrigger lucky cards
            if context.repetition and context.cardarea == G.play then
                if context.other_card.ability.effect == "Lucky Card" then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = self.ability.extra,
                        card = self
                    }
                end
            end
        end
    end

    if config.incompleteJoker then
        SMODS.Jokers.j_mmc_incomplete.calculate = function(self, context)
            -- Check if hand is less than 3 cards, then apply chips
            if SMODS.end_calculate_context(context) then
                if #context.full_hand <= self.ability.extra.req then
                    return {
                        message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                        chip_mod = self.ability.extra.chips
                    }
                end
            end
        end
    end

    if config.abbeyRoadJoker then
        SMODS.Jokers.j_mmc_abbey_road.calculate = function(self, context)
            if context.after and context.cardarea == G.jokers then
                -- Reset hand count
                self.ability.extra.hand_equal_count = {}

                -- Count occurance of all hands
                for _, v in ipairs(G.handlist) do
                    if G.GAME.hands[v].played > 0 then
                        if self.ability.extra.hand_equal_count[G.GAME.hands[v].played] == nil then
                            self.ability.extra.hand_equal_count[G.GAME.hands[v].played] = 1
                        else
                            self.ability.extra.hand_equal_count[G.GAME.hands[v].played] =
                                self.ability.extra.hand_equal_count[G.GAME.hands[v].played] + 1
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

            if SMODS.end_calculate_context(context) then
                if self.ability.extra.should_trigger then
                    self.ability.extra.should_trigger = false
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.Xmult } },
                        Xmult_mod = self.ability.extra.Xmult,
                        card = self
                    }
                end
            end
        end
    end

    if config.boatingLicenseJoker then
        SMODS.Jokers.j_mmc_boating_license.calculate = function(self, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card.ability.effect == "Bonus Card" or context.other_card.ability.effect == "Stone Card" then
                    return {
                        message = localize { type = 'variable', key = 'a_chips', vars = { context.other_card.ability.bonus } },
                        chips = context.other_card.ability.bonus,
                        card = self
                    }
                elseif context.other_card.ability.effect == "Mult Card" then
                    return {
                        message = localize { type = 'variable', key = 'a_mult', vars = { context.other_card.ability.mult } },
                        mult = context.other_card.ability.mult,
                        card = self
                    }
                elseif context.other_card.ability.effect == "Glass Card" then
                    return {
                        message = localize { type = 'variable', key = 'Xmult', vars = { context.other_card.ability.Xmult } },
                        Xmult = context.other_card.ability.Xmult,
                        card = self
                    }
                elseif context.other_card.ability.effect == "Lucky Card" then
                    if pseudorandom('lucky_money') < G.GAME.probabilities.normal / 15 then
                        ease_dollars(context.other_card.ability.p_dollars)
                        card_eval_status_text(self, 'extra', nil, nil, nil,
                            {
                                message = localize('$') .. context.other_card.ability.p_dollars,
                                dollars = context.other_card.ability.p_dollars,
                                colour = G.C.MONEY,
                                delay = 0.45
                            })
                    end
                    if pseudorandom('lucky_mult') < G.GAME.probabilities.normal / 5 then
                        return {
                            message = localize { type = 'variable', key = 'a_mult', vars = { context.other_card.ability.mult } },
                            mult = context.other_card.ability.mult,
                            card = self
                        }
                    end
                end
            end
        end
    end

    if config.bankerJoker then
        SMODS.Jokers.j_mmc_banker.calculate = function(self, context)
            -- Banker
            if context.end_of_round and not context.individual and not context.repetition then
                local gold_tally = 0
                -- Count all Gold Cards and Gold Seals
                for _, v in pairs(G.playing_cards) do
                    if v.ability.name == 'Gold Card' then
                        gold_tally = gold_tally + 1
                    end
                    if v.seal == 'Gold' then
                        gold_tally = gold_tally + 1
                    end
                end

                -- Give money and reset
                if gold_tally >= 1 then
                    ease_dollars(gold_tally * self.ability.extra.dollars)
                    return {
                        message = localize('$') .. gold_tally * self.ability.extra.dollars,
                        dollars = gold_tally * self.ability.extra.dollars,
                        colour = G.C.MONEY
                    }
                end
            end
        end
    end

    if config.riggedJoker then
        SMODS.Jokers.j_mmc_rigged.calculate = function(self, context)
            -- Check if lucky card does not trigger
            if context.individual and context.cardarea == G.play and context.other_card.ability.effect == "Lucky Card" then
                if not context.other_card.lucky_trigger and not self.ability.extra.has_triggered then
                    self.ability.extra.has_triggered = true
                end
            end

            -- Increase probabilities and reset has_triggered
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.has_triggered then
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_luck'), colour = G.C.GREEN })
                    self.ability.extra.probability = self.ability.extra.probability + self.ability.extra.probability
                    for k, v in pairs(G.GAME.probabilities) do
                        G.GAME.probabilities[k] = v + self.ability.extra.probability
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
                    card_eval_status_text(self, 'extra', nil, nil, nil,
                        { message = localize('k_mmc_reset') })
                end
            end
        end
    end

    if config.commanderJoker then
        SMODS.Jokers.j_mmc_commander.calculate = function(self, context)
            -- If first hand is single card, upgrade
            if G.GAME.current_round.hands_played == 0 then
                if context.before then
                    if #context.full_hand == 1 then
                        local _card = context.full_hand[1]

                        -- Animate card
                        G.E_MANAGER:add_event(Event({
                            delay = 0.5,
                            func = function()
                                _card:juice_up(0.3, 0.5)
                                -- Add seal and edition
                                if _card.ability.seal == nil then
                                    _card:set_seal(get_random_in_table(seals), nil, true)
                                end
                                if _card.edition == nil then
                                    _card:set_edition(get_random_in_table(card_editions), nil, true)
                                end
                                return true
                            end
                        }))

                        -- Add enhancement, outside of animate because this has a delay for some reason
                        if _card.ability.effect == 'Base' then
                            _card:set_ability(get_random_in_table(enhancements), nil, true)
                        end

                        -- Return message
                        card_eval_status_text(self, 'extra', nil, nil, nil,
                            { message = localize('k_mmc_upgrade') })
                    end
                end
            end
        end
    end

    if config.whatAreTheOddsJoker then
        SMODS.Jokers.j_mmc_what_are_the_odds.calculate = function(self, context)
            -- Count lucky triggers
            if context.individual and context.cardarea == G.play then
                for _, v in ipairs(context.full_hand) do
                    if v.lucky_trigger then
                        self.ability.extra.lucky_tally = self.ability.extra.lucky_tally + 1
                    end
                end
            end

            -- Check for 5 lucky triggers
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.lucky_tally >= 4 then
                    -- Create new negative Joker based on Judgement Tarot card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nil, 'jud')
                            card:set_edition({ negative = true })
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            return true
                        end
                    }))
                    -- Reset mult and return message
                    self.ability.extra.lucky_tally = 0
                    return { message = localize('k_plus_joker'), colour = G.C.BLUE }
                else
                    -- Nope!
                    self.ability.extra.lucky_tally = 0
                    return { message = localize('k_nope_ex'), colour = G.C.SECONDARY_SET.Tarot }
                end
            end
        end
    end

    if config.dagonetJoker then
        SMODS.Jokers.j_mmc_dagonet.calculate = function(self, context)
            if not context.repetition or context.individual then
                -- Reset defaults
                local other_dagonet_trigger = false
                self.ability.extra.triggered = false

                -- Increase multiplier based on how many Dagonets there are
                self.ability.extra._mult = self.ability.extra._base
                for _, v in ipairs(G.jokers.cards) do
                    if v ~= self then
                        if v.ability.name == 'MMC Dagonet' then
                            if v.ability.extra.triggered then
                                other_dagonet_trigger = true
                            end
                            self.ability.extra._mult = self.ability.extra._mult * 2
                        end
                    end
                end

                -- Loop over all jokers (excluding self)
                if not other_dagonet_trigger then
                    self.ability.extra.triggered = true
                    for _, v in ipairs(G.jokers.cards) do
                        if v ~= self then
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
        SMODS.Jokers.j_mmc_glue.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                -- Add xmult if we have both Half and Incomplete Joker
                if self.ability.extra.half and self.ability.extra.incomplete then
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

    if config.harpSealJoker then
        SMODS.Jokers.j_mmc_harp_seal.calculate = function(self, context)
            -- Give $3 for each Gold Seal
            if context.individual and context.cardarea == G.play and not context.repetition then
                if context.other_card.seal == 'Gold' then
                    ease_dollars(3)
                    return {
                        message = localize('$') .. 3,
                        dollars = 3,
                        colour = G.C.MONEY,
                        card = self
                    }
                end
            end

            -- Repeat Red Seals
            if context.repetition and context.cardarea == G.play then
                if context.other_card.seal == 'Red' then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = self
                    }
                end
            end

            -- Create tarot card for each Purple Seal
            if context.discard then
                if context.other_card.seal == 'Purple' then
                    -- Check consumeable space
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        -- Add card
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, '8ba')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)
                        }))
                        -- Show message
                        card_eval_status_text(self, 'extra', nil, nil, nil,
                            { message = localize('k_plus_tarot'), colour = G.C.PURPLE })
                    end
                end
            end
        end
    end

    if config.footballCardJoker then
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
                        message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                        chip_mod = self.ability.extra.chips
                    }
                end
            end
        end
    end

    if config.specialEditionJoker then
        SMODS.Jokers.j_mmc_special_edition.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                -- Add xmult if we have both Half and Incomplete Joker
                if self.ability.extra.current_mult > 0 or self.ability.extra.current_chips > 0
                    or self.ability.extra.current_Xmult > 1 then
                    return {
                        -- Return bonus message and apply bonus
                        mult_mod = self.ability.extra.current_mult,
                        chip_mod = self.ability.extra.current_chips,
                        Xmult_mod = self.ability.extra.current_Xmult,
                        message = localize('k_mmc_bonus'),
                        card = self
                    }
                end
            end
        end
    end

    if config.stockpilerJoker then
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
                    if self.ability.extra.current_h_size > 0 then
                        G.hand:change_size(-self.ability.extra.current_h_size)
                        self.ability.extra.current_h_size = 0
                    end
                end
            end
        end
    end

    if config.studentLoansJoker then
        SMODS.Jokers.j_mmc_student_loans.calculate = function(self, context)
            if not context.repetition or context.individual then
                -- Decrease discards based on negative balance
                local negative_bal = G.GAME.dollars
                if negative_bal < 0 then
                    local debuffs = math.ceil(negative_bal / self.ability.extra.every) * self.ability.extra.discard_sub
                    if debuffs ~= self.ability.extra.discards then
                        debuffs = debuffs - self.ability.extra.discards
                        ease_discard(debuffs)
                        G.GAME.round_resets.discards = G.GAME.round_resets.discards + debuffs
                        self.ability.extra.discards = self.ability.extra.discards + debuffs
                    end
                end
            end
        end
    end

    if config.brokeJoker then
        SMODS.Jokers.j_mmc_broke.calculate = function(self, context)
            if SMODS.end_calculate_context(context) then
                -- Apply mult
                if self.ability.extra.current_mult > 0 then
                    return {
                        message = localize {
                            type = 'variable',
                            key = 'a_mult',
                            vars = { self.ability.extra.current_mult }
                        },
                        mult_mod = self.ability.extra.current_mult,
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

        if self.ability.name == 'MMC Prime Time' then
            loc_vars = { self.ability.extra.Xmult }
        elseif self.ability.name == 'MMC Straight Nate' then
            loc_vars = { self.ability.extra.Xmult, self.ability.extra.j_slots }
        elseif self.ability.name == 'MMC The Fisherman' then
            loc_vars = { self.ability.extra.current_h_size, self.ability.extra.h_mod }
        elseif self.ability.name == 'MMC Impatient Joker' then
            loc_vars = { self.ability.extra.current_mult, self.ability.extra.mult_mod }
        elseif self.ability.name == 'MMC Cultist' then
            loc_vars = { self.ability.extra.current_Xmult, self.ability.extra.Xmult_mod }
        elseif self.ability.name == 'MMC Seal Collector' then
            loc_vars = { self.ability.extra.current_chips, self.ability.extra.chip_mod }
        elseif self.ability.name == 'MMC Camper' then
            loc_vars = { self.ability.extra.chip_mod }
        elseif self.ability.name == 'MMC Lucky Number Seven' then
            loc_vars = { self.ability.extra.dollar_gain_one, self.ability.extra.dollar_gain_two,
                self.ability.extra.dollar_gain_three, self.ability.extra.dollar_gain_four,
                self.ability.extra.dollar_gain_five }
        elseif self.ability.name == 'MMC Delayed Joker' then
            loc_vars = { self.ability.extra.mult, self.ability.extra.chips, self.ability.extra.Xmult,
                self.ability.extra.action_tally, self.ability.extra.every }
        elseif self.ability.name == 'MMC The Show-Off' then
            loc_vars = { self.ability.extra.current_Xmult, self.ability.extra.Xmult_mod, self.ability.extra.req }
        elseif self.ability.name == 'MMC The Sniper' then
            loc_vars = { self.ability.extra.current_Xmult, self.ability.extra.Xmult_mod }
        elseif self.ability.name == 'MMC Blackjack Joker' then
            loc_vars = { self.ability.extra.Xmult, self.ability.extra.req }
        elseif self.ability.name == 'MMC Batman' then
            loc_vars = { self.ability.extra.current_mult, self.ability.extra.mult_mod }
        elseif self.ability.name == 'MMC Bomb' then
            loc_vars = { self.ability.extra.current_mult, self.ability.extra.mult_mod, self.ability.extra._every }
        elseif self.ability.name == 'MMC Alphabet Joker' then
            loc_vars = { self.ability.extra.chips, self.ability.extra.letter }
        elseif self.ability.name == 'MMC Grudgeful Joker' then
            loc_vars = { self.ability.extra.current_chips, self.ability.extra.percentage }
        elseif self.ability.name == 'MMC Finishing Blow' then
            loc_vars = { self.ability.extra.enhancement }
        elseif self.ability.name == 'MMC Planetary Alignment' then
            loc_vars = { self.ability.extra.every }
        elseif self.ability.name == 'MMC Historical Joker' then
            loc_vars = { self.ability.extra.percentage }
        elseif self.ability.name == 'MMC Suit Alley' then
            loc_vars = { self.ability.extra.chips, self.ability.extra.mult }
        elseif self.ability.name == 'MMC The Printer' then
            loc_vars = {}
        elseif self.ability.name == 'MMC Shy Joker' then
            loc_vars = { self.ability.extra.current_Xmult, self.ability.extra.Xmult_mod }
        elseif self.ability.name == 'MMC The Gambler' then
            loc_vars = {}
        elseif self.ability.name == 'MMC Incomplete Joker' then
            loc_vars = { self.ability.extra.chips, self.ability.extra.req }
        elseif self.ability.name == 'MMC Abbey Road' then
            loc_vars = { self.ability.extra.Xmult, self.ability.extra.req }
        elseif self.ability.name == 'MMC Boating License' then
            loc_vars = {}
        elseif self.ability.name == 'MMC The Banker' then
            loc_vars = { self.ability.extra.dollars }
        elseif self.ability.name == 'MMC Rigged Joker' then
            loc_vars = { self.ability.extra.increase }
        elseif self.ability.name == 'MMC The Commander' then
            loc_vars = {}
        elseif self.ability.name == 'MMC What Are The Odds' then
            loc_vars = { self.ability.extra.req }
        elseif self.ability.name == 'MMC Dagonet' then
            loc_vars = {}
        elseif self.ability.name == 'MMC Glue' then
            loc_vars = { self.ability.extra.Xmult, self.ability.extra.j_slots }
        elseif self.ability.name == 'MMC Harp Seal' then
            loc_vars = {}
        elseif self.ability.name == 'MMC Football Card' then
            loc_vars = { self.ability.extra.chips }
        elseif self.ability.name == 'MMC Special Edition Joker' then
            loc_vars = { self.ability.extra.current_mult, self.ability.extra.mult_mod, self.ability.extra.current_chips,
                self.ability.extra.chip_mod, self.ability.extra.current_Xmult, self.ability.extra.Xmult_mod }
        elseif self.ability.name == 'MMC The Stockpiler' then
            loc_vars = { self.ability.extra.current_h_size, self.ability.extra.h_mod, self.ability.extra.base,
                self.ability.extra.every }
        elseif self.ability.name == 'MMC Student Loans' then
            loc_vars = { self.ability.extra.negative_bal, self.ability.extra.every, self.ability.extra.discards,
                self.ability.extra.discard_sub }
        elseif self.ability.name == 'MMC Broke Joker' then
            loc_vars = { self.ability.extra.mult_mod, self.ability.extra.current_mult, self.ability.extra.every }
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
        if self.ability.name == 'MMC Straight Nate' then
            -- Add Joker slot
            G.jokers.config.card_limit = G.jokers.config.card_limit + self.ability.extra.j_slots
        end

        if G.GAME.starting_params.mmc_for_hire and self.ability.set == 'Joker' then
            -- Add Joker slot and increment counter
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            for_hire_counter = for_hire_counter + 1
        end

        -- Glue
        if self.ability.name == 'Half Joker' then
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == 'MMC Glue' then
                    v.ability.extra.half = true
                    if v.ability.extra.incomplete then
                        v.ability.extra.triggered = true
                        G.jokers.config.card_limit = G.jokers.config.card_limit + v.ability.extra.j_slots
                    end
                end
            end
        end
        if self.ability.name == 'MMC Incomplete Joker' then
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == 'MMC Glue' then
                    v.ability.extra.incomplete = true
                    if v.ability.extra.half then
                        v.ability.extra.triggered = true
                        G.jokers.config.card_limit = G.jokers.config.card_limit + v.ability.extra.j_slots
                    end
                end
            end
        end
        if self.ability.name == 'MMC Glue' then
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == 'Half Joker' then
                    self.ability.extra.half = true
                end
                if v.ability.name == 'MMC Incomplete Joker' then
                    self.ability.extra.incomplete = true
                end
            end
            if self.ability.extra.half and self.ability.extra.incomplete then
                self.ability.extra.triggered = true
                G.jokers.config.card_limit = G.jokers.config.card_limit + self.ability.extra.j_slots
            end
        end

        if self.ability.name == 'MMC Student Loans' then
            G.GAME.bankrupt_at = G.GAME.bankrupt_at - self.ability.extra.negative_bal
        end
    end
    add_to_deckref(self, from_debuff)
end

local remove_from_deckref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    if self.added_to_deck then
        if self.ability.name == 'MMC Straight Nate' then
            -- Remove Joker slot
            G.jokers.config.card_limit = G.jokers.config.card_limit - self.ability.extra.j_slots
        end

        if G.GAME.starting_params.mmc_for_hire and self.ability.set == 'Joker' then
            -- Remove Joker slot and decrement counter
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
            for_hire_counter = for_hire_counter - 1
        end

        if self.ability.name == 'MMC The Fisherman' then
            -- Reset hand size
            if self.ability.extra.current_h_size ~= 0 then
                G.hand:change_size(-self.ability.extra.current_h_size)
                self.ability.extra.current_h_size = 0
            end
        end

        if self.ability.name == 'MMC Rigged Joker' then
            -- Reset probabilities
            if self.ability.extra.probability > 0 then
                for k, v in pairs(G.GAME.probabilities) do
                    G.GAME.probabilities[k] = v - self.ability.extra.probability
                end
                self.ability.extra.probability = 0
            end
        end

        if self.ability.name == 'MMC Dagonet' then
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

        -- Glue
        if self.ability.name == 'Half Joker' then
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == 'MMC Glue' then
                    v.ability.extra.half = false
                    if v.ability.extra.triggered then
                        v.ability.extra.triggered = false
                        G.jokers.config.card_limit = G.jokers.config.card_limit - v.ability.extra.j_slots
                    end
                end
            end
        end
        if self.ability.name == 'MMC Incomplete Joker' then
            for _, v in pairs(G.jokers.cards) do
                if v.ability.name == 'MMC Glue' then
                    v.ability.extra.incomplete = false
                    if v.ability.extra.triggered then
                        v.ability.extra.triggered = false
                        G.jokers.config.card_limit = G.jokers.config.card_limit - v.ability.extra.j_slots
                    end
                end
            end
        end
        if self.ability.name == 'MMC Glue' then
            if self.ability.extra.triggered then
                self.ability.extra.triggered = false
                G.jokers.config.card_limit = G.jokers.config.card_limit - self.ability.extra.j_slots
            end
        end

        if self.ability.name == 'MMC The Stockpiler' then
            G.hand:change_size(-self.ability.extra.current_h_size)
        end

        if self.ability.name == 'MMC Student Loans' then
            G.GAME.bankrupt_at = G.GAME.bankrupt_at + self.ability.extra.negative_bal
            ease_discard(-self.ability.extra.discards)
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - self.ability.extra.discards
        end
    end
    remove_from_deckref(self, from_debuff)
end

-- Handle cost increase
local set_costref = Card.set_cost
function Card.set_cost(self)
    set_costref(self)
    if self.ability.name == 'MMC Alphabet Joker' and not self.added_to_deck then
        self.ability.extra.letter = get_random_letter()
    end

    if G.GAME.starting_params.mmc_for_hire and (self.ability.set == 'Joker' or string.find(self.ability.name, 'Buffoon')) then
        -- Multiply cost exponentially with counter
        self.cost = self.cost * 2 ^ for_hire_counter
    end
end

-- Card updates
local card_updateref = Card.update
function Card.update(self, dt)
    if G.STAGE == G.STAGES.RUN then
        if self.ability.name == 'MMC Seal Collector' then
            self.ability.extra.current_chips = self.ability.extra.base
            -- Count all seal cards
            for _, v in pairs(G.playing_cards) do
                if v.seal ~= nil then
                    -- Add chips to total
                    self.ability.extra.current_chips = self.ability.extra.current_chips + self.ability.extra.chip_mod
                end
            end
        end

        if self.ability.name == 'MMC Batman' then
            self.ability.extra.mult_mod = self.ability.extra.base
            -- Count all jokers with 'Joker' in the name
            for _, v in pairs(G.jokers.cards) do
                if string.find(v.ability.name, 'Joker') then
                    -- Increase mult gain
                    self.ability.extra.mult_mod = self.ability.extra.mult_mod + 1
                end
            end
        end

        if self.ability.name == 'MMC Special Edition Joker' then
            -- Reset defaults
            self.ability.extra.current_mult = 0
            self.ability.extra.current_chips = 0
            self.ability.extra.current_Xmult = 1
            -- Count all special cards
            for _, v in pairs(G.playing_cards) do
                if v.seal ~= nil then
                    self.ability.extra.current_mult = self.ability.extra.current_mult + self.ability.extra.mult_mod
                end
                if v.ability.set == 'Enhanced' then
                    self.ability.extra.current_chips = self.ability.extra.current_chips + self.ability.extra.chip_mod
                end
                if v.edition ~= nil then
                    self.ability.extra.current_Xmult = self.ability.extra.current_Xmult + self.ability.extra.Xmult_mod
                end
            end
        end

        if self.ability.name == 'MMC Broke Joker' then
            -- Update mult based on negative balance
            local negative_bal = G.GAME.dollars
            if negative_bal < 0 then
                self.ability.extra.current_mult = -1 * math.ceil(negative_bal / self.ability.extra.every) *
                    self.ability.extra.mult_mod
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
            { card = G.consumeables, after = true, mmc_scored_chips = hand_chips * mult })
        if effects.jokers then
            card_eval_status_text(G.jokers.cards[i], 'jokers', nil, 0.3, nil, effects.jokers)
        end
    end
end

-- Handle end of round card effects
local get_end_of_round_effectref = Card.get_end_of_round_effect
function Card.get_end_of_round_effect(self, context)
    if self.seal == 'Blue' then
        for _, v in pairs(G.jokers.cards) do
            -- Check for Planetary Alignment Joker and consumeable space
            if v.ability.name == 'MMC Planetary Alignment' and v.ability.extra.round % v.ability.extra.every == 0
                and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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

            -- Create planet for each Blue Seal
            if v.ability.name == 'MMC Harp Seal' and
                #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                -- Add card
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        local card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'blusl')
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

    -- Call base function and return result
    local ret = get_end_of_round_effectref(self, context)
    return ret
end

----------------------------------------------
------------MOD CODE END----------------------
