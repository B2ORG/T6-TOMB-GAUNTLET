// #define ENABLE_TRACERS
// #define ENABLE_DEBUG

/* Inspection can cause ils, use only when needed */
#define MUTE_INSPECT_DAMAGE
#define MUTE_INSPECT_DEATH

#ifdef ENABLE_TRACERS
#define TRACE(__txt) _trace(__txt);
#else
#define TRACE(__txt)
#endif

#ifdef ENABLE_DEBUG
#define DEBUG(__txt) printf("DEBUG [" + convert_time(gettime() - getstarttime(), "m:ss.vv", true) + "] ^5" + __txt);
#define DUMP(__obj) _dump(__obj);
#else
#define DEBUG(__txt)
#define DUMP(__obj)
#endif

#define WARN(__txt) printf("WARN [" + convert_time(gettime() - getstarttime(), "m:ss.vv", true) + "] ^3" + __txt);
#define ERROR(__txt) printf("ERROR [" + convert_time(gettime() - getstarttime(), "m:ss.vv", true) + "] ^1" + __txt);

#define GAUNTLET_SINGLE(__fn) level notify("gauntlet_" + __fn); \
                                level endon("gauntlet_" + __fn);
#define GAUNTLET_MUTEX(__fn) flag_set("m_gauntlet_" + __fn); \
                                flag_waitopen("m_gauntlet_" + __fn);
#define GAUNTLET_CLEAR_MUTEX(__fn) flag_clear("m_gauntlet_" + __fn);
#define STR(__val) "" + __val
#define JSON_ENCODE_MAX_DEPTH 3

#define GAUNTLET_VERSION "0.21"
#define PLUTO_MINIMAL_VERSION 5278
#define GAUNTLET_ROUNDS 30
#define MAX_STRING_LEN 8191

#define SIG_INIT_READY "init_ready"
#define SIG_BEFORE_ROUND "start_of_round"
#define SIG_BEFORE_THIS_ROUND "start_of_this_round"
#define SIG_END_ROUND "end_of_round"
#define SIG_END_THIS_ROUND "end_of_this_round"
#define SIG_HUD_STATE "hud_state"
#define SIG_PROGRESS_CHANGED "progress_changed"

#define GAUNTLET_TIMER_HUD "gauntlet_timer_hud"
#define GAUNTLET_COUNTER_HUD "gauntlet_counter_hud"
#define GAUNTLET_TITLE_HUD "gauntlet_challenge_title_hud"
#define GAUNTLET_STATUS_HUD "gauntlet_challenge_player_status_hud"

#define GAUNTLET_HUD_SET_VALUE "set_value"
#define GAUNTLET_HUD_SET_TEXT "set_text"
#define GAUNTLET_HUD_SET_COLOR "set_color"
#define GAUNTLET_HUD_FADE_IN "fade_in"
#define GAUNTLET_HUD_FADE_OUT "fade_out"
#define GAUNTLET_HUD_SET_TEXT_AND_COLOR "set_text_and_color"
#define GAUNTLET_HUD_SET_POINT "set_point"

#define GAUNTLET_NOTIFY(__sig) level notify("gauntlet_notify+" + __sig)
#define GAUNTLET_NOTIFY_HUD(__hud, __instruction, __value, __player) level notify("gauntlet_notify+" + SIG_HUD_STATE + "+" + __hud, __instruction, __value, __player)
#define GAUNTLET_NOTIFY_INIT level notify("gauntlet_notify+" + SIG_INIT_READY)
#define GAUNTLET_NOTIFY_BEFORE_ROUND level notify("gauntlet_notify+" + SIG_BEFORE_ROUND)
#define GAUNTLET_NOTIFY_BEFORE_THIS_ROUND level notify("gauntlet_notify+" + SIG_BEFORE_THIS_ROUND)
#define GAUNTLET_NOTIFY_END_ROUND level notify("gauntlet_notify+" + SIG_END_ROUND)
#define GAUNTLET_NOTIFY_END_THIS_ROUND level notify("gauntlet_notify+" + SIG_END_THIS_ROUND)
#define GAUNTLET_NOTIFY_PROGRESS_CHANGED(__ent, __status) __ent notify("gauntlet_notify+" + SIG_PROGRESS_CHANGED, __status)

#define GAUNTLET_WAITTILL(__sig) level waittill("gauntlet_notify+" + __sig)
#define GAUNTLET_WAITTILL_HUD(__hud) level waittill("gauntlet_notify+" + SIG_HUD_STATE + "+" + __hud, instruction, data, player)
#define GAUNTLET_WAITTILL_INIT level waittill("gauntlet_notify+" + SIG_INIT_READY)
#define GAUNTLET_WAITTILL_BEFORE_ROUND level waittill("gauntlet_notify+" + SIG_BEFORE_ROUND)
#define GAUNTLET_WAITTILL_BEFORE_THIS_ROUND level waittill("gauntlet_notify+" + SIG_BEFORE_THIS_ROUND)
#define GAUNTLET_WAITTILL_END_ROUND level waittill("gauntlet_notify+" + SIG_END_ROUND)
#define GAUNTLET_WAITTILL_END_THIS_ROUND level waittill("gauntlet_notify+" + SIG_END_THIS_ROUND)
#define GAUNTLET_WAITTILL_PROGRESS_CHANGED level waittill("gauntlet_notify+" + SIG_PROGRESS_CHANGED)

#define CHALLENGE_STATUS_NEW "new"
#define CHALLENGE_STATUS_IN_PROGRESS "in_progress"
#define CHALLENGE_STATUS_SUCCESS "success"
#define CHALLENGE_STATUS_FAIL "fail"

#define TOMB_GENERATOR_1 "generator_start_bunker"
#define TOMB_GENERATOR_2 "generator_tank_trench"
#define TOMB_GENERATOR_3 "generator_mid_trench"
#define TOMB_GENERATOR_4 "generator_nml_right"
#define TOMB_GENERATOR_5 "generator_nml_left"
#define TOMB_GENERATOR_6 "generator_church"

#define TIME_MMSSVV 1
#define TIME_MSSVV 2
#define TIME_MMSS 3
#define TIME_HHMMSSVV 4

#define MECHZ_ROUNDS array(8, 12, 16, 20, 24, 28, 30)
#define GENERATOR_ROUNDS array(10, 21, 24, 28)

#define GAUNTLET_WORLD_WEAPONS_ALLOWED_FOR_GUN_RESTRICTION array()

#define TELEPORT_WIND_IN "air_teleport_player"
#define TELEPORT_WIND_OUT "air_teleport_return"
#define TELEPORT_FIRE_IN "fire_teleport_player"
#define TELEPORT_FIRE_OUT "fire_teleport_return"
#define TELEPORT_ELECTRIC_IN "electric_teleport_player"
#define TELEPORT_ELECTRIC_OUT "elec_teleport_return"
#define TELEPORT_ICE_IN "water_teleport_player"
#define TELEPORT_ICE_OUT "ice_teleport_return"

#define COLOR_ORANGE (1, 0.7, 0.4)
#define COLOR_BLUE (0.4, 0.7, 1)
#define COLOR_YELLOW (1, 1, 0.4)
#define COLOR_RED (1, 0, 0)
#define COLOR_WHITE (1, 1, 1)

#define AREA_TRENCHES 1
#define AREA_CHURCH 2
#define AREA_NML 4
#define AREA_FULL 8

#define DROP_BOTTOM (0, -361, -618)
#define DROP_UPPER (5, -392, -488)
