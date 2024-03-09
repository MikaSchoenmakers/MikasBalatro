--- STEAMODDED HEADER
--- MOD_NAME: Prime Joker
--- MOD_ID: Primejoker
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: Adds the Prime joker, that gives a 1.1x multiplier if the played hand contains any prime number (2, 3, 5, 7, Ace)

----------------------------------------------
------------MOD CODE -------------------------

local loc_txt = {
    name = "Prime Joker",
    text = {
        "Each played {C:attention}Ace{},",
        "{C:attention}2{}, {C:attention}3{}, {C:attention}5{}, or {C:attention}7{} gives",
        "{X:mult,C:white} X1.2 {} Mult when scored"
    }
}

local primeJoker = SMODS.Joker:new(
    "Prime Joker", "j_prime",
    { extra = { Xmult = 1.2 } },
    { x = 0, y = 4 }, loc_txt,
    1, 4, true, true, true, true
)

function SMODS.INIT.MikaPrimejoker()
    primeJoker:register()
end

local card_calculate_joker_ref = Card.calculate_joker
function Card.calculate_joker(self, context)
    local calculate_joker_ref = card_calculate_joker_ref(self, context)
    if context.individual then
        if context.cardarea == G.play then
            if self.ability.name == "Prime Joker" and (
                context.other_card:get_id() == 2 or 
                context.other_card:get_id() == 3 or 
                context.other_card:get_id() == 5 or 
                context.other_card:get_id() == 7 or 
                context.other_card:get_id() == 14) then
                    return {
                        x_mult = self.ability.extra.Xmult,
                        card = self
                    }
            end
        end
    end
    
    return calculate_joker_ref
end

----------------------------------------------
------------MOD CODE END----------------------