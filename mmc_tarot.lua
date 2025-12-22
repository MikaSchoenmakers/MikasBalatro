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

end
