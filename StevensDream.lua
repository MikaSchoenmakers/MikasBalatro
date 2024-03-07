--- STEAMODDED HEADER
--- MOD_NAME: Stevens Dream
--- MOD_ID: Stevensdream
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: Adds a deck with only even cards

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

				return true
			end
		}))
	end
end

-- Create Deck
local loc_def = {
	["name"]="Stevens Dream",
	["text"]={
		[1]="A deck with only even cards!",
	},
}

-- Initialize Deck
local stevensDream = SMODS.Deck:new("Stevens Dream", "stevensdream", {only_evens = true}, {x = 0, y = 0}, loc_def)
stevensDream:register()

----------------------------------------------
------------MOD CODE END----------------------