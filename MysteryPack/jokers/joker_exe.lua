
-- Joker.exe
SMODS.Joker{
	key = "joker_exe",
	atlas = "jokers",
	pos = {x=0,y=1},
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	perishable_compat= false,
	eternal_compat = true,
	config = {extra = {
		odds = 2,
		xmult_per = 0.2,
		xmult = 1
	}},
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "mypa_joker_exe")
		return {vars = {
			n,
			d,
			card.ability.extra.xmult_per,
			card.ability.extra.xmult
		}}
	end,
	calculate = function(self, card, context)
		if context.destroy_card and context.cardarea == G.play then
			if SMODS.pseudorandom_probability(card, "mypa_joker_exe_destroys", 1, card.ability.extra.odds, "mypa_joker_exe") then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_per
				return {remove = true, message = localize("k_upgrade_ex"), colour = G.C.RED}
			end
		end
		if context.joker_main then
			return {x_mult = card.ability.extra.xmult}
		end
	end
}
