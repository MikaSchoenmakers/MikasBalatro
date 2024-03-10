--- STEAMODDED HEADER
--- MOD_NAME: Mika's Mod Collection
--- MOD_ID: Mikasmods
--- MOD_AUTHOR: [Mikadoe]
--- MOD_DESCRIPTION: A collection of Mika's Mods. Check the mod description for more information :)

----------------------------------------------
------------MOD CODE -------------------------

-- Config: DISABLE UNWANTED MODS HERE
local config = {
	-- Decks
	evenStevenDeck = true,
	oddToddDeck = true,
	fibonacciDeck = true,
	primeDeck = true,
	midasDeck = true,
	-- Jokers
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
				local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_prime', nil)
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
end

-- Create Localization
local loc_def_steven = {
	["name"]="Even Steven's Deck",
	["text"]={
		[1]="Start run with",
		[2]="only {C:attention}even cards{} and",
		[3]="the {C:attention}Even Steven{} joker"
	},
}

local loc_def_todd = {
	["name"]="Odd Todd's Deck",
	["text"]={
		[1]="Start run with",
		[2]="only {C:attention}odd cards{} and",
		[3]="the {C:attention}Odd Todd{} joker"
	},
}

local loc_def_fibo = {
	["name"]="Fibonacci Deck",
	["text"]={
		[1]="Start run with only",
		[2]="{C:attention}Fibonacci cards{} and",
		[3]="the {C:attention}Fibonacci{} joker"
	},
}

local loc_def_prime_deck = {
	["name"]="Prime Deck",
	["text"]={
		[1]="Start run with",
		[2]="only {C:attention}prime cards{} and",
		[3]="the {C:attention}Prime{} joker"
	},
}

local loc_def_midas = {
	["name"]="Midas's Deck",
	["text"]={
		[1]="Start run with only",
		[2]="{C:attention}Gold Face cards{} and",
		[3]="the {C:attention}Midas Mask{} joker",
	},
}

local loc_txt_prime_joker = {
    name = "Prime Joker",
    text = {
        "Each played {C:attention}2{},",
        "{C:attention}3{}, {C:attention}5{}, {C:attention}7{} or {C:attention}Ace{}, gives",
        "{X:mult,C:white} X1.2 {} Mult when scored"
    }
}

local loc_txt_nate = {
    name = "Straight Nate",
    text = {
        "{X:mult,C:white} X4 {} Mult if played hand",
        "contains a {C:attention}Straight{} and you have",
        "both {C:attention}Odd Todd{} and {C:attention}Even Steven.",
        "Also gives {C:dark_edition}+1{} Joker slot"
    }
}

-- Initialize
local evenStevenDeck = SMODS.Deck:new("Even Steven's Deck", "stevendeck", {only_evens = true}, {x = 5, y = 2}, loc_def_steven)
evenStevenDeck:register()

local oddToddDeck = SMODS.Deck:new("Odd Todd's Deck", "todddeck", {only_odds = true}, {x = 5, y = 2}, loc_def_todd)
oddToddDeck:register()

local fibonacciDeck = SMODS.Deck:new("Fibonacci Deck", "fibodeck", {only_fibo = true}, {x = 5, y = 2}, loc_def_fibo)
fibonacciDeck:register()

local primeDeck = SMODS.Deck:new("Prime Deck", "primedeck", {only_prime = true}, {x = 5, y = 2}, loc_def_prime_deck)
primeDeck:register()

local midasDeck = SMODS.Deck:new("Midas's Deck", "midasdeck", {gold = true}, {x = 6, y = 0}, loc_def_midas)
midasDeck:register()

local primeJoker = SMODS.Joker:new("Prime Joker", "prime", { extra = { Xmult = 1.2 } }, { x = 0, y = 4 }, loc_txt_prime_joker, 1, 4, true, true, true, true)

local straightNateJoker = SMODS.Joker:new("Straight Nate", "straight_nate", { extra = { Xmult = 4 } }, { x = 0, y = 0 }, loc_txt_nate,  3, 7, true, true, true, true)

function SMODS.INIT.MikasModCollection()
    primeJoker:register()

    straightNateJoker:register()

	-- Joker calculations
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

-- Handle card addition/removing
function Card:add_to_deck(from_debuff)
    if not self.added_to_deck then
        self.added_to_deck = true
        if self.ability.name == 'Straight Nate' then
			-- Add joker slot
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        end
    end
end

function Card:remove_from_deck(from_debuff)
    if self.added_to_deck then
        self.added_to_deck = false
        if self.ability.name == 'Straight Nate' then
			-- Remove joker slot
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        end
    end
end

----------------------------------------------
------------MOD CODE END----------------------