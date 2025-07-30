
-- Jokers Against Humanity
SMODS.Joker{
	key = "jokers_against_humanity",
	atlas = "jokers",
	pos = {x=9,y=4},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = {extra = {
		chips = 50,
		mult = 10,
		xmult = 1.5,
		money = 2,
	}},
	loc_vars = function(self, info_queue, card)
	return {vars = {
		card.ability.extra.chips,
		card.ability.extra.mult,
		card.ability.extra.xmult,
		card.ability.extra.money,
	}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit("Spades") then
			local choice = math.floor(pseudorandom("mypa_filled_blank") * 4) + 1
			if choice == 1 then return {chips = card.ability.extra.chips} end
			if choice == 2 then return {mult = card.ability.extra.mult} end
			if choice == 3 then return {xmult = card.ability.extra.xmult} end
			if choice == 4 then return {dollars = card.ability.extra.money} end
		end
	end
}
