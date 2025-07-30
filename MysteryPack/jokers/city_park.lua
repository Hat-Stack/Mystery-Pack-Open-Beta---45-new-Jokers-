
-- City Park
SMODS.Joker{
	key = "city_park",
	atlas = "jokers",
	pos = {x=9,y=1},
	rarity = 2, -- what rarity is this joker?
	cost = 8,   -- the cost is dependent on that (also change any costs if you want anyway)
	blueprint_compat = true,
	config = {
		extra = {x_mult = 0.05,
			base = 1 -- change this to 1 if it has 1x mult by default ( so if there are 52 clean cards it would be 3.6x not 2.6x in total)            ok I changed it watchu gonna do about it?
		}
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.extra.x_mult, center.ability.extra.base+(center.ability.extra.x_mult * MysteryPack.Utils.get_clean_cards_tally())}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and MysteryPack.Utils.get_clean_cards_tally() > 0 then
			return {x_mult = card.ability.extra.base+(card.ability.extra.x_mult * MysteryPack.Utils.get_clean_cards_tally())}
		end
	end
}