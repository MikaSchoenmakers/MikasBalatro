--- STEAMODDED HEADER
--- MOD_NAME: Odd Todd's Deck
--- MOD_ID: Todddeck
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: Adds a deck with only odd cards, that starts with the Odd Todd joker

----------------------------------------------
------------MOD CODE -------------------------

-- Local functions

-- Check if value is odd
local function isOdd(card)
	local id = card:get_id()
	return (id % 2 ~= 0 and id < 10) or id == 14
end

-- Add custom effect to config
local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(arg_56_0)
	Backapply_to_runRef(arg_56_0)

	if arg_56_0.effect.config.only_odds then
		G.E_MANAGER:add_event(Event({
			func = function()

				-- Loop over all cards
				for iter_57_0 = #G.playing_cards, 1, -1 do
					-- Remove even cards
					if not isOdd(G.playing_cards[iter_57_0]) then
						G.playing_cards[iter_57_0]:start_dissolve(nil, true)
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
end

-- Create Deck
local loc_def = {
	["name"]="Odd Todd's Deck",
	["text"]={
		[1]="Start run with",
		[2]="only {C:attention}odd cards{} and",
		[3]="the {C:attention}Odd Todd{} joker"
	},
}

-- Initialize Deck
local oddToddDeck = SMODS.Deck:new("Odd Todd's Deck", "todddeck", {only_odds = true}, {x = 5, y = 2}, loc_def)
oddToddDeck:register()

----------------------------------------------
------------MOD CODE END----------------------