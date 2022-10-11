----------------------------------------------------
-- Modifier of Historical data for NWs
-- Jul 15, 2021: Created, adan_eslavo
-----------------------------------------------------------
-- Corrected names with the "the" in their names
-----------------------------------------------------------
UPDATE Language_en_US SET Text = REPLACE(Text, 'The ', '') 	WHERE Tag = 'TXT_KEY_FEATURE_REEF';
UPDATE Language_en_US SET Text = REPLACE(Text, 'The ', '') 	WHERE Tag = 'TXT_KEY_FEATURE_MESA';
UPDATE Language_en_US SET Text = REPLACE(Text, 'The ', '') 	WHERE Tag = 'TXT_KEY_FEATURE_CRATER';
-----------------------------------------------------------
-- Moved Civilopedia entry from OLD_REEF to NEW_REEF
-----------------------------------------------------------
INSERT INTO Language_en_US
			(Tag,										Text)
SELECT		'TXT_KEY_CIV5_FEATURES_NEW_REEF_A_TEXT',	Text	FROM Language_en_US WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GREATBARRIERREEF_TEXT' UNION ALL
SELECT		'TXT_KEY_CIV5_FEATURES_NEW_REEF_B_TEXT',	Text	FROM Language_en_US WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GREATBARRIERREEF_TEXT' UNION ALL
SELECT		'TXT_KEY_CIV5_FEATURES_NEW_REEF_C_TEXT',	Text	FROM Language_en_US WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GREATBARRIERREEF_TEXT';
-----------------------------------------------------------
-- Goddess of Nature change for multi-tile Natural Wonders
-----------------------------------------------------------
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_CULTURE]', '+3 [ICON_CULTURE]') WHERE Tag ='TXT_KEY_BELIEF_ONE_WITH_NATURE';
UPDATE Language_en_US SET Text = Text||' (split propotionally between all tiles of multi-tile Natural Wonders)' WHERE Tag ='TXT_KEY_BELIEF_ONE_WITH_NATURE';
-----------------------------------------------------------
-- One liners = Help texts (Game Info in Civilopedia)
-----------------------------------------------------------
UPDATE Language_en_US SET Text = 'Mythical fountain, whose water was believed to give everlasting youth to those drinking it.' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FOUNTAIN_YOUTH_HELP';
UPDATE Language_en_US SET Text = 'Mythical city, believed to be hidden deep in the jungles of America, made of gold and full of riches Europeans searched for ages.' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_EL_DORADO_HELP';
UPDATE Language_en_US SET Text = 'Volcano that is the highest peak in Africa and the highest single free-standing mountain above sea level in the world.' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KILIMANJARO_HELP';

INSERT INTO Language_en_US
			(Tag,	Text)
VALUES		('TXT_KEY_CIV5_FEATURES_CRATER_HELP',			'One of the biggests, and the surely the best preserved meteor crater in the world.'),
			('TXT_KEY_CIV5_FEATURES_FUJI_HELP',				'Volcano that has one of the most epic and beautiful cones, being inspiration for many artists.'),
			('TXT_KEY_CIV5_FEATURES_MESA_HELP',				'Largest flat-topped mountain in the world.'),
			('TXT_KEY_CIV5_FEATURES_NEW_REEF_HELP',			'The biggest coral reef in the world.'),
			('TXT_KEY_CIV5_FEATURES_VOLCANO_HELP',			'Volcano that performed one of the greatest erruptions of human age, devastating life, destroying and creating lands, and killing tousands of people.'),
			('TXT_KEY_CIV5_FEATURES_GIBRALTAR_HELP',		'Lonely rock marking the gateway to the Mediterranean Sea, and being used as a defensive feature.'),
			('TXT_KEY_CIV5_FEATURES_GEYSER_HELP',			'One of the most regular geysers in the world, with one of the most frequent eruptions rate.'),
			('TXT_KEY_CIV5_FEATURES_POTOSI_HELP',			'Silver, gold and other resources mined by slaves from this mountain was constantly carried to Europe on enormous scale and broke the economics of that time.'),
			('TXT_KEY_CIV5_FEATURES_SRI_PADA_HELP',			'Mountain that contains, what is believed to be, a footprint of a holy person by four different religions (Hinduism, Buddhism, Islam and Indian Christianity).'),
			('TXT_KEY_CIV5_FEATURES_MT_SINAI_HELP',			'Mountain, where according to the Bible, the Decalogue was given to Moses in form of the tablets.'),
			('TXT_KEY_CIV5_FEATURES_MT_KAILASH_HELP',		'Mountain that is a holy peak of four different religions: Hinduism, Buddhism, Jainism and Bon.'),
			('TXT_KEY_CIV5_FEATURES_ULURU_HELP',			'Lonely rock of unknown origin, being a sacred place of local Aboriginal tribes.'),
			('TXT_KEY_CIV5_FEATURES_LAKE_VICTORIA_HELP',	'The biggest tropical lake feeding numerous african countries and tribes around.'),
			('TXT_KEY_CIV5_FEATURES_SOLOMONS_MINES_HELP',	'Mythical mines that helped biblical ruler to accumulate enormous amonts of gold.'),
			('TXT_KEY_CIV5_FEATURES_SALAR_HELP',			'The biggest salt flat in the world, where speed records are often broken and satellites calibrate their devices using its surface.'),
			('TXT_KEY_CIV5_FEATURES_CAUSEWAY_HELP',			'Unusual hexagonal basalt columns growing up from the water and land.'),
			('TXT_KEY_CIV5_FEATURES_MT_EVEREST_HELP',		'Highest and the most famous peak in the world, and surely the most besieged mountain of all known.'),
			('TXT_KEY_CIV5_FEATURES_RETBA_HELP',			'Salt lake inhabited by unusual pink algae.'),
			('TXT_KEY_CIV5_FEATURES_BERMUDA_HELP',			'Mysterious area, where ships and planes seemed to disappear and never happened to be found.'),
			('TXT_KEY_CIV5_FEATURES_LUMI_BAY_HELP',			'Bay inhabited by unusual kinds of phytoplancton glowing blue and giving wonderful visual effects.'),
			('TXT_KEY_CIV5_FEATURES_DALLOL_HELP',			'Flat volcanoes, creating unusual lake structures formed by huge african rifts.'),
			('TXT_KEY_CIV5_FEATURES_MT_PAEKTU_HELP',		'Holy mountain of both Korean nations, and the highest volcanic lake of all known.'),
			('TXT_KEY_CIV5_FEATURES_EYE_OF_SAHARA_HELP',	'Huge sand formation of unknown origin, which is seen in its full shape only from the air or space.');
-----------------------------------------------------------
-- Civilopedia replacements (deleted texts out of date)
-----------------------------------------------------------
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_RESEARCH] Science from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_BARRINGER_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_PRODUCTION] Production from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_POTOSI_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_CULTURE] Culture from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_EL_DORADO_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_RESEARCH] Science from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FOUNTAIN_YOUTH_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_FOOD] Food from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GRANDMESA_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_RESEARCH] Science from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_NEW_REEF_A_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_RESEARCH] Science from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_NEW_REEF_B_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_RESEARCH] Science from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_NEW_REEF_C_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_CULTURE] Culture from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KILIMANJARO_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_PRODUCTION] Production from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SOLOMONS_MINES_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_RESEARCH] Science from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KRAKATOA_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_FOOD] Food from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_LAKE_VICTORIA_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_CULTURE] Culture from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FUJI_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_PEACE] Faith from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_KAILASH_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_PEACE] Faith from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_SINAI_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_CULTURE] Culture from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_OLDFAITHFUL_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_GOLD] Gold from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GIBRALTER_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_FOOD] Food from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SRI_PADA_TEXT';
UPDATE Language_en_US SET Text = REPLACE(Text, '+2 [ICON_PRODUCTION] Production from this Natural Wonder for every Era after the Ancient Era.[NEWLINE][NEWLINE]', '') 	WHERE Tag = 'TXT_KEY_CIV5_FEATURES_ULURU_TEXT';
-----------------------------------------------------------
-- Civilopedia entries
-----------------------------------------------------------
UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]Detailed information about Natural Wonder:'
WHERE Tag IN (SELECT Civilopedia FROM Features WHERE (NaturalWonder = 1 OR PseudoNaturalWonder = 1));

-- Barringer Crater
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) 10 [ICON_GOLDEN_AGE] in your Capital every time you research a Technology[NEWLINE][ICON_BULLET](owned) +20%[ICON_PRODUCTION][ICON_PRODUCTION] during construction of Spaceship Parts[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_BARRINGER_TEXT';

-- Cerro de Potosi
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) +1 flat [ICON_RES_SILVER][NEWLINE][ICON_BULLET](owned) +1 [ICON_INTERNATIONAL_TRADE][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_POTOSI_TEXT';

-- El Dorado
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]grants 250[ICON_GOLD] to the first player who will discover it[NEWLINE][ICON_BULLET](owned) +1 flat [ICON_RES_GOLD][NEWLINE][ICON_BULLET](owned) +2 [ICON_GOLD]/[ICON_RES_GOLD][ICON_RES_GOLD][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_EL_DORADO_TEXT';

-- Fountain of Youth
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) adds [COLOR_POSITIVE_TEXT]Fresh Water[ENDCOLOR][NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Everlasting Youth[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Military Melee[ENDCOLOR] units[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FOUNTAIN_YOUTH_TEXT';

-- Grand Mesa
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) +20% [ICON_PRODUCTION] towards Mounted Military Units[NEWLINE][ICON_BULLET](owned) +1[ICON_WAR][ICON_WAR] Military Supply Cap[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GRANDMESA_TEXT';

-- Great Barrier Reef
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]3-tile (line)[NEWLINE][ICON_BULLET](owned) +1[ICON_RESEARCH]/all Sea luxury resources[NEWLINE][ICON_BULLET](map) spawns up to [COLOR_POSITIVE_TEXT]5 different features or resources[ENDCOLOR] adjacent to its tiles[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_NEW_REEF_A_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]3-tile (line)[NEWLINE][ICON_BULLET](owned) +1[ICON_FOOD]/all Fishing Boats[NEWLINE][ICON_BULLET](map) spawns up to [COLOR_POSITIVE_TEXT]5 different features or resources[ENDCOLOR] adjacent to its tiles[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_NEW_REEF_B_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]3-tile (line)[NEWLINE][ICON_BULLET](owned) +1[ICON_FOOD]/all Fishing Boats[NEWLINE][ICON_BULLET](map) spawns up to [COLOR_POSITIVE_TEXT]5 different features or resources[ENDCOLOR] adjacent to its tiles[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_NEW_REEF_C_TEXT';

-- Kilimanjaro
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Altitude Training[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Military Land[ENDCOLOR] units[NEWLINE][ICON_BULLET](owned) +1 [ICON_CULTURE]/[ICON_RES_IVORY][ICON_RES_IVORY][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KILIMANJARO_TEXT';

-- King Solomon's Mines
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]For the King[ENDCOLOR] promotion for [COLOR:255:230:85:255]Workers[ENDCOLOR] adjacent to this Wonder[NEWLINE][ICON_BULLET](owned) +1[ICON_GOLDEN_AGE]/all Mines[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SOLOMONS_MINES_TEXT';

-- Krakatoa
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) +1 [ICON_FOOD], +1 [ICON_RESEARCH]/all Scientists[NEWLINE][ICON_BULLET](owned) +2[ICON_GREAT_SCIENTIST] in Capital[NEWLINE][ICON_BULLET](map) spawns up to 3 additional island tiles in the 2nd ring of water[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_KRAKATOA_TEXT';

-- Lake Victoria
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET]passable at [COLOR_CYAN]Fishing[ENDCOLOR][NEWLINE][ICON_BULLET](owned) adds [COLOR_POSITIVE_TEXT]Fresh Water[ENDCOLOR][NEWLINE][ICON_BULLET](owned) allows establishing [ICON_FOOD][ICON_INTERNATIONAL_TRADE] across the Empire[NEWLINE][ICON_BULLET](owned) -10% [ICON_GOLD][ICON_GOLD] Hurry Cost Modifier[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_LAKE_VICTORIA_TEXT';

-- Mt. Fuji
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) +3[ICON_GREAT_ARTIST] in Capital[NEWLINE][ICON_BULLET](owned) +2[ICON_GREAT_WRITER] in Capital[NEWLINE][ICON_BULLET](owned) +1[ICON_GREAT_MUSICIAN] in Capital[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_FUJI_TEXT';

-- Mt. Kailash
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Mahaprasthanika Parva[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Missionaries[ENDCOLOR][NEWLINE][ICON_BULLET](owned) +2 [ICON_PEACE]/all Monuments and Temples[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_KAILASH_TEXT';

-- Mt. Sinai
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) grants 50 [ICON_PEACE] every time you gain possesion of this Natural Wonder[NEWLINE][ICON_BULLET](owned) +1[ICON_PEACE], +1[ICON_GOLDEN_AGE]/[ICON_GREAT_WORK][ICON_GREAT_WORK][NEWLINE][ICON_BULLET](owned) +1[ICON_PEACE], +1[ICON_GOLDEN_AGE]/all Holy Sites[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_SINAI_TEXT';

-- Old Faithful
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-10[ENDCOLOR] HP/Turn[NEWLINE][ICON_BULLET](owned) adds [COLOR_POSITIVE_TEXT]Fresh Water[ENDCOLOR][NEWLINE][ICON_BULLET](owned) -10% [ICON_HAPPINESS_3][ICON_HAPPINESS_3] Needs Modifier[NEWLINE][ICON_BULLET](owned) +1 [ICON_RESEARCH]/all Engineers[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_OLDFAITHFUL_TEXT';

-- Rock of Gibraltar
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned)+10% [ICON_STRENGTH][ICON_STRENGTH][NEWLINE][ICON_BULLET](owned) +1[ICON_DIPLOMAT] League Vote[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_GIBRALTER_TEXT';

-- Sri Pada
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Sacred Steps[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Civilian[ENDCOLOR] units[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SRI_PADA_TEXT';

-- Uluru
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Old Tribes[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Diplomatic[ENDCOLOR] units[NEWLINE][ICON_BULLET](owned) +20% [ICON_PRODUCTION] towards Diplomatic Units in Capital[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_ULURU_TEXT';

-- Salar de Uyuni
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]2-tile (2 shapes with different abilities)[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-20[ENDCOLOR] HP/Turn[NEWLINE][ICON_BULLET](owned) +2 [ICON_PRODUCTION]/all Factories and (any) Power Plants[NEWLINE][ICON_BULLET](owned) +7% [ICON_PRODUCTION][ICON_PRODUCTION] during construction of Spaceship Parts[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SALAR_A_TEXT';
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]2-tile (2 shapes with different abilities)[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-20[ENDCOLOR] HP/Turn[NEWLINE][ICON_BULLET](owned) +1 [ICON_PRODUCTION]/all Factories and (any) Power Plants[NEWLINE][ICON_BULLET](owned) +3% [ICON_PRODUCTION][ICON_PRODUCTION] during construction of Spaceship Parts[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_SALAR_B_TEXT';

-- Giant's Causeway
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]2-tile (2 shapes with different abilities)[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Curiosity[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Archaeologist[ENDCOLOR] units[NEWLINE][ICON_BULLET](owned) +10%[ICON_TOURISM]/all Landmarks[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_CAUSEWAY_TEXT';

-- Mt. Everest
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) [COLOR_POSITIVE_TEXT]Roof of the World[ENDCOLOR] promotion for newly created [COLOR:255:230:85:255]Recon[ENDCOLOR] units[NEWLINE][ICON_BULLET](owned) +5%[ICON_TOURISM][ICON_TOURISM][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_EVEREST_TEXT';

-- Lake Retba
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) +5% [ICON_FOOD][ICON_FOOD][NEWLINE][ICON_BULLET](owned) +10% [ICON_FOOD][ICON_FOOD] during [ICON_HAPPINESS_1] WLTKD[NEWLINE][ICON_BULLET](owned) 15 [ICON_TOURISM] for every [ICON_CITIZEN][ICON_CITIZEN] Birth[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_RETBA_TEXT';

-- Bermuda Triangle
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]3-tile (triangle)[NEWLINE][ICON_BULLET]passable at [COLOR_CYAN]Compass[ENDCOLOR][NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-25[ENDCOLOR] HP/Turn[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]stops unit[ENDCOLOR] on its tiles[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]Lost in Time and Space[ENDCOLOR] promotion for unit on its tiles[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_BERMUDA_TEXT';

-- Bioluminescent Bay
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]-5[ENDCOLOR] HP/Turn[NEWLINE][ICON_BULLET](owned) +1[ICON_RESEARCH]/[ICON_RES_FISH][ICON_RES_FISH], [ICON_RES_TROPICAL_FISH][ICON_RES_TROPICAL_FISH][NEWLINE][ICON_BULLET](owned) 25 [ICON_TOURISM] for every Civilian unit creation[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_LUMI_BAY_TEXT';

-- Dallol
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) +1 flat [ICON_RES_SYLVITE][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_DALLOL_TEXT';

-- Mt. Paektu
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]1-tile[NEWLINE][ICON_BULLET](owned) first owner gets unique building in the City nearby: [COLOR_YIELD_FOOD]Altar of the Born under the Mountain[ENDCOLOR] with unique [ICON_GREAT_WORK] [COLOR_CULTURE_STORED]Kim Il-sung and Kim Jong-il standing at the peak of Mount Paektu[ENDCOLOR], and other bonuses[NEWLINE][ICON_BULLET](map) is a source of [COLOR_POSITIVE_TEXT]3 new Rivers[ENDCOLOR] on the map[NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_MT_PAEKTU_TEXT';

-- Eye of the Sahara
UPDATE Language_en_US SET Text = Text||'[NEWLINE][ICON_BULLET]3-tile[NEWLINE][ICON_BULLET](owned) +1[ICON_CULTURE] at [COLOR_CYAN]Masonry[ENDCOLOR][NEWLINE][ICON_BULLET](owned) +2[ICON_TOURISM] at [COLOR_CYAN]Archaeology[ENDCOLOR][NEWLINE][ICON_BULLET](owned) +5[ICON_TOURISM] at [COLOR_CYAN]Satellites[ENDCOLOR][NEWLINE]' WHERE Tag = 'TXT_KEY_CIV5_FEATURES_EYE_OF_SAHARA_TEXT';

