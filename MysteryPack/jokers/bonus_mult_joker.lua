
-- Bonus joker
SMODS.Joker{
	key = "bonus_joker",
	atlas = "jokers",
	pos = {x=3,y=1},
	rarity = 1,
	cost = 3,
	blueprint_compat = false,
	perishable_compat= true,
	eternal_compat = true,
	config = {extra = {
		amount = 75
	}},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS["m_bonus"]
		return { vars = {center.ability.extra.amount}}
	end,
	calculate = function(self, card, context)
		if context.before and context.full_hand and not context.blueprint and not context.retrigger_joker then
			for _,v in ipairs(context.full_hand) do
				if SMODS.has_enhancement(v, "m_bonus") and v.ability.bonus and not (v.ability.extra and v.ability.extra.bonus_buffed )then
					v.ability.bonus = v.ability.bonus - G.P_CENTERS["m_bonus"].config.bonus + card.ability.extra.amount
					if not v.ability.extra then v.ability.extra = {} end
					v.ability.extra.bonus_buffed = true
				end
			end
		end
		if context.after and context.full_hand and not context.blueprint and not context.retrigger_joker then
			for _,v in ipairs(context.full_hand) do
				if SMODS.has_enhancement(v, "m_bonus") and v.ability.bonus and (v.ability.extra and v.ability.extra.bonus_buffed) then
					v.ability.bonus = v.ability.bonus + G.P_CENTERS["m_bonus"].config.bonus - card.ability.extra.amount
					if not v.ability.extra then v.ability.extra = {} end
					v.ability.extra.bonus_buffed = nil
				end
			end
		end
	end,
	enhancement_gate = "m_bonus"
}

-- Mult joker
SMODS.Joker{
	key = "mult_joker",
	atlas = "jokers",
	pos = {x=4,y=1},
	rarity = 1,
	cost = 3,
	blueprint_compat = false,
	perishable_compat= true,
	eternal_compat = true,
	config = {extra = {
		amount = 10
	}},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS["m_mult"]
		return { vars = {center.ability.extra.amount}}
	end,
	calculate = function(self, card, context)
		if context.before and context.full_hand and not context.blueprint and not context.retrigger_joker then
			for _,v in ipairs(context.full_hand) do
				if SMODS.has_enhancement(v, "m_mult") and v.ability.mult and not (v.ability.extra and v.ability.extra.mult_buffed )then
					v.ability.mult = v.ability.mult - G.P_CENTERS["m_mult"].config.mult + card.ability.extra.amount
					if not v.ability.extra then v.ability.extra = {} end
					v.ability.extra.mult_buffed = true
				end
			end
		end
		if context.after and context.full_hand and not context.blueprint and not context.retrigger_joker then
			for _,v in ipairs(context.full_hand) do
				if SMODS.has_enhancement(v, "m_,mult") and v.ability.mult and (v.ability.extra and v.ability.extra.mult_buffed) then
					v.ability.mult = v.ability.mult + G.P_CENTERS["m_mult"].config.mult - card.ability.extra.amount
					if not v.ability.extra then v.ability.extra = {} end
					v.ability.extra.mult_buffed = nil
				end
			end
		end
	end,
	enhancement_gate = "m_mult"
}
