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

-- Export all helper functions
return {
    init_joker = init_joker,
    init_tarot = init_tarot,
    init_spectral = init_spectral,
    create_tarot = create_tarot,
    create_planet = create_planet,
    is_even = is_even,
    is_odd = is_odd,
    is_fibo = is_fibo,
    is_prime = is_prime,
    is_face = is_face,
    remove_prefix = remove_prefix,
    count_letters = count_letters,
    tables_equal = tables_equal,
    tables_copy = tables_copy,
    increase_attributes = increase_attributes,
    get_mikas_jokers = get_mikas_jokers,
    get_chips_jokers = get_chips_jokers,
    get_mult_jokers = get_mult_jokers,
    get_xmult_jokers = get_xmult_jokers,
    get_money_jokers = get_money_jokers,
    get_support_jokers = get_support_jokers,
    letters = letters,
    enhancements = enhancements,
    seals = seals,
    attributes = attributes,
    dagonet_blacklist = dagonet_blacklist,
    cicero_blacklist = cicero_blacklist,
    cicero_whitelist = cicero_whitelist,
}
