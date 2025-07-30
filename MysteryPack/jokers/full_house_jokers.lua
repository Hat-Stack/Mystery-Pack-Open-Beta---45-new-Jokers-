
SMODS.Joker{
	key = "playful",
	atlas = "jokers",
	pos = {x=2,y=5},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	config = {
		t_mult = 12,
		t_chips = 0,
		type = "Full House"
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.t_mult, localize(center.ability.type, "poker_hands")}}
	end
}

SMODS.Joker{
	key = "tricky",
	atlas = "jokers",
	pos = {x=3,y=5},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	config = {
		t_mult = 0,
		t_chips = 100,
		type = "Full House"
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.t_chips, localize(center.ability.type, "poker_hands")}}
	end
}

SMODS.Joker{
	key = "pyramid",
	atlas = "jokers",
	pos = {x=4,y=5},
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	config = {
		extra = {x_mult = 4},
		type = "Full House"
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.extra.x_mult, localize(center.ability.type, "poker_hands")}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands[card.ability.type]) then
			return {x_mult = card.ability.extra.x_mult}
		end
	end,
}