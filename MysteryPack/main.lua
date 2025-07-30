
-- LOAD USEFUL STUFF

-- globals go here! (or in G.GAME.mystery_pack)
MysteryPack = {}

-- utilities contains useful functions needed for certain jokers
assert(SMODS.load_file("utilities.lua"))()
-- overrides contains the hooks used to create certain custom contexts (also needed for certain jokers)
assert(SMODS.load_file("overrides.lua"))()


-- you add the modicon by defining an atlas with key "modicon"
SMODS.Atlas{
	key = "modicon",
	path = "mystery_tag.png",
	px = 34,
	py = 34,
}


-- LOAD JOKERS

-- create the jokers atlas
SMODS.Atlas{
	key = "jokers",
	path = "Jokers.png",
	px = 71,
	py = 95
}

-- I have to put this here for J-Card Reader and the Brand Joker
SMODS.current_mod.optional_features = {retrigger_joker = true}



for _,v in ipairs({
	"full_house_jokers",
	"five_of_a_kind_jokers",
	"high_card_jokers",
	"disguised_joker",
	"8bit_joker",
	"gift_certificate",
	"draw_4_card",
	"othello_joker",
	"phantomancer",
	"j_reader_card",
	"hematite",
	"stone_wheel",
	"joker_exe",
	"battle_card_joker",
	"stretched_joker",
	"bonus_mult_joker",
	"city_park",
	"virtual_joker",
	"circuit_board",
	"neon_joker",
	"the_dud",
	"sunk_cost_fallacy",
	"living_space",
	"consolation_prize",
	"estrogen",
	"corporate_joker",
	"comedy_gold",
	"joker_against_humanity",
	"jackpot",
	"specil_prize",
	"turf_war",
	"hypno_disk",
	"coulrophobia",
	"infinite_chocolate",
	"snowball_joker",
	"cd_album",
	"collage_joker",
	"energy_bar",
}) do
	assert(SMODS.load_file("jokers/"..v..".lua"))()
end


