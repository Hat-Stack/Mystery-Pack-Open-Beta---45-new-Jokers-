
-- Battle Card Joker
SMODS.Joker{
	key = "battle_card_joker",
	atlas = "jokers",
	pos = {x=1,y=1},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = {
		extra = {
			amount = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.amount
		}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and context.full_hand then
			return {
				mult = card.ability.extra.amount * MysteryPack.Utils.get_unique_suits(context.full_hand)
			}
		end
	end
}
