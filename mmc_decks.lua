return function(config, helpers)
    -- Unpack helper functions
    local init_joker = helpers.init_joker
    local init_tarot = helpers.init_tarot
    local init_spectral = helpers.init_spectral
    local create_tarot = helpers.create_tarot
    local create_planet = helpers.create_planet
    local is_even = helpers.is_even
    local is_odd = helpers.is_odd
    local is_fibo = helpers.is_fibo
    local is_prime = helpers.is_prime
    local is_face = helpers.is_face
    local remove_prefix = helpers.remove_prefix
    local count_letters = helpers.count_letters
    local tables_equal = helpers.tables_equal
    local tables_copy = helpers.tables_copy
    local increase_attributes = helpers.increase_attributes
    local get_mikas_jokers = helpers.get_mikas_jokers
    local get_chips_jokers = helpers.get_chips_jokers
    local get_mult_jokers = helpers.get_mult_jokers
    local get_xmult_jokers = helpers.get_xmult_jokers
    local get_money_jokers = helpers.get_money_jokers
    local get_support_jokers = helpers.get_support_jokers
    local letters = helpers.letters
    local enhancements = helpers.enhancements
    local seals = helpers.seals
    local attributes = helpers.attributes
    local dagonet_blacklist = helpers.dagonet_blacklist
    local cicero_blacklist = helpers.cicero_blacklist
    local cicero_whitelist = helpers.cicero_whitelist

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

end
