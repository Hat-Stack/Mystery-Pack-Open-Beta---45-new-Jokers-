
-- Consolation Prize
SMODS.Joker{
	key = "consolation_prize",
	atlas = "jokers",
	pos = {x=4,y=3},
	pixel_size = {h = 63},
	rarity = 1,
	cost = 3,
	blueprint_compat = true,
	perishable_compat= false,
	eternal_compat = true,
	config = {extra = {
		per = 2,
		current = 0
	}},
	loc_vars = function(self, info_queue, card)
		return {vars = {
			card.ability.extra.per,
			card.ability.extra.current
		}}
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
			local unscoring_count = 0
			
			-- find amount of unscoring cards
			
			for a,b in ipairs(context.full_hand) do
				local scoring = false
				for c,d in ipairs(context.scoring_hand) do
					if d == b then
						scoring = true
					end
				end
				if not scoring then
					unscoring_count = unscoring_count + 1
				end
			end
			
			if unscoring_count > 0 then
				card.ability.extra.current = card.ability.extra.current + (card.ability.extra.per * unscoring_count)
				return {message = localize("k_upgrade_ex"), colour = G.C.CHIPS}
			end
		end
		if context.joker_main then
			return {chips = card.ability.extra.current}
		end
	end
}
