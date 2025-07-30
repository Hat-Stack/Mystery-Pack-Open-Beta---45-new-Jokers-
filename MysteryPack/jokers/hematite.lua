
-- Hematite
SMODS.Joker{
	key = "hematite",
	atlas = "jokers",
	pos = {x=8,y=0},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	config = {
		extra = {
			mult_amount = 2,
			card = "m_wild"
		}
	},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS[center.ability.extra.card]
		return { vars = {center.ability.extra.mult_amount}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, card.ability.extra.card) then
				context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
				context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult_amount
				return {
					message = localize("k_upgrade_ex"),
					colour = G.C.MULT
				}
			end
		end
	end,
	enhancement_gate = "m_wild"
}