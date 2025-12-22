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
end
