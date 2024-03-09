--- STEAMODDED HEADER
--- MOD_NAME: Prime Deck
--- MOD_ID: Primedeck
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: Adds a deck with only prime cards, that starts with the custom Prime joker. Requires the Prime joker mod from my GitHub!

----------------------------------------------
------------MOD CODE -------------------------

-- Local functions

-- Check if value is prime
local function isPrime(card)
	local id = card:get_id()
	return id == 2 or id == 3 or id == 5 or id == 7 or id == 14
end

-- Add custom effect to config
local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(arg_56_0)
	Backapply_to_runRef(arg_56_0)

	if arg_56_0.effect.config.only_prime then
		G.E_MANAGER:add_event(Event({
			func = function()

				-- Loop over all cards
				for iter_57_0 = #G.playing_cards, 1, -1 do
					-- Remove non prime cards
					if not isPrime(G.playing_cards[iter_57_0]) then
						G.playing_cards[iter_57_0]:start_dissolve(nil, true)
					end
				end

				-- Add Prime Joker
				local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_prime', nil)
                        card:add_to_deck()
                        G.jokers:emplace(card)

				return true
			end
		}))
	end
end

-- Create Deck
local loc_def = {
	["name"]="Prime Deck",
	["text"]={
		[1]="Start run with",
		[2]="only {C:attention}prime cards{} and",
		[3]="the {C:attention}Prime{} joker"
	},
}

-- Initialize Deck
local primeDeck = SMODS.Deck:new("Prime Deck", "primedeck", {only_prime = true}, {x = 5, y = 2}, loc_def)
primeDeck:register()

----------------------------------------------
------------MOD CODE END----------------------