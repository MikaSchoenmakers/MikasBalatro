--- STEAMODDED HEADER
--- MOD_NAME: Even Steven's Deck
--- MOD_ID: Stevendeck
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: Adds a deck with only even cards that starts with the Even Steven joker

----------------------------------------------
------------MOD CODE -------------------------

-- Add custom effect to config
local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(arg_56_0)
	Backapply_to_runRef(arg_56_0)

	if arg_56_0.effect.config.only_evens then
		G.E_MANAGER:add_event(Event({
			func = function()

				-- Loop over all cards
				for iter_57_0 = #G.playing_cards, 1, -1 do
					
					-- Check if value is even
					local function isEven(val)
						local value = tonumber(val)

						if value then
							return value % 2 == 0
						else
							return false
						end
					end
					
					-- Remove non even cards
					if not isEven(G.playing_cards[iter_57_0].base.value) then
						G.playing_cards[iter_57_0]:start_dissolve(nil, true)
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
end

-- Create Deck
local loc_def = {
	["name"]="Even Steven's Deck",
	["text"]={
		[1]="Start run with",
		[2]="only {C:attention}Even{} cards and",
		[3]="the {C:attention}Even Steven{} joker"
	},
}

-- Initialize Deck
local evenStevenDeck = SMODS.Deck:new("Even Steven's Deck", "stevendeck", {only_evens = true}, {x = 5, y = 2}, loc_def)
evenStevenDeck:register()

----------------------------------------------
------------MOD CODE END----------------------