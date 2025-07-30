
-- CD Album
SMODS.Joker{
	key = "cd_album",
	atlas = "jokers",
	pos = {x=5,y=8},
	pixel_size = {h = 75}, 
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = {
		extra = {
			chips = 50
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.chips
		}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.poker_hands and
		(next(context.poker_hands["Two Pair"]) or next(context.poker_hands["Full House"])) and
		context.other_card == context.scoring_hand[#context.scoring_hand] then
			return {chips = card.ability.extra.chips}
		end
	end
}
