--- STEAMODDED HEADER
--- MOD_NAME: Straight Nate Joker
--- MOD_ID: StraightNate
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: Adds the Straight Nate joker, that gives a x4 multiplier if the hand contains a straight and you have both the Odd Todd and Even Steven jokers. Also gives 1 extra joker slot

----------------------------------------------
------------MOD CODE -------------------------

local loc_txt = {
    name = "Straight Nate",
    text = {
        "{X:mult,C:white} X4 {} Mult if played hand",
        "contains a {C:attention}Straight{} and you have",
        "both {C:attention}Odd Todd{} and {C:attention}Even Steven.",
        "Also gives {C:dark_edition}+1{} Joker slot"
    }
}

local straightNateJoker = SMODS.Joker:new(
    "Straight Nate", "straight_nate",
    { extra = { Xmult = 4 } },
    { x = 0, y = 0 }, loc_txt,
    3, 7, true, true, true, true
)

function SMODS.INIT.MikaStraightNateJoker()
    straightNateJoker:register()

    SMODS.Jokers.j_straight_nate.calculate = function(self, context)
        if SMODS.end_calculate_context(context) then
            if next(context.poker_hands["Straight"]) then
                local todd = false;
                local steven = false;
                for k, v in pairs(G.jokers.cards) do
                    if v.ability.name == "Odd Todd" then todd = true end
                    if v.ability.name == "Even Steven" then steven = true end
                end

                if todd and steven then
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { 4 } },
                        Xmult_mod = 4
                    }
                end
            end
        end
    end
end

function Card:add_to_deck(from_debuff)
    if not self.added_to_deck then
        self.added_to_deck = true
        if self.ability.name == 'Straight Nate' then
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        end
    end
end

function Card:remove_from_deck(from_debuff)
    if self.added_to_deck then
        self.added_to_deck = false
        if self.ability.name == 'Straight Nate' then
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        end
    end
end

----------------------------------------------
------------MOD CODE END----------------------
