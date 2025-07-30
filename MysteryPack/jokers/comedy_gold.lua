
-- Comedy Gold
SMODS.Joker{
	key = "comedy_gold",
	atlas = "jokers",
	pos = {x=5,y=4},
	rarity = 2,
	cost = 6,
	blueprint_compat = false,
	perishable_compat= true,
	eternal_compat = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				math.floor(MysteryPack.Utils.sell_value_total(card) / 2)
			}
		}
	end,
	calc_dollar_bonus = function(self, card)
		return math.floor(MysteryPack.Utils.sell_value_total(card) / 2)
	end
}
