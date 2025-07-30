
-- Othello Joker
SMODS.Joker{
	key = "othello_joker",
	atlas = "jokers",
	pos = {x=4,y=0},
	rarity = 2,
	cost = 6,
	blueprint_compat = false,
	calculate = function(self, card, context)
		if context.before then
			if context.scoring_hand and context.full_hand and context.scoring_hand[1] == context.full_hand[1] and
			context.scoring_hand[#context.scoring_hand] == context.full_hand[#context.full_hand] and not context.blueprint and not context.retrigger_joker then
				
				-- find the middle cards
				local cards_to_change = {}
				local left_card = context.full_hand[1]
				local right_card = context.full_hand[#context.full_hand]
				for i=1,#context.full_hand do
					cards_to_change[#cards_to_change+1] = context.full_hand[i]
				end
				
				-- wait, how should this joker interact with wild cards/ smeared joker?
				-- also suitless cards like stone cards: how should they work
				-- who knows how they work: I haven't tested it... It'll be fine!
				local changeto_suit = nil
				if left_card.config.card.suit == right_card.config.card.suit then
					changeto_suit = left_card.config.card.suit
				end
				
				local changed_cards = 0
				if changeto_suit and not context.blueprint then
					for _,v in ipairs(cards_to_change) do
						if v.config.card.suit ~= changeto_suit then
							SMODS.change_base(v, changeto_suit)
							changed_cards = changed_cards + 1
							v:juice_up(0.5, 0.5)
						end
					end
					
					if changed_cards > 0 then
						return {
							message = localize("mypa_othello_ex"),
							colour = G.C.FILTER
						}
					end
				end
			end
		end
	end
}