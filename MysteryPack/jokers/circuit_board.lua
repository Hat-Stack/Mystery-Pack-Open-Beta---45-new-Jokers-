

-- Circuit Board
SMODS.Joker{
	key = "circuit_board",
	atlas = "jokers",
	pos = {x=4,y=2},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	perishable_compat= true,
	eternal_compat = true,
	config = {
		extra = {
			chips = 50
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS["m_steel"]
		info_queue[#info_queue + 1] = G.P_CENTERS["m_gold"]
		return {vars = {
			card.ability.extra.chips
		}}
	end,
	in_pool = function(self, args)  -- it works with either enhancement so we can't use enhancement_gate :(
		for _,v in ipairs(G.playing_cards) do
			if SMODS.has_enhancement(v, "m_steel") or SMODS.has_enhancement(v, "m_gold") then
				return true
			end
		end
		return false
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and
		(SMODS.has_enhancement(context.other_card, "m_steel") or SMODS.has_enhancement(context.other_card, "m_gold")) then
			return {chips = card.ability.extra.chips}
		end
	end
}
