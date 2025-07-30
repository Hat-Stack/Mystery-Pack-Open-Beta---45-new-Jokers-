
-- Snowball Joker
SMODS.Joker{
	key = "snowball_joker",
	atlas = "jokers",
	pos = {x=3,y=8},
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	config = {extra = {gain = 0.2, amount = 1}},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.gain, card.ability.extra.amount}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.amount > 1 then
			return {x_mult = card.ability.extra.amount}
		end
		if context.end_of_round and context.main_eval and not context.blueprint and not context.retrigger_joker and G.GAME.current_round.hands_played == 1 then
			card.ability.extra.amount = card.ability.extra.amount + card.ability.extra.gain
			return {
				message = localize("k_upgrade_ex"),
				colour = G.C.MULT
			}
		end
	end
}
