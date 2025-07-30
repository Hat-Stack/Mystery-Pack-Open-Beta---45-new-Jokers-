-- sorry this is one of the worst coded jokers in the mod


-- J-Reader Card
SMODS.Joker{
	key = "j_reader_card",
	atlas = "jokers",
	pos = {x=7,y=0},
	rarity = 3,
	cost = 9,
	blueprint_compat = false,
	perishable_compat= true,
	eternal_compat = true,
	config = {extra = {
		this_is_j_card_reader = true, -- no it isn't necessary? i'm afraid to remove it anyway
		target = nil,
		debuffed_this_hand = false -- to fix a bug...
	}},
	calculate = function(self, card, context)
		if context.retrigger_joker then return {} end
		if context.retrigger_joker_check and not context.retrigger_joker then
			if (not context.other_card.debuff) and (context.other_card ~= self) and
			not (card.ability.extra.target and card.ability.extra.target == context.other_card) then -- new line added to try and fix the strange "again when debuffing" bug that so perplexed me yesterday  -- and it continues to do so!
				return {
					repetitions = 1,
					message = localize("k_again_ex"),
					colour = G.C.FILTER,
					card = card
				}
			else
				return {}, true
			end
		end
		if context.debuff_card and context.debuff_card.area == G.jokers and not context.retrigger_joker then
			if card.ability.extra.target and card.ability.extra.target == context.debuff_card and not card.ability.extra.debuffed_this_hand then
				card.ability.extra.debuffed_this_hand = true -- because I can't rely on things to not randomly happen multiple times for no reason any more.
				return {debuff = true}
			end
		end
		if context.hand_drawn and not context.retrigger_joker then
			card.ability.extra.debuffed_this_hand = false
			local old_target = card.ability.extra.target
			card.ability.extra.target = nil
			-- select a target
			-- first find valid target
			local valid_targets = {}
			for _,v in ipairs(G.jokers.cards) do
				if not (v.ability.name == "j_mypa_j_reader_car") then
					valid_targets[#valid_targets+1] = v
				end
			end
			
			-- v.config and v.config.center.key ~= self.key
			
			if #valid_targets > 1 then
				-- remove old_target
				for k,v in ipairs(valid_targets) do
					if v == old_target then
						table.remove(valid_targets, k)
						break
					end
				end
			end
			
			if next(valid_targets) then
				local selected_target = pseudorandom_element(valid_targets, 01101101011110010111000001100001) -- it wants a number?
				card.ability.extra.target = selected_target
				card:juice_up(0.5, 0.5)
				--SMODS.debuff_card(selected_target) -- remove this because it is so ridiculous that it will only debuff the first time!
				selected_target:juice_up(0.5, 0.5)
			end
			
			for _,v in ipairs(G.jokers.cards) do
				SMODS.recalc_debuff(v) -- this probably won't be really unstable!
			end
		end
		if context.end_of_round and context.main_eval and not context.retrigger_joker then
			card.ability.extra.target = nil
			for _,v in ipairs(G.jokers.cards) do
				SMODS.recalc_debuff(v)
			end
		end
	end
}
