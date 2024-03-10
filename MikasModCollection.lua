--- STEAMODDED HEADER
--- MOD_NAME: Mika's Mod Collection
--- MOD_ID: Mikasmods
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: A collection of Mika's Mods. Check the mod description on GitHub for more information :)

----------------------------------------------
------------MOD CODE -------------------------

-- Config: DISABLE UNWANTED MODS HERE
local config = {
	evenStevenDeck = true,
	oddToddDeck = true,
	fibonacciDeck = true,
	primeDeck = true, -- Do not enable without primeJoker
	midasDeck = true,
	jokersForHireDeck = true,
	primeJoker = true,
	straightNateJoker = true
}

-- Helper functions
local function isEven(card)
	local id = card:get_id()
	return id <= 10 and id % 2 == 0
end

local function isOdd(card)
	local id = card:get_id()
	return (id % 2 ~= 0 and id < 10) or id == 14
end

local function isFibo(card)
	local id = card:get_id()
	return id == 2 or id == 3 or id == 5 or id == 8 or id == 14
end

local function isPrime(card)
	local id = card:get_id()
	return id == 2 or id == 3 or id == 5 or id == 7 or id == 14
end

local function isFace(card)
	local id = card:get_id()
	return id == 11 or id == 12 or id == 13
end

-- Local variables
local for_hire_counter = 0

-- Initialize deck effect
local Backapply_to_runRef = Back.apply_to_run
function Back.apply_to_run(arg_56_0)
	Backapply_to_runRef(arg_56_0)

	-- Even Steven Deck
	if arg_56_0.effect.config.only_evens then
		G.E_MANAGER:add_event(Event({
			func = function()
				-- Loop over all cards
				for i = #G.playing_cards, 1, -1 do
					-- Remove odd cards
					if not isEven(G.playing_cards[i]) then
						G.playing_cards[i]:start_dissolve(nil, true)
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

	-- Odd Todd Deck
	if arg_56_0.effect.config.only_odds then
		G.E_MANAGER:add_event(Event({
			func = function()
				-- Loop over all cards
				for i = #G.playing_cards, 1, -1 do
					-- Remove even cards
					if not isOdd(G.playing_cards[i]) then
						G.playing_cards[i]:start_dissolve(nil, true)
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

	-- Fibonacci Deck
	if arg_56_0.effect.config.only_fibo then
		G.E_MANAGER:add_event(Event({
			func = function()
				-- Loop over all cards
				for i = #G.playing_cards, 1, -1 do
					-- Remove non fibonacci cards
					if not isFibo(G.playing_cards[i]) then
						G.playing_cards[i]:start_dissolve(nil, true)
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

	-- Prime Deck
	if arg_56_0.effect.config.only_prime then
		G.E_MANAGER:add_event(Event({
			func = function()
				-- Loop over all cards
				for i = #G.playing_cards, 1, -1 do
					-- Remove non prime cards
					if not isPrime(G.playing_cards[i]) then
						G.playing_cards[i]:start_dissolve(nil, true)
					end
				end

				-- Add Prime Joker
				local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_mmc_prime', nil)
				card:add_to_deck()
				G.jokers:emplace(card)
				return true
			end
		}))
	end

	-- Midas Deck
	if arg_56_0.effect.config.gold then
		G.E_MANAGER:add_event(Event({
			func = function()
				-- Loop over all cards
				for i = #G.playing_cards, 1, -1 do
					if not isFace(G.playing_cards[i]) then
						-- Remove non face cards
						G.playing_cards[i]:start_dissolve(nil, true)
					else
						-- Set to gold
						G.playing_cards[i]:set_ability(G.P_CENTERS.m_gold)
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

	-- Jokers For Hire Deck
	if arg_56_0.effect.config.for_hire then
		G.E_MANAGER:add_event(Event({
			func = function()
				-- Increase joker limit
				G.jokers.config.card_limit = 9999
				
				-- Add effect to starting params
				G.GAME.starting_params.for_hire = true
				return true
			end
		}))
	end
end

-- Create Localization
local locs = {
	evenStevenDeck = {
		name = "Even Steven's Deck",
		text = {
			"Start run with only",
			"{C:attention}even cards{} and",
			"the {C:attention}Even Steven{} joker"
		}
	},
	oddToddDeck = {
		name = "Odd Todd's Deck",
		text = {
			"Start run with only",
			"{C:attention}odd cards{} and",
			"the {C:attention}Odd Todd{} joker"
		}
	},
	fibonacciDeck = {
		name = "Fibonacci Deck",
		text = {
			"Start run with only",
			"{C:attention}Fibonacci cards{} and",
			"the {C:attention}Fibonacci{} joker"
		}
	},
	primeDeck = {
		name = "Prime Deck",
		text = {
			"Start run with",
			"only {C:attention}prime cards{} and",
			"the {C:attention}Prime{} joker"
		}
	},
	midasDeck = {
		name = "Midas's Deck",
		text = {
			"Start run with only",
			"{C:attention}Gold Face cards{} and",
			"the {C:attention}Midas Mask{} joker"
		},
	},
	jokersForHireDeck = {
		name = "\"Jokers for Hire\" Deck",
		text = {
			"Start run with {C:dark_edition}9999{}",
			"Joker slots. Price of Jokers",
			"and Buffoon Packs",
			"increase {C:attention}exponentially"
		},
	},
	primeJoker = {
		name = "Prime Joker",
		text = {
			"Each played {C:attention}2{},",
			"{C:attention}3{}, {C:attention}5{}, {C:attention}7{} or {C:attention}Ace{}, gives",
			"{X:mult,C:white} X1.2 {} Mult when scored"
		}
	},
	straightNateJoker = {
		name = "Straight Nate",
		text = {
			"{X:mult,C:white} X4 {} Mult if played hand",
			"contains a {C:attention}Straight{} and you have",
			"both {C:attention}Odd Todd{} and {C:attention}Even Steven{}.",
			"Also gives {C:dark_edition}+1{} Joker slot"
		}
	}
}

-- Initialize Decks
local decks = {
	evenStevenDeck = { name = "Even Steven's Deck", config = { only_evens = true }, sprite = { x = 5, y = 2 } },
	oddToddDeck = { name = "Odd Todd's Deck", config = { only_odds = true }, sprite = { x = 5, y = 2 } },
	fibonacciDeck = { name = "Fibonacci Deck", config = { only_fibo = true }, sprite = { x = 5, y = 2 } },
	primeDeck = { name = "Prime Deck", config = { only_prime = true }, sprite = { x = 5, y = 2 } },
	midasDeck = { name = "Midas's Deck", config = { gold = true }, sprite = { x = 6, y = 0 } },
	jokersForHireDeck = { name = "Jokers for Hire", config = { for_hire = true }, sprite = { x = 6, y = 0 } }
}

for key, value in pairs(decks) do
	if config[key] then
		local newDeck = SMODS.Deck:new(value.name, key, value.config, value.sprite, locs[key])
		newDeck:register()
	end
end

-- Create Jokers
local jokers = {
	primeJoker = {
		ability_name = "Prime Joker",
		slug = "mmc_prime",
		ability = { extra = { Xmult = 1.2 } },
		sprite = { x = 0, y = 4 },
		rarity = 1,
		cost = 4,
		unlocked = true,
		discovered = true,
		blueprint_compat = true,
		eternal_compat = true
	},
	straightNateJoker = {
		ability_name = "Straight Nate",
		slug = "mmc_straight_nate",
		ability = { extra = { Xmult = 4 } },
		sprite = { x = 0, y = 0 },
		rarity = 3,
		cost = 7,
		unlocked = true,
		discovered = true,
		blueprint_compat = true,
		eternal_compat = true
	}
}

function SMODS.INIT.MikasModCollection()
	-- Initialize Jokers
	for key, value in pairs(jokers) do
		if config[key] then
			local newJoker = SMODS.Joker:new(value.ability_name, value.slug, value.ability, value.sprite, locs[key],
				value.rarity, value.cost, value.unlocked, value.discovered, value.blueprint_compat, value.eternal_compat)
			newJoker:register()
		end
	end

	-- Joker calculations
	if config.primeJoker then
		SMODS.Jokers.j_mmc_prime.calculate = function(self, context)
			if context.individual then
				if context.cardarea == G.play then
					if (context.other_card:get_id() == 2 or
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
		end
	end

	if config.straightNateJoker then
		SMODS.Jokers.j_mmc_straight_nate.calculate = function(self, context)
			if SMODS.end_calculate_context(context) then
				if next(context.poker_hands["Straight"]) then
					local todd = false;
					local steven = false;
					for _, v in pairs(G.jokers.cards) do
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
end

-- Handle card addition/removing
if config.straightNateJoker or config.jokersForHireDeck then
	function Card:add_to_deck(from_debuff)
		-- Straight Nate
		if not self.added_to_deck then
			self.added_to_deck = true
			if self.ability.name == 'Straight Nate' then
				-- Add joker slot
				G.jokers.config.card_limit = G.jokers.config.card_limit + 1
			end

			-- Jokers for Hire
			if self.ability.set == 'Joker' then
				sendDebugMessage("Added")
				for_hire_counter = for_hire_counter + 1
				sendDebugMessage(for_hire_counter)
			end
		end
	end

	function Card:remove_from_deck(from_debuff)
		-- Straight Nate
		if self.added_to_deck then
			self.added_to_deck = false
			if self.ability.name == 'Straight Nate' then
				-- Remove joker slot
				G.jokers.config.card_limit = G.jokers.config.card_limit - 1
			end

			-- Jokers for Hire
			if self.ability.set == 'Joker' then
				sendDebugMessage("Removed")
				for_hire_counter = for_hire_counter - 1
				sendDebugMessage(for_hire_counter)
			end
		end
	end
end

-- Handle cost increase
local set_costref = Card.set_cost
function Card.set_cost(self)
    set_costref(self)
	if self.ability.name ~= nil then
		sendDebugMessage(self.ability.name)
	end
    if G.GAME.starting_params.for_hire and (self.ability.set == 'Joker' or string.find(self.ability.name, 'Buffoon')) then
        self.cost = self.cost * 2^for_hire_counter
    end
end

----------------------------------------------
------------MOD CODE END----------------------