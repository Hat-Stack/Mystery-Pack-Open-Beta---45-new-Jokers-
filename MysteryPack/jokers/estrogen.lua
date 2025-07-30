
-- Estrogen
SMODS.Joker{
	key = "estrogen",
	atlas = "jokers",
	pos = {x=3,y=4},
	rarity = 2,
	cost = 5,
	blueprint_compat = false,
	perishable_compat= true,
	eternal_compat = true,
	calculate = function(self, card, context)
		if context.before and not context.blueprint and not context.retrigger_joker then
			local changed_cards = 0
			for _,v in ipairs(context.scoring_hand) do
				if v:is_face() and v:get_id() ~= 12 then
					v:flip()
					local change_amount = 12 - v:get_id()
					SMODS.modify_rank(v, change_amount)
					changed_cards = changed_cards + 1
					v:flip()
				end
			end
			if changed_cards > 0 then
				changed_cards = 0
				return {
					message = localize("mypa_queenify_ex"),
					colour = G.C.MYPA_PINK
				} 
			end
		end
	end
}
