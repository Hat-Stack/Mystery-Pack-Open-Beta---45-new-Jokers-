
-- Living Space
SMODS.Joker{
	key = "living_space",
	atlas = "jokers",
	pos = {x=1,y=3},
	pixel_size = {h = 60}, 
	rarity = 3,
	cost = 7,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = true,
	config = {
		extra = {
			amount_gain = 1,
			current_gain = 0,
			valid = false
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.amount_gain,
			card.ability.extra.current_gain
		}}
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint and not context.retrigger_joker and context.main_eval then
			if next(context.poker_hands['Full House']) and G.GAME.current_round.hands_left == 0 then
				card.ability.extra.valid = true
			else
				card.ability.extra.valid = false
			end
		end
		if context.end_of_round and not context.blueprint and not context.retrigger_joker and context.main_eval and card.ability.extra.valid then
			card.ability.extra.valid = false
			card.ability.extra.current_gain = card.ability.extra.amount_gain + card.ability.extra.current_gain
			G.hand:change_size(card.ability.extra.amount_gain)
			return {message = localize("k_upgrade_ex"), colour = G.C.FILTER}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.current_gain)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.current_gain)
	end
}
