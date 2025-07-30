
-- Gift Certificate
SMODS.Joker{
	key = "gift_certificate",
	atlas = "jokers",
	pos = {x=2,y=0},
	rarity = 1,
	cost = 4,
	blueprint_compat = true,
	config = {
		extra = {
			chips_per = 1, -- Finally, perfectly balanced, as all things must be
			loss_amount = 1,
			current_chips = 0
		}
	},
	loc_vars = function(self, infoqueue, center)
		return { vars = {center.ability.extra.chips_per, center.ability.extra.loss_amount, center.ability.extra.current_chips}}
	end,
	calculate = function(self, card, context)
		if context.mystery_pack and context.mystery_pack.money_change and not context.blueprint and not context.retrigger_joker then
			local lost_amount = 0 - context.mystery_pack.money_change
			if lost_amount > 0 then
				lost_amount = math.floor(lost_amount / card.ability.extra.loss_amount)
				if lost_amount > 0 then
					for i=1,lost_amount do
						card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.chips_per
					end
					return {message = localize("k_upgrade_ex"), colour = G.C.CHIPS}
					--return {message = localize{type ="variable", key = "a_chips", vars={card.ability.extra.chips_per * lost_amount}}}
					-- use the bottom commented out line if you prefer
				end
			end
		end
		if context.joker_main and card.ability.extra.current_chips > 0 then
			return {chips = card.ability.extra.current_chips}
		end
	end
}