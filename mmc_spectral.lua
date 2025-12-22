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

end
