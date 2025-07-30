
SMODS.Joker{
	key = "peculiar",
	atlas = "jokers",
	pos = {x=8,y=5},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	config = {
		extra = {
			value = 12
		}
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.extra.value}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and context.scoring_name and G.GAME.hands[context.scoring_name] and context.scoring_name == "High Card" then
			return {mult = card.ability.extra.value}
		end
	end
}

SMODS.Joker{
	key = "savvy",
	atlas = "jokers",
	pos = {x=9,y=5},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	config = {
		extra = {
			value = 100
		}
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.extra.value}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and context.scoring_name and G.GAME.hands[context.scoring_name] and context.scoring_name == "High Card" then
			return {chips = card.ability.extra.value}
		end
	end
}

SMODS.Joker{
	key = "lone",
	atlas = "jokers",
	pos = {x=0,y=6},
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	config = {
		extra = {
			value = 4
		}
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.extra.value}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and context.scoring_name and G.GAME.hands[context.scoring_name] and context.scoring_name == "High Card" then
			return {x_mult = card.ability.extra.value}
		end
	end
}