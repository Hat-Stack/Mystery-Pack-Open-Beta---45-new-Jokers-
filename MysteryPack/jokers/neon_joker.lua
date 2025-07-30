
-- Neon Joker
SMODS.Joker{
	key = "neon_joker",
	atlas = "jokers",
	pos = {x=5,y=2},
	rarity = 3,
	cost = 10,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = {
		extra = {
			left = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.left
		}}
	end,
	calculate = function(self, card, context)
		--if context.retrigger_joker_check and not context.retrigger_joker then
		--	if context.other_card.edition and context.other_card ~= self then
		--		return {repetitions = 1}
		--	end
		--end
		-- It's not working.
		-- Why is it not working?!
		if context.repetition and (context.cardarea == G.play or context.cardarea == G.hand) then
			if context.other_card.edition then
				return {repetitions = 1}
			end
		end
	end
}
