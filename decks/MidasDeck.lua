--- STEAMODDED HEADER
--- MOD_NAME: Midas's Deck
--- MOD_ID: Midasdeck
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: Adds a deck with only gold face cards, that starts with the Midas Mask joker

----------------------------------------------
------------MOD CODE -------------------------

-- Local functions

-- Check if val is a face card
local function isFace(card)
	local id = card:get_id()
	return id == 11 or id == 12 or id == 13
end

-- Add custom effect to config
local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(arg_56_0)
	Backapply_to_runRef(arg_56_0)

	if arg_56_0.effect.config.gold then
		G.E_MANAGER:add_event(Event({
			func = function()

				-- Loop over all cards
				for iter_57_0 = #G.playing_cards, 1, -1 do
					if not isFace(G.playing_cards[iter_57_0]) then
						-- Remove non face cards
						G.playing_cards[iter_57_0]:start_dissolve(nil, true)
					else
						-- Set to gold
						G.playing_cards[iter_57_0]:set_ability(G.P_CENTERS.m_gold)
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
end

-- Create Deck
local loc_def = {
	["name"]="Midas's Deck",
	["text"]={
		[1]="Start run with only",
		[2]="{C:attention}Gold Face cards{} and",
		[3]="the {C:attention}Midas Mask{} joker",
	},
}

-- Initialize Deck
local midasDeck = SMODS.Deck:new("Midas's Deck", "midasdeck", {gold = true}, {x = 6, y = 0}, loc_def)
midasDeck:register()

----------------------------------------------
------------MOD CODE END----------------------