
-- Sunk Cost Fallacy
SMODS.Joker{
	key = "sunk_cost_fallacy",
	atlas = "jokers",
	pos = {x=9,y=2},
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	config = {
		extra = {
			gain = 0.25,
			current = 1,
			this_round_discarded = false
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.gain,
			card.ability.extra.current
		}}
	end,
	calculate = function(self, card, context)
		if context.pre_discard and not context.blueprint and not context.retrigger_joker then
			card.ability.extra.this_round_discarded = true
			if card.ability.extra.current > 1 then
				card.ability.extra.current = 1
				return {message = localize("k_reset"), colour = G.C.RED}
			end
		end
		if context.end_of_round and context.main_eval and not context.blueprint and not context.retrigger_joker then
			if not card.ability.extra.this_round_discarded then
				card.ability.extra.current = card.ability.extra.current + card.ability.extra.gain
				return {message = localize("mypa_sunk_cost_ex"), colour = G.C.RED}
			else
				card.ability.extra.this_round_discarded = nil
			end
		end
		if context.joker_main then
			if card.ability.extra.current > 1 then return {xmult = card.ability.extra.current} end
		end
	end
}
