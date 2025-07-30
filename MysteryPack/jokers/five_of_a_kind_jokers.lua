
SMODS.Joker{
	key = "lunatic",
	atlas = "jokers",
	pos = {x=5,y=5},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	config = {
		t_mult = 16,
		t_chips = 0,
		type = "Five of a Kind"
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.t_mult, localize(center.ability.type, "poker_hands")}}
	end,
	in_pool = function(self, args)
		if G.GAME.hands["Five of a Kind"].visible then
			return true
		else
			return false
		end
	end
}

SMODS.Joker{
	key = "cunning",
	atlas = "jokers",
	pos = {x=6,y=5},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	config = {
		t_mult = 0,
		t_chips = 200,
		type = "Five of a Kind"
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.t_chips, localize(center.ability.type, "poker_hands")}}
	end,
	in_pool = function(self, args)
		if G.GAME.hands["Five of a Kind"].visible then
			return true
		else
			return false
		end
	end
}

SMODS.Joker{
	key = "lineage",
	atlas = "jokers",
	pos = {x=7,y=5},
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	config = {
		extra = {x_mult = 5},
		type = "Five of a Kind"
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.extra.x_mult, localize(center.ability.type, "poker_hands")}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and next(context.poker_hands[card.ability.type]) then
			return {x_mult = card.ability.extra.x_mult}
		end
	end,
	in_pool = function(self, args)
		if G.GAME.hands["Five of a Kind"].visible then
			return true
		else
			return false
		end
	end
}