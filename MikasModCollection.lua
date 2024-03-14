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
    evenStevenDeck = false,
    oddToddDeck = false,
    fibonacciDeck = false,
    primeDeck = false, -- Do not enable without primeJoker
    midasDeck = false,
    jokersForHireDeck = false,
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
    sniperJoker = true
}

-- Helper functions
local function isEven(card)
    local id = card:get_id()
    return id <= 10 and id % 2 == 0
end

local function isOdd(card)
    local id = card:get_id()
    return (id % 2 ~= 0 and id < 10) or id == 14
end

local function isFibo(card)
    local id = card:get_id()
    return id == 2 or id == 3 or id == 5 or id == 8 or id == 14
end

local function isPrime(card)
    local id = card:get_id()
    return id == 2 or id == 3 or id == 5 or id == 7 or id == 14
end

local function isFace(card)
    local id = card:get_id()
    return id == 11 or id == 12 or id == 13
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
                    if not isEven(G.playing_cards[i]) then
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
                    if not isOdd(G.playing_cards[i]) then
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
                    if not isFibo(G.playing_cards[i]) then
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
                    if not isPrime(G.playing_cards[i]) then
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
                    if not isFace(G.playing_cards[i]) then
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
            "increase {C:red}exponentially",
        }
    },
    primeJoker = {
        name = "Prime Joker",
        text = {
            "Each played {C:attention}2{},",
            "{C:attention}3{}, {C:attention}5{}, {C:attention}7{} or {C:attention}Ace{}, gives",
            "{X:mult,C:white} X#1# {} Mult when scored"
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
            "{C:inactive}(Currently {C:chips}+#1#{} Chips)"
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
            "{C:inactive}(Current action: {C:attention}#4#{}{C:inactive})"
        }
    },
    showoffJoker = {
        name = "The Show-Off",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult when",
            "a blind is finished with",
            "{C:attention}2x{} the chip requirement",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} Mult)"
        }
    },
    sniperJoker = {
        name = "The Sniper",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult when",
            "a blind is finished with",
            "the {C:attention}exact{} chip requirement",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} Mult)"
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
        ability_name = "MMC Show-Off",
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
        ability_name = "MMC Sniper",
        slug = "mmc_sniper",
        ability = { extra = { Xmult = 1, Xmult_add = 4, total_chips = 0 } },
        rarity = 4,
        cost = 15,
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
            local newJoker = SMODS.Joker:new(value.ability_name, value.slug, value.ability, { x = 0, y = 0 }, locs[key],
                value.rarity, value.cost, value.unlocked, value.discovered, value.blueprint_compat, value.eternal_compat)
            newJoker:register()
            SMODS.Sprite:new("j_" .. value.slug, SMODS.findModByID("MikasMods").path,
                "j_" .. value.slug .. ".png", 71, 95, "asset_atli"):register()
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
            if context.end_of_round then
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
            if context.end_of_round then
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
            if context.end_of_round then
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
                elseif self.ability.extra.seven_tally == 5 then
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
            if context.end_of_round then
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
            if context.end_of_round then
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
        elseif self.ability.name == 'MMC Show-Off' then
            loc_vars = { self.ability.extra.Xmult, self.ability.extra.Xmult_add }
        elseif self.ability.name == 'MMC Sniper' then
            loc_vars = { self.ability.extra.Xmult, self.ability.extra.Xmult_add }
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
            for _, v in pairs(G.playing_cards) do
                if v.seal ~= nil then
                    -- Add chips to total
                    self.ability.extra.chips = self.ability.extra.chips + self.ability.extra.chips_add
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

----------------------------------------------
------------MOD CODE END----------------------
