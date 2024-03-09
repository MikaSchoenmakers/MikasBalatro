--- STEAMODDED HEADER
--- MOD_NAME: Fibonacci Deck
--- MOD_ID: Fibodeck
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: Adds a deck with only the cards from the Fibonacci Sequence (Ace, 2, 3, 5, 8), that starts with the Fibonacci joker

----------------------------------------------
------------MOD CODE -------------------------

-- Local functions

-- Check if value is in the fibonacci sequence
local function isFibo(card)
	local id = card:get_id()
	return id == 2 or id == 3 or id == 5 or id == 8 or id == 14
end

-- Add custom effect to config
local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(arg_56_0)
	Backapply_to_runRef(arg_56_0)

	if arg_56_0.effect.config.only_fibo then
		G.E_MANAGER:add_event(Event({
			func = function()

				-- Loop over all cards
				for iter_57_0 = #G.playing_cards, 1, -1 do
					-- Remove non fibonacci cards
					if not isFibo(G.playing_cards[iter_57_0]) then
						G.playing_cards[iter_57_0]:start_dissolve(nil, true)
					end
				end

				-- Add Fibonacci Joker
				local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_fibonacci', nil)
                        card:add_to_deck()
                        G.jokers:emplace(card)

				return true
			end
		}))
	end
end

-- Create Deck
local loc_def = {
	["name"]="Fibonacci Deck",
	["text"]={
		[1]="Start run with only",
		[2]="{C:attention}Fibonacci cards{} and",
		[3]="the {C:attention}Fibonacci{} joker"
	},
}

-- Initialize Deck
local fibonacciDeck = SMODS.Deck:new("Fibonacci Deck", "fibodeck", {only_fibo = true}, {x = 5, y = 2}, loc_def)
fibonacciDeck:register()

----------------------------------------------
------------MOD CODE END----------------------