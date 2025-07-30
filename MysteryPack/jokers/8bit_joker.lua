
-- 8-Bit Joker
SMODS.Joker{
	key = "8bit_joker",
	atlas = "jokers",
	pos = {x=1,y=0},
	rarity = 2,
	cost = 8, --change this, it is probably too high (though it's nice that its 8)
	blueprint_compat = true,
	config = {
		extra = {mult = 8}
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.extra.mult, center.ability.extra.mult * MysteryPack.Utils.get_cards_of_rank_tally(8)}}
	end,
	calculate = function(self, card, context)
		-- yes it is a good use of resources to count the amount of 8s twice, why do you ask
		if context.joker_main and MysteryPack.Utils.get_cards_of_rank_tally(8) > 0 then
			return {mult = card.ability.extra.mult * MysteryPack.Utils.get_cards_of_rank_tally(8)}
		end
	end
}