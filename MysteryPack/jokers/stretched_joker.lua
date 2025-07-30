
-- Stretched Joker
SMODS.Joker{
	key = "stretched_joker",
	atlas = "jokers",
	pos = {x=2,y=1},
	rarity = 3,
	cost = 9,
	blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
	calculate = function(self, card, context)
		if context.before and context.main_eval and context.full_hand and context.scoring_hand and
		G.hand.cards and G.hand.cards[1] then
		
			-- identify unscoring cards
			local unscoring_cards = {}
			for _,v in ipairs(context.full_hand) do
				local unscoring = true
				for a,b in ipairs(context.scoring_hand) do
					if b == v then
						unscoring = false
					end
				end
				if unscoring then unscoring_cards[#unscoring_cards+1] = v end
			end
			
			-- do the copying, but only if cards unscore
			for _,v in ipairs(unscoring_cards) do
				delay(0.1)
				G.E_MANAGER:add_event(Event({
					--trigger = "after",
					delay = 0.1,
					func = function()
						v:flip()
						copy_card(G.hand.cards[1], v)
						v:flip()
						return true
					end
				}))
			end
			--mark card for destruction
			G.hand.cards[1].ability.mypa_marked_for_death = true
		end
		if context.destroy_card and context.cardarea == G.hand and
		not context.blueprint and not context.retrigger_joker and
		context.destroy_card.ability and context.destroy_card.ability.mypa_marked_for_death then
			context.destroy_card.ability.mypa_marked_for_death = nil
			return {remove = true}
		end
	end
}
