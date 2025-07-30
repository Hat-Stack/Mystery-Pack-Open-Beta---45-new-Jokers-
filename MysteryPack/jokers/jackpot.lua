
-- Jackpot
SMODS.Joker{
	key = "jackpot",
	atlas = "jokers",
	pos = {x=0,y=5},
	rarity = 2,
	cost = 6,
	blueprint_compat = true,
	perishable_compat= true,
	eternal_compat = true,
	config = {extra = {
		cash = 25
	}},
	loc_vars = function(self, info_queue, card)
		return {vars = {
			card.ability.extra.cash
		}}
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval then
			local sevens = 0
			for _,v in ipairs(context.scoring_hand) do
				if v:get_id() == 7 then
					sevens = sevens + 1
				end
			end
			
			if sevens > 3 or sevens == 3 then
				return {dollars = card.ability.extra.cash}
			end
		end
	end
}
