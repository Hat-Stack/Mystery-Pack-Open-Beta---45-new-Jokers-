
-- Turf War
SMODS.Joker{
	key = "turf_war",
	atlas = "jokers",
	pos = {x=5,y=6},
	rarity = 2, -- best guess
	cost = 5,
	blueprint_compat = true,
	perishable_compat= true,
	eternal_compat = true,
	config = {extra = {
		chips = 5,
		mult = 1
	}},
	loc_vars = function(self, info_queue, card)
		return {vars = {
			card.ability.extra.chips,
			card.ability.extra.mult,
			card.ability.extra.chips * MysteryPack.Utils.get_suit_tally("Clubs"),
			card.ability.extra.mult * MysteryPack.Utils.get_suit_tally("Diamonds")
		}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips * MysteryPack.Utils.get_suit_tally("Clubs"),
				mult = card.ability.extra.mult * MysteryPack.Utils.get_suit_tally("Diamonds")
			}
		end
	end
}
