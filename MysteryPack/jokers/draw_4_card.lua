
-- Draw 4 Card
SMODS.Joker{
	key = "draw_4_card",
	loc_txt = {
		name = "Draw 4 Card",
		text = {
			"{C:attention}+#1#{} hand size after hand",
			"contains {C:attention}#2#{} cards in",
			"{C:attention}#3#{} {C:inactive}[#4#]{} separate rounds",
			"{C:inactive}(Currently {C:attention}+#5#{C:inactive}){}"
		}
	},
	atlas = "jokers",
	pos = {x=3,y=0},
	rarity = 3,
	cost = 8,
	blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = true,
	config = {
		extra = {
			amount_gain = 2,
			amount_cards = 4,
			amount_rounds = 3,
			current_rounds = 3,
			current_gain = 0,
			this_round_gone = false
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.amount_gain,
			card.ability.extra.amount_cards,
			card.ability.extra.amount_rounds,
			card.ability.extra.current_rounds,
			card.ability.extra.current_gain
		}}
	end,
	calculate = function(self, card, context)
		if context.before and not context.blueprint and not context.retrigger_joker and context.main_eval and not card.ability.extra.this_round_gone then
			card.ability.extra.this_round_gone = true
			card.ability.extra.current_rounds = card.ability.extra.current_rounds - 1
			if card.ability.extra.current_rounds == 0 then
				card.ability.extra.current_rounds = card.ability.extra.amount_rounds
				card.ability.extra.current_gain = card.ability.extra.current_gain + card.ability.extra.amount_gain
				G.hand:change_size(card.ability.extra.amount_gain)
				return {message = localize("k_upgrade_ex"), colour = G.C.FILTER}
			end
		end
		if context.end_of_round and not context.blueprint and not context.retrigger_joker and context.main_eval and card.ability.extra.this_round_gone then
			card.ability.extra.this_round_gone = false
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.current_gain)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.current_gain)
	end
}
