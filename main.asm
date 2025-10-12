INCLUDE "constants.asm"


SECTION "bank1", ROMX

INCLUDE "data/sprites/facings.asm"
INCLUDE "engine/battle/safari_zone.asm"
INCLUDE "engine/movie/title.asm"
INCLUDE "engine/pokemon/load_mon_data.asm"
INCLUDE "data/items/prices.asm"
INCLUDE "data/items/names.asm"
;INCLUDE "data/text/unused_names.asm" ; edited, commented out as unused
INCLUDE "engine/gfx/sprite_oam.asm"
INCLUDE "engine/overworld/sprite_collisions.asm"
INCLUDE "engine/events/pick_up_item.asm"
INCLUDE "engine/events/rock_smash.asm" ; new
INCLUDE "engine/overworld/movement.asm"
INCLUDE "engine/menus/main_menu.asm"
INCLUDE "engine/movie/oak_speech/oak_speech.asm"
INCLUDE "engine/overworld/special_warps.asm"
INCLUDE "engine/debug/debug_party.asm"
INCLUDE "engine/menus/naming_screen.asm"
INCLUDE "engine/movie/oak_speech/oak_speech2.asm"
INCLUDE "engine/items/subtract_paid_money.asm"
INCLUDE "engine/menus/swap_items.asm"
INCLUDE "engine/events/pokemart.asm"
INCLUDE "engine/pokemon/learn_move.asm"
INCLUDE "engine/events/pokecenter.asm"
INCLUDE "engine/events/set_blackout_map.asm"
INCLUDE "engine/menus/display_text_id_init.asm"
INCLUDE "engine/menus/draw_start_menu.asm"
INCLUDE "engine/menus/text_box.asm"
INCLUDE "engine/battle/move_effects/drain_hp.asm"
INCLUDE "engine/menus/players_pc.asm"
INCLUDE "engine/pokemon/remove_mon.asm"
INCLUDE "engine/events/display_pokedex.asm"
; moved all engine/link files to another bank


SECTION "bank3", ROMX

INCLUDE "engine/joypad.asm"
INCLUDE "engine/overworld/player_state.asm"
INCLUDE "engine/overworld/tilesets.asm"
INCLUDE "data/maps/hide_show_data.asm"
INCLUDE "data/maps/hide_show_data_sevii.asm" ; new
INCLUDE "engine/items/item_effects.asm"
INCLUDE "engine/overworld/cut.asm"
INCLUDE "engine/overworld/missable_objects.asm"
INCLUDE "engine/overworld/push_boulder.asm"
INCLUDE "engine/overworld/pathfinding.asm"
;INCLUDE "engine/items/get_bag_item_quantity.asm" ; moved to bankGarage2
;INCLUDE "engine/events/poison.asm" ; moved to bankGarage2
;INCLUDE "engine/overworld/daycare_exp.asm" ; moved to bankGarage2
;INCLUDE "engine/menus/draw_badges.asm" ; moved to bankGarage
;INCLUDE "engine/pokemon/add_mon.asm" ; moved
;INCLUDE "engine/flag_action.asm" ; moved
;INCLUDE "engine/events/heal_party.asm" ; moved to bankGarage
;INCLUDE "engine/math/bcd.asm" ; moved to bankGarage
;INCLUDE "engine/movie/oak_speech/init_player_data.asm" ; moved
;INCLUDE "engine/gfx/hp_bar.asm" ; moved to bankGarage
;INCLUDE "engine/overworld/clear_variables.asm" ; moved to bankGarage2
;INCLUDE "engine/overworld/update_map.asm" ; moved to bankGarage2
;INCLUDE "engine/overworld/wild_mons.asm" ; moved to bankGarage2


SECTION "bankGarage", ROMX ; new, tentative place where to move independent stuff in overflowing banks

INCLUDE "engine/menus/draw_badges.asm" ; moved from bank3
INCLUDE "engine/gfx/animated_tiles_code.asm" ; contains function moved from vcopy.asm, which is in home
INCLUDE "engine/gfx/hp_bar.asm" ; moved from bank3
INCLUDE "engine/events/heal_party.asm" ; moved from bank3, after modifying one call into a callfar
INCLUDE "engine/overworld/use_another_repel.asm" ; new, from Vortiene
INCLUDE "engine/overworld/check_map_connections.asm" ; new, from Vortiene
INCLUDE "engine/miscellanea/miscellanea.asm" ; new
INCLUDE "engine/overworld/hm_usage_in_overworld.asm" ; new, testing
INCLUDE "engine/events/heat_damage.asm" ; new, testing
INCLUDE "engine/link/print_waiting_text.asm" ; moved from bank1
INCLUDE "engine/link/cable_club.asm" ; moved from bank1
INCLUDE "engine/link/cable_club_npc.asm" ; moved from bank1
INCLUDE "engine/miscellanea/overworld.asm" ; new
INCLUDE "engine/math/bcd.asm" ; moved from bank3
INCLUDE "engine/miscellanea/shiny.asm" ; new
INCLUDE "engine/miscellanea/evolve_temp.asm" ; new


SECTION "bankGarage2", ROMX ; new

INCLUDE "engine/menus/item_descriptions.asm"
INCLUDE "audio/fade_audio.asm" ; moved from home bank
; moved all from bank3 (?)
INCLUDE "engine/events/hidden_objects/bookshelves.asm"
INCLUDE "engine/events/hidden_objects/indigo_plateau_statues.asm"
INCLUDE "engine/events/hidden_objects/book_or_sculpture.asm"
INCLUDE "engine/events/hidden_objects/elevator.asm"
INCLUDE "engine/events/hidden_objects/town_map.asm"
INCLUDE "engine/events/hidden_objects/pokemon_stuff.asm"
INCLUDE "engine/battle/trainers2.asm" ; edited, moved out of HOME
INCLUDE "engine/menus/print_text_internal.asm" ; new
INCLUDE "engine/events/poison.asm" ; from bank3
INCLUDE "engine/overworld/daycare_exp.asm" ; from bank3
INCLUDE "engine/movie/oak_speech/init_player_data.asm" ; from bank3
INCLUDE "engine/movie/title_yellow.asm" ; from Battle Engine 9
INCLUDE "engine/menus/link_menu.asm" ; from Battle Engine 9
INCLUDE "engine/miscellanea/battlecore2.asm" ; new
INCLUDE "engine/miscellanea/tutor.asm" ; new
INCLUDE "data/moves/tutor_table.asm" ; new
INCLUDE "engine/overworld/clear_variables.asm" ; from bank3
INCLUDE "engine/overworld/update_map.asm" ; from bank3
INCLUDE "engine/items/get_bag_item_quantity.asm" ; from bank3
INCLUDE "engine/overworld/wild_mons.asm" ; from bank3


SECTION "bankGarage3", ROMX ; new
INCLUDE "engine/pokemon/add_mon.asm" ; from bank3
INCLUDE "engine/flag_action.asm" ; from bank3


SECTION "bank4", ROMX

INCLUDE "gfx/font.asm"
INCLUDE "engine/pokemon/status_screen.asm"
INCLUDE "engine/menus/party_menu.asm"
INCLUDE "gfx/player.asm"
INCLUDE "engine/menus/start_sub_menus.asm"
INCLUDE "engine/items/tms.asm"


SECTION "Battle Engine 1", ROMX

INCLUDE "engine/battle/wild_encounters.asm"


SECTION "bank5", ROMX

INCLUDE "engine/gfx/load_pokedex_tiles.asm"
INCLUDE "engine/overworld/map_sprites.asm"


SECTION "Battle Engine 2", ROMX

INCLUDE "engine/battle/move_effects/substitute.asm"
INCLUDE "engine/menus/pc.asm"


SECTION "Doors and Ledges", ROMX

INCLUDE "engine/overworld/auto_movement.asm"
INCLUDE "engine/overworld/doors.asm"
INCLUDE "engine/overworld/ledges.asm"


SECTION "bank7", ROMX

INCLUDE "engine/movie/oak_speech/clear_save.asm"
INCLUDE "engine/events/elevator.asm"


SECTION "Hidden Objects 1", ROMX

INCLUDE "engine/menus/oaks_pc.asm"
INCLUDE "engine/events/hidden_objects/new_bike.asm"
INCLUDE "engine/events/hidden_objects/oaks_lab_posters.asm"
INCLUDE "engine/events/hidden_objects/safari_game.asm"
INCLUDE "engine/events/hidden_objects/cinnabar_gym_quiz.asm"
INCLUDE "engine/events/hidden_objects/magazines.asm"
INCLUDE "engine/events/hidden_objects/bills_house_pc.asm"
INCLUDE "engine/events/hidden_objects/oaks_lab_email.asm"


SECTION "Bill's PC", ROMX

INCLUDE "engine/pokemon/bills_pc.asm"


SECTION "Battle Engine 3", ROMX

INCLUDE "engine/battle/print_type.asm"
;INCLUDE "engine/battle/save_trainer_name.asm" ; removed, useless


SECTION "Battle Engine 4", ROMX


SECTION "Battle Engine 5", ROMX

INCLUDE "engine/battle/display_effectiveness.asm"
INCLUDE "engine/items/tmhm.asm"
INCLUDE "engine/pikachu/respawn_overworld_pikachu.asm"
INCLUDE "engine/battle/scale_sprites.asm"
INCLUDE "engine/slots/game_corner_slots2.asm"


SECTION "Slot Machines", ROMX

INCLUDE "engine/movie/title_rb.asm"
INCLUDE "engine/slots/slot_machine.asm"
INCLUDE "engine/slots/game_corner_slots.asm"


SECTION "Battle Engine 6", ROMX

INCLUDE "engine/battle/trainer_ai.asm"


SECTION "Battle Engine 6b", ROMX ; new, to save space in the previous Section

INCLUDE "gfx/trade.asm" ; moved from "Battle Engine 6"
INCLUDE "data/pokemon/cries.asm" ; moved from "Battle Engine 6"
INCLUDE "engine/battle/draw_hud_pokeball_gfx.asm" ; moved from "Battle Engine 6"
INCLUDE "data/moves/moves.asm" ; moved from "Battle Engine 6"
INCLUDE "engine/battle/misc.asm" ; moved from "Battle Engine 6"
INCLUDE "data/trainers/names.asm" ; moved from "Battle Engine 6"


SECTION "Battle Engine 6c", ROMX ; new, to save space in the previous Sections

INCLUDE "data/trainers/parties.asm" ; moved from "Battle Engine 6"
INCLUDE "engine/battle/read_trainer_party.asm" ; moved from "Battle Engine 6"


SECTION "Evos Moves 1", ROMX ; new, from Vortiene's pureRGB, moved from "Battle Engine 6"

INCLUDE "data/pokemon/base_stats.asm"
INCLUDE "engine/pokemon/base_stats_copying.asm"


SECTION "Evos Moves 2", ROMX ; new, testing

INCLUDE "engine/pokemon/evos_moves.asm"


SECTION "Battle Core", ROMX

INCLUDE "engine/battle/core.asm"
INCLUDE "engine/battle/effects.asm"


SECTION "bank10", ROMX

INCLUDE "engine/menus/pokedex.asm"
INCLUDE "engine/overworld/emotion_bubbles.asm"
INCLUDE "engine/movie/trade.asm"
INCLUDE "engine/movie/intro.asm"
INCLUDE "engine/movie/trade2.asm"
INCLUDE "engine/menus/options.asm"
INCLUDE "engine/menus/attackdex.asm" ; new
INCLUDE "engine/menus/randomization.asm" ; new
INCLUDE "engine/menus/personalization.asm" ; new, testing
INCLUDE "engine/menus/luck.asm" ; new, testing


SECTION "Pokédex Rating", ROMX

INCLUDE "engine/events/pokedex_rating.asm"


SECTION "Dungeon Warps", ROMX

INCLUDE "engine/overworld/dungeon_warps.asm"


SECTION "Hidden Objects 2", ROMX

INCLUDE "engine/events/card_key.asm"
INCLUDE "engine/events/prize_menu.asm"
INCLUDE "engine/events/hidden_objects/school_notebooks.asm"
INCLUDE "engine/events/hidden_objects/fighting_dojo.asm"
INCLUDE "engine/events/hidden_objects/indigo_plateau_hq.asm"


SECTION "Battle Engine 7", ROMX

INCLUDE "engine/battle/experience.asm"


SECTION "Diploma", ROMX

INCLUDE "engine/events/diploma.asm"


SECTION "Trainer Sight", ROMX

INCLUDE "engine/overworld/trainer_sight.asm"


SECTION "bank16", ROMX

INCLUDE "engine/pokemon/experience.asm"
INCLUDE "engine/pokemon/status_ailments.asm"
INCLUDE "engine/events/oaks_aide.asm"


SECTION "Saffron Guards", ROMX

INCLUDE "engine/events/saffron_guards.asm"


; removed this because useless in yellow?
;SECTION "Starter Dex", ROMX

;INCLUDE "engine/events/starter_dex.asm"


SECTION "Traveler functions", ROMX ; new, testing

INCLUDE "engine/miscellanea/traveler.asm"


SECTION "Hidden Objects 3", ROMX

INCLUDE "engine/movie/evolution.asm"
INCLUDE "engine/pokemon/set_types.asm"
INCLUDE "engine/events/hidden_objects/reds_room.asm"
INCLUDE "engine/events/hidden_objects/museum_fossils.asm"
INCLUDE "engine/events/hidden_objects/fanclub_pictures.asm"
INCLUDE "engine/events/hidden_objects/museum_fossils2.asm"
INCLUDE "engine/events/hidden_objects/school_blackboard.asm"
INCLUDE "engine/events/hidden_objects/vermilion_gym_trash.asm"


SECTION "Cinnabar Lab Fossils", ROMX

INCLUDE "engine/events/cinnabar_lab.asm"


SECTION "Hidden Objects 4", ROMX

INCLUDE "engine/events/hidden_objects/gym_statues.asm"
INCLUDE "engine/events/hidden_objects/bench_guys.asm"
INCLUDE "engine/events/hidden_objects/blues_room.asm"
INCLUDE "engine/events/hidden_objects/pokecenter_pc.asm"


SECTION "Version Graphics", ROMX

INCLUDE "gfx/version.asm"


SECTION "bank1C", ROMX

INCLUDE "engine/overworld/player_animations.asm"
INCLUDE "engine/items/town_map.asm"
INCLUDE "engine/gfx/mon_icons.asm"
INCLUDE "engine/gfx/palettes.asm"
;INCLUDE "engine/movie/splash.asm" ; moved to the next bank
;INCLUDE "engine/movie/hall_of_fame.asm" ; moved to the next bank
;INCLUDE "engine/overworld/healing_machine.asm" ; moved to the next bank
;INCLUDE "engine/battle/ghost_marowak_anim.asm" ; moved to the next bank
;INCLUDE "engine/events/in_game_trades.asm" ; moved to next bank
;INCLUDE "engine/menus/save.asm" ; moved to the next bank
;INCLUDE "engine/battle/battle_transitions.asm" ; moved to the next bank


SECTION "bank1C bis", ROMX ; new, move some stuff out of the original bank1c

INCLUDE "engine/movie/splash.asm" ; this seems to be referenced only by intro.asm with a farcall?
INCLUDE "engine/battle/ghost_marowak_anim.asm" ; only by common_text.asm with a farcall?
INCLUDE "engine/overworld/healing_machine.asm" ; needed for the marowak animation, and only farcalled?
INCLUDE "engine/movie/hall_of_fame.asm" ; only referenced via farcalling, and calling nothing away?
INCLUDE "engine/menus/save.asm" ; only used as a predef?
INCLUDE "engine/events/in_game_trades.asm" ; only used as a predef?
INCLUDE "engine/battle/battle_transitions.asm" ; only as a predef?


SECTION "Itemfinder 1", ROMX

INCLUDE "engine/items/itemfinder.asm"


SECTION "Vending Machine", ROMX

INCLUDE "engine/events/vending_machine.asm"
INCLUDE "engine/pokemon/calc_stats.asm" ; new, here because yes, to save space in Home


SECTION "Itemfinder 2", ROMX

INCLUDE "engine/menus/league_pc.asm"
INCLUDE "engine/overworld/elevator.asm"
INCLUDE "engine/events/hidden_items.asm"


SECTION "bank1E", ROMX

INCLUDE "engine/battle/animations.asm"
;INCLUDE "engine/overworld/cut2.asm"
;INCLUDE "engine/overworld/dust_smoke.asm"
;INCLUDE "gfx/fishing.asm" ; moved to bank1F
INCLUDE "data/moves/animations.asm"
INCLUDE "data/battle_anims/subanimations.asm"
INCLUDE "data/battle_anims/frame_blocks.asm"


SECTION "bank1EExtra", ROMX ; new, just to host the animation tilesets
INCLUDE "engine/battle/animationtilesets.asm" ; new


SECTION "bank1F", ROMX ; new: contains stuff moved from bank1E

INCLUDE "gfx/fishing.asm"
INCLUDE "engine/overworld/cut2.asm"
INCLUDE "engine/overworld/dust_smoke.asm"


SECTION "BG Map Attributes (Debug)", ROMX

IF DEF(_DEBUG)
	INCLUDE "engine/gfx/bg_map_attributes.asm"
ENDC


SECTION "BG Map Attributes", ROMX

INCLUDE "data/cgb/bg_map_attributes.asm"
IF !DEF(_DEBUG)
	INCLUDE "engine/gfx/bg_map_attributes.asm"
ENDC


SECTION "bank30", ROMX

;; This whole bank is garbage data.
;IF !DEF(_DEBUG)
;	INCBIN "garbage/bank30.bin"
;ENDC


SECTION "bank3A", ROMX

;INCLUDE "data/pokemon/names.asm"
INCLUDE "engine/overworld/is_player_just_outside_map.asm"
INCLUDE "engine/printer/serial.asm"
INCLUDE "engine/printer/printer.asm"
INCLUDE "engine/events/diploma2.asm"
INCLUDE "engine/printer/printer2.asm"
INCLUDE "engine/overworld/npc_movement_2.asm"

SECTION "bank3Abis", ROMX ; new

INCLUDE "data/pokemon/names.asm"


SECTION "Pikachu PCM", ROMX

INCLUDE "engine/pikachu/pikachu_pcm.asm"
INCLUDE "engine/overworld/advance_player_sprite.asm"
INCLUDE "engine/events/black_out.asm"
INCLUDE "engine/overworld/specific_script_flags.asm"


SECTION "Try Pikachu Movement", ROMX

INCLUDE "engine/overworld/unused_load_missable_object_data.asm"
INCLUDE "engine/events/try_pikachu_movement.asm"


SECTION "Credits", ROMX

INCLUDE "engine/events/pokecenter_chansey.asm"
INCLUDE "engine/movie/credits.asm"


SECTION "Hidden Objects Core", ROMX

INCLUDE "engine/overworld/hidden_objects.asm"
INCLUDE "engine/events/hidden_objects/vermilion_gym_trash2.asm"


SECTION "Battle Engine 8", ROMX

INCLUDE "engine/battle/common_text.asm"
INCLUDE "engine/battle/link_battle_versus_text.asm"
INCLUDE "engine/battle/unused_stats_functions.asm"
INCLUDE "engine/battle/scroll_draw_trainer_pic.asm"
INCLUDE "engine/battle/pikachu_entrance_anim.asm"
INCLUDE "engine/battle/decrement_pp.asm"
INCLUDE "engine/events/pikachu_happiness.asm"


SECTION "Battle Engine 9", ROMX

INCLUDE "engine/battle/init_battle.asm"
INCLUDE "engine/battle/init_battle_variables.asm"
INCLUDE "engine/battle/move_effects/focus_energy.asm"
INCLUDE "engine/battle/move_effects/heal.asm"
INCLUDE "engine/battle/move_effects/transform.asm"
INCLUDE "engine/battle/move_effects/reflect_light_screen.asm"
INCLUDE "engine/battle/move_effects/mist.asm"
INCLUDE "engine/battle/move_effects/one_hit_ko.asm"
INCLUDE "engine/battle/move_effects/pay_day.asm"
INCLUDE "engine/battle/move_effects/paralyze.asm"
INCLUDE "engine/battle/move_effects/random2.asm"			; new
INCLUDE "engine/battle/move_effects/mimic.asm"				; new
INCLUDE "engine/battle/move_effects/twotofiveattacks.asm"	; new
INCLUDE "engine/battle/move_effects/teleport.asm"			; new
INCLUDE "engine/battle/move_effects/flinch.asm"				; new
INCLUDE "engine/battle/move_effects/burn.asm"				; new
INCLUDE "engine/battle/move_effects/trapping.asm"			; new
INCLUDE "engine/battle/move_effects/disable.asm"			; new
INCLUDE "engine/battle/move_effects/criticalhittest.asm"	; new
INCLUDE "engine/battle/move_effects/randomizedamage.asm"	; new
INCLUDE "engine/battle/move_effects/handleplayerblackout.asm"	; new
INCLUDE "engine/battle/move_effects/sleep.asm"				; new
INCLUDE "engine/battle/move_effects/extra_core_stuff.asm"	; new
INCLUDE "engine/battle/move_effects/explode.asm"	        ; new
INCLUDE "engine/battle/move_effects/poison.asm"	            ; new
INCLUDE "engine/battle/move_effects/play_animation_copy.asm"	; new
INCLUDE "engine/items/tm_prices.asm"
INCLUDE "engine/math/multiply_divide.asm"
INCLUDE "engine/events/give_pokemon.asm"
INCLUDE "engine/battle/get_trainer_name.asm"
INCLUDE "engine/math/random.asm"
INCLUDE "engine/predefs.asm"
INCLUDE "engine/battle/move_effects/slideplayerenemy.asm"	; new
INCLUDE "engine/battle/move_effects/triattack.asm"          ; new
INCLUDE "engine/battle/move_effects/confusion.asm"          ; new
INCLUDE "engine/battle/move_effects/freezeburnparalyze.asm" ; new
INCLUDE "engine/battle/move_effects/bide.asm"               ; new
INCLUDE "engine/battle/move_effects/thrashpetaldance.asm"   ; new
INCLUDE "engine/battle/move_effects/recoil.asm"				; moved from Battle Engine 1
INCLUDE "engine/battle/move_effects/conversion.asm"			; moved from Battle Engine 1
INCLUDE "engine/battle/move_effects/haze.asm"				; moved from Battle Engine 1
INCLUDE "engine/battle/end_of_battle.asm"                   ; moved from Battle Engine 1
INCLUDE "engine/miscellanea/battlecore.asm"                 ; new
; from Battle Engine 4
INCLUDE "engine/gfx/screen_effects.asm"
INCLUDE "engine/battle/move_effects/leech_seed.asm"
INCLUDE "engine/battle/move_effects/curse.asm" ; new
INCLUDE "engine/battle/move_effects/weathers.asm" ; new
INCLUDE "engine/battle/move_effects/trickroomandentryhazards.asm" ; new
INCLUDE "engine/battle/move_effects/terrains.asm" ; new
INCLUDE "engine/battle/move_effects/handlepoisonburnleechseed.asm" ; new
; these can prolly be moved away
INCLUDE "engine/menus/unused_input.asm"
INCLUDE "engine/overworld/field_move_messages.asm"
INCLUDE "engine/items/inventory.asm"
INCLUDE "gfx/trainer_card.asm"
INCLUDE "engine/items/super_rod.asm"


SECTION "Surfing Minigame", ROMX

INCLUDE "engine/minigame/surfing_pikachu.asm"
INCLUDE "engine/movie/intro_yellow.asm"
INCLUDE "engine/gfx/animated_objects.asm"


SECTION "Overworld Pikachu", ROMX

INCLUDE "data/maps/songs.asm"
INCLUDE "data/maps/map_header_pointers.asm"
INCLUDE "data/maps/map_header_banks.asm"
INCLUDE "engine/pikachu/pikachu_follow.asm"
INCLUDE "engine/pikachu/pikachu_status.asm"
INCLUDE "engine/pikachu/pikachu_emotions.asm"
INCLUDE "engine/pikachu/pikachu_movement.asm"
INCLUDE "engine/pikachu/pikachu_pic_animation.asm"
INCLUDE "engine/debug/debug_menu.asm"


SECTION "Sevii 1", ROMX ; new

INCLUDE "data/maps/songs_sevii.asm"
INCLUDE "data/maps/map_header_pointers_sevii.asm"
INCLUDE "data/maps/map_header_banks_sevii.asm"
INCLUDE "scripts/SeviiIslandsCommon.asm"
