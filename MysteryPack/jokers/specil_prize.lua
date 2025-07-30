
-- Specil Prize
SMODS.Joker{
	key = "specil_prize",
	atlas = "jokers",
	pos = {x=4,y=6},
	rarity = 2,
	cost = 5,
	blueprint_compat = false,
	perishable_compat= true,
	eternal_compat = true,
	config = {extra = {
		loss = -5,
		gain = 25
	}},
	loc_vars = function(self, info_queue, card)
		return {vars = {
			-card.ability.extra.loss,
			card.ability.extra.gain
		}}
	end,
	calc_dollar_bonus = function(self, card)
		return (pseudorandom("specil_prize_money_mypa") * (1 + card.ability.extra.gain - card.ability.extra.loss)) + card.ability.extra.loss
	end
}
