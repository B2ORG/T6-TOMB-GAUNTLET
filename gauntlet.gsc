#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\animscripts\zm_utility;
#include maps\mp\gametypes_zm\_globallogic_score;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\gametypes_zm\_shellshock;
#include maps\mp\gametypes_zm\_tweakables;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\zombies\_weapons;
#include maps\mp\zombies\_zm_game_module;
#include maps\mp\zombies\_zm_net;
#include maps\mp\zombies\_zm_ai_mechz;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_perk_random;
#include maps\mp\zombies\_zm_laststand;
#include maps\mp\zombies\_zm_magicbox;
#include maps\mp\zombies\_zm_powerups;
#include maps\mp\zombies\_zm_equipment;
#include maps\mp\zombies\_zm_melee_weapon;
#include maps\mp\zombies\_zm_score;
#include maps\mp\zombies\_zm_spawner;
#include maps\mp\zombies\_zm_stats;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm;
#include maps\mp\zm_tomb;
#include maps\mp\zm_tomb_utility;
#include maps\mp\zm_tomb_capture_zones;
#include maps\mp\zm_tomb_craftables;
#include maps\mp\zm_tomb_tank;
#include maps\mp\zm_tomb_dig;

#inline gauntlet;

main()
{
    fn = getfunction("maps/mp/zombies/_zm_ai_mechz", "mechz_round_tracker");
    if (isdefined(fn))
    {
        DEBUG("replacefunc mechz_round_tracker");
        replacefunc(fn, ::gauntlet_mechz_round_tracker);
    }

    fn = getfunction("maps/mp/zombies/_zm_powerups", "powerup_drop");
    if (isdefined(fn))
    {
        DEBUG("replacefunc powerup_drop");
        replacefunc(fn, ::gauntlet_powerup_drop);
    }

    fn = getfunction("maps/mp/zm_tomb_dig", "waittill_dug");
    if (isdefined(fn))
    {
        DEBUG("replacefunc waittill_dug");
        replacefunc(fn, ::gauntlet_waittill_dug);
    }

    fn = getfunction("maps/mp/zm_tomb_capture_zones", "recapture_round_tracker");
    if (isdefined(fn))
    {
        DEBUG("replacefunc recapture_round_tracker");
        replacefunc(fn, ::gauntlet_recapture_round_tracker);
    }

    fn = getfunction("maps/mp/zm_tomb_capture_zones", "delete_zombie_for_capture_event");
    if (isdefined(fn))
    {
        DEBUG("replacefunc delete_zombie_for_capture_event");
        replacefunc(fn, ::gauntlet_delete_zombie_for_capture_event);
    }

    fn = getfunction("maps/mp/zm_tomb_capture_zones", "drop_max_ammo_at_death_location");
    if (isdefined(fn))
    {
        DEBUG("replacefunc drop_max_ammo_at_death_location");
        replacefunc(fn, ::gauntlet_drop_max_ammo_at_death_location);
    }

    fn = getfunction("maps/mp/zombies/_zm_zonemgr", "manage_zones");
    if (isdefined(fn))
    {
        DEBUG("replacefunc manage_zones");
        replacefunc(fn, ::gauntlet_manage_zones);
    }

    fn = getfunction("maps/mp/zm_tomb_utility", "zombie_gib_all");
    if (isdefined(fn))
    {
        DEBUG("replacefunc zombie_gib_all");
        replacefunc(fn, ::gauntlet_zombie_gib_all);
    }

    fn = getfunction("maps/mp/zm_tomb_utility", "zombie_gib_guts");
    if (isdefined(fn))
    {
        DEBUG("replacefunc zombie_gib_guts");
        replacefunc(fn, ::gauntlet_zombie_gib_guts);
    }

    fn = getfunction("maps/mp/zombies/_zm_perk_electric_cherry", "electric_cherry_laststand");
    if (isdefined(fn))
    {
        DEBUG("replacefunc electric_cherry_laststand");
        replacefunc(fn, ::gauntlet_electric_cherry_laststand);
    }

    fn = getfunction("maps/mp/zombies/_zm_powerups", "check_for_instakill");
    if (isdefined(fn))
    {
        DEBUG("replacefunc check_for_instakill");
        replacefunc(fn, ::gauntlet_check_for_instakill);
    }

    fn = getfunction("maps/mp/zombies/_zm_weap_staff_lightning", "staff_lightning_death_event");
    if (isdefined(fn))
    {
        DEBUG("replacefunc staff_lightning_death_event");
        replacefunc(fn, ::gauntlet_staff_lightning_death_event);
    }

    fn = getfunction("maps/mp/zm_tomb_capture_zones", "get_recapture_zone");
    if (isdefined(fn))
    {
        DEBUG("replacefunc get_recapture_zone");
        replacefunc(fn, ::player_aware_get_recapture_zone);
    }

    fn = getfunction("maps/mp/zm_tomb_challenges", "reward_packed_weapon");
    if (isdefined(fn))
    {
        DEBUG("replacefunc reward_packed_weapon");
        replacefunc(fn, ::gauntlet_reward_packed_weapon);
    }

    fn = getfunction("maps/mp/zm_tomb_dig", "dig_spots_respawn");
    if (isdefined(fn))
    {
        DEBUG("replacefunc dig_spots_respawn");
        replacefunc(fn, ::gauntlet_dig_spots_respawn);
    }

    fn = getfunction("maps/mp/zombies/_zm", "player_out_of_playable_area_monitor");
    if (isdefined(fn))
    {
        DEBUG("replacefunc player_out_of_playable_area_monitor");
        replacefunc(fn, ::gauntlet_player_out_of_playable_area_monitor);
    }
}

init()
{
    validate_game();
#ifdef ENABLE_TRACERS
    fs_remove("b2gauntlet/trace.log");
#endif
    thread run_on_gauntlet_notify();
    thread setup_game();

    DEBUG(convert_time(7382 * 1000, TIME_MSSVV, true));
    DEBUG(convert_time(7382 * 1000, TIME_MMSS, true));
    DEBUG(convert_time(7382 * 1000, TIME_HHMMSSVV, true));
    DEBUG(convert_time(7382 * 1000, TIME_MMSSVV, true));
}

setup_game()
{
    TRACE("setup_game");

    if (isdefined(level.b2_sniff))
    {
        level.b2_sniff++;
    }
    else
    {
        level.b2_sniff = 1;
    }

    level.mechz_spawning_logic_override_func = getfunction("maps/mp/zombies/_zm_ai_mechz", "enable_mechz_rounds");
    setdvar("cg_flashScriptHashes", 1);
    setdvar("cg_drawIdentifier", 1);

    level.b2_gauntlet_state = 0;

#ifdef ENABLE_DEBUG
    if (getdvar("gauntlet_round") == "")
    {
        setdvar("gauntlet_round", 0);
    }
    else if (getdvarint("gauntlet_round") > 0)
    {
        _debug_round = getdvarint("gauntlet_round");

        level.start_round = _debug_round;
        level.round_number = _debug_round;
        for ( i = 1; i <= level.round_number; i++ )
        {
            timer = level.zombie_vars["zombie_spawn_delay"];
            if (timer > 0.08)
            {
                level.zombie_vars["zombie_spawn_delay"] = timer * 0.95;
                continue;
            }
            if (timer < 0.08)
            {
                level.zombie_vars["zombie_spawn_delay"] = 0.08;
            }
        }
        level.zombie_move_speed = level.round_number * level.zombie_vars["zombie_move_speed_multiplier"];
#ifdef DEV_SET_EASTEREGGS
        if (level.start_round > 6)
        {
            b2_flag_set(FLAG_MONK_CHALLENGE);
            thread _refund_next_purchase();
        }
        if (level.start_round > 13)
        {
            b2_flag_set(FLAG_ZONE_CHALLENGE);
            thread upgrade_wallbuys();
        }
        if (level.start_round >= 19)
        {
            pcount = clamp_int(level.players.size, 1, 4);
            thread mauser_reward((829, -2487, 355), (0, 330, 0));
            if (pcount > 1)
            {
                thread mauser_reward((853, -2610, 355), (0, 60, 0));
            }
            if (pcount > 2)
            {
                thread mauser_reward((989, -2575, 355), (0, 150, 0));
            }
            if (pcount > 3)
            {
                thread mauser_reward((962, -2453, 355), (0, 240, 0));
            }
        }
#endif
        thread _dev_handle_doors();
    }
#endif

    flag_init("gauntlet_mechz_lock");
    flag_init("gauntlet_ee_r3");
    flag_init("gauntlet_ee_r6");
    flag_init("gauntlet_ee_r13");
    flag_init("gauntlet_ee_r18");

    /* Gauntlet hooks into existing logic callback overrides */
#ifdef ENABLE_DEBUG
    register_zombie_damage_callback(::_inspect_damage);
    register_zombie_death_event_callback(::_inspect_death);
#endif
    register_zombie_damage_callback(::gauntlet_zombie_damage_callback);
    register_zombie_death_event_callback(::gauntlet_zombie_death_callback);
    register_player_damage_callback(::gauntlet_player_damage_callback);
    onplayerconnect_callback(::b2_player_state);
    onplayerconnect_callback(::welcome_prints);
    onplayerconnect_callback(::player_gauntlet_hud);
    add_custom_zombie_spawn_logic(::gauntlet_zombie_spawn_logic);

    /* Gauntlet own hooks for setting up the challenge */
    register_on_gauntlet_init_ready(::set_gauntlet_weather);
    register_on_gauntlet_init_ready(::remove_raygun);
    register_on_gauntlet_init_ready(::gauntlet_hud);
    register_on_gauntlet_init_ready(::gauntlet_main_loop);
    register_on_gauntlet_init_ready(::set_gauntlet_starting_points);
    register_on_gauntlet_init_ready(::chat_listener);
    register_on_gauntlet_init_ready(::change_starting_box_location);
    register_on_gauntlet_init_ready(::gauntlet_electric_cherry_threads);
    register_on_gauntlet_init_ready(::gauntlet_mechz_damage_override);
    register_on_gauntlet_init_ready(::gauntlet_r2l_watcher);

    /* Gauntlet own hook to call before each round */
    register_on_gauntlet_start_of_round(::reset_status);
    register_on_gauntlet_start_of_round(::setup_gauntlet_round_hud);
    register_on_gauntlet_start_of_round(::take_round_snapshot);
    register_on_gauntlet_start_of_round(::terminate_on_status_fail);
    register_on_gauntlet_start_of_round(::set_gauntlet_progress);

    /* Gauntlet own hook to call after each round */
    register_on_gauntlet_end_of_round(::stop_round_timer_hud);
    register_on_gauntlet_end_of_round(::clear_mechz_lock);
    register_on_gauntlet_end_of_round(::reset_skip_progress_eval_for_dead);

    flag_wait("initial_blackscreen_passed");

    level.gauntlet_game_start = gettime();
    /* If defined, will be injected into gauntlet zombie damage callback */
    level.gauntlet_zombie_damage_callback_logic = undefined;
    /* If defined, will be injected into gauntlet zombie death callback */
    level.gauntlet_zombie_death_callback_logic = undefined;
    /* Holds the chance passed to randint in powerup_drop */
    level.gauntlet_custom_rand_drop_chance = 100;
    /* Stores amount of second chances left */
    level.gauntlet_second_chances = level.start_round > 1 ? 1 : 0;
    /* Stores info about players to be able to rollback */
    level.gauntlet_round_snapshot = [];
    /* Stores info about challenge progress for the round */
    level.gauntlet_challenge_progress = [];
    /* Store the default quota for hud */
    level.gauntlet_hud_quota = 0;
    /* Stores the runtime param for panzer rounds */
    level.gauntlet_mechz_max_allowed_count = 1;
    /* Store info when was the last max from gen zombies */
    level.gauntlet_last_capture_reward = 1;
    /* Store powerups disabled for digging for the round */
    level.gauntlet_disabled_dig_powerups = [];
    /* Store list of allowed guns for restricted rounds */
    level.gauntlet_allowed_guns = undefined;
    /* Custom callbacks to inject into actor damage logic */
    level.gauntlet_actor_damage_logic_fn = undefined;
    level.gauntlet_actor_damage_world_logic_fn = undefined;
    /* Store override for dig respawns */
    level.gauntlet_dig_spots_respawn_override = undefined;
    /* Whether on that round, it skips checking progress on dead players */
    level._gauntlet_skip_progress_eval_for_dead_players = false;
    /* Round 15 gen recapture last state */
    level.gauntlet_last_gen_recapture = undefined;

    foreach (player in level.players)
    {
        level.gauntlet_challenge_progress[player.entity_num] = [];
    }

    GAUNTLET_NOTIFY_INIT;
}

gauntlet_main_loop()
{
    TRACE("gauntlet_main_loop");
    level endon("end_game");
    level endon("gauntlet_reboot");
    GAUNTLET_SINGLE("gauntlet_main_loop");

    flag_wait("initial_blackscreen_passed");

    while (true)
    {
        level waittill("start_of_round");

        level.gauntlet_round = level.round_number;

        GAUNTLET_NOTIFY_BEFORE_ROUND;
        waittillframeend;

        players = get_players();

        switch (level.gauntlet_round)
        {
            case 1:
                register_on_gauntlet_end_of_this_round(::award_second_chance);
                thread wrap_gauntlet_round(::validate_generators, array(TOMB_GENERATOR_1));
                break;
            case 2:
                register_on_gauntlet_start_of_this_round(::terminate_drone_for_a_round);
                register_on_gauntlet_start_of_this_round(::disable_nukes_for_a_round);
#ifdef GUNS_DEBOUNCE_DAMAGE
                register_on_gauntlet_start_of_this_round(::disable_lighting_staff_income_for_a_round);
#endif
                thread wrap_gauntlet_round(::melee_only);
                break;
            case 3: 
                register_on_gauntlet_start_of_this_round(::headshot_bonus);
                thread wrap_gauntlet_round(::restrict_movement, true);
                break;
            case 4:
                set_skip_progress_eval_for_dead();
                if (players.size > 1)
                    register_on_gauntlet_start_of_this_round(::force_drop_double_points);
                thread wrap_gauntlet_round(::perk_count_requirement, 1);
                break;
            case 5:
                set_skip_progress_eval_for_dead();
                register_on_gauntlet_start_of_this_round(::more_monkeys_in_the_box);
                thread wrap_gauntlet_round(::watch_for_picked_box_weapon);
                break;
            case 6:
                register_on_gauntlet_start_of_this_round(::monkey_bonus);
                thread wrap_gauntlet_round(::watch_for_digging, min_int(players.size, 4));
                break;
            case 7:
                _r7_kill_count = players.size == 1 ? 6 : 12;
                thread wrap_gauntlet_round(::count_melee_kills, _r7_kill_count);
                break;
            case 8:
                set_skip_progress_eval_for_dead();
                thread wrap_gauntlet_round(::perk_requirement, array("specialty_armorvest"));
                break;
            case 9:
                register_on_gauntlet_start_of_this_round(::terminate_drone_for_a_round);
                register_on_gauntlet_start_of_this_round(::disable_nukes_for_a_round);
#ifdef GUNS_DEBOUNCE_DAMAGE
                register_on_gauntlet_start_of_this_round(::disable_lighting_staff_income_for_a_round);
#endif
                thread wrap_gauntlet_round(::restrict_guns, array("mp40_zm", "mp40_stalker_zm"));
                break;
            case 10:
                register_on_gauntlet_start_of_this_round(::more_monkeys_in_the_box);
                register_on_gauntlet_start_of_this_round(::lower_gspeed_for_a_round);
                thread wrap_gauntlet_round(::restrict_movement, false);
                break;
            case 11:
                thread wrap_gauntlet_round(::watch_score_spending);
                break;
            case 12:
                _r12_staff_count = 1;
                if (players.size > 2)
                    _r12_staff_count = 2;
                if (players.size > 3)
                    _r12_staff_count = 3;
                register_on_gauntlet_start_of_this_round(::dig_more_zombies);
                register_on_gauntlet_end_of_this_round(::check_staff_progress);
                thread wrap_gauntlet_round(::watch_for_staff_upgrade, _r12_staff_count);
                break;
            case 13:
                register_on_gauntlet_start_of_this_round(::zone_killing);
                thread wrap_gauntlet_round(::watch_player_velocity);
                break;
            case 14:
                thread wrap_gauntlet_round(::zombie_aggresive);
                break;
            case 15:
                register_on_gauntlet_start_of_this_round(::more_monkeys_in_the_box);
                register_on_gauntlet_start_of_this_round(::disable_nukes_for_a_round);
                register_on_gauntlet_start_of_this_round(::repeat_gen_zombies);
                thread wrap_gauntlet_round(::vibe_killing);
                break;
            case 16:
                _r16_panzer_cnt = min_int(players.size + 3, 7);
                register_on_gauntlet_start_of_this_round(::guard_panzer_round);
                register_on_gauntlet_start_of_this_round(::guard_crazy_place);
                register_on_gauntlet_end_of_this_round(::set_dig_override_7);
                thread wrap_gauntlet_round(::panzer_round, _r16_panzer_cnt, true);
                break;
            case 17:
                register_on_gauntlet_start_of_this_round(::help_players_with_golden_shovel);
                thread wrap_gauntlet_round(::watch_for_digging, 7);
                break;
            case 18:
                register_on_gauntlet_start_of_this_round(::mauser_reward_church);
                thread wrap_gauntlet_round(::break_time_and_space);
                break;
            case 19:
                register_on_gauntlet_start_of_this_round(::terminate_drone_for_a_round);
                register_on_gauntlet_start_of_this_round(::disable_nukes_for_a_round);
#ifdef GUNS_DEBOUNCE_DAMAGE
                register_on_gauntlet_start_of_this_round(::disable_lighting_staff_income_for_a_round);
#endif
                thread wrap_gauntlet_round(::restrict_guns, array("mp40_zm", "mp40_stalker_zm"));
                break;
            case 20:
                register_on_gauntlet_end_of_this_round(::giveaway_zombie_blood);
                thread wrap_gauntlet_round(::protect_zone, array("zone_village_2"));
                break;
            case 21:
                set_skip_progress_eval_for_dead();
                _r21_perk_requirement = players.size > 4 ? 4 : 5;
                thread wrap_gauntlet_round(::perk_count_requirement, _r21_perk_requirement);
                break;
            case 22:
                thread wrap_gauntlet_round(::remove_and_disable_perks);
                break;
            case 23:
                set_skip_progress_eval_for_dead();
                register_on_gauntlet_start_of_this_round(::force_drop_max_ammo);
                thread wrap_gauntlet_round(::equipment_kills);
                break;
            case 24:
                register_on_gauntlet_start_of_this_round(::terminate_drone_for_a_round);
                register_on_gauntlet_start_of_this_round(::disable_nukes_for_a_round);
#ifdef GUNS_DEBOUNCE_DAMAGE
                register_on_gauntlet_start_of_this_round(::disable_lighting_staff_income_for_a_round);
#endif
                thread wrap_gauntlet_round(::restrict_guns, array("c96_zm", "knife_zm", "m14_zm", "ballista_zm", "galil_zm", "mp44_zm", "scar_zm", "frag_grenade_zm"));
                break;
            case 25:
                thread wrap_gauntlet_round(::indoors_only);
                break;
            case 26:
                thread wrap_gauntlet_round(::double_ammo_consumption);
                break;
            case 27:
                thread wrap_gauntlet_round(::absurd_powerups);
                break;
            case 28:
                _r28_tank_kills = players.size == 1 ? 24 : 24 + (clamp_int(players.size, 2, 4) * 24);
                thread wrap_gauntlet_round(::watch_tank_kills, _r28_tank_kills);
                break;
            case 29:
                register_on_gauntlet_start_of_this_round(::terminate_drone);
                register_on_gauntlet_start_of_this_round(::terminate_staffs);
                register_on_gauntlet_start_of_this_round(::disable_buildables_pickup_for_a_round);
                thread wrap_gauntlet_round(::gungame);
                break;
            case 30:
                register_on_gauntlet_start_of_this_round(::dynamic_round);
                register_on_gauntlet_start_of_this_round(::panzer_round);
                register_on_gauntlet_start_of_this_round(::flash_hash);
                thread wrap_gauntlet_round(::protect_zone, array("ug_bottom_zone"));
                break;
        }

        GAUNTLET_WAITTILL_END_ROUND;
        DEBUG(sstr(level.b2_gauntlet_state));
        DEBUG(sstr(level.b2_gauntlet_player_state));
    }
}

wrap_gauntlet_round(gauntlet_fn, a1, a2, a3)
{
    TRACE("wrap_gauntlet_round " + sstr(gauntlet_fn) + " " + sstr(a1) + " " + sstr(a2) + " " + sstr(a3));
    level endon("end_game");
    level endon("start_of_round");

    /* Run callbacks registered only for the beginning of this round */
    GAUNTLET_NOTIFY_BEFORE_THIS_ROUND;

    /* I don't particulary like doing it here, but for now it works, ensures best timing */
    foreach (player in level.players)
    {
        player set_status_hud_property(GAUNTLET_HUD_FADE_IN, 1);
    }

    DEBUG("Starting gauntlet main logic for round " + sstr(level.gauntlet_round));

    /*
     * If the main round function is not running a loop, it should wait till end of the round
     * Otherwise it should add the end_of_round endon
     */
    if (isdefined(a3))
    {
        [[gauntlet_fn]](a1, a2, a3);
    }
    else if (isdefined(a2))
    {
        [[gauntlet_fn]](a1, a2);
    }
    else if (isdefined(a1))
    {
        [[gauntlet_fn]](a1);
    }
    else
    {
        [[gauntlet_fn]]();
    }

    DEBUG("Finished gauntlet main logic for round " + sstr(level.gauntlet_round));

    /* Status evaluates first, and the whole logic is halt on failure, full reboot */
    if (!evaluate_player_progress_status())
    {
        return;
    }

    /* Run callbacks registered only for the end of this round */
    GAUNTLET_NOTIFY_END_THIS_ROUND;

    /* Run callbacks registered for end of round */
    GAUNTLET_NOTIFY_END_ROUND;
}

wrap_gauntlet_callback(callback)
{
    TRACE("wrap_gauntlet_callback " + sstr(callback));
    level endon("gauntlet_reboot");
    [[callback]]();
}

set_status(status, new_hud_value, new_hud_color)
{
    TRACE(sstr(self) + " set_status " + sstr(status) + " " + sstr(new_hud_value) + " " + sstr(new_hud_color));
    if (!isdefined(new_hud_color))
    {
        switch (status)
        {
            case CHALLENGE_STATUS_SUCCESS:
                new_hud_color = COLOR_BLUE;
                break;
            case CHALLENGE_STATUS_IN_PROGRESS:
                new_hud_color = COLOR_YELLOW;
                break;
            default:
                new_hud_color = COLOR_ORANGE;
        }
    }

    if (self is_player())
    {
        level.gauntlet_challenge_progress[self.entity_num] = status;
        GAUNTLET_NOTIFY_PROGRESS_CHANGED(self, status);

        if (isdefined(new_hud_value))
        {
            self set_status_hud_property(GAUNTLET_HUD_SET_TEXT, new_hud_value);
        }
        if (isdefined(new_hud_color))
        {
            self set_status_hud_property(GAUNTLET_HUD_SET_COLOR, new_hud_color);
        }
    }
    else
    {
        foreach (player in level.players)
        {
            level.gauntlet_challenge_progress[player.entity_num] = status;
            GAUNTLET_NOTIFY_PROGRESS_CHANGED(player, status);

            if (isdefined(new_hud_value))
            {
                player set_status_hud_property(GAUNTLET_HUD_SET_TEXT, new_hud_value);
            }
            if (isdefined(new_hud_color))
            {
                player set_status_hud_property(GAUNTLET_HUD_SET_COLOR, new_hud_color);
            }
        }
    }
}

validate_game()
{
    TRACE("validate_game");
    if (int(getsubstr(getdvar("shortversion"), 1)) < PLUTO_MINIMAL_VERSION)
    {
        flag_wait("initial_blackscreen_passed");
        iprintln("The gauntlet minimal required Plutonium version is ^1r" + PLUTO_MINIMAL_VERSION);
        ERROR("The gauntlet minimal required Plutonium version is ^1r" + PLUTO_MINIMAL_VERSION);
        return;
    }
    if (getdvar("scr_allowfileio") != "1")
    {
        flag_wait("initial_blackscreen_passed");
        iprintln("The 'scr_allowfileio' DVAR must be set to ^11");
        ERROR("The 'scr_allowfileio' DVAR must be set to ^11");
        return;
    }
    if (getdvar("fs_game") != "")
    {
        flag_wait("initial_blackscreen_passed");
        iprintln("The current version of the Gauntlet does not support mods");
        ERROR("The current version of the Gauntlet does not support mods");
        return;
    }
    if (level.script != "zm_tomb")
    {
        flag_wait("initial_blackscreen_passed");
        iprintln("This gauntlet only supports playing on Origins");
        ERROR("This gauntlet only supports playing on Origins");
        return;
    }
}

start_timer_status(time, auto_hide = false)
{
    TRACE(sstr(self) + " start_timer_status " + sstr(time) + " " + sstr(auto_hide));
    if (typeof(self) == "entity" && isplayer(self))
    {
        self.gauntlet_timer_player_status settenthstimer(time / 1000);
        self.gauntlet_timer_player_status.alpha = 1;
        if (is_true(auto_hide))
        {
            self thread hide_timer_status(time);
        }
    }
    else
    {
        foreach (player in level.players)
        {
            player.gauntlet_timer_player_status settenthstimer(time / 1000);
            player.gauntlet_timer_player_status.alpha = 1;
            if (is_true(auto_hide))
            {
                player thread hide_timer_status(time);
            }
        }
    }
}

hide_timer_status(delay = 0)
{
    TRACE(sstr(self) + " hide_timer_status " + sstr(delay));
    level endon("end_game");
    wait delay;
    if (typeof(self) == "entity" && isplayer(self))
    {
        if (isdefined(self.gauntlet_timer_player_status))
        {
            self.gauntlet_timer_player_status.alpha = 0;
        }
    }
    else
    {
        foreach (player in level.players)
        {
            if (isdefined(player.gauntlet_timer_player_status))
            {
                player.gauntlet_timer_player_status.alpha = 0;
            }
        }
    }
}

terminate_on_status_fail()
{
    TRACE("terminate_on_status_fail");
    level endon("end_game");
    level endon("end_of_round");
    GAUNTLET_SINGLE("terminate_on_status_fail");

    while (true)
    {
        foreach (player_num, status in level.gauntlet_challenge_progress)
        {
            if (status == CHALLENGE_STATUS_FAIL)
            {
                DEBUG("terminate_on_status_fail fail_gauntlet " + sstr(player_num));
                thread fail_gauntlet(false);
                return;
            }
        }

        wait 0.05;
    }
}

reset_status()
{
    TRACE("reset_status");
    set_status(CHALLENGE_STATUS_NEW, "", COLOR_ORANGE);
    level.gauntlet_hud_quota = 0;
}

evaluate_player_progress_status()
{
    TRACE("evaluate_player_progress_status");
    failures = 0;

    foreach (player_ent, status in level.gauntlet_challenge_progress)
    {
        if (status != CHALLENGE_STATUS_SUCCESS)
        {
            player = get_player_by_ent_num(player_ent);
            if (is_true(level._gauntlet_skip_progress_eval_for_dead_players) && isdefined(player) && !isalive(player))
            {
                DEBUG("Skipping evaluating progress for player " + sstr(player_ent));
                continue;
            }
            else if (!isdefined(player))
            {
                WARN("Could not get player by entity num " + sstr(player_ent));
            }
            failures++;
        }
    }

    if (failures)
    {
        self set_status_hud_property(GAUNTLET_HUD_SET_TEXT, "FAILED");
        self set_status_hud_property(GAUNTLET_HUD_SET_COLOR, COLOR_ORANGE);
        // thread fade_out_hud_after();
        DEBUG("evaluate_player_progress_status fail_gauntlet " + sstr(failures));
        thread fail_gauntlet(true);
        return false;
    }
    else if (level.gauntlet_round >= GAUNTLET_ROUNDS)
    {
        end_gauntlet(true);
    }
    else
    {
        self set_status_hud_property(GAUNTLET_HUD_SET_TEXT, "SUCCESS");
        self set_status_hud_property(GAUNTLET_HUD_SET_COLOR, COLOR_BLUE);
        thread fade_out_hud_after();
    }

    return true;
}

fail_gauntlet(go_back_a_round = false)
{
    TRACE("fail_gauntlet " + sstr(go_back_a_round));
    players = get_players();
    level notify("gauntlet_stop_side_ee");
    if (players.size == 1)
    {
        if (players[0] hasperk("specialty_quickrevive"))
        {
            thread second_chance_hud(players.size);
            snapshot_restore(true, go_back_a_round);
            return;
        }
    }
    else
    {
        if (level.gauntlet_second_chances)
        {
            level.gauntlet_second_chances--;
            thread second_chance_hud(players.size);
            snapshot_restore(false, go_back_a_round);
            return;
        }
    }

    end_gauntlet(false);
}

end_gauntlet(victory)
{
    TRACE("end_gauntlet " + sstr(victory));
    level endon("end_game");

    if (is_true(victory))
    {
        level._supress_survived_screen = true;
        level.custom_end_screen = ::custom_win_screen;
        maps\mp\zombies\_zm_game_module::freeze_players(1);
        level notify("end_game");
    }

    level.custom_end_screen = ::custom_lose_screen;
    players = getplayers();
    foreach (player in players)
    {
        player dodamage(10000, (0, 0, 0));
    }

    /* This is for when player is downed with qr on solo */
    wait 0.1;
    maps\mp\zombies\_zm_game_module::freeze_players(1);
    level notify("end_game");
}

snapshot_restore(remove_quickrevive, go_back_a_round)
{
    TRACE("snapshot_restore " + sstr(remove_quickrevive) + " " + sstr(go_back_a_round));
    level notify("end_round_think");
    level notify("gauntlet_reboot");

    players = get_players();

    level.isresetting_grief = true;
    array_func(players, ::remote_revive);
    level.isresetting_grief = undefined;

    wait 0.05;

    thread terminate_active_powerups(players[0].team);

    level.zombie_vars["spectators_respawn"] = 1;
    level.round_number -= go_back_a_round;

    /* Round 5 */
    if (isdefined(level._gauntlet_count_box_weapon_grabbed))
    {
        level._gauntlet_count_box_weapon_grabbed = 0;
    }
    /* Round 7 */
    if (isdefined(level._gauntlet_melee_kills_callback))
    {
        level._gauntlet_melee_kills_callback = 0;
    }
    /* Round 23 */
    if (isdefined(level._gauntlet_killed_with_drone))
    {
        level._gauntlet_killed_with_drone = undefined;
    }

    foreach (player in players)
    {
        player setclientfield("score_cf_double_points_active", 0);
        player notify("insta_kill_over");

        player takeallweapons();
        foreach (active_perk in player.perks_active)
        {
            player notify(active_perk + "_stop");
        }
        /* Round 23 */
        self._gauntlet_killed_with_mine = undefined;
        self._gauntlet_killed_with_stick = undefined;
        self._gauntlet_killed_with_shield = undefined;
    }

    level.round_hud set_text_safe("0:00");
    terminate_drone();
    zombie_goto_round(level.round_number);

    DEBUG("Restoring snapshots: " + sstr(level.gauntlet_round_snapshot));
    foreach (player in players)
    {
        snap = level.gauntlet_round_snapshot[STR(player.entity_num)];
        if (!isdefined(snap))
        {
            WARN("No snapshot for " + sstr(player));
            player.score = 1505;
            player give_start_weapon(true);
            player giveweapon("knife_zm");
            continue;
        }

        player.score = max_int(snap.score, 1505);
        player snapshot_restore_guns(snap.weapons);
        player snapshot_restore_perks(snap.perks, remove_quickrevive);
        if (isdefined(snap.origin))
        {
            player setorigin(snap.origin);
        }
        thread maps\mp\zm_tomb_ee_side::tablet_cleanliness_chastise(player);
    }

    thread snapshot_restore_stargate(level.gauntlet_round_snapshot["stargate"]);

    maps\mp\zombies\_zm::round_over();
    thread maps\mp\zombies\_zm::round_think(true);
    thread gauntlet_main_loop();
}

snapshot_restore_guns(weapon_snap)
{
    TRACE(sstr(self) + " snapshot_restore_guns " + sstr(weapon_snap));
    primaries = 0;
    if (!weapon_snap.size)
    {
        self give_start_weapon(true);
        self giveweapon("knife_zm");
    }

    foreach (weapondata in weapon_snap)
    {
        if (isweaponprimary(weapondata["name"]))
        {
            if (primaries > get_player_weapon_limit(self))
            {
                continue;
            }
            primaries++;
        }
        self weapondata_give(weapondata);
        DEBUG("Restoring weapon to " + sstr(self.name) + " " + sstr(weapondata));

        if (primaries == 1)
        {
            self switchtoweapon(weapondata["name"]);
        }
    }
}

snapshot_restore_perks(perk_snap, remove_quickrevive)
{
    TRACE(sstr(self) + " snapshot_restore_perks " + sstr(perk_snap) + " " + sstr(remove_quickrevive));
    foreach (perk in perk_snap)
    {
        if (is_true(remove_quickrevive) && perk == "specialty_quickrevive")
        {
            continue;
        }
        DEBUG("restoring perk " + sstr(perk) + " to " + sstr(self));
        self give_perk(perk, false);
    }
}

snapshot_restore_stargate(stargates)
{
    TRACE("snapshot_restore_stargate " + sstr(stargates));
    for (i = 1; i < 5; i++)
    {
        maps\mp\zm_tomb_teleporter::stargate_teleport_disable(i);
    }
    wait 1;

    foreach (idx, state in stargates)
    {
        if (is_true(state))
        {
            maps\mp\zm_tomb_teleporter::stargate_teleport_enable(idx);
        }
    }
}

terminate_active_powerups(team)
{
    players = get_players(team);

    level.zombie_vars[team]["zombie_point_scalar"] = 1;
    level.zombie_vars[team]["zombie_insta_kill"] = 0;
    level.zombie_vars[team]["zombie_powerup_point_doubler_time"] = 0;
    level.zombie_vars[team]["zombie_powerup_insta_kill_time"] = 0;
    level.zombie_vars["zombie_powerup_fire_sale_time"] = 0;
    level notify("powerup points scaled_" + team);
    level notify("powerup instakill_" + team);
    foreach (player in players)
    {
        player.zombie_vars["zombie_powerup_zombie_blood_time"] = 0;
    }

    wait 0.1;
    level.zombie_vars[team]["zombie_powerup_point_doubler_time"] = 30;
    level.zombie_vars[team]["zombie_powerup_insta_kill_time"] = 30;

    /* Kill powerups on the ground */
    wait 0.1;
    if (isdefined(level.active_powerups))
    {
        foreach (powerup_key in getarraykeys(level.active_powerups))
        {
            if (isdefined(level.active_powerups[powerup_key]))
            {
                level.active_powerups[powerup_key] notify("powerup_timedout");
                level.active_powerups[powerup_key] powerup_delete();
            }
        }
    }
}

// TODO snapshot doors
// TODO snapshot digs
// TODO snapshot equipment state
// TODO snapshot staff upgrade
// TODO snapshot gens
take_round_snapshot()
{
    TRACE("take_round_snapshot");
    snapshot = [];
    foreach (player in level.players)
    {
        s = spawnstruct();
        s.score = player.score;
        s.perks = isarray(player.perks_active) ? array_copy(player.perks_active) : [];
        s.weapons = [];
        foreach (weapon in player getweaponslist())
        {
            if (issubstr(weapon, "bottle_"))
            {
                continue;
            }
            s.weapons[s.weapons.size] = get_player_weapondata(player, weapon);
        }
        s thread save_player_origin_when_safe(player);

        snapshot[STR(player.entity_num)] = s;
    }

    snapshot["stargate"] = [];
    snapshot["stargate"]["1"] = flag_exists("enable_teleporter_1") && flag("enable_teleporter_1");
    snapshot["stargate"]["2"] = flag_exists("enable_teleporter_2") && flag("enable_teleporter_2");
    snapshot["stargate"]["3"] = flag_exists("enable_teleporter_3") && flag("enable_teleporter_3");
    snapshot["stargate"]["4"] = flag_exists("enable_teleporter_4") && flag("enable_teleporter_4");

    level.gauntlet_round_snapshot = snapshot;
}

save_player_origin_when_safe(player)
{
    TRACE(sstr(self) + " save_player_origin_when_safe " + sstr(player));
    while (!is_player_valid(player) || !player isonground() || !check_point_in_playable_area(player.origin) || is_true(self.teleporting))
    {
        wait 0.05;
    }
    self.origin = (player.origin[0], player.origin[1], player.origin[2] + 5);
    // DEBUG("saving origin " + sstr(self.origin));
}

freeze_round_zombie_count()
{
    TRACE("freeze_round_zombie_count");
    level endon("end_round");
    level endon("gauntlet_unfreeze_round");

    current_zombies_in_the_round = level.zombie_total + get_round_enemy_array().size;
    level.gauntlet_zombie_spawn_callback_logic = ::set_no_points_and_powerups;
    fn = getfunction("maps/mp/zombies/_zm_weap_staff_lightning", "staff_lightning_kill_zombie");
    replacefunc(fn, ::_staff_lighting_kill_zombie_no_points);
    foreach (zombie in get_round_enemy_array())
    {
        zombie set_no_points_and_powerups();
    }
    while (true)
    {
        wait 0.05;
        level.zombie_total = current_zombies_in_the_round - get_round_enemy_array().size;
    }
}

unfreeze_round_zombie_count()
{
    TRACE("unfreeze_round_zombie_count");
    level notify("gauntlet_unfreeze_round");
    waittillframeend;

    level.gauntlet_zombie_spawn_callback_logic = undefined;
    fn = getfunction("maps/mp/zombies/_zm_weap_staff_lightning", "staff_lightning_kill_zombie");
    removedetour(fn);
    foreach (zombie in get_round_enemy_array())
    {
        zombie unset_no_points_and_powerups();
    }
}

gauntlet_clock(seconds, signal, set_flag = false, set_b2_flag = undefined)
{
    TRACE(sstr(self) + " gauntlet_clock " + sstr(seconds) + " " + sstr(signal) + " " + sstr(set_flag));
    level notify("gauntlet_clock+" + signal);
    level endon("end_game");
    level endon("gauntlet_clock+" + signal);
    wait seconds;
    if (is_true(set_flag))
    {
        flag_set(signal);
    }
    if (isdefined(set_b2_flag))
    {
        b2_flag_set(set_b2_flag);
    }
    self notify(signal);
}

set_no_points_and_powerups()
{
    TRACE(sstr(self) + " set_no_points_and_powerups");
    self.deathpoints_already_given = true;
    self.no_damage_points = true;
    self.no_powerups = true;
}

unset_no_points_and_powerups()
{
    TRACE(sstr(self) + " unset_no_points_and_powerups");
    self.deathpoints_already_given = undefined;
    self.no_damage_points = undefined;
    self.no_powerups = false;
}

b2_player_state()
{
    TRACE("b2_player_state");
    if (!isdefined(level.b2_gauntlet_player_state))
    {
        level.b2_gauntlet_player_state = [];
    }
    level.b2_gauntlet_player_state[STR(self.entity_num)] = 0;
}

b2_flag(flag, player)
{
    TRACE("b2_flag " + sstr(flag) + " " + sstr(player));
    if (isdefined(player) && isplayer(player))
    {
        return (level.b2_gauntlet_player_state[STR(player.entity_num)] & int(flag));
    }
    return (level.b2_gauntlet_state & int(flag));
}

b2_flag_set(flag, player)
{
    TRACE("b2_flag_set " + sstr(flag) + " " + sstr(player));
    if (typeof(player) == "entity" && isplayer(player))
    {
        level.b2_gauntlet_player_state[STR(player.entity_num)] |= int(flag);
    }
    else
    {
        level.b2_gauntlet_state |= int(flag);
    }
}

b2_flag_clear(flag, player)
{
    TRACE("b2_flag_clear " + sstr(flag) + " " + sstr(player));
    if (isdefined(player) && isplayer(player))
    {
        level.b2_gauntlet_player_state[STR(player.entity_num)] = level.b2_gauntlet_player_state[STR(player.entity_num)] & ~int(flag);
    }
    else
    {
        level.b2_gauntlet_state = level.b2_gauntlet_state & ~int(flag);
    }
}

yes()
{
    TRACE("yes");
    return true;
}

no()
{
    TRACE("no");
    return false;
}

trigger_blocker(a1, a2, a3, a4, a5)
{
    TRACE("trigger_blocker");
    level endon("end_game");
    flag_wait("initial_blackscreen_passed");
    if (isdefined(self.script_flag))
    {
        flag_wait(self.script_flag);
    }
    self notify("trigger", a1, a2, a3, a4, a5);
}

disable_nukes_for_a_round()
{
    TRACE("disable_nukes_for_a_round");
    level.zombie_powerups["nuke"].func_should_drop_with_regular_powerups = ::no;
    level.gauntlet_disabled_dig_powerups[level.gauntlet_disabled_dig_powerups.size] = "nuke";
    register_on_gauntlet_end_of_this_round(::enable_nukes);
}

enable_nukes()
{
    TRACE("enable_nukes");
    level.zombie_powerups["nuke"].func_should_drop_with_regular_powerups = ::yes;
    arrayremovevalue(level.gauntlet_disabled_dig_powerups, "nuke", false);
}

terminate_drone_for_a_round()
{
    TRACE("terminate_drone_for_a_round");
    terminate_drone();
    thread debounce_drone_damage_for_a_round();
}

terminate_drone()
{
    TRACE("terminate_drone");
    level notify("drone_should_return");
}

debounce_drone_damage_for_a_round()
{
    TRACE("debounce_drone_damage");
    level.gauntlet_actor_damage_world_logic = ::debounce_drone_damage;
    level waittill("end_of_round");
    level.gauntlet_actor_damage_world_logic = undefined;
}

debounce_drone_damage(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex)
{
    TRACE(sstr(self) + " debounce_drone_damage_for_a_round " + sstr(inflictor) + " " + sstr(attacker) + " " + sstr(damage) + " " + sstr(flags) + " " + sstr(meansofdeath) + " " + sstr(weapon) + " " + sstr(vpoint) + " " + sstr(vdir) + " " + sstr(shitloc) + " " + sstr(psoffsettime) + " " + sstr(boneindex));
    return eq(weapon, "quadrotorturret_zm") ? 0 : damage;
}

more_monkeys_in_the_box()
{
    TRACE("more_monkeys_in_the_box");
    level endon("end_game");

    level.gauntlet_high_cymbalmonkey_chances = 69;
    old_custom_weights = level.customrandomweaponweights;
    level.customrandomweaponweights = ::cymbalmonkey_weights;

    level waittill_any("end_of_round", "gauntlet_received_weighted_monkeys");
    level.customrandomweaponweights = old_custom_weights;
}

cymbalmonkey_weights(keys)
{
    TRACE("cymbalmonkey_weights " + sstr(keys));
    if (randomint(100) < level.gauntlet_high_cymbalmonkey_chances)
    {
        keys[0] = "cymbal_monkey_zm";
        level notify("gauntlet_received_weighted_monkeys");
        return keys;
    }
    level.gauntlet_high_cymbalmonkey_chances = min_int(level.gauntlet_high_cymbalmonkey_chances + 10, 99);

    return keys;
}

mauser_reward_church()
{
    TRACE("mauser_reward_church");
    if (flag("gauntlet_ee_r18"))
    {
        return;
    }
    flag_set("gauntlet_ee_r18");
    b2_flag_set(FLAG_DMG_CHALLENGE);
    level._game_module_player_damage_callback = ::_no_damage_player_callback;
    level waittill("end_of_round");
    level._game_module_player_damage_callback = undefined;
    while (level.gauntlet_round < 20)
    {
        level waittill("start_of_round");
    }

    if (!b2_flag(FLAG_DMG_CHALLENGE))
    {
        playsoundonplayers("evt_player_downgrade");
        return;
    }

    pcount = clamp_int(level.players.size, 1, 4);
    thread mauser_reward((829, -2487, 355), (0, 330, 0));
    if (pcount > 1)
    {
        thread mauser_reward((853, -2610, 355), (0, 60, 0));
    }
    if (pcount > 2)
    {
        thread mauser_reward((989, -2575, 355), (0, 150, 0));
    }
    if (pcount > 3)
    {
        thread mauser_reward((962, -2453, 355), (0, 240, 0));
    }
}

giveaway_zombie_blood()
{
    TRACE("giveaway_zombie_blood");
    wait 4;
    /* Gen 2 & Gen 3 */
    trenches = cointoss()
        ? array((-462, 3334, -286), (-235, 3334, -286), (-235, 3560, -286), (-462, 3560, -286))
        : array((642, 2225, -116), (410, 2225, -116), (410, 2457, -116), (642, 2457, -116));
    /* Gen 4 & Gen 5 */
    nml = cointoss()
        ? array((2249, 118, 125), (2249, 360, 125), (2490, 360, 125), (2490, 118, 125))
        : array((-2744, 292, 241), (-2744, 57, 241), (-2505, 57, 241), (-2505, 292, 241));
    /* Gen 6 */
    church = array((1078, -3590, 311), (1078, -3830, 311), (838, -3830, 311), (838, -3590, 311));

    players = get_players();
    level._powerup_timeout_custom_time = ::powerup_round_duration;
    min = min_int(players.size, 4);
    if (b2_flag(FLAG_MONK_CHALLENGE))
    {
        for (i = 0; i < min; i++)
        {
            specific_powerup_drop("zombie_blood", church[i]);
        }
    }
    if (b2_flag(FLAG_ZONE_CHALLENGE))
    {
        for (i = 0; i < min; i++)
        {
            specific_powerup_drop("zombie_blood", trenches[i]);
        }
    }
    if (b2_flag(FLAG_DMG_CHALLENGE))
    {
        for (i = 0; i < min; i++)
        {
            specific_powerup_drop("zombie_blood", nml[i]);
        }
    }
    level._powerup_timeout_custom_time = undefined;
}

powerup_round_duration(powerup)
{
    TRACE("powerup_round_duration");
    level waittill_any("end_of_round", "gauntlet_stop_side_ee");
    return 0.5;
}

_no_damage_player_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime)
{
    TRACE(sstr(self) + " _no_damage_player_callback " + sstr(einflictor) + " " + sstr(eattacker) + " " + sstr(idamage) + " " + sstr(idflags) + " " + sstr(smeansofdeath) + " " + sstr(sweapon) + " " + sstr(vpoint) + " " + sstr(vdir) + " " + sstr(shitloc) + " " + sstr(psoffsettime));
    if (is_player_valid(self, false, true) && is_true(eattacker.is_zombie))
    {
        b2_flag_clear(FLAG_DMG_CHALLENGE);
        b2_flag_set(P_FLAG_DMG_CHALLENGE_FAIL, self);
    }
}

mauser_reward(origin, angles)
{
    TRACE("mauser_reward " + sstr(origin) + " " + sstr(angles));
    weapon = b2_flag(FLAG_ZONE_CHALLENGE) ? "c96_upgraded_zm" : "c96_zm";
    options = level.players[0] maps\mp\zombies\_zm_weapons::get_pack_a_punch_weapon_options(weapon);
    model = spawn_weapon_model(weapon, undefined, origin, angles, options);
    playfxontag(level._effect["special_glow"], model, "tag_origin");
    trig = tomb_spawn_trigger_radius(origin, 40, 1);
    trig.require_look_at = 1;
    trig.hint_string = &"PLATFORM_PICKUPNEWWEAPON";

    for (b_retrieved = 0; !b_retrieved; b_retrieved = swap_mauser(player, b2_flag(FLAG_ZONE_CHALLENGE)))
    {
        trig waittill("trigger", player);
    }

    trig tomb_unitrigger_delete();
    model delete();
}

swap_mauser(player, upgraded = false)
{
    TRACE("swap_mauser " + sstr(player));
    str_current_weapon = player getcurrentweapon();
    str_reward_weapon = upgraded ? maps\mp\zombies\_zm_weapons::get_upgrade_weapon("c96_zm") : "c96_zm";

    if (is_player_valid(player) && !player.is_drinking && !is_placeable_mine(str_current_weapon) && !is_equipment(str_current_weapon) && level.revive_tool != str_current_weapon && "none" != str_current_weapon && !player hacker_active())
    {
        if (player hasweapon(str_reward_weapon))
        {
            player givemaxammo(str_reward_weapon);
        }
        else
        {
            a_weapons = player getweaponslistprimaries();

            if (isdefined(a_weapons) && a_weapons.size >= get_player_weapon_limit(player))
            {
                player takeweapon(str_current_weapon);
            }

            player giveweapon(str_reward_weapon, 0, player maps\mp\zombies\_zm_weapons::get_pack_a_punch_weapon_options(str_reward_weapon));
            player givestartammo(str_reward_weapon);
            player switchtoweapon(str_reward_weapon);
        }

        return true;
    }
    return false;
}

set_gauntlet_weather()
{
    TRACE("set_gauntlet_weather");
    level.force_weather[5] = "rain";
    level.force_weather[6] = "snow";
    level.force_weather[7] = "snow";
    level.force_weather[8] = "none";
    level.force_weather[9] = "rain";
    level.force_weather[10] = "snow";
    level.force_weather[11] = "none";
    level.force_weather[12] = "none";
    level.force_weather[13] = "rain";
    level.force_weather[14] = "snow";
    level.force_weather[15] = "snow";
    level.force_weather[16] = "rain";
    level.force_weather[17] = "rain";
    level.force_weather[21] = "none";
    level.force_weather[25] = "rain";
}

remove_raygun()
{
    TRACE("remove_raygun");
    arrayremovevalue(level.zombie_weapons, level.zombie_weapons["ray_gun_zm"], true);
    arrayremovevalue(level.zombie_weapons, level.zombie_weapons["raygun_mark2_zm"], true);
}

change_starting_box_location()
{
    TRACE("change_starting_box_location");
    chests_new = [];
    /* All chests here do exist */
    foreach (chest in level.chests)
    {
        chest notify("kill_chest_think");
        /* Kill the FX playing on active box location, hide_chest won't do it */
        if (isdefined(chest.zbarrier) && chest.zbarrier getclientfield("magicbox_amb_fx"))
        {
            chest.zbarrier setclientfield("magicbox_amb_fx", 0);
        }

        if (chest.script_noteworthy == "bunker_tank_chest")
        {
            lb_chest = chest;
        }
        else
        {
            chests_new[chests_new.size] = chest;
        }

        /* Classic maps use this flag to check */
        if (is_classic() && is_true(level.random_pandora_box_start))
        {
            chest.start_exclude = chest.script_noteworthy == "bunker_tank_chest" ? 0 : 1;
        }
    }

    /* We're in trouble if we get into this if */
    if (!isdefined(lb_chest))
    {
        array_thread(level.chests, maps\mp\zombies\_zm_magicbox::treasure_chest_think);
        ERROR("lb_chest undefined, should never happen!");
        return;
    }

    /* Pandora box based maps (mob & origins) */
    if (is_true(level.random_pandora_box_start))
    {
        maps\mp\zombies\_zm_magicbox::init_starting_chest_location("start_chest");
    }
    /* script noteworthy based maps */
    else
    {
        /* I have to reindex the global array, since the actual location is index dependent */
        // level.chests = [];
        // level.chests[0] = lb_chest;
        // foreach (new in chests_new)
        // {
        //     level.chests[level.chests.size] = new;
        // }

        // maps\mp\zombies\_zm_magicbox::init_starting_chest_location("");
    }

    array_thread(level.chests, maps\mp\zombies\_zm_magicbox::treasure_chest_think);
}

gauntlet_electric_cherry_threads()
{
    TRACE("gauntlet_electric_cherry_threads");
    level._custom_perks["specialty_grenadepulldeath"].player_thread_give = undefined;
    register_perk_threads("specialty_grenadepulldeath", ::gauntlet_cherry_reload_attack);
}

gauntlet_cherry_reload_attack()
{
    TRACE(sstr(self) + " gauntlet_cherry_reload_attack");
    self endon("death");
    self endon("disconnect");
    self endon("stop_electric_cherry_reload_attack");
    self.wait_on_reload = [];
    self.consecutive_electric_cherry_attacks = 0;

    while (true)
    {
        self waittill("reload_start");
        str_current_weapon = self getcurrentweapon();

        if (isinarray(self.wait_on_reload, str_current_weapon))
        {
            continue;
        }

        self.wait_on_reload[self.wait_on_reload.size] = str_current_weapon;
        self.consecutive_electric_cherry_attacks++;
        n_clip_current = self getweaponammoclip(str_current_weapon);
        n_clip_max = weaponclipsize(str_current_weapon);
        n_fraction = n_clip_current / n_clip_max;
        perk_radius = linear_map(n_fraction, 1.0, 0.0, 32, 128);
        perk_dmg = linear_map(n_fraction, 1.0, 0.0, 1, 1045);
#ifdef GUNS_DEBOUNCE_DAMAGE
        if (isdefined(level.gauntlet_allowed_guns) && level.gauntlet_allowed_guns.size)
        {
            perk_dmg = 1;
        }
#endif
        self thread maps\mp\zombies\_zm_perk_electric_cherry::check_for_reload_complete(str_current_weapon);

        if (isdefined(self))
        {
            switch (self.consecutive_electric_cherry_attacks)
            {
                case 0:
                case 1:
                    n_zombie_limit = undefined;
                    break;
                case 2:
                    n_zombie_limit = 8;
                    break;
                case 3:
                    n_zombie_limit = 4;
                    break;
                case 4:
                    n_zombie_limit = 2;
                    break;
                default:
                    n_zombie_limit = 0;
            }

            self thread maps\mp\zombies\_zm_perk_electric_cherry::electric_cherry_cooldown_timer(str_current_weapon);

            if (isdefined(n_zombie_limit) && n_zombie_limit == 0)
            {
                continue;
            }

            self thread electric_cherry_reload_fx(n_fraction);
            self notify("electric_cherry_start");
            self playsound("zmb_cherry_explode");
            a_zombies = getaispeciesarray("axis", "all");
            a_zombies = get_array_of_closest(self.origin, a_zombies, undefined, undefined, perk_radius);
            n_zombies_hit = 0;

            for (i = 0; i < a_zombies.size; i++)
            {
                if (isalive(self) && isalive(a_zombies[i]))
                {
                    if (isdefined(n_zombie_limit))
                    {
                        if (n_zombies_hit < n_zombie_limit)
                        {
                            n_zombies_hit++;
                        }
                        else
                        {
                            break;
                        }
                    }

                    if (a_zombies[i].health <= perk_dmg)
                    {
                        a_zombies[i] thread maps\mp\zombies\_zm_perk_electric_cherry::electric_cherry_death_fx();

                        if (isdefined(self.cherry_kills))
                        {
                            self.cherry_kills++;
                        }

                        self maps\mp\zombies\_zm_score::add_to_player_score(40);
                    }
                    else
                    {
                        if (!isdefined(a_zombies[i].is_mechz))
                        {
                            a_zombies[i] thread maps\mp\zombies\_zm_perk_electric_cherry::electric_cherry_stun();
                        }

                        a_zombies[i] thread maps\mp\zombies\_zm_perk_electric_cherry::electric_cherry_shock_fx();
                    }

                    wait 0.1;

                    if (isalive(a_zombies[i]))
                    {
                        a_zombies[i]._cherry_damage = perk_dmg;
                        a_zombies[i] dodamage(perk_dmg, self.origin, self, self, "none");
                    }
                }
            }

            self notify("electric_cherry_end");
        }
    }
}

lower_gspeed_for_a_round()
{
    TRACE("lower_gspeed_for_a_round");
    register_on_gauntlet_end_of_this_round(::reset_gspeed);
    setdvar("g_speed", 170);
}

reset_gspeed()
{
    TRACE("reset_gspeed");
    setdvar("g_speed", 190);
}

dig_more_zombies()
{
    TRACE("dig_more_zombies");
    register_on_gauntlet_end_of_this_round(::clear_dig_override);
    level.gauntlet_dig_reward_override = ::high_chance_to_dig_zombie;
}

clear_dig_override()
{
    TRACE("clear_dig_override");
    level.gauntlet_dig_reward_override = undefined;
}

high_chance_to_dig_zombie(dig_spot, player)
{
    TRACE("high_chance_to_dig_zombie " + sstr(dig_spot) + " " + sstr(player));
    if (cointoss())
    {
        player dig_reward_dialog("dig_zombie");
        self thread dig_up_zombie(player, dig_spot);
        return true;
    }

    return false;
}

help_players_with_golden_shovel()
{
    TRACE("help_players_with_golden_shovel");
    level endon("end_game");

    players = get_players();
    foreach (player in players)
    {
        player.dig_vars["n_spots_dug"] += 30;
    }

    level waittill("end_of_round");
    foreach (player in players)
    {
        player.dig_vars["n_spots_dug"] -= 30;
    }
}

check_staff_progress()
{
    TRACE("check_staff_progress");
    if (getclientfield("quest_state" + 1) == 3)
    {
        b2_flag_set(FLAG_STAFF_FIRE);
    }
    if (getclientfield("quest_state" + 2) == 3)
    {
        b2_flag_set(FLAG_STAFF_AIR);
    }
    if (getclientfield("quest_state" + 3) == 3)
    {
        b2_flag_set(FLAG_STAFF_LIGHTNING);
    }
    if (getclientfield("quest_state" + 4) == 3)
    {
        b2_flag_set(FLAG_STAFF_WATER);
    }
}

repeat_gen_zombies()
{
    TRACE("repeat_gen_zombies");
    level endon("end_game");
    level endon("end_of_round");

    gen_wait_multiplier = 0;

    while (true)
    {
        wait 1;
        zone_count = get_captured_zone_count();
        if (zone_count <= 4)
        {
            continue;
        }

        thread recapture_round_start();
        switch (zone_count)
        {
            case 6:
                wait_for = randomintrange(12, 16);
                break;
            default:
                wait_for = randomintrange(24, 28);
        }

        wait 4;
        flag_waitopen_array(array("recapture_event_in_progress", "zone_capture_in_progress"));
        DEBUG("repeat_gen_zombies waiting " + sstr(wait_for + gen_wait_multiplier));
        level.zombie_ai_limit = 24;
        wait wait_for + gen_wait_multiplier;
        gen_wait_multiplier += 4;
    }
}

player_aware_get_recapture_zone(s_last_recapture_zone)
{
    TRACE("player_aware_get_recapture_zone " + sstr(s_last_recapture_zone));
    occupated_zones = 0;
    players = get_alive_players();
    foreach (player in players)
    {
        switch (player get_current_zone())
        {
            case "zone_start":
            case "zone_start_a":
            case "zone_start_b":
            case "zone_bunker_1a":
            case "zone_fire_stairs":
            case "zone_bunker_1":
            case "zone_bunker_3a":
            case "zone_bunker_3b":
            case "zone_bunker_2a":
            case "zone_bunker_2":
            case "zone_bunker_4a":
            case "zone_bunker_4b":
            case "zone_bunker_4c":
            case "zone_bunker_4d":
            case "zone_bunker_tank_c":
            case "zone_bunker_tank_c1":
            case "zone_bunker_4e":
            case "zone_bunker_tank_d":
            case "zone_bunker_tank_d1":
            case "zone_bunker_4f":
                occupated_zones |= AREA_TRENCHES;
                break;
            case "zone_bunker_5a":
            case "zone_bunker_5b":
            case "zone_bunker_tank_a":
            case "zone_bunker_tank_a1":
            case "zone_bunker_tank_b":
            case "zone_bunker_tank_e":
            case "zone_bunker_tank_e1":
            case "zone_bunker_tank_f":
            case "zone_nml_1":
            case "zone_nml_2":
            case "zone_nml_2a":
            case "zone_nml_2b":
            case "zone_nml_5":
            case "zone_nml_6":
            case "zone_nml_7":
                occupated_zones |= (AREA_TRENCHES | AREA_NML);
                break;
            case "zone_nml_0":
            case "zone_nml_3":
            case "zone_nml_4":
            case "zone_nml_9":
            case "zone_nml_11":
            case "zone_nml_12":
            case "zone_nml_16":
            case "zone_nml_17":
            case "zone_nml_18":
            case "zone_air_stairs":
            case "zone_bolt_stairs":
            case "zone_nml_farm":
            case "zone_nml_celllar":
                occupated_zones |=  AREA_NML;
                break;
            case "zone_nml_8":
            case "zone_nml_10":
            case "zone_nml_10a":
            case "zone_nml_13":
            case "zone_nml_14":
            case "zone_nml_14a":
            case "zone_nml_15":
            /* Adding these too, else it'd just try to repeat 6 all the time */
            case "zone_village_0":
            case "zone_village_5":
            case "zone_village_5a":
            case "zone_village_5b":
            case "zone_village_1":
            case "zone_village_4b":
            case "zone_village_4a":
            case "zone_village_4":
            case "zone_village_2":
            case "zone_village_3":
            case "zone_village_3a":
            case "zone_ice_stairs":
            case "zone_village_6":
                occupated_zones |= (AREA_NML | AREA_CHURCH);
                break;
            default:
                occupated_zones |= AREA_FULL;
        }
    }
    DEBUG("occupated_zones: " + sstr(occupated_zones));

    a_s_player_zones = [];

    foreach (str_key, s_zone in level.zone_capture.zones)
    {
        if (s_zone ent_flag("player_controlled"))
        {
            a_s_player_zones[str_key] = s_zone;
        }
    }

    s_recapture_zone = undefined;
    if (a_s_player_zones.size == 1)
    {
        /* Failsafe, just return the only one available outright */
        DEBUG("player_aware_get_recapture_zone failsafe");
        return random(a_s_player_zones);
    }
    else if (isdefined(s_last_recapture_zone))
    {
        n_distance_closest = undefined;

        foreach (s_zone in a_s_player_zones)
        {
            n_distance = distancesquared(s_zone.origin, s_last_recapture_zone.origin);

            if (!isdefined(n_distance_closest) || n_distance < n_distance_closest)
            {
                s_recapture_zone = s_zone;
                n_distance_closest = n_distance;
            }
        }

        return isdefined(s_recapture_zone) ? s_recapture_zone : random(a_s_player_zones);
    }

    aware_players_zones = [];

    zone_map = [];
    zone_map[TOMB_GENERATOR_1] = AREA_FULL | AREA_TRENCHES;
    zone_map[TOMB_GENERATOR_2] = AREA_FULL | AREA_TRENCHES;
    zone_map[TOMB_GENERATOR_3] = AREA_FULL | AREA_TRENCHES;
    zone_map[TOMB_GENERATOR_4] = AREA_FULL | AREA_NML;
    zone_map[TOMB_GENERATOR_5] = AREA_FULL | AREA_NML;
    zone_map[TOMB_GENERATOR_6] = AREA_FULL | AREA_CHURCH;
    foreach (gen_key, gen_flag in zone_map)
    {
        if (isdefined(level.gauntlet_last_gen_recapture) && eq(level.gauntlet_last_gen_recapture, a_s_player_zones[gen_key]))
        {
            DEBUG("skip previous gen " + sstr(gen_key));
            continue;
        }

        if (occupated_zones & gen_flag)
        {
            DEBUG("binding gen (bitflag): " + sstr(gen_key));
            aware_players_zones[aware_players_zones.size] = a_s_player_zones[gen_key];
        }
    }

    // DEBUG("aware_players_zones " + sstr(aware_players_zones));
    if (aware_players_zones.size > 0)
    {
        s_recapture_zone = random(aware_players_zones);
        level.gauntlet_last_gen_recapture = s_recapture_zone;
        DEBUG("player_aware_get_recapture_zone rolling " + sstr(s_recapture_zone));
        return s_recapture_zone;
    }
    fallback = random(a_s_player_zones);
    level.gauntlet_last_gen_recapture = fallback;
    DEBUG("player_aware_get_recapture_zone last failsafe");
    return fallback;
}

gauntlet_reward_packed_weapon(player, s_stat)
{
    TRACE("gauntlet_reward_packed_weapon " + sstr(player) + " " + sstr(s_stat));
    if (!isdefined(s_stat.str_reward_weapon))
    {
        a_weapons = array("scar_zm", "galil_zm");
        s_stat.str_reward_weapon = maps\mp\zombies\_zm_weapons::get_upgrade_weapon(random(a_weapons));
    }

    m_weapon = spawn("script_model", self.origin);
    m_weapon.angles = self.angles + vectorscale((0, 1, 0), 180.0);
    m_weapon playsound("zmb_spawn_powerup");
    m_weapon playloopsound("zmb_spawn_powerup_loop", 0.5);
    str_model = getweaponmodel( s_stat.str_reward_weapon );
    options = player maps\mp\zombies\_zm_weapons::get_pack_a_punch_weapon_options(s_stat.str_reward_weapon);
    m_weapon useweaponmodel(s_stat.str_reward_weapon, str_model, options);
    wait_network_frame();

    if (!maps\mp\zombies\_zm_challenges::reward_rise_and_grab(m_weapon, 50, 2, 2, 10))
    {
        return false;
    }

    weapon_limit = get_player_weapon_limit(player);
    primaries = player getweaponslistprimaries();

    if (isdefined(primaries) && primaries.size >= weapon_limit)
    {
        player maps\mp\zombies\_zm_weapons::weapon_give(s_stat.str_reward_weapon);
    }
    else
    {
        player giveweapon(s_stat.str_reward_weapon, 0, player maps\mp\zombies\_zm_weapons::get_pack_a_punch_weapon_options(s_stat.str_reward_weapon));
        player givestartammo(s_stat.str_reward_weapon);
    }

    player switchtoweapon(s_stat.str_reward_weapon);
    m_weapon stoploopsound(0.1);
    player playsound("zmb_powerup_grabbed");
    m_weapon delete();
    return true;
}

gauntlet_dig_spots_respawn(a_dig_spots)
{
    TRACE("gauntlet_dig_spots_respawn " + sstr(a_dig_spots));
    while (true)
    {
        level waittill("end_of_round");
        wait 2;
        a_dig_spots = array_randomize(level.a_dig_spots);
        n_respawned = 0;
        n_respawned_max = 3;

        if (isdefined(level.gauntlet_dig_spots_respawn_override))
        {
            n_respawned_max = level.gauntlet_dig_spots_respawn_override;
            level.gauntlet_dig_spots_respawn_override = undefined;
        }
        else if (level.weather_snow > 0)
        {
            n_respawned_max = 0;
        }
        else if (level.weather_rain > 0)
        {
            n_respawned_max = 5;
        }

        if (level.weather_snow == 0)
        {
            n_respawned_max = n_respawned_max + randomint(get_players().size);
        }

        for (i = 0; i < a_dig_spots.size; i++)
        {
            if (isdefined(a_dig_spots[i].dug) && a_dig_spots[i].dug && n_respawned < n_respawned_max && level.n_dig_spots_cur <= level.n_dig_spots_max)
            {
                a_dig_spots[i].dug = undefined;
                a_dig_spots[i] thread dig_spot_spawn();
                wait_network_frame();
                n_respawned++;
            }
        }

        if (level.weather_snow > 0 && level.ice_staff_pieces.size > 0)
        {
            foreach (s_staff in level.ice_staff_pieces)
            {
                a_staff_spots = [];
                n_active_mounds = 0;

                foreach (s_dig_spot in level.a_dig_spots)
                {
                    if (isdefined(s_dig_spot.str_zone) && issubstr(s_dig_spot.str_zone, s_staff.zone_substr))
                    {
                        if (!(isdefined(s_dig_spot.dug) && s_dig_spot.dug))
                        {
                            n_active_mounds++;
                            continue;
                        }

                        a_staff_spots[a_staff_spots.size] = s_dig_spot;
                    }
                }

                if (n_active_mounds < 2 && a_staff_spots.size > 0 && level.n_dig_spots_cur <= level.n_dig_spots_max)
                {
                    n_index = randomint(a_staff_spots.size);
                    a_staff_spots[n_index].dug = undefined;
                    a_staff_spots[n_index] thread dig_spot_spawn();
                    arrayremoveindex(a_staff_spots, n_index);
                    n_active_mounds++;
                    wait_network_frame();
                }
            }
        }
    }
}

guard_panzer_round()
{
    TRACE("guard_panzer_round");
    level endon("end_game");
    level endon("end_of_round");

    level._gauntlet_guard_zcount = get_round_count();
    thread _guard_panzer_round_thread();
    register_on_gauntlet_end_of_this_round(::unfreeze_round_zombie_count);

    zombie_count = get_round_count();
    while (true)
    {
        if (level._gauntlet_guard_zcount > get_round_count() + 24)
        {
            thread freeze_round_zombie_count();
            while (level._gauntlet_guard_zcount > get_round_count() + 24)
            {
                wait 0.05;
            }
            unfreeze_round_zombie_count();
        }
        wait 0.05;
    }
}

_guard_panzer_round_thread()
{
    TRACE("_guard_panzer_round_thread");
    level endon("end_game");
    level endon("end_of_round");

    while (true)
    {
        level waittill("mechz_killed", origin);
        level._gauntlet_guard_zcount = get_round_count();
    }
}

guard_crazy_place()
{
    TRACE("guard_crazy_place");
    level endon("end_game");
    level endon("end_of_round");
    register_on_gauntlet_end_of_this_round(::unguard_crazy_place);

    for (i = 1; i < 5; i++)
    {
        maps\mp\zm_tomb_teleporter::stargate_teleport_disable(i);
    }

    wait_network_frame();

    foreach (player in get_alive_players())
    {
        if (maps\mp\zm_tomb_chamber::is_point_in_chamber(player.origin))
        {
            teleport_target = array(TELEPORT_WIND_OUT, TELEPORT_FIRE_OUT, TELEPORT_ELECTRIC_OUT, TELEPORT_ICE_OUT)[randomint(4)];
            stargate_teleport_player(teleport_target, player);
        }
    }

    wait 2;

    while (true)
    {
        a_players = get_alive_players();
        foreach (player in a_players)
        {
            if (maps\mp\zm_tomb_chamber::is_point_in_chamber(player.origin))
            {
                player instakill_player();
            }
        }

        wait 0.5;
    }
}

unguard_crazy_place()
{
    TRACE("unguard_crazy_place");
    level endon("end_game");
    level waittill("end_of_round");

    if (b2_flag(FLAG_MONK_CHALLENGE))
    {
        for (i = 1; i < 5; i++)
        {
            maps\mp\zm_tomb_teleporter::stargate_teleport_enable(i);
        }
    }
    else
    {
        // fixme
        snapshot_restore_stargate(level.gauntlet_round_snapshot["stargate"]);
    }
}

force_next_drop(drop)
{
    TRACE("force_next_drop " + sstr(drop));
    level endon("end_game");

    cache_func = [];
    foreach (powerup, p_struct in level.zombie_powerups)
    {
        if (!eq(powerup, drop))
        {
            cache_func[powerup] = p_struct.func_should_drop_with_regular_powerups;
            p_struct.func_should_drop_with_regular_powerups = ::no;
        }
    }

    level waittill_any("powerup_dropped", "end_of_round");

    foreach (key, cache in cache_func)
    {
        level.zombie_powerups[key].func_should_drop_with_regular_powerups = cache;
    }
}

force_drop_max_ammo()
{
    TRACE("force_drop_max_ammo");
    force_next_drop("full_ammo");
}

force_drop_double_points()
{
    TRACE("force_drop_double_points");
    force_next_drop("double_points");
}

set_gauntlet_starting_points()
{
    TRACE("set_gauntlet_starting_points");
#ifdef ENABLE_DEBUG
    score = 5 + (getdvarint("gauntlet_round") * 1000);
#else
    score = 5;
#endif
    foreach (player in level.players)
    {
        player add_to_player_score(score);
    }
}

terminate_staffs()
{
    TRACE("terminate_staffs");
    fn = getfunction("maps/mp/zm_tomb_main_quest", "can_pickup_staff");
    if (isdefined(fn))
    {
        replacefunc(fn, ::no);
    }

    wait 0.05;

    hide_staff_model();
    foreach (player in get_alive_players())
    {
        foreach (wpn in player getweaponslist())
        {
            if (issubstr(wpn, "staff_"))
            {
                player takeweapon(wpn);
            }
        }
    }
    foreach (player_num, player_snapshots in level.gauntlet_round_snapshot)
    {
        if (!isdefined(player_snapshots.weapons) || !isarray(player_snapshots.weapons))
        {
            continue;
        }

        foreach (snap_idx in getarraykeys(player_snapshots.weapons))
        {
            if (issubstr(player_snapshots.weapons[snap_idx]["name"], "staff_"))
            {
                DEBUG("Removing snapshot " + sstr(player_snapshots.weapons[snap_idx]["name"]) + " for player " + sstr(player_num));
                arrayremoveindex(level.gauntlet_round_snapshot[player_num].weapons, snap_idx, false);
            }
        }
    }

    clear_player_staff("staff_air_zm");
    clear_player_staff("staff_fire_zm");
    clear_player_staff("staff_lightning_zm");
    clear_player_staff("staff_water_zm");
}

disable_buildables_pickup_for_a_round()
{
    TRACE("disable_buildables_pickup");
    saved_custom_craftable_validation = level.custom_craftable_validation;
    level.custom_craftable_validation = ::no;
    level waittill("end_of_round");
    level.custom_craftable_validation = saved_custom_craftable_validation;
}

dynamic_round()
{
    TRACE("dynamic_round");
    level endon("end_game");

    level waittill("gauntlet_begin_protecting_zone");
    zombie_count = get_round_count();
    players = get_players();
    level.zombie_vars["zombie_powerup_drop_max_per_round"] = 0;
    level.mechz_should_drop_powerup = false;
    drop_location = players.size < 2 ? DROP_BOTTOM : DROP_UPPER;

    cycle = 0;
    while (true)
    {
        wait 45;
        playsoundonplayers("zmb_perks_packa_ready");
        level._powerup_timeout_custom_time = ::finale_powerup_timeout;
        switch (cycle)
        {
            case 0:
                specific_powerup_drop("full_ammo", DROP_BOTTOM);
                break;
            case 1:
                specific_powerup_drop("insta_kill", DROP_BOTTOM);
                specific_powerup_drop("zombie_blood", DROP_UPPER);
                break;
            case 2:
                foreach (player in players)
                {
                    if (is_player_valid(player))
                    {
                        player give_perk_ordered();
                        if (player get_perk_array().size < 4)
                        {
                            player give_perk_ordered();
                        }
                    }
                }
                specific_powerup_drop("full_ammo", drop_location);
                break;
            case 3:
                specific_powerup_drop("zombie_blood", DROP_BOTTOM);
                if (level.zombie_total > 0)
                {
                    specific_powerup_drop("nuke", DROP_UPPER);
                }
                break;
        }
        cycle++;
        if (cycle > 3)
        {
            cycle = 0;
        }
        level._powerup_timeout_custom_time = undefined;

        if (level.zombie_total > 0)
        {
            level.zombie_total += 20;
        }
    }
}

give_perk_ordered()
{
    TRACE(sstr(self) + " give_perk_ordered");
    if (!self hasperk("specialty_armorvest"))
    {
        self give_perk("specialty_armorvest");
    }
    else if (!self hasperk("specialty_rof"))
    {
        self give_perk("specialty_rof");
    }
    else if (!self hasperk("specialty_fastreload"))
    {
        self give_perk("specialty_fastreload");
    }
    else if (!self hasperk("specialty_quickrevive"))
    {
        self give_perk("specialty_quickrevive");
    }
    else if (!self hasperk("specialty_longersprint"))
    {
        self give_perk("specialty_longersprint");
    }
    else if (!self hasperk("specialty_deadshot"))
    {
        self give_perk("specialty_deadshot");
    }
    else if (!self hasperk("specialty_flakjacket"))
    {
        self give_perk("specialty_flakjacket");
    }
    else if (!self hasperk("specialty_grenadepulldeath"))
    {
        self give_perk("specialty_grenadepulldeath");
    }
    else if (!self hasperk("specialty_additionalprimaryweapon"))
    {
        self give_perk("specialty_additionalprimaryweapon");
    }
}

finale_powerup_timeout(powerup)
{
    return 30;
}

headshot_bonus()
{
    TRACE("headshot_bonus");
    if (flag("gauntlet_ee_r3"))
    {
        return;
    }
    flag_set("gauntlet_ee_r3");

    level endon("end_game");
    level.gauntlet_zombie_damage_callback_logic = ::_headshot_bonus_callback;
    level.gauntlet_r3_ee_reward = clamp_int(750 + (level.players.size * 250), 1000, 2000);
    players = get_players();
    switch (players.size)
    {
        case 1:
            timems = 46000;
            break;
        case 2:
            timems = 52000;
            break;
        case 3:
            timems = 64000;
            break;
        default:
            timems = 74000;
    }

    thread gauntlet_clock(timems / 1000, "gauntlet_hs_bonus_expired", false, FLAG_HS_CHALLENGE_EXPIRED);

    level waittill_any("end_of_round", "gauntlet_hs_bonus_expired");
    level notify("gauntlet_clock+gauntlet_hs_bonus_expired");
    wait 0.75;

    no_failure = true;
    foreach (player in players)
    {
        if (b2_flag(FLAG_HS_CHALLENGE_EXPIRED) && !is_false(player._gauntlet_headshots_only))
        {
            player playsoundtoplayer("evt_player_downgrade", player);
            no_failure = false;
        }
        if (!b2_flag(FLAG_HS_CHALLENGE_EXPIRED) && !is_false(player._gauntlet_headshots_only))
        {
            wait 0.25;
            b2_flag_set(FLAG_HS_CHALLENGE);
            b2_flag_set(P_FLAG_HS_CHALLENGE, player);
            player add_to_player_score(level.gauntlet_r3_ee_reward);
            player playsoundtoplayer("evt_player_upgrade", player);
        }
    }
    if (no_failure)
    {
        b2_flag_set(FLAG_HS_CHALLENGE_FULL);
    }

    level.gauntlet_zombie_damage_callback_logic = undefined;
}

_headshot_bonus_callback(mod, hit_location, hit_origin, player, amount)
{
    TRACE(sstr(self) + " _headshot_bonus_callback " + sstr(mod) + " " + sstr(hit_location) + " " + sstr(hit_origin) + " " + sstr(player) + " " + sstr(amount));
    if (!is_false(player._gauntlet_headshots_only) && !isinarray(array("head", "helmet"), hit_location))
    {
        player playsoundtoplayer("evt_player_downgrade", player);
        player._gauntlet_headshots_only = false;
        level.gauntlet_r3_ee_reward -= 250;
    }
    return false;
}

monkey_bonus()
{
    TRACE("monkey_bonus");
    if (flag("gauntlet_ee_r6"))
    {
        return;
    }
    flag_set("gauntlet_ee_r6");
    level endon("end_game");

    level.gauntlet_zombie_death_callback_logic = ::_on_monkey_kill;
    level waittill("end_of_round");
    level.gauntlet_zombie_death_callback_logic = undefined;
    if (!b2_flag(FLAG_MONK_CHALLENGE))
    {
        playsoundonplayers("evt_player_downgrade");
    }
}

_on_monkey_kill()
{
    TRACE("_on_monkey_kill");
    if (is_true(self.is_recapture_zombie))
    {
        return;
    }
    if (self get_last_damageweapon() == "cymbal_monkey_zm")
    {
        level.gauntlet_zombie_death_callback_logic = undefined;
        b2_flag_set(FLAG_MONK_CHALLENGE);
        b2_flag_set(P_FLAG_MONK_ATTACKER, self.attacker);
        thread _refund_next_purchase();
        playsoundonplayers("evt_player_upgrade");
    }
}

_refund_next_purchase()
{
    TRACE("_refund_next_purchase");
    GAUNTLET_SINGLE("_refund_next_purchase");
    level endon("end_game");
    level endon("gauntlet_stop_side_ee");
    while (true)
    {
        level waittill("spent_points", player, points);
        if (player is_player() && is_player_valid(player, false, false) && points >= 500)
        {
            wait 1;
            player maps\mp\zombies\_zm_score::add_to_player_score(points);
            player play_sound_on_ent("purchase");
            break;
        }
    }
}

zone_killing()
{
    TRACE("zone_killing");
    if (flag("gauntlet_ee_r13"))
    {
        return;
    }
    flag_set("gauntlet_ee_r13");
    level.gauntlet_zombie_death_callback_logic = ::_capture_zone_kills;
    _zone_killing();
    level.gauntlet_zombie_death_callback_logic = undefined;
    level.gauntlet_zone_hud_processing = undefined;
    set_zone_hud_property(GAUNTLET_HUD_SET_COLOR, (0.85, 0.85, 0.85));
    if (!b2_flag(FLAG_ZONE_CHALLENGE))
    {
        playsoundonplayers("evt_player_downgrade");
    }
}

_zone_killing()
{
    TRACE("_zone_killing");
    level endon("end_of_round");

    flag_init("gauntlet_zone_killing_half");

    while (true)
    {
        progress = zone_killing_hud_percent_complete();
        if (progress >= 100)
        {
            thread upgrade_wallbuys();
            b2_flag_set(FLAG_ZONE_CHALLENGE);
            playsoundonplayers("evt_player_upgrade");
            level.gauntlet_zone_hud_processing = undefined;
            set_zone_hud_property(GAUNTLET_HUD_SET_COLOR, (0.85, 0.85, 0.85));
            level waittill("forever");
        }
        else if (!flag("gauntlet_zone_killing_half") && progress >= 50)
        {
            flag_set("gauntlet_zone_killing_half");
            thread hint_zone_killing_progress();
        }

        wait 0.05;
    }
}

hint_zone_killing_progress()
{
    TRACE("hint_zone_killing_progress");
    level endon("end_game");
    wait randomfloatrange(3.0, 6.0);
    players = get_alive_players();
    while (true)
    {
        close_to_pap = false;
        foreach (player in players)
        {
            if (player get_current_zone() == "zone_nml_18")
            {
                close_to_pap = true;
            }
        }
        if (!close_to_pap)
        {
            break;
        }
    }

    if (b2_flag(FLAG_ZONE_CHALLENGE))
    {
        return;
    }

    playsoundonplayers("zmb_perks_packa_ready");
    level.gauntlet_zone_hud_processing = ::zone_killing_state_color;
}

_capture_zone_kills()
{
    TRACE("_capture_zone_kills");
    if (typeof(self.attacker) != "entity" || !self.attacker is_player())
    {
        return;
    }
    if (!isdefined(self.attacker._gauntlet_secret_zone_kills))
    {
        self.attacker._gauntlet_secret_zone_kills = [];
    }
    zone = self.attacker get_current_zone();
    self.attacker._gauntlet_secret_zone_kills[zone] = true;
    // DEBUG("Set zone kill " + zone + " for " + sstr(self.attacker));
}

upgrade_wallbuys()
{
    TRACE("upgrade_wallbuys");
    GAUNTLET_SINGLE("upgrade_wallbuys");
    level endon("gauntlet_stop_side_ee");
    level endon("gauntlet_stop_upgrade_wallbuys");
    thread stop_upgrade_wallbuys();

    while (true)
    {
        level waittill("weapon_bought", player, weapon);

        if (typeof(player) != "entity" || !player is_player())
        {
            continue;
        }
        stance = player getstance();

        if (can_upgrade_weapon(weapon) && !is_weapon_upgraded(weapon) && (stance == "crouch" || stance == "prone"))
        {
            DEBUG("Upgrading weapon " + sstr(weapon));
            upgraded = get_upgrade_weapon(weapon);
            player takeweapon(weapon);
            player giveweapon(upgraded, 0, player get_pack_a_punch_weapon_options(upgraded));
            player givestartammo(upgraded);
            player switchtoweapon(upgraded);
        }
    }
}

stop_upgrade_wallbuys()
{
    TRACE("stop_upgrade_wallbuys");
    level endon("end_game");
    if (level.round_number >= 20)
    {
        level notify("gauntlet_stop_upgrade_wallbuys");
        return;
    }

    while (true)
    {
        level waittill("end_of_round");
        if (level.round_number >= 20)
        {
            break;
        }
    }
}

zone_killing_state_color(hud)
{
    TRACE(sstr(self) + " zone_killing_state_color " + sstr(hud));
    zone = self get_current_zone();
    if (isdefined(self._gauntlet_secret_zone_kills[zone]))
    {
        color_level = 0.85 - (zone_killing_hud_percent_complete() / 450);
        hud.color = (0.85, color_level, 0.85);
    }
    else
    {
        hud.color = (0.85, 0.85, 0.85);
    }
}

zone_killing_hud_percent_complete()
{
    TRACE("zone_killing_hud_percent_complete");
    players = get_players();
    target = min_int(7 + players.size, 12);
    max_current = 0;
    foreach (player in players)
    {
        if (!isdefined(player._gauntlet_secret_zone_kills) || !isarray(player._gauntlet_secret_zone_kills) || !player._gauntlet_secret_zone_kills.size)
        {
            continue;
        }
        max_current = max_int(max_current, player._gauntlet_secret_zone_kills.size);
    }
    percentage = max_current / target * 100;
    // DEBUG("zone_killing_hud_percent_complete percentage " + sstr(max_current) + " / " + sstr(target) + " * 100 = " + sstr(percentage));
    return percentage;
}

set_dig_override_7()
{
    level.gauntlet_dig_spots_respawn_override = 7;
}

goal_string(current = 0, target)
{
    TRACE("goal_string " + sstr(current) + " " + sstr(target));
    if (!isdefined(target))
    {
        target = level.gauntlet_hud_quota;
    }
    return "" + clamp(current, 0, target) + " / " + target;
}

clamp(value, min, max)
{
    TRACE("clamp " + sstr(value) + " " + sstr(min) + " " + sstr(max));
    return min(max(value, min), max);
}

clamp_int(value, min, max)
{
    TRACE("clamp_int " + sstr(value) + " " + sstr(min) + " " + sstr(max));
    return min_int(max_int(value, min), max);
}

convert_time(time_ms = 0, format, notrace = false)
{
    if (is_false(notrace))
    {
        TRACE("convert_time " + sstr(time_ms) + " " + sstr(format) + " " + sstr(notrace));
    }
    timedata = spawnstruct();
    timedata.abs_ticks = int(time_ms / 10);
    timedata.abs_seconds = int(time_ms / 1000);
    timedata.abs_minutes = int(time_ms / 60000);
    timedata.abs_hours = int(time_ms / 3600000);

    timedata.ticks = int((time_ms % 1000) / 10);
    timedata.seconds = int(time_ms / 1000);
    if (timedata.seconds >= 60)
    {
        timedata.minutes = int(timedata.seconds / 60);
        timedata.seconds %= 60;
    }
    else
    {
        timedata.minutes = 0;
    }
    if (timedata.minutes >= 60)
    {
        timedata.hours = int(timedata.minutes / 60);
        timedata.minutes %= 60;
    }
    else
    {
        timedata.hours = 0;
    }

    switch (format)
    {
        case TIME_MSSVV:
            return add_strings(
                STR(timedata.abs_minutes),
                ":",
                zfill(timedata.seconds),
                ".",
                zfill(timedata.ticks)
            );
        case TIME_MMSS:
            return add_strings(
                zfill(timedata.abs_minutes),
                ":",
                zfill(timedata.seconds)
            );
        case TIME_HHMMSSVV:
            return add_strings(
                zfill(timedata.hours),
                ":",
                zfill(timedata.minutes),
                ":",
                zfill(timedata.seconds),
                ".",
                zfill(timedata.ticks)
            );
        default:
            return add_strings(
                zfill(timedata.abs_minutes),
                ":",
                zfill(timedata.seconds),
                ".",
                zfill(timedata.ticks)
            );
    }
}

convert_time_from_seconds(time = 0, format, notrace = false)
{
    if (is_false(notrace))
    {
        TRACE("convert_time_from_seconds " + sstr(time) + " " + sstr(format) + " " + sstr(notrace));
    }
    return convert_time(int(time / 1000), format, notrace);
}

zfill(number, fill_to = 10)
{
    return number < fill_to ? ("0" + number) : STR(number);
}

_trace(txt)
{
    f = fs_fopen("b2gauntlet/trace.log", "append");
    fs_writeline(f, convert_time(gettime() - getstarttime(), TIME_MSSVV, true) + " - TRACE - " + txt);
    fs_fclose(f);
}

_dump(object, f)
{
    file = "b2gauntlet/dump_" + getutc() + "_" + randomint(10000) + ".json";
    f = isdefined(f) ? f : fs_fopen(file, "append");
    if (!isdefined(f))
    {
        ERROR("Undefined file pointer for " + sstr(file));
        return;
    }
    fs_writeline(f, "{");
    DEBUG(typeof(object));
    switch (typeof(object))
    {
        case "entity":
            foreach (key in object getfieldkeys())
            {
                fs_writeline(f, "\"" + key + "\": " + sstr(object getfield(key)));
            }
            break;
        case "struct":
            foreach (key in getstructkeys(object))
            {
                fs_writeline(f, "\"" + key + "\": " + sstr(structget(object, key)));
            }
            break;
    }
    fs_writeline(f, "}");
    fs_fclose(f);
}

eq(condition1, condition2)
{
    // TRACE("eq " + sstr(condition1) + " " + sstr(condition2));
    return typeof(condition1) == typeof(condition2) && condition1 == condition2;
}

min_int(a, b)
{
    TRACE("min_int " + sstr(a) + " " + sstr(b));
    return int(min(a, b));
}

max_int(a, b)
{
    TRACE("max_int " + sstr(a) + " " + sstr(b));
    return int(max(a, b));
}

add_strings(a, b, c, d, e, f, g, h, i, j)
{
    concat = "";
    foreach (idx, candidate in array(a, b, c, d, e, f, g, h, i, j))
    {
        if (!isdefined(candidate))
        {
            break;
        }
        assert(isstring(candidate), "add_strings arg " + idx + " is not a string: " + typeof(candidate));
        // DEBUG("size: " + sstr(concat.size));

        if (concat.size + candidate.size > MAX_STRING_LEN)
        {
            WARN("Attempted to add strings with total length bigger than the string size limit of " + MAX_STRING_LEN);
#ifdef ENABLE_DEBUG
            print("(" + sstr(typeof(concat)) + ") ");
            printf(sstr(getsubstr(concat, 0, MAX_STRING_LEN - 32)));

            print("(" + sstr(typeof(candidate)) + ") ");
            printf(sstr(getsubstr(candidate, 0, MAX_STRING_LEN - 32)));
#endif
            return concat;
        }
        concat += candidate;
    }
    return concat;
}

sstr(value)
{
    switch (typeof(value))
    {
        case "string":
        case "locatized string":
        case "hash":
        case "vector":
        case "float":
        case "int":
            return "" + value;
        case "entity":
        case "removed entity":
            if (value is_player())
                return "<player:" + sstr(value.name) + "(" + sstr(value.entity_num) + ")>";
            if (eq(value.classname, "script_vehicle") || isvehicle(value))
                return "<vehicle:" + sstr(value.model) + ">";
            if (value is_zombie())
                return "<zombie:" + sstr(value.model) + ">";
            if (eq(value, level))
                return "<level:" + sstr(level.script) + ">";
            return "<entity:" + _entity_field(value) + ">";
        case "struct":
            if (eq(value, level))
                return "<level:" + sstr(level.script) + ">";
        case "array":
            return json_encode(value);
        case "function":
            return "<function:" + sstr(getfunctionname(value)) + ">";
        default:
            return "<" + typeof(value) + ">";
    }
}

json_encode(object, _depth = 0)
{
    if (_depth > JSON_ENCODE_MAX_DEPTH)
    {
        return "";
    }

    switch (typeof(object))
    {
        case "array":
            proxy_object = object;
            break;
        case "struct":
            proxy_object = [];
            foreach (s_key in getstructkeys(object))
            {
                proxy_object[s_key] = structget(object, s_key);
            }
            break;
        case "entity":
            proxy_object = [];
            foreach (e_key in object getfieldkeys())
            {
                proxy_object[e_key] = object getfield(e_key);
            }
            break;
        case "vector":
            return add_strings("[" , sstr(object[0]), ", ", sstr(object[1]), ", ", sstr(object[2]), "]");
        default:
            if (_depth > 0)
            {
                return sstr(object);
            }
            proxy_object = array(object);
    }

    is_list = true;
    encoded = "[";
    last_int_key = -1;
    foreach (k, v in proxy_object)
    {
        if (isint(k) && k == last_int_key + 1)
        {
            last_int_key++;
            continue;
        }

        is_list = false;
        encoded = "{";
        break;
    }

    foreach (k, v in proxy_object)
    {
        /* Doing it here prevents adding the comma at the last item */
        if (encoded.size > 1)
        {
            encoded = add_strings(encoded, ", ");
        }

        /* Handle key first */
        encode_data = [];
        encode_data["key"] = is_list ? "" : add_strings("\"", k, "\": ");
        encode_data["prefix"] = "";
        encode_data["suffix"] = "";

        /* Then handle values */
        // DEBUG("Value for key (" + k + ") " + _encode_basic(v) + " type: " + typeof(v));
        switch (typeof(v))
        {
            case "undefined":
                encode_data["value"] = "null";
                break;
            case "string":
            case "localized string":
            case "hash":
                encode_data["prefix"] = "\"";
                encode_data["suffix"] = "\"";
            case "float":
            case "int":
            case "vector":
            case "function":
                encode_data["value"] = sstr(v);
                break;
            case "struct":
            case "entity":
            case "removed entity":
            case "array":
                encode_data["value"] = json_encode(v, _depth + 1);
                break;
            default:
                encode_data["value"] = add_strings("<", typeof(v), ">");
        }

        str_size = encode_data["prefix"].size + encode_data["suffix"].size + encode_data["value"].size;
        if (str_size > MAX_STRING_LEN)
        {
            DEBUG("json_encode string size overflow for object " + sstr(typeof(object)) + ": " + sstr(str_size) + "(prefix=" + sstr(encode_data["prefix"].size) + " suffix=" + sstr(encode_data["suffix"].size) + " value=" + sstr(encode_data["value"].size) + ")");
            encode_data["prefix"] = "\"";
            encode_data["suffix"] = "\"";
            encode_data["value"] = add_strings("<", sstr(typeof(v)), ":", sstr(encode_data["value"].size), ">");
        }

        encoded = add_strings(encoded, encode_data["key"], encode_data["prefix"], encode_data["value"], encode_data["suffix"]);
    }

    return is_list ? add_strings(encoded, "]") : add_strings(encoded, "}");
}

_entity_field(ent)
{
    if (isdefined(ent.name) && ent.name.size > 0)
    {
        return "name=" + ent.name;
    }
    if (isdefined(ent.model) && ent.model.size > 0)
    {
        return "model=" + ent.model;
    }
    if (isdefined(ent.script_noteworthy) && ent.script_noteworthy.size > 0)
    {
        return "script_noteworthy=" + ent.script_noteworthy;
    }
    if (isdefined(ent.entity_num) && ent.entity_num.size > 0)
    {
        return "entity_num=" + ent.entity_num;
    }
    if (isdefined(ent.targetname) && ent.targetname)
    {
        return "targetname=" + ent.targetname;
    }
    return "[" + sstr(ent getfieldkeys()) + "]";
}

instakill_player()
{
    if (is_true(self.insta_killed))
    {
        return;
    }
    self.insta_killed = true;

    if (self maps\mp\zombies\_zm_laststand::player_is_in_laststand())
    {
        self.bleedout_time = 0;
    }
    else
    {
        self.no_revive_trigger = true;
        self dodamage(10000, (0, 0, 0));

        wait 0.2;
        self.no_revive_trigger = undefined;
    }
}

disable_lighting_staff_income_for_a_round()
{
    TRACE("disable_lighting_staff_income_for_a_round");
    level endon("end_game");
    fn = getfunction("maps/mp/zombies/_zm_weap_staff_lightning", "staff_lightning_kill_zombie");
    replacefunc(fn, ::_staff_lighting_kill_zombie_no_points);
    level waittill("end_of_round");
    removedetour(fn);
}

_staff_lighting_kill_zombie_no_points(player, str_weapon)
{
    TRACE(sstr(self) + " _staff_lighting_kill_zombie_no_points " + sstr(player) + " " + sstr(str_weapon));
    player endon("disconnect");

    if (!isalive(self))
    {
        return;
    }

    if (is_true(self.has_legs))
    {
        if (!self hasanimstatefromasd("zm_death_tesla"))
        {
            return;
        }

        self.deathanim = "zm_death_tesla";
    }
    else
    {
        if (!self hasanimstatefromasd("zm_death_tesla_crawl"))
        {
            return;
        }

        self.deathanim = "zm_death_tesla_crawl";
    }

    if (is_true(self.is_traversing))
    {
        self.deathanim = undefined;
    }

    self do_damage_network_safe(player, self.health, str_weapon, "MOD_RIFLE_BULLET");
}

wunderfizz_hide_for_a_round()
{
    machines = getentarray("random_perk_machine", "targetname");
    current_machine = undefined;
    foreach (machine in machines)
    {
        machine.is_locked = 1;
        if (is_true(machine.is_current_ball_location))
        {
            current_machine = machine;
        }
    }

    level notify("machine_think");

    if (isdefined(current_machine))
    {
        level notify("pmmove");
        current_machine thread update_animation("shut_down");
        current_machine setclientfield("turn_on_location_indicator", 0);
        current_machine.is_current_ball_location = 0;
        current_machine conditional_power_indicators();
        current_machine hidepart("j_ball");
    }

    level waittill("end_of_round");
    if (isdefined(current_machine))
    {
        current_machine thread maps\mp\zombies\_zm_perk_random::machine_think();
    }
    else
    {
        level notify("random_perk_moving");
    }

    a_s_generator = getstructarray("s_generator", "targetname");
    foreach (s_generator in a_s_generator)
    {
        if (level.zone_capture.zones[s_generator.script_noteworthy] ent_flag("player_controlled"))
        {
            s_generator enable_random_perk_machines_in_zone();
        }
    }
}

get_gauntlet_progress()
{
    TRACE("get_gauntlet_progress");
    if (!fs_testfile("b2gauntlet/progress.txt"))
    {
        return 1;
    }

    progress = 1;
    f = fs_fopen("b2gauntlet/progress.txt", "read");
    foreach (line in strtok(fs_read(f), "\n"))
    {
        if (issubstr(line, "0: "))
        {
            progress = int(getsubstr(line, 3));
            break;
        }
    }
    fs_fclose(f);

    return progress;
}

set_gauntlet_progress()
{
    TRACE("set_gauntlet_progress");
    if (get_gauntlet_progress() >= level.gauntlet_round)
    {
        return;
    }

    DEBUG("Updating progress for gauntlet 0 to: " + sstr(level.gauntlet_round));
    lines = array("0: " + level.gauntlet_round);

    if (fs_testfile("b2gauntlet/progress.txt"))
    {
        f = fs_fopen("b2gauntlet/progress.txt", "read");
        foreach (line in strtok(fs_read(f), "\n"))
        {
            if (!issubstr(line, "0: "))
            {
                lines[lines.size] = line;
            }
        }
        fs_fclose(f);
    }

    f = fs_fopen("b2gauntlet/progress.txt", "write");
    foreach (line in lines)
    {
        fs_writeline(f, line);
    }
    fs_fclose(f);
}

chat_listener()
{
    TRACE("chat_listener");
    level endon("end_game");

    while (true)
    {
        level waittill("say", message, player);

        DEBUG("chat_listener: " + sstr(message));

        if (message == "?")
        {
            say(gauntlet_round_hud_config()[level.gauntlet_round][1]);
        }
        else if (getsubstr(message, 0, 1) == "?")
        {
            round = int(getsubstr(message, 1));
            if (get_gauntlet_progress() >= round)
            {
                say(gauntlet_round_hud_config()[round][1]);
            }
            else
            {
                say("Round has not been discovered yet");
            }
        }
        else if (getsubstr(message, 0, 7) == "starton")
        {
#ifdef ENABLE_DEBUG
            tokens = strtok(message, " ");
            setdvar("gauntlet_round", tokens[1]);
            cmdexec("map_restart");
#endif
        }
        else if (message == "hudcenter")
        {
            player set_status_hud_property(GAUNTLET_HUD_SET_POINT, array("CENTER", "TOPRCENTERIGHT", 0, 24));
        }
        else if (message == "hudnormal")
        {
            player set_status_hud_property(GAUNTLET_HUD_SET_POINT, array("TOPRIGHT", "TOPRIGHT", 0, 70));
        }
    }
}

gauntlet_r2l_watcher()
{
    TRACE("gauntlet_r2l_watcher");
    level endon("end_game");
    level endon("gauntlet_end_r2l_watcher");
    thread _gauntlet_end_r2l_watcher();
    players = get_players();
    wait_time = get_player_out_of_playable_area_monitor_wait_time() * 1000;

    while (true)
    {
        time = gettime();
        foreach (player in players)
        {
            if (!isdefined(player._gauntlet_last_deathbarrier_tick))
            {
                continue;
            }

            if (player get_current_zone() == "zone_bunker_6" && !b2_flag(P_FLAG_SHOW_R2L, player))
            {
                DEBUG("creating r2l bar for " + sstr(player.name));
                player._gauntlet_r2l_hud = player createbar(COLOR_WHITE, 24, 2);
                player._gauntlet_r2l_hud setpoint("center", "center", 0, 12);
                b2_flag_set(P_FLAG_SHOW_R2L, player);
            }
            else if (player get_current_zone() != "zone_bunker_6" && b2_flag(P_FLAG_SHOW_R2L, player))
            {
                DEBUG("destroying r2l bar for " + sstr(player.name));
                player._gauntlet_r2l_hud destroyelem();
                b2_flag_clear(P_FLAG_SHOW_R2L, player);
            }

            if (b2_flag(P_FLAG_SHOW_R2L, player))
            {
                DEBUG("\t(" + gettime() + " - " + sstr(player._gauntlet_last_deathbarrier_tick) + ") / " + sstr(wait_time) + " = " + sstr(diff));
                diff = (gettime() - player._gauntlet_last_deathbarrier_tick) / wait_time;
                if (isdefined(player._gauntlet_r2l_hud))
                {
                    player._gauntlet_r2l_hud updatebar(diff);
                }
                else
                {
                    ERROR("undefined r2l hud for " + sstr(player.name));
                }
            }
        }

        if (isdefined(level.num_staffpieces_picked_up) && isdefined(level.num_staffpieces_picked_up["elemental_staff_lightning"]) && level.num_staffpieces_picked_up["elemental_staff_lightning"] > 0)
        {
            b2_flag_set(FLAG_R2L);
            b2_flag_clear(P_FLAG_SHOW_R2L, player);
            if (isdefined(player._gauntlet_r2l_hud))
            {
                player._gauntlet_r2l_hud destroyelem();
                player._gauntlet_r2l_hud = undefined;
            }
            break;
        }

        wait 0.05;
    }
}

_gauntlet_end_r2l_watcher()
{
    TRACE("_gauntlet_end_r2l_watcher");
    level endon("end_game");
    flag_wait("activate_zone_nml");
    level notify("gauntlet_end_r2l_watcher");
    foreach (player in level.players)
    {
        b2_flag_clear(P_FLAG_SHOW_R2L, player);
        player._gauntlet_r2l_hud.alpha = 0;
        player._gauntlet_r2l_hud destroyelem();
    }
}

remove_all_perks()
{
    TRACE(sstr(self) + " remove_all_perks");
    level endon("end_game");
    self endon("disconnect");

    foreach (active_perk in self get_perk_array())
    {
        self notify(active_perk + "_stop");
        wait 0.1;
    }
}

get_round_count()
{
    return get_round_enemy_array().size + level.zombie_total;
}

set_damageweapon(weapon)
{
    TRACE(sstr(self) + " set_damageweapon " + sstr(weapon));
    gauntlet_damageweapon = isdefined(weapon) ? weapon : "none";
    if (is_true(self._cherry_damage))
    {
        gauntlet_damageweapon = "specialty_grenadepulldeath";
    }
    self._cherry_damage = undefined;
    if (gauntlet_damageweapon == "none" && isdefined(self.staff_dmg) && self.staff_dmg != "")
    {
        gauntlet_damageweapon = self.staff_dmg;
    }

    if (!isdefined(self._gauntlet_damageweapon_history))
    {
        self._gauntlet_damageweapon_history = [];
    }
    if (self._gauntlet_damageweapon_history.size > 32)
    {
        arrayremoveindex(self._gauntlet_damageweapon_history, 0, false);
    }
    self._gauntlet_damageweapon_history[self._gauntlet_damageweapon_history.size] = gauntlet_damageweapon;
}

get_last_damageweapon(base = true, check_history = 1)
{
    TRACE(sstr(self) + " get_last_damageweapon " + sstr(base) + " " + sstr(check_history));
    if (!isdefined(self._gauntlet_damageweapon_history) || !self._gauntlet_damageweapon_history.size)
    {
        return "none";
    }

    j = 1;
    for (i = self._gauntlet_damageweapon_history.size - 1; i >= 0; i--)
    {
        if (isdefined(self._gauntlet_damageweapon_history[i]) && self._gauntlet_damageweapon_history[i] != "none")
        {
            damageweapon = base
                ? get_base_weapon_name(self._gauntlet_damageweapon_history[i], true)
                : self._gauntlet_damageweapon_history[i];
            // DEBUG("get_last_damageweapon (history): " + sstr(damageweapon));
            return damageweapon;
        }
        if (j >= check_history)
        {
            break;
        }
        j++;
    }
    return "none";
}

clear_mechz_lock()
{
    TRACE("clear_mechz_lock");
    flag_clear("gauntlet_mechz_lock");
}

award_second_chance()
{
    TRACE("award_second_chance");
    if (level.players.size < 2)
    {
        return;
    }
    iprintln("Team awarded: ^3SECOND CHANCE");
    level.gauntlet_second_chances++;
}

reduce_riotshield_hitpoints(modifier)
{
    TRACE("reduce_riotshield_hitpoints");
    hp = level.zombie_vars["riotshield_hit_points"];
    level.zombie_vars["riotshield_hit_points"] = int(hp * modifier);
    DEBUG("reduced shield hp to " + sstr(level.zombie_vars["riotshield_hit_points"]) + " from " + sstr(hp));
    return hp;
}

get_player_by_ent_num(num)
{
    TRACE("get_player_by_ent_num " + sstr(num));
    foreach (player in level.players)
    {
        if (int(num) == player.entity_num)
        {
            return player;
        }
    }
    return undefined;
}

set_skip_progress_eval_for_dead()
{
    TRACE("set_skip_progress_eval_for_dead");
    level._gauntlet_skip_progress_eval_for_dead_players = true;
}

reset_skip_progress_eval_for_dead()
{
    TRACE("reset_skip_progress_eval_for_dead");
    level._gauntlet_skip_progress_eval_for_dead_players = false;
}

get_alive_players()
{
    TRACE("get_alive_players");
    alive_players = [];
    foreach (player in level.players)
    {
        if (isalive(player))
        {
            alive_players[alive_players.size] = player;
        }
    }
    return alive_players;
}

/*********************************************************************************/
/*                                SECTION: CALLBACKS                             */
/*********************************************************************************/

/* Setup gauntlet, runs after "initial_blackscreen_passed" */
register_on_gauntlet_init_ready(callback)
{
    TRACE("register_on_gauntlet_init_ready " + sstr(callback));
    level.callbacks_gauntlet_init_ready[level.callbacks_gauntlet_init_ready.size] = callback;
}

/* Setup the round, runs at the beginning of every round */
register_on_gauntlet_start_of_round(callback)
{
    TRACE("register_on_gauntlet_start_of_round " + sstr(callback));
    level.callbacks_gauntlet_start_of_round[level.callbacks_gauntlet_start_of_round.size] = callback;
}

/* Cleanup the round, runs at the end of every round */
register_on_gauntlet_end_of_round(callback)
{
    TRACE("register_on_gauntlet_end_of_round " + sstr(callback));
    level.callbacks_gauntlet_end_of_round[level.callbacks_gauntlet_end_of_round.size] = callback;
}

/* Setup the round, runs only at the beginning of the round it was registered for */
register_on_gauntlet_start_of_this_round(callback)
{
    TRACE("register_on_gauntlet_start_of_this_round " + sstr(callback));
    level.callbacks_gauntlet_start_of_this_round[level.callbacks_gauntlet_start_of_this_round.size] = callback;
}

/* Cleanup the round, runs only at the end of the round it was registered for */
register_on_gauntlet_end_of_this_round(callback)
{
    TRACE("register_on_gauntlet_end_of_this_round " + sstr(callback));
    level.callbacks_gauntlet_end_of_this_round[level.callbacks_gauntlet_end_of_this_round.size] = callback;
}

run_on_gauntlet_notify()
{
    TRACE("run_on_gauntlet_notify");
    level.callbacks_gauntlet_init_ready = [];
    level.callbacks_gauntlet_start_of_round = [];
    level.callbacks_gauntlet_start_of_this_round = [];
    level.callbacks_gauntlet_end_of_round = [];
    level.callbacks_gauntlet_end_of_this_round = [];

    thread _on_gauntlet_init_ready();
    thread _on_gauntlet_start_of_round();
    thread _on_gauntlet_start_of_this_round();
    thread _on_gauntlet_end_of_round();
    thread _on_gauntlet_end_of_this_round();
}

_on_gauntlet_init_ready()
{
    TRACE("_on_gauntlet_init_ready");
    level endon("end_game");
    while (true)
    {
        GAUNTLET_WAITTILL_INIT;
        foreach (callback in level.callbacks_gauntlet_init_ready)
        {
            if (typeof(callback) == "function")
            {
                thread [[callback]]();
            }
            else
            {
                ERROR(SIG_INIT_READY + " callback is not a function");
            }
        }
    }
}

_on_gauntlet_start_of_round()
{
    TRACE("_on_gauntlet_start_of_round");
    level endon("end_game");
    while (true)
    {
        GAUNTLET_WAITTILL_BEFORE_ROUND;
        foreach (callback in level.callbacks_gauntlet_start_of_round)
        {
            if (typeof(callback) == "function")
            {
                thread [[callback]]();
            }
            else
            {
                ERROR(SIG_BEFORE_ROUND + " callback is not a function");
            }
        }
    }
}

_on_gauntlet_start_of_this_round()
{
    TRACE("_on_gauntlet_start_of_this_round");
    level endon("end_game");
    while (true)
    {
        GAUNTLET_WAITTILL_BEFORE_THIS_ROUND;
        foreach (callback in level.callbacks_gauntlet_start_of_this_round)
        {
            if (typeof(callback) == "function")
            {
                thread wrap_gauntlet_callback(callback);
            }
            else
            {
                ERROR(SIG_BEFORE_THIS_ROUND + " callback is not a function");
            }
        }
        level.callbacks_gauntlet_start_of_this_round = [];
    }
}

_on_gauntlet_end_of_round()
{
    TRACE("_on_gauntlet_end_of_round");
    level endon("end_game");
    while (true)
    {
        GAUNTLET_WAITTILL_END_ROUND;
        foreach (callback in level.callbacks_gauntlet_end_of_round)
        {
            if (typeof(callback) == "function")
            {
                thread [[callback]]();
            }
            else
            {
                ERROR(SIG_END_ROUND + " callback is not a function");
            }
        }
    }
}

_on_gauntlet_end_of_this_round()
{
    TRACE("_on_gauntlet_end_of_this_round");
    level endon("end_game");
    while (true)
    {
        GAUNTLET_WAITTILL_END_THIS_ROUND;
        foreach (callback in level.callbacks_gauntlet_end_of_this_round)
        {
            if (typeof(callback) == "function")
            {
                thread [[callback]]();
            }
            else
            {
                ERROR(SIG_END_THIS_ROUND + " callback is not a function");
            }
        }
        level.callbacks_gauntlet_end_of_this_round = [];
    }
}

gauntlet_zombie_gib_all()
{
    if (!isdefined(self))
    {
        return;
    }

    if (isdefined(self.is_mechz) && self.is_mechz)
    {
        return;
    }

#ifdef GUNS_DEBOUNCE_DAMAGE
    if (isdefined(level.gauntlet_allowed_guns) && isarray(level.gauntlet_allowed_guns) && level.gauntlet_allowed_guns.size && !isinarray(level.gauntlet_allowed_guns, self get_last_damageweapon()))
    {
        return;
    }
#endif

    a_gib_ref = [];
    a_gib_ref[0] = level._zombie_gib_piece_index_all;
    self gib("normal", a_gib_ref);
    self ghost();
    wait 0.4;

    if (isdefined(self))
    {
        self self_delete();
    }
}

gauntlet_zombie_gib_guts()
{
    if (!isdefined(self))
    {
        return;
    }

    if (isdefined(self.is_mechz) && self.is_mechz)
    {
        return;
    }

#ifdef GUNS_DEBOUNCE_DAMAGE
    if (isdefined(level.gauntlet_allowed_guns) && isarray(level.gauntlet_allowed_guns) && level.gauntlet_allowed_guns.size && !isinarray(level.gauntlet_allowed_guns, self get_last_damageweapon()))
    {
        return;
    }
#endif

    v_origin = self gettagorigin("J_SpineLower");

    if (isdefined(v_origin))
    {
        v_forward = anglestoforward((0, randomint(360), 0));
        playfx(level._effect["zombie_guts_explosion"], v_origin, v_forward);
    }

    wait_network_frame();

    if (isdefined(self))
    {
        self ghost();
        wait(randomfloatrange(0.4, 1.1));

        if (isdefined(self))
        {
            self self_delete();
        }
    }
}

gauntlet_zombie_damage_callback(mod, hit_location, hit_origin, player, amount)
{
    TRACE("gauntlet_zombie_damage_callback " + sstr(mod) + " " + sstr(hit_location) + " " + sstr(hit_origin) + " " + sstr(player) + " " + sstr(amount));
    if (isdefined(level.gauntlet_zombie_damage_callback_logic))
    {
        return self [[level.gauntlet_zombie_damage_callback_logic]](mod, hit_location, hit_origin, player, amount);
    }

    return false;
}

gauntlet_zombie_death_callback()
{
    TRACE("gauntlet_zombie_death_callback");
    if (isdefined(level.gauntlet_zombie_death_callback_logic))
    {
        self [[level.gauntlet_zombie_death_callback_logic]]();
    }
}

gauntlet_player_damage_callback(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name)
{
    TRACE(sstr(self) + " gauntlet_player_damage_callback " + sstr(e_inflictor) + " " + sstr(e_attacker) + " " + sstr(n_damage) + " " + sstr(n_dflags) + " " + sstr(str_means_of_death) + " " + sstr(str_weapon) + " " + sstr(v_point) + " " + sstr(v_dir) + " " + sstr(str_hit_loc) + " " + sstr(psoffsettime) + " " + sstr(b_damage_from_underneath) + " " + sstr(n_model_index) + " " + sstr(str_part_name));
    if (isdefined(level.gauntlet_player_damage_callback_logic))
    {
        return self [[level.gauntlet_player_damage_callback_logic]](e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name);
    }
    return -1;
}

gauntlet_actor_damage_logic(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex)
{
    TRACE(sstr(self) + " gauntlet_actor_damage_logic " + sstr(inflictor) + " " + sstr(attacker) + " " + sstr(damage) + " " + sstr(flags) + " " + sstr(meansofdeath) + " " + sstr(weapon) + " " + sstr(vpoint) + " " + sstr(vdir) + " " + sstr(shitloc) + " " + sstr(psoffsettime) + " " + sstr(boneindex));
    /* 
     * Save the info, gauntlet can use it later in dmg/death callbacks
     * skip on instakill, it will override the actual gune with none
     */
    if (!is_true(self._killed_with_instakill))
    {
        self set_damageweapon(weapon);
    }
#ifdef GUNS_DEBOUNCE_DAMAGE
    /* Predefine this behavior, used frequently */
    if (isdefined(level.gauntlet_allowed_guns) && isarray(level.gauntlet_allowed_guns) && level.gauntlet_allowed_guns.size && !isinarray(level.gauntlet_allowed_guns, get_base_weapon_name(weapon, true)))
    {
        DEBUG("debounce damage: " + sstr(get_base_weapon_name(weapon, true)) + " " + sstr(level.gauntlet_allowed_guns));
        return 0;
    }
#endif
    /* Allow injecting custom behavior unrelated to weapon restrictions */
    if (isdefined(level.gauntlet_actor_damage_logic_fn))
    {
        return [[level.gauntlet_actor_damage_logic_fn]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    }
    /* Run the 3arc registered callback if is's there */
    if (isdefined(self.vanilla_actor_damage_func))
    {
        return [[self.vanilla_actor_damage_func]](inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    }
    return damage;
}

gauntlet_actor_damage_world_logic(damage, weapon, attacker)
{
    TRACE(sstr(self) + " gauntlet_actor_damage_world_logic " + sstr(damage) + " " + sstr(weapon) + " " + sstr(attacker));
    /* 
     * Save the info, gauntlet can use it later in dmg/death callbacks
     * skip on instakill, it will override the actual gune with none
     */
    if (!is_true(self._killed_with_instakill))
    {
        self set_damageweapon(weapon);
    }
#ifdef GUNS_DEBOUNCE_DAMAGE
    /* Predefine this behavior, used frequently */
    if (isdefined(level.gauntlet_allowed_guns) && isarray(level.gauntlet_allowed_guns) && level.gauntlet_allowed_guns.size && !isinarray(GAUNTLET_WORLD_WEAPONS_ALLOWED_FOR_GUN_RESTRICTION, get_base_weapon_name(weapon, true)))
    {
        DEBUG("debounce world damage: " + sstr(weapon) + " " + sstr(level.gauntlet_allowed_guns));
        return 0;
    }
#endif
    /* Allow injecting custom behavior unrelated to weapon restrictions */
    if (isdefined(level.gauntlet_actor_damage_world_logic_fn))
    {
        return [[level.gauntlet_actor_damage_world_logic_fn]](damage, weapon, attacker);
    }
    /* Run the 3arc registered callback if is's there */
    if (isdefined(self.vanilla_non_attacker_func))
    {
        return [[self.vanilla_non_attacker_func]](damage, weapon, attacker);
    }
    return damage;
}

gauntlet_zombie_spawn_logic()
{
    TRACE("gauntlet_zombie_spawn_logic");
    self.non_attack_func_takes_attacker = true;
    self.actor_damage_func = ::gauntlet_actor_damage_logic;
    self.non_attacker_func = ::gauntlet_actor_damage_world_logic;
    if (isdefined(level.gauntlet_zombie_spawn_callback_logic))
    {
        self [[level.gauntlet_zombie_spawn_callback_logic]]();
    }
}

_inspect_damage(mod, hit_location, hit_origin, player, amount)
{
    TRACE("_inspect_damage " + sstr(mod) + " " + sstr(hit_location) + " " + sstr(hit_origin) + " " + sstr(player) + " " + sstr(amount));
#ifndef MUTE_INSPECT_DAMAGE
    data = [];
    data["attacker"] = self.attacker;
    data["damagemod"] = self.damagemod;
    data["damageweapon"] = self.damageweapon;
    data["is_recapture_zombie"] = self.is_recapture_zombie;
    data["model"] = self.model;
    data["origin"] = self.origin;
    data["hit_location"] = self.hit_location;
    data["gauntlet_damageweapon"] = self._gauntlet_damageweapon;
    data["gauntlet_damageweapon_history"] = self._gauntlet_damageweapon_history;
    data["script_noteworthy"] = self.script_noteworthy;
    DEBUG("inspecting damage: " + sstr(data));
#endif
    return false;
}

_inspect_death()
{
    TRACE("_inspect_death");
#ifndef MUTE_INSPECT_DEATH
    data = [];
    data["attacker"] = self.attacker;
    data["damagemod"] = self.damagemod;
    data["damageweapon"] = self.damageweapon;
    data["is_recapture_zombie"] = self.is_recapture_zombie;
    data["model"] = self.model;
    data["origin"] = self.origin;
    data["hit_location"] = self.hit_location;
    data["gauntlet_damageweapon"] = self._gauntlet_damageweapon;
    data["gauntlet_damageweapon_history"] = self._gauntlet_damageweapon_history;
    data["script_noteworthy"] = self.script_noteworthy;
    DEBUG("inspecting death: " + sstr(data));
#endif
}

gauntlet_mechz_damage_override()
{
    TRACE("gauntlet_mechz_damage_override");
    level endon("end_game");
    while (true)
    {
        level waittill("sam_clue_mechz", mechz);
        mechz.vanilla_actor_damage_func = mechz.actor_damage_func;
        mechz.actor_damage_func = ::gauntlet_actor_damage_logic;
        mechz.vanilla_non_attacker_func = mechz.non_attacker_func;
        self.non_attacker_func = ::gauntlet_actor_damage_world_logic;
    }
}

/*********************************************************************************/
/*                             SECTION: CHALLENGE ROUNDS                         */
/*********************************************************************************/

validate_generators(generators, freeze_on_capture = false)
{
    TRACE("validate_generators " + sstr(generators));
    level endon("end_game");
    level endon("end_of_round");

    if (!isdefined(generators))
    {
        generators = array(TOMB_GENERATOR_1, TOMB_GENERATOR_2, TOMB_GENERATOR_3, TOMB_GENERATOR_4, TOMB_GENERATOR_5, TOMB_GENERATOR_6);
    }
    level.gauntlet_hud_quota = generators.size;

    while (true)
    {
        num_of_active = 0;

        if (flag_exists("generator_under_attack") && flag("generator_under_attack"))
        {
            set_status(CHALLENGE_STATUS_IN_PROGRESS, "LOSING");
            thread freeze_round_zombie_count();
            flag_waitopen("generator_under_attack");
            unfreeze_round_zombie_count();
        }
        if (flag_exists("zone_capture_in_progress") && flag("zone_capture_in_progress"))
        {
            set_status(CHALLENGE_STATUS_IN_PROGRESS, "CAPTURING");
            if (is_true(freeze_on_capture))
            {
                thread freeze_round_zombie_count();
            }
            flag_waitopen("zone_capture_in_progress");
            if (is_true(freeze_on_capture))
            {
                unfreeze_round_zombie_count();
            }
        }

        foreach (generator in generators)
        {
            if (level.zone_capture.zones[generator] ent_flag("player_controlled"))
            {
                num_of_active++;
            }
        }

        if (num_of_active >= level.gauntlet_hud_quota)
        {
            set_status(CHALLENGE_STATUS_SUCCESS, goal_string(num_of_active));
        }
        else if (num_of_active)
        {
            set_status(CHALLENGE_STATUS_IN_PROGRESS, goal_string(num_of_active));
        }
        else
        {
            set_status(CHALLENGE_STATUS_NEW, goal_string());
        }

        wait 0.05;
    }

    level notify("gauntlet_end_of_round");
}

melee_only()
{
    TRACE("melee_only");
    level.gauntlet_zombie_death_callback_logic = ::_melee_only_callback;
    level waittill("end_of_round");
    level.gauntlet_zombie_death_callback_logic = undefined;
    set_status(CHALLENGE_STATUS_SUCCESS);
}

_melee_only_callback()
{
    TRACE(sstr(self) + " _melee_only_callback");
    if (is_true(self.is_recapture_zombie))
    {
        return;
    }
    if (!isdefined(self.attacker) || !self.attacker is_player())
    {
        return;
    }
    if (!isdefined(self.damagemod) || self.damagemod != "MOD_MELEE")
    {
        set_status(CHALLENGE_STATUS_FAIL);
    }
}

restrict_movement(block_walking)
{
    TRACE("restrict_movement " + sstr(block_walking));
    level endon("end_game");

    players = get_players();

    foreach (player in players)
    {
        if (is_true(player.giant_robot_transition) || eq(player get_current_zone(), "zone_robot_head"))
        {
            player thread _restrict_movement_thread(block_walking, true);
        }
        else
        {
            player thread _restrict_movement_thread(block_walking);
        }
    }

    level waittill("end_of_round");
    set_status(CHALLENGE_STATUS_SUCCESS);
    foreach (player in players)
    {
        /* Fix mud slowdown - the watcher is stateful */
        if (is_true(player.is_player_slowed) && isdefined(player.n_move_scale))
        {
            player setmovespeedscale(player.n_move_scale);
        }
        else
        {
            player setmovespeedscale(1);
        }
        player allowjump(1);
    }
}

_restrict_movement_thread(restrict_movement, after_robot_eject)
{
    TRACE("_restrict_movement_thread " + sstr(restrict_movement) + " " + sstr(after_robot_eject));
    level endon("end_of_round");

    if (is_true(after_robot_eject))
    {
        self waittill("gr_eject_sequence_complete");
    }

    while (true)
    {
        if (is_true(restrict_movement))
        {
            self setmovespeedscale(0);
        }
        self allowjump(0);

        wait 0.05;
    }
}

perk_requirement(required_perks)
{
    TRACE("perk_requirement " + sstr(required_perks));
    level endon("end_game");
    level endon("end_of_round");

    level.gauntlet_hud_quota = required_perks.size;

    while (true)
    {
        foreach (player in level.players)
        {
            perks_have = 0;

            foreach (required_perk in required_perks)
            {
                if (isinarray(player.perks_active, required_perk))
                {
                    perks_have++;
                }
            }

            if (perks_have >= required_perks.size)
            {
                player set_status(CHALLENGE_STATUS_SUCCESS, goal_string(perks_have));
            }
            else if (perks_have)
            {
                player set_status(CHALLENGE_STATUS_IN_PROGRESS, goal_string(perks_have));
            }
            else
            {
                player set_status(CHALLENGE_STATUS_NEW, goal_string());
            }
        }

        wait 0.05;
    }
}

perk_count_requirement(required_perks)
{
    TRACE("perk_count_requirement " + sstr(required_perks));
    level endon("end_game");
    level endon("end_of_round");

    level.gauntlet_hud_quota = required_perks;
    players = get_players();

    while (true)
    {
        foreach (player in players)
        {
            if (isarray(player.perks_active) && player.perks_active.size >= required_perks)
            {
                player set_status(CHALLENGE_STATUS_SUCCESS, goal_string(player.perks_active.size));
            }
            else if (isarray(player.perks_active) && player.perks_active.size)
            {
                player set_status(CHALLENGE_STATUS_IN_PROGRESS, goal_string(player.perks_active.size));
            }
            else
            {
                player set_status(CHALLENGE_STATUS_NEW, goal_string());
            }
        }

        wait 0.05;
    }
}

watch_for_picked_box_weapon()
{
    TRACE("watch_for_picked_box_weapon");
    level endon("end_game");

    level.gauntlet_hud_quota = 1;

    players = get_players();

    player_count_at_the_start = players.size;
    if (player_count_at_the_start > 4)
    {
        level.gauntlet_hud_quota = 4;
        level._gauntlet_count_box_weapon_grabbed = 0;
        array_thread(players, ::_watch_box_weapon_grabbed_and_count);
        level thread _track_box_weapon_grabbed();
    }
    else
    {
        array_thread(players, ::_watch_box_weapon_grabbed);
    }

    level waittill("end_of_round");
}

_watch_box_weapon_grabbed()
{
    TRACE("_watch_box_weapon_grabbed");
    level endon("end_game");
    level endon("end_of_round");
    self endon("disconnect");

    self set_status(CHALLENGE_STATUS_NEW, goal_string());

    self waittill("user_grabbed_weapon");
    self set_status(CHALLENGE_STATUS_SUCCESS, goal_string(1));
}

_watch_box_weapon_grabbed_and_count()
{
    TRACE("_watch_box_weapon_grabbed_and_count");
    level endon("end_game");
    level endon("end_of_round");
    self endon("disconnect");

    while (true)
    {
        self waittill("user_grabbed_weapon");
        level._gauntlet_count_box_weapon_grabbed++;
    }
}

_track_box_weapon_grabbed()
{
    TRACE("_track_box_weapon_grabbed");
    level endon("end_game");
    level endon("end_of_round");

    while (true)
    {
        if (level._gauntlet_count_box_weapon_grabbed >= 4)
        {
            set_status(CHALLENGE_STATUS_SUCCESS, goal_string(level._gauntlet_count_box_weapon_grabbed));
        }
        else if (level._gauntlet_count_box_weapon_grabbed)
        {
            set_status(CHALLENGE_STATUS_IN_PROGRESS, goal_string(level._gauntlet_count_box_weapon_grabbed));
        }
        else
        {
            set_status(CHALLENGE_STATUS_NEW, goal_string());
        }
    }
}

watch_for_digging(count)
{
    TRACE("watch_for_digging "+ sstr(count));
    level endon("end_game");
    level endon("end_of_round");

    level.gauntlet_hud_quota = count;

    dug_at_the_start_of_round = 0;
    foreach (dig_spot in level.a_dig_spots)
    {
        if (is_true(dig_spot.dug))
        {
            dug_at_the_start_of_round++;
        }
    }

    while (true)
    {
        currently_dug = 0;
        foreach (dig_spot in level.a_dig_spots)
        {
            if (is_true(dig_spot.dug))
            {
                currently_dug++;
            }
        }

        if (currently_dug - dug_at_the_start_of_round >= count)
        {
            set_status(CHALLENGE_STATUS_SUCCESS, goal_string(currently_dug - dug_at_the_start_of_round));
        }
        else if (currently_dug - dug_at_the_start_of_round)
        {
            set_status(CHALLENGE_STATUS_IN_PROGRESS, goal_string(currently_dug - dug_at_the_start_of_round));
        }
        else
        {
            set_status(CHALLENGE_STATUS_NEW, goal_string());
        }

        wait 0.05;
    }
}

count_melee_kills(count)
{
    TRACE("count_melee_kills " + sstr(count));
    level._gauntlet_melee_kills_callback = 0;
    level._gauntlet_melee_kills_required = count;
    level.gauntlet_hud_quota = count;
    set_status_hud_property(GAUNTLET_HUD_SET_TEXT, goal_string());
    level.gauntlet_zombie_death_callback_logic = ::_count_melee_callback;
    level waittill("end_of_round");
    level.gauntlet_zombie_death_callback_logic = undefined;
}

_count_melee_callback()
{
    TRACE(sstr(self) + " _count_melee_callback");
    if (isdefined(self.damagemod) && self.damagemod == "MOD_MELEE")
    {
        level._gauntlet_melee_kills_callback++;
    }
    else if (issubstr(self get_last_damageweapon(), "shield_zm"))
    {
        level._gauntlet_melee_kills_callback++;
    }

    if (level._gauntlet_melee_kills_callback >= level._gauntlet_melee_kills_required)
    {
        set_status(CHALLENGE_STATUS_SUCCESS, goal_string(level._gauntlet_melee_kills_callback));
    }
    else if (level._gauntlet_melee_kills_callback)
    {
        set_status(CHALLENGE_STATUS_IN_PROGRESS, goal_string(level._gauntlet_melee_kills_callback));
    }
}

restrict_guns(allowed_guns)
{
    TRACE("restrict_guns " + sstr(allowed_guns));
    level.gauntlet_allowed_guns = allowed_guns;
    level.gauntlet_zombie_death_callback_logic = ::_restrict_guns_kill_check;
    level waittill("end_of_round");
    level.gauntlet_zombie_death_callback_logic = undefined;
    level.gauntlet_allowed_guns = undefined;

    set_status(CHALLENGE_STATUS_SUCCESS);
}

_restrict_guns_kill_check()
{
    TRACE(sstr(self) + " _restrict_guns_kill_check");
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "capture_zombie")
    {
        return;
    }
    if (typeof(self.attacker) != "entity" || (!self.attacker is_player() && !isvehicle(self.attacker)))
    {
        DEBUG("Incorrect attacker " + sstr(self.attacker));
        return;
    }

    switch (self.damagemod)
    {
        case "MOD_GRENADE_SPLASH":
        case "MOD_PROJECTILE":
            last_damageweapon = get_last_damageweapon(true, 16);
            break;
        case "MOD_UNKNOWN":
            last_damageweapon = get_last_damageweapon(true, 2);
            break;
        default:
            last_damageweapon = get_last_damageweapon();
    }
    DEBUG("_restrict_guns_kill_check logic " + sstr(last_damageweapon));
    if (!isinarray(level.gauntlet_allowed_guns, last_damageweapon))
    {
        WARN(sstr(self.attacker) + " used illegal weapon: " + sstr(last_damageweapon));
        self.attacker set_status(CHALLENGE_STATUS_FAIL);
    }
}

watch_score_spending()
{
    TRACE("watch_score_spending");
    level endon("end_game");
    set_status_hud_property(GAUNTLET_HUD_SET_TEXT, "SURVIVE");
    thread _watch_score_spending_thread();
    level waittill("end_of_round");
    set_status(CHALLENGE_STATUS_SUCCESS);
}

_watch_score_spending_thread()
{
    TRACE("_watch_score_spending_thread");
    level endon("end_game");
    level endon("end_of_round");

    while (true)
    {
        level waittill("spent_points", player, points);
        player set_status(CHALLENGE_STATUS_FAIL);
    }
}

watch_for_staff_upgrade(count = 1)
{
    TRACE("watch_for_staff_upgrade");
    level endon("end_game");
    level endon("end_of_round");

    level.gauntlet_hud_quota = count;

    while (true)
    {
        tick_count = 0;
        foreach (staff in level.a_elemental_staffs_upgraded)
        {
            if (is_true(staff.charger.is_charged))
            {
                tick_count++;
            }
        }

        if (tick_count >= count)
        {
            set_status(CHALLENGE_STATUS_SUCCESS, goal_string(tick_count));
        }
        else if (tick_count)
        {
            set_status(CHALLENGE_STATUS_IN_PROGRESS, goal_string(tick_count));
        }
        else
        {
            set_status(CHALLENGE_STATUS_NEW, goal_string());
        }

        wait 0.05;
    }
}

watch_player_velocity()
{
    TRACE("watch_player_velocity");
    level endon("end_game");

    wait 2;

    array_thread(level.players, ::_watch_player_velocity_thread);

    level waittill("end_of_round");
    set_status(CHALLENGE_STATUS_SUCCESS);
}

_watch_player_velocity_thread()
{
    TRACE(sstr(self) + " _watch_player_velocity_thread");
    level endon("end_game");
    level endon("end_of_round");
    self endon("disconnect");

    movement_points = 999;
    not_moving_checks = 0;
    last_teleport_state = false;

#ifdef ENABLE_DEBUG
    self._gauntlet_dev_hud_movement_points = self createbar(COLOR_WHITE, 24, 2);
    self._gauntlet_dev_hud_movement_points setpoint("center", "center", 0, 12);
    register_on_gauntlet_end_of_this_round(::_cleanup_dev_hud);
#endif
    while (true)
    {
        wait 0.1;

        /* Reset the movement points, so it's not as brutal when changing state */
        if (!is_player_valid(self))
        {
            movement_points = 999;
            not_moving_checks = 0;
            continue;
        }

        if (is_true(self.teleporting))
        {
            movement_points = 999;
            not_moving_checks = 0;
            continue;
        }
        else if (!is_true(self.teleporting) && is_true(last_teleport_state))
        {
            /* Out of teleport, small intermission */
            wait 0.5;
        }
        last_teleport_state = self.teleporting;

        assert(isplayer(self), "_watch_player_velocity_thread thread must be on a player");

        velocity = int(length(self getvelocity() * (1, 1, self isonground() ? 1 : 0)));
        not_moving_checks = gettime() % 20 == 0 && velocity < 50 ? not_moving_checks + 0.5 : 0;

        movement_points += min_int(velocity, 190);
        movement_points -= min_int(99 * max_int(1, not_moving_checks), 750);
        movement_points = clamp_int(movement_points, 0, 999);
#ifdef ENABLE_DEBUG
        self._gauntlet_dev_hud_movement_points updatebar(movement_points / 999);
        self._gauntlet_dev_hud_movement_points.color = movement_points <= 333 ? COLOR_RED : COLOR_WHITE;
#endif
        if (movement_points <= 333)
        {
            self iprintln("^1MOVE!");
            weapons = self getweaponslistprimaries();
            weapon_to_steal = weapons[randomint(weapons.size)];
            ammo_stock = self getweaponammostock(weapon_to_steal);

            /* Don't deal damage while reviving someone */
            rng = clamp_int(randomint(3), is_true(self.is_reviving_any), 2);
            // DEBUG("_watch_player_velocity_thread for " + sstr(self) + ": movement_points=" + sstr(movement_points) + " weapons=" + sstr(weapons) + " weapon_to_steal=" + sstr(weapon_to_steal) + " ammo_stock=" + sstr(ammo_stock) + " score=" + sstr(self.score) + " rng=" + sstr(rng) + " intermission=" + sstr(level.intermission));

            if (rng == 2 && self.score > 50)
            {
                penalty = roundtonearestfive(max_int(30, self.score / 25));
                assert(isint(penalty));
                self minus_to_player_score(penalty);
                // DEBUG("Movement penalty for " + sstr(self) + " POINTS: " + sstr(penalty));
            }
            else if (rng == 1 && ammo_stock)
            {
                penalty = max_int(1, weaponclipsize(weapon_to_steal) / 10);
                assert(isint(penalty));
                self setweaponammostock(weapon_to_steal, ammo_stock - penalty);
                // DEBUG("Movement penalty for " + sstr(self) + " AMMO: " + sstr(penalty));
            }
            else
            {
                penalty = int(self.maxhealth / 25);
                assert(isint(penalty));
                self dodamage(penalty, self.origin);
                // DEBUG("Movement penalty for " + sstr(self) + " HEALTH: " + sstr(penalty));
            }
        }
    }
}

zombie_aggresive()
{
    TRACE("zombie_aggresive");
    level endon("end_game");
    level.gauntlet_zombie_spawn_callback_logic = ::_zombie_aggressive_callback;
    shield_default = reduce_riotshield_hitpoints(0.66);
    level waittill("end_of_round");
    level.gauntlet_zombie_spawn_callback_logic = undefined;
    level.zombie_vars["riotshield_hit_points"] = shield_default;
    set_status(CHALLENGE_STATUS_SUCCESS);
}

_zombie_aggressive_callback()
{
    TRACE("_zombie_aggressive_callback");
    level endon("end_game");
    self endon("death");

    self waittill("zombie_init_done");

    if (randomint(10))
    {
        self waittill("completed_emerging_into_playable_area");
        while (true)
        {
            self set_zombie_run_cycle("super_sprint");
            self.meleedamage = 80;
            wait 0.5;
        }
    }
}

vibe_killing()
{
    TRACE("vibe_killing");
    level endon("end_game");

    register_on_gauntlet_end_of_this_round(::unfreeze_round_zombie_count);
    _vibe_killing_thread();
    set_status(CHALLENGE_STATUS_SUCCESS);
}

_vibe_killing_thread()
{
    TRACE("_vibe_killing_thread");
    level endon("end_of_round");
    is_locked = false;
    while (true)
    {
        wait 0.05;
        if (flag("recapture_event_in_progress") || flag("zone_capture_in_progress"))
        {
            if (!is_locked)
            {
                thread freeze_round_zombie_count();
                is_locked = true;
                set_status(CHALLENGE_STATUS_IN_PROGRESS, "LOCKED");
            }
            continue;
        }

        if (get_captured_zone_count() < 6)
        {
            if (!is_locked)
            {
                thread freeze_round_zombie_count();
                is_locked = true;
                set_status(CHALLENGE_STATUS_IN_PROGRESS, "LOCKED");
            }
            continue;
        }

        if (is_locked)
        {
            unfreeze_round_zombie_count();
            is_locked = false;
            set_status(CHALLENGE_STATUS_NEW, "SURVIVE");
        }
    }
}

panzer_round(panzer_count = 2, manage_status = false)
{
    TRACE("panzer_round " + sstr(panzer_count) + " " + sstr(manage_status));
    level endon("end_game");

    level.gauntlet_override_mechz_per_round = 4096;
    level.gauntlet_mechz_max_allowed_count = panzer_count;
    DEBUG("set panzer round overrides: gauntlet_mechz_max_allowed_count=" + sstr(level.gauntlet_mechz_max_allowed_count) + " gauntlet_override_mechz_per_round=" + sstr(level.gauntlet_override_mechz_per_round));
    level waittill("end_of_round");

    level.gauntlet_override_mechz_per_round = undefined;
    level.gauntlet_mechz_max_allowed_count = 1;

    if (is_true(manage_status))
    {
        set_status(CHALLENGE_STATUS_SUCCESS);
    }
}

break_time_and_space()
{
    TRACE("break_time_and_space");
    level endon("end_game");

    thread _break_time_and_space_thread();

    level waittill("end_of_round");
    waittillframeend;
    setdvar("timescale", 1);
    reset_gspeed();
    set_status(CHALLENGE_STATUS_SUCCESS);
}

_break_time_and_space_thread()
{
    TRACE("_break_time_and_space_thread");
    level endon("end_game");
    level endon("end_of_round");

    gspeed_range = array(175, 215);
    timescale_range = array(1.4, 1.8);
    while (true)
    {
        setdvar("timescale", randomfloatrange(timescale_range[0], timescale_range[1]));
        DEBUG("set timescale: " + sstr(getdvar("timescale")));
        wait randomfloatrange(0.8, 1.2);
        setdvar("g_speed", randomintrange(gspeed_range[0], gspeed_range[1]));
        DEBUG("set g_speed: " + sstr(getdvar("g_speed")));
        wait randomfloatrange(0.8, 1.2);
    }
}

protect_zone(zones)
{
    TRACE("protect_zone " + sstr(zones));
    level endon("end_game");
    level endon("gauntlet_reboot");

    level.zombie_vars["zombie_powerup_drop_max_per_round"] = 0;
    flag_set("gauntlet_mechz_lock");

    players_in_desired_zones = 0;
    time_to_get_there = gettime() + 60000;

    volume = undefined;
    foreach (zone in zones)
    {
        // DEBUG(sstr(level.zones[zone]));
        volume = level.zones[zone].volumes[0];
    }

    DEBUG("Protect zone volume: " + sstr(volume));
    if (isdefined(volume))
    {
        objective_state(3, "active");
        objective_position(3, volume.origin);
    }

    thread freeze_round_zombie_count();

    while (time_to_get_there > gettime() && players_in_desired_zones < get_alive_players().size)
    {
        players_in_desired_zones = 0;
        outside = [];
        foreach (player in get_alive_players())
        {
            if (is_player_valid(player) && isinarray(zones, player get_current_zone()))
            {
                players_in_desired_zones++;
                if (is_true(player._gauntlet_get_to_zone_hud))
                {
                    player set_status(CHALLENGE_STATUS_SUCCESS, "WAITING FOR OTHER PLAYERS");
                    player hide_timer_status();
                    player._gauntlet_get_to_zone_hud = undefined;
                }
            }
            else
            {
                outside[outside.size] = player;
            }
        }

        foreach (o_player in outside)
        {
            o_player set_status(CHALLENGE_STATUS_IN_PROGRESS, "Time to get to the zone:");
            if (!is_true(o_player._gauntlet_get_to_zone_hud))
            {
                o_player start_timer_status(time_to_get_there - gettime(), true);
            }
            o_player._gauntlet_get_to_zone_hud = true;
        }

        wait 0.05;
    }

    set_status(CHALLENGE_STATUS_NEW, "SURVIVE");
    objective_state(3, "invisible");
    hide_timer_status();

    players = get_players();

    if (players.size == 1)
    {
        player = players[0];
        if (!is_player_valid(player) || !isinarray(zones, player get_current_zone()))
        {
            player set_status(CHALLENGE_STATUS_FAIL);
        }
    }
    else
    {
        foreach (player in players)
        {
            if (!is_player_valid(player) || !isinarray(zones, player get_current_zone()))
            {
                player thread instakill_player();
            }
        }
    }

    thread unfreeze_round_zombie_count();
    level.zombie_vars["zombie_powerup_drop_max_per_round"] = 4;
    clear_mechz_lock();
    level notify("gauntlet_begin_protecting_zone");
    _player_is_protecting_zone(zones);

    hide_timer_status();
    set_status(CHALLENGE_STATUS_SUCCESS);
}

_player_is_protecting_zone(zones)
{
    TRACE("_player_is_protecting_zone " + sstr(zones));
    level endon("end_game");
    level endon("end_of_round");

    players = get_players();

    player_remaining_timer = [];
    foreach (player in players)
    {
        player_remaining_timer[STR(player.entity_num)] = 5000;
    }

    while (true)
    {
        alive_players = get_alive_players();
        foreach (player in alive_players)
        {
            if (is_player_valid(player) && !isinarray(zones, player get_current_zone()))
            {
                player_remaining_timer[STR(player.entity_num)] -= 50;
                player start_timer_status(player_remaining_timer[STR(player.entity_num)]);
                player set_status_hud_property(GAUNTLET_HUD_SET_TEXT, "GET BACK TO THE ZONE!");
            }
            else
            {
                /* Regenerate 1 second every 10 seconds */
                if (gettime() % 10000 == 0)
                {
                    player_remaining_timer[STR(player.entity_num)] = min_int(player_remaining_timer[STR(player.entity_num)] + 1000, 5000);
                }
                player hide_timer_status();
                player set_status_hud_property(GAUNTLET_HUD_SET_TEXT, "SURVIVE");
            }
        }

        foreach (player_ent, rem_time in player_remaining_timer)
        {
            if (rem_time <= 0)
            {
                foreach (d_player in alive_players)
                {
                    if (STR(d_player.entity_num) == player_ent)
                    {
                        d_player dodamage(d_player.maxhealth * 2, d_player.origin);
                        player_remaining_timer[player_ent] += 2000;
                        break;
                    }
                }
            }
        }

        wait 0.05;
    }
}

remove_and_disable_perks()
{
    TRACE("remove_and_disable_perks");
    level endon("end_game");

    old_custom_perk_validation = level.custom_perk_validation;
    level.custom_perk_validation = ::no;

    thread wunderfizz_hide_for_a_round();
    array_thread(level.players, ::remove_all_perks);

    level waittill("end_of_round");
    level.custom_perk_validation = old_custom_perk_validation;
    set_status(CHALLENGE_STATUS_SUCCESS);
}

equipment_kills()
{
    TRACE("equipment_kills");
    level.gauntlet_zombie_death_callback_logic = ::_player_killed_with_equipment;
    level.gauntlet_hud_quota = 4;
    set_status_hud_property(GAUNTLET_HUD_SET_TEXT, goal_string());
    thread _equipment_kills_thread();

    level waittill("end_of_round");
    level.gauntlet_zombie_death_callback_logic = undefined;
}

_player_killed_with_equipment()
{
    TRACE("_player_killed_with_equipment");
    killed_with = self get_last_damageweapon();
    if (is_placeable_mine(self get_last_damageweapon(true, 32)))
    {
        self.attacker._gauntlet_killed_with_mine = true;
        DEBUG("set _gauntlet_killed_with_mine for " + sstr(self.attacker));
    }
    if (killed_with == "staff_revive_zm")
    {
        self.attacker._gauntlet_killed_with_stick = true;
        DEBUG("set _gauntlet_killed_with_stick for " + sstr(self.attacker));
    }
    if (issubstr(killed_with, "shield_zm"))
    {
        self.attacker._gauntlet_killed_with_shield = true;
        DEBUG("set _gauntlet_killed_with_shield for " + sstr(self.attacker));
    }
    if (killed_with == "quadrotorturret_zm" || killed_with == "quadrotorturret_upgraded_zm")
    {
        level._gauntlet_killed_with_drone = true;
        DEBUG("set _gauntlet_killed_with_drone by " + sstr(self.attacker.player_owner));
    }
}

_equipment_kills_thread()
{
    TRACE("_equipment_kills_thread");
    level endon("end_game");
    level endon("end_of_round");

    player_equipment_progress = [];

    while (true)
    {
        foreach (player in level.players)
        {
            player_equipment_progress[STR(player.entity_num)] = is_true(player._gauntlet_killed_with_mine) + is_true(player._gauntlet_killed_with_stick) + is_true(player._gauntlet_killed_with_shield) + is_true(level._gauntlet_killed_with_drone);

            if (player_equipment_progress[STR(player.entity_num)] >= 4)
            {
                player set_status(CHALLENGE_STATUS_SUCCESS, goal_string(player_equipment_progress[STR(player.entity_num)]));
            }
            else if (player_equipment_progress[STR(player.entity_num)])
            {
                player set_status(CHALLENGE_STATUS_IN_PROGRESS, goal_string(player_equipment_progress[STR(player.entity_num)]));
            }
        }

        wait 0.05;
    }
}

indoors_only()
{
    TRACE("indoors_only");
    players = get_players();
    level.gauntlet_zombie_death_callback_logic = ::_restrict_outside_check;
    array_thread(players, ::_outside_vision);
#ifdef GUNS_DEBOUNCE_DAMAGE
    level.gauntlet_actor_damage_logic_fn = ::_restrict_outside_nodamage;
    level.gauntlet_actor_damage_world_logic_fn = ::debounce_drone_damage;
#endif
    level waittill("end_of_round");
    level.gauntlet_zombie_death_callback_logic = undefined;
    foreach (player in players)
    {
        player useservervisionset(false);
        player setvisionsetforplayer("default", 0.5);
        player.turned_vision = false;
    }

    set_status(CHALLENGE_STATUS_SUCCESS);
}

_restrict_outside_nodamage(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex)
{
    TRACE(sstr(self) + " _restrict_outside_nodamage " + sstr(inflictor) + " " + sstr(attacker) + " " + sstr(damage) + " " + sstr(flags) + " " + sstr(meansofdeath) + " " + sstr(weapon) + " " + sstr(vpoint) + " " + sstr(vdir) + " " + sstr(shitloc) + " " + sstr(psoffsettime) + " " + sstr(boneindex));
    return attacker _is_inside_tomb() ? damage : 0;
}

_restrict_outside_world_nodamage(damage, weapon, attacker)
{
    TRACE(sstr(self) + " _restrict_outside_world_nodamage " + sstr(damage) + " " + sstr(weapon) + " " + sstr(attacker));
    if (eq(weapon, "quadrotorturret_zm"))
    {
        return 0;
    }
    // if (isdefined(attacker) && typeof(attacker) == "entity") {}
    return damage;
}

_restrict_outside_check()
{
    TRACE("_restrict_outside_check");
    if (is_true(self.is_recapture_zombie))
    {
        return;
    }
    if (!isdefined(self.attacker) || !self.attacker is_player())
    {
        return;
    }
    if (!self.attacker _is_inside_tomb())
    {
        self.attacker set_status(CHALLENGE_STATUS_FAIL);
    }
}

_outside_vision()
{
    TRACE(sstr(self) + " _outside_vision");
    level endon("end_game");
    level endon("end_of_round");

    register_on_gauntlet_end_of_this_round(::_restore_vision);

    while (true)
    {
        wait 0.05;
        if (!self is_player_valid(self, false, false))
        {
            continue;
        }

        inside_tomb = self _is_inside_tomb();
        if (inside_tomb && is_true(self.turned_vision))
        {
            self useservervisionset(false);
            self setvisionsetforplayer("default", 0.5);
            self.turned_vision = false;
            wait 0.5;
        }
        else if (!inside_tomb && !is_true(self.turned_vision))
        {
            self useservervisionset(true);
            self setvisionsetforplayer("zombie_turned", 0.5);
            self.turned_vision = true;
            wait 0.5;
        }
    }
}

_restore_vision()
{
    TRACE(sstr(self) + " _restore_vision");
    if (isalive(self))
    {
        self useservervisionset(false);
        self setvisionsetforplayer("default", 0.5);
        if (self maps\mp\zombies\_zm_laststand::player_is_in_laststand())
        {
            visionsetlaststand("zombie_last_stand", 0.5);
        }
    }
    self.turned_vision = undefined;
}

_is_inside_tomb()
{
    TRACE("_is_inside_tomb");
    allowed_zones = array("zone_start", "zone_start_a", "zone_start_b", "zone_fire_stairs", "zone_bunker_5a", "zone_bunker_5b", "zone_bunker_4c", "zone_nml_celllar", "zone_bolt_stairs", "zone_nml_19", "ug_bottom_zone", "zone_air_stairs", "zone_village_1", "zone_village_2", "zone_ice_stairs", "zone_chamber_0", "zone_chamber_1", "zone_chamber_2", "zone_chamber_3", "zone_chamber_4", "zone_chamber_5", "zone_chamber_6", "zone_chamber_7", "zone_chamber_8", "zone_robot_head");
    current_zone = self get_current_zone();

    if (isinarray(allowed_zones, current_zone))
    {
        return true;
    }

    x = self.origin[0];
    y = self.origin[1];
    z = self.origin[2];

    /* Wind tunnel */
    if (current_zone == "zone_nml_9" && z <= 110 && x > 2000 && x < 3550 && y < 1400 & y > 650)
    {
        return true;
    }

    return false;
}

double_ammo_consumption()
{
    TRACE("double_ammo_consumption");
    level endon("end_game");

    players = get_players();

    array_thread(players, ::_sub_ammo_on_fire);
    /* There are no missiles on origins that don't already fire normal wpn notifier */
    // array_thread(players, ::_sub_ammo_on_missile);
    array_thread(players, ::_sub_ammo_on_grenade);

    level waittill("end_of_round");
    set_status(CHALLENGE_STATUS_SUCCESS);
}

_sub_ammo(weapon, sub, ref)
{
    TRACE(sstr(self) + " _sub_ammo " + sstr(weapon) + " " + sstr(sub) + " " + sstr(ref));
    if (!isalive(self) || !self hasweapon(weapon))
    {
        return;
    }

    clip = self getweaponammoclip(weapon);
    stock = self getweaponammostock(weapon);
    // DEBUG("_sub_ammo sub=" + sstr(sub) + " clip=" + sstr(clip) + " stock=" + sstr(stock) + " weapon=" + sstr(weapon));
    if (clip > sub)
    {
        self setweaponammoclip(weapon, max_int(0, clip - sub));
    }
    else
    {
        self setweaponammostock(weapon, max_int(0, stock - sub));
    }
}

_sub_ammo_on_fire()
{
    TRACE("_sub_ammo_on_fire");
    level endon("end_game");
    level endon("end_of_round");
    self endon("disconnect");

    while (true)
    {
        self waittill("weapon_fired", weapon);
        sub = 1;
        if (issubstr(weapon, "_upgraded3_"))
        {
            tokens = strtok(weapon, "_");
            weapon = add_strings(tokens[0], "_", tokens[1], "_upgraded_zm");
            sub = 6;
        }
        else if (issubstr(weapon, "_upgraded2_"))
        {
            tokens = strtok(weapon, "_");
            weapon = add_strings(tokens[0], "_", tokens[1], "_upgraded_zm");
            sub = 3;
        }

        self _sub_ammo(weapon, sub, "weapon_fired");
    }
}

_sub_ammo_on_missile()
{
    TRACE("_sub_ammo_on_missile");
    level endon("end_game");
    level endon("end_of_round");
    self endon("disconnect");

    while (true)
    {
        self waittill("missile_fire", missile, weapon);
        sub = 1;
        if (issubstr(weapon, "_upgraded3_"))
        {
            sub = 6;
        }
        else if (issubstr(weapon, "_upgraded2_"))
        {
            sub = 3;
        }

        self _sub_ammo(weapon, sub, "missile_fire");
    }
}

_sub_ammo_on_grenade()
{
    TRACE("_sub_ammo_on_grenade");
    level endon("end_game");
    level endon("end_of_round");
    self endon("disconnect");

    while (true)
    {
        self waittill("grenade_fire", grenade, weapon);
        /* The sub_ammo flow will crash the game if player tries to sui */
        if (!is_player_valid(self))
        {
            continue;
        }
        self _sub_ammo(weapon, 1, "grenade_fire");
    }
}

absurd_powerups()
{
    TRACE("absurd_powerups");
    level endon("end_game");

    old_max_powerup = level.zombie_vars["zombie_powerup_drop_max_per_round"];
    old_powerup_grab_check = level._powerup_grab_check;
    level.zombie_vars["zombie_powerup_drop_max_per_round"] = 65534;
    level.gauntlet_custom_rand_drop_chance = 16;
    level._powerup_grab_check = ::_fail_on_powerup_grab;

    level waittill("end_of_round");

    level.zombie_vars["zombie_powerup_drop_max_per_round"] = old_max_powerup;
    level.gauntlet_custom_rand_drop_chance = 100;
    level._powerup_grab_check = old_powerup_grab_check;
    set_status(CHALLENGE_STATUS_SUCCESS);
}

_fail_on_powerup_grab(player)
{
    TRACE("_fail_on_powerup_grab " + sstr(player));
    player set_status(CHALLENGE_STATUS_FAIL);
    return false;
}

watch_tank_kills(kill_goal)
{
    TRACE("watch_tank_kills " + sstr(kill_goal));
    level.gauntlet_hud_quota = kill_goal;
    set_status_hud_property(GAUNTLET_HUD_SET_TEXT, goal_string());
    level.gauntlet_zombie_death_callback_logic = ::_count_up_on_tank_kill;
    _watch_tank_kills_thread(kill_goal);
    level.gauntlet_zombie_death_callback_logic = undefined;
}

_count_up_on_tank_kill()
{
    TRACE("_count_up_on_tank_kill");
    if (self.damagemod == "MOD_CRUSH" && isinarray(array("zombie_markiv_cannon", "zombie_markiv_side_cannon", "zombie_markiv_turret"), self get_last_damageweapon()))
    {
        level notify("gauntlet_tank_kill", self.attacker);
    }
    if (self.damagemod == "MOD_BURNED" && self.attacker.classname == "script_vehicle")
    {
        level notify("gauntlet_tank_kill", self.attacker);
    }
}

_watch_tank_kills_thread(count)
{
    TRACE("_watch_tank_kills_thread " + sstr(count));
    level endon("end_game");
    level endon("end_of_round");

    kills = 0;
    if (count == 0)
    {
        set_status(CHALLENGE_STATUS_SUCCESS, goal_string(0));
        level waittill("forever");
    }

    while (true)
    {
        level waittill("gauntlet_tank_kill", attacker);
        kills++;

        if (kills >= count)
        {
            set_status(CHALLENGE_STATUS_SUCCESS, goal_string(kills));
        }
        else if (kills)
        {
            set_status(CHALLENGE_STATUS_IN_PROGRESS, goal_string(kills));
        }
    }
}

gungame()
{
    TRACE("gungame");
    level endon("end_game");

    current_players = get_players();

    thread _gungame_sync();
    array_thread(current_players, ::_gungame_player_thread);

    level waittill("end_of_round");

    foreach (player in current_players)
    {
        snap = level.gauntlet_round_snapshot[STR(player.entity_num)];
        player takeallweapons();
        player snapshot_restore_guns(snap.weapons);
    }

    set_status(CHALLENGE_STATUS_SUCCESS);
}

_gungame_sync()
{
    TRACE("_gungame_sync");
    level endon("end_game");
    level endon("end_of_round");

    while (true)
    {
        wait randomfloatrange(10.0, 16.0);
        level notify("gauntlet_gungame_change");
    }
}

_gungame_player_thread()
{
    TRACE("_gungame_player_thread");
    level endon("end_game");
    level endon("end_of_round");
    self endon("disconnect");

    while (!is_player_valid(self))
    {
        wait 0.05;
    }

    weapon = "";
    while (true)
    {
        if (is_player_valid(self))
        {
            weapon = _roll_gungame_weapon(weapon);
            pap_rng = b2_flag(FLAG_ZONE_CHALLENGE) ? 5 : 8;
            if (get_is_in_box(weapon) && !randomint(pap_rng))
            {
                weapon = get_upgrade_weapon(weapon);
            }
            else if (!get_is_in_box(weapon) && !randomint(pap_rng - 3))
            {
                weapon = get_upgrade_weapon(weapon);
            }

            while (is_true(self.is_drinking))
            {
                wait 0.05;
            }

            self takeallweapons();

            if (is_weapon_upgraded(weapon))
            {
                self giveweapon(weapon, 0, self get_pack_a_punch_weapon_options(weapon));
            }
            else
            {
                self giveweapon(weapon);
            }
            self givestartammo(weapon);
            self switchtoweapon(weapon);
            wait 0.05;
            self play_sound_on_ent("purchase");
        }

        level waittill("gauntlet_gungame_change");
    }
}

_roll_gungame_weapon(current_weapon)
{
    TRACE("_roll_gungame_weapon " + sstr(current_weapon));
    roll_count = 0;
    current_weapon = isdefined(current_weapon) ? current_weapon : "";
    for (i = 0; i <= 10; i++)
    {
        wpn = getarraykeys(level.zombie_weapons)[randomint(level.zombie_weapons.size)]; 
        if (!isdefined(wpn) || get_base_weapon_name(current_weapon, true) == wpn || issubstr(wpn, "staff_") || wpn == "c96_zm" || getsubstr(wpn, 0, 3) == "ray")
        {
            continue;
        }
        if (is_lethal_grenade(wpn) || is_tactical_grenade(wpn) | is_placeable_mine(wpn) || is_melee_weapon(wpn))
        {
            continue;
        }
        return wpn;
    }

    return "m14_zm";
}

/*********************************************************************************/
/*                               SECTION: REPLACEMENTS                           */
/*********************************************************************************/

noop()
{
    TRACE("noop");
}

gauntlet_mechz_round_tracker()
{
    TRACE("gauntlet_mechz_round_tracker");
    maps\mp\zombies\_zm_ai_mechz_ffotd::mechz_round_tracker_start();
    level.num_mechz_spawned = 0;

    flag_wait("activate_zone_nml");

    level.next_mechz_round = 8;

    while (true)
    {
        maps\mp\zombies\_zm_ai_mechz_ffotd::mechz_round_tracker_loop_start();

        /* This is for the panzer challenge logic to correctly apply */
        level waittill("start_of_round");
        wait 0.1;

        flag_waitopen("gauntlet_mechz_lock");

        DEBUG("mechz tracker start logic: next_mechz_round=" + sstr(level.next_mechz_round) + " gauntlet_round" + sstr(level.gauntlet_round));
        if (level.num_mechz_spawned > 0 && level.zombie_vars["zombie_powerup_drop_max_per_round"] > 0)
        {
            level.mechz_should_drop_powerup = true;
        }

        if (level.mechz_left_to_spawn == 0 && level.next_mechz_round == level.gauntlet_round)
        {
            mechz_health_increases();

            level.mechz_zombie_per_round = 3;
            if (isdefined(level.gauntlet_override_mechz_per_round))
            {
                level.mechz_zombie_per_round = level.gauntlet_override_mechz_per_round;
            }
            else if (is_true(level.is_forever_solo_game) || level.mechz_round_count < 2)
            {
                level.mechz_zombie_per_round = 1;
            }
            else if (level.mechz_round_count < 5)
            {
                level.mechz_zombie_per_round = 2;
            }

            DEBUG("mechz tracker start spawning: mechz_zombie_per_round=" + sstr(level.mechz_zombie_per_round));

            level.mechz_left_to_spawn = level.mechz_zombie_per_round;
            wait(randomfloatrange(5.0, 10.0));
            thread mechz_spawner();
        }

        level.next_mechz_round = gauntlet_get_next_mechz_round();
        DEBUG("mechz tracker set next round to " + sstr(level.next_mechz_round));

        maps\mp\zombies\_zm_ai_mechz_ffotd::mechz_round_tracker_loop_end();
        level waittill("between_round_over");
        mechz_clear_spawns();
        level.mechz_left_to_spawn = 0;
    }
}

mechz_spawner()
{
    TRACE("mechz_spawner");
    level endon("end_game");
    level endon("end_of_round");

    while (true)
    {
        if (!level.mechz_left_to_spawn)
        {
            break;
        }

        a_zombies = getaispeciesarray(level.zombie_team, "all");

        current_mechz_count = 0;
        foreach (zombie in a_zombies)
        {
            if (is_true(zombie.is_mechz) && isalive(zombie))
            {
                current_mechz_count++;
            }
        }

        if (current_mechz_count >= level.gauntlet_mechz_max_allowed_count)
        {
            wait(randomfloatrange(5.0, 10.0));
            continue;
        }

        while (level.zombie_mechz_locations.size < 1)
        {
            WARN("empty mechz locations");
            wait(randomfloatrange(5.0, 10.0));
        }

        ai = spawn_zombie(level.mechz_spawners[0]);
        ai thread mechz_spawn();
        level.num_mechz_spawned++;
        level.mechz_left_to_spawn--;

        if (level.mechz_left_to_spawn == 0)
        {
            level thread response_to_air_raid_siren_vo();
        }

        ai thread mechz_hint_vo();
        wait(randomfloatrange(3.0, 6.0));
    }
}

gauntlet_get_next_mechz_round()
{
    TRACE("gauntlet_get_next_mechz_round");
    foreach (rnd in MECHZ_ROUNDS)
    {
        if (rnd > level.gauntlet_round)
        {
            DEBUG("gauntlet_get_next_mechz_round set from mechz_rounds " + sstr(rnd));
            return rnd;
        }
    }

    rnd = level.round_number + (is_true(level.is_forever_solo_game) ? randomintrange(level.mechz_min_round_fq_solo, level.mechz_max_round_fq_solo) : randomintrange(level.mechz_min_round_fq, level.mechz_max_round_fq));
    DEBUG("gauntlet_get_next_mechz_round set from randomintrange " + sstr(rnd));
    return rnd;
}

gauntlet_powerup_drop(drop_point)
{
    TRACE("gauntlet_powerup_drop " + sstr(drop_point));
    if (level.powerup_drop_count >= level.zombie_vars["zombie_powerup_drop_max_per_round"])
    {
        return;
    }

    if (!isdefined( level.zombie_include_powerups ) || level.zombie_include_powerups.size == 0)
    {
        return;
    }

    rand_drop = randomint(level.gauntlet_custom_rand_drop_chance);
    if (level.gauntlet_round == 27)
    {
        DEBUG("rand_drop: " + sstr(rand_drop));
    }
    if (rand_drop > 2 && !level.zombie_vars["zombie_drop_item"])
    {
        return;
    }

    playable_area = getentarray("player_volume", "script_noteworthy");
    level.powerup_drop_count++;
    powerup = maps\mp\zombies\_zm_net::network_safe_spawn("powerup", 1, "script_model", drop_point + vectorscale((0, 0, 1), 40.0));
    valid_drop = 0;

    for (i = 0; i < playable_area.size; i++)
    {
        if (powerup istouching(playable_area[i]))
        {
            valid_drop = 1;
        }
    }

    if (valid_drop && level.rare_powerups_active)
    {
        pos = (drop_point[0], drop_point[1], drop_point[2] + 42);

        if (check_for_rare_drop_override(pos))
        {
            level.zombie_vars["zombie_drop_item"] = 0;
            valid_drop = 0;
        }
    }

    if (!valid_drop)
    {
        level.powerup_drop_count--;
        powerup delete();
        return;
    }

    if (level.gauntlet_round == 27)
    {
        DEBUG("powerup: " + sstr(powerup));
    }

    powerup powerup_setup();
    powerup thread powerup_timeout();
    powerup thread powerup_wobble();
    powerup thread powerup_grab();
    powerup thread powerup_move();
    powerup thread powerup_emp();
    level.zombie_vars["zombie_drop_item"] = 0;
    level notify("powerup_dropped", powerup);
}

gauntlet_waittill_dug(s_dig_spot)
{
    TRACE("gauntlet_waittill_dug " + sstr(s_dig_spot));
    while (true)
    {
        self waittill("trigger", player);

        if (is_true(player.dig_vars["has_shovel"]))
        {
            player playsound("evt_dig");
            s_dig_spot.dug = 1;
            level.n_dig_spots_cur--;
            playfx(level._effect["digging"], self.origin);
            player setclientfieldtoplayer("player_rumble_and_shake", 1);
            player maps\mp\zombies\_zm_stats::increment_client_stat("tomb_dig", 0);
            player maps\mp\zombies\_zm_stats::increment_player_stat("tomb_dig");
            s_staff_piece = s_dig_spot maps\mp\zm_tomb_main_quest::dig_spot_get_staff_piece(player);

            if (isdefined(s_staff_piece))
            {
                s_staff_piece maps\mp\zm_tomb_main_quest::show_ice_staff_piece(self.origin);
                player dig_reward_dialog("dig_staff_part");
            }
            else if (!isdefined(level.gauntlet_dig_reward_override) || !self [[level.gauntlet_dig_reward_override]](s_dig_spot, player))
            {
                n_good_chance = 50;

                if (player.dig_vars["n_spots_dug"] == 0 || player.dig_vars["n_losing_streak"] == 3)
                {
                    player.dig_vars["n_losing_streak"] = 0;
                    n_good_chance = 100;
                }

                if (player.dig_vars["has_upgraded_shovel"])
                {
                    if (!player.dig_vars["has_helmet"])
                    {
                        n_helmet_roll = randomint(100);

                        if (n_helmet_roll >= 95)
                        {
                            player.dig_vars["has_helmet"] = 1;
                            n_player = player getentitynumber() + 1;
                            level setclientfield("helmet_player" + n_player, 1);
                            player playsoundtoplayer("zmb_squest_golden_anything", player);
                            player maps\mp\zombies\_zm_stats::increment_client_stat("tomb_golden_hard_hat", 0);
                            player maps\mp\zombies\_zm_stats::increment_player_stat("tomb_golden_hard_hat");
                            return;
                        }
                    }

                    n_good_chance = 70;
                }

                n_prize_roll = randomint(100);

                if (n_prize_roll > n_good_chance)
                {
                    if (cointoss())
                    {
                        player dig_reward_dialog("dig_grenade");
                        self thread dig_up_grenade(player);
                    }
                    else
                    {
                        player dig_reward_dialog("dig_zombie");
                        self thread dig_up_zombie(player, s_dig_spot);
                    }

                    player.dig_vars["n_losing_streak"]++;
                }
                else if (cointoss())
                {
                    self thread gauntlet_dig_up_powerup(player);
                }
                else
                {
                    player dig_reward_dialog("dig_gun");
                    self thread dig_up_weapon(player);
                }
            }

            if (!player.dig_vars["has_upgraded_shovel"])
            {
                player.dig_vars["n_spots_dug"]++;

                if (player.dig_vars["n_spots_dug"] >= 30)
                {
                    player.dig_vars["has_upgraded_shovel"] = 1;
                    player thread ee_zombie_blood_dig();
                    n_player = player getentitynumber() + 1;
                    level setclientfield("shovel_player" + n_player, 2);
                    player playsoundtoplayer("zmb_squest_golden_anything", player);
                    player maps\mp\zombies\_zm_stats::increment_client_stat("tomb_golden_shovel", 0);
                    player maps\mp\zombies\_zm_stats::increment_player_stat("tomb_golden_shovel");
                }
            }

            return;
        }
    }
}

gauntlet_dig_up_powerup(player)
{
    powerup = spawn( "script_model", self.origin );
    powerup endon( "powerup_grabbed" );
    powerup endon( "powerup_timedout" );
    a_rare_powerups = dig_get_rare_powerups(player);
    powerup_item = undefined;

    foreach (disabled_dig in level.gauntlet_disabled_dig_powerups)
    {
        arrayremovevalue(a_rare_powerups, disabled_dig, false);
    }

    if (level.dig_n_powerups_spawned + level.powerup_drop_count > 4 || level.dig_last_prize_rare || a_rare_powerups.size == 0 || randomint(100) < 80)
    {
        if (level.dig_n_zombie_bloods_spawned < 1 && randomint(100) > 70)
        {
            powerup_item = "zombie_blood";
            level.dig_n_zombie_bloods_spawned++;
            level.dig_n_powerups_spawned++;
            player dig_reward_dialog("dig_powerup");
        }
        else
        {
            powerup_item = "bonus_points_player";
            player dig_reward_dialog("dig_cash");
        }

        level.dig_last_prize_rare = 0;
    }
    else
    {
        powerup_item = a_rare_powerups[randomint(a_rare_powerups.size)];
        level.dig_last_prize_rare = 1;
        level.dig_n_powerups_spawned++;
        player dig_reward_dialog("dig_powerup");
        dig_set_powerup_spawned(powerup_item);
    }

    powerup maps\mp\zombies\_zm_powerups::powerup_setup(powerup_item);
    powerup movez(40, 0.6);
    powerup waittill("movedone");
    powerup thread maps\mp\zombies\_zm_powerups::powerup_timeout();
    powerup thread maps\mp\zombies\_zm_powerups::powerup_wobble();
    powerup thread maps\mp\zombies\_zm_powerups::powerup_grab();
}

gauntlet_recapture_round_tracker()
{
    TRACE("gauntlet_recapture_round_tracker");
    level endon("end_game");

    level waittill("start_of_round");
    n_next_recapture_round = gauntlet_get_next_recapture_round();
    while (true)
    {
        level waittill_any("between_round_over", "force_recapture_start");

        if (level.round_number == n_next_recapture_round && !flag("zone_capture_in_progress") && get_captured_zone_count() >= get_player_controlled_zone_count_for_recapture())
        {
            level thread recapture_round_start();
        }

        n_next_recapture_round = gauntlet_get_next_recapture_round();
    }
}

gauntlet_get_next_recapture_round()
{
    TRACE("gauntlet_get_next_recapture_round");
    foreach (rnd in GENERATOR_ROUNDS)
    {
        if (rnd > level.round_number)
        {
            DEBUG("gauntlet_get_next_recapture_round set from generator_rounds " + sstr(rnd));
            return rnd;
        }
    }

    rnd = level.round_number + randomintrange(3, 6);;
    DEBUG("gauntlet_get_next_recapture_round set from randomintrange " + sstr(rnd));
    return rnd;
}

gauntlet_drop_max_ammo_at_death_location()
{
    TRACE(sstr(self) + " gauntlet_drop_max_ammo_at_death_location");
    if (level.gauntlet_last_capture_reward >= level.gauntlet_round)
    {
        return;
    }
    level.gauntlet_last_capture_reward = level.gauntlet_round;
    fn = getfunction("maps/mp/zm_tomb_capture_zones", "drop_max_ammo_at_death_location");
    disabledetouronce(fn);
    self [[fn]]();
}

gauntlet_delete_zombie_for_capture_event()
{
    if (isdefined(self))
    {
        playfx(level._effect["tesla_elec_kill"], self.origin);
        self ghost();
    }

    wait_network_frame();

    if (isdefined(self))
    {
        self delete();
        /* Add only if there's something already there, no point on <=24 */
        if (level.zombie_total > 0)
        {
            level.zombie_total++;
        }
    }
}

gauntlet_manage_zones(initial_zone)
{
    TRACE("gauntlet_manage_zones " + sstr(initial_zone));
    /* This is the only place where i can reliably hook into the logic */
    level.gauntlet_old_manager_init_func = level.zone_manager_init_func;
    level.zone_manager_init_func = ::gauntlet_tomb_zones_init;
    fn = getfunction("maps/mp/zombies/_zm_zonemgr", "manage_zones");
    disabledetouronce(fn);
    [[fn]](initial_zone);
}

gauntlet_tomb_zones_init()
{
    TRACE("gauntlet_tomb_zones_init");
    [[level.gauntlet_old_manager_init_func]]();
    /* Fixes panzer cheesing */
    maps\mp\zombies\_zm_zonemgr::add_adjacent_zone("zone_start", "zone_bunker_2a", "activate_zone_bunker_1");
}

gauntlet_electric_cherry_laststand()
{
    TRACE(sstr(self) + " gauntlet_electric_cherry_laststand");
    visionsetlaststand("zombie_last_stand", 1);

    if (isdefined(self))
    {
        playfx(level._effect["electric_cherry_explode"], self.origin);
        self playsound("zmb_cherry_explode");
        self notify("electric_cherry_start");
        wait 0.05;
        a_zombies = get_round_enemy_array();
        a_zombies = get_array_of_closest(self.origin, a_zombies, undefined, undefined, 500);

        for (i = 0; i < a_zombies.size; i++)
        {
            if (isalive(self))
            {
                if (a_zombies[i].health <= 1000)
                {
                    a_zombies[i] thread electric_cherry_death_fx();

                    if (isdefined(self.cherry_kills))
                    {
                        self.cherry_kills++;
                    }

                    self maps\mp\zombies\_zm_score::add_to_player_score(40);
                }
                else
                {
                    a_zombies[i] thread electric_cherry_stun();
                    a_zombies[i] thread electric_cherry_shock_fx();
                }

                wait 0.1;
                a_zombies[i]._cherry_damage = 1000;
                a_zombies[i] dodamage(1000, self.origin, self, self, "none");
            }
        }

        self notify("electric_cherry_end");
    }
}

gauntlet_check_for_instakill(player, mod, hit_location)
{
    TRACE("gauntlet_check_for_instakill " + sstr(player) + " " + sstr(mod) + " " + sstr(hit_location));
    if (isdefined(player) && isalive(player) && isdefined(level.check_for_instakill_override) && !self [[level.check_for_instakill_override]](player))
    {
        if (!self [[level.check_for_instakill_override]](player))
        {
            return;
        }

        if (player.use_weapon_type == "MOD_MELEE")
        {
            player.last_kill_method = "MOD_MELEE";
        }
        else
        {
            player.last_kill_method = "MOD_UNKNOWN";
        }

        modname = remove_mod_from_methodofdeath(mod);

        if (!(isdefined(self.no_gib) && self.no_gib))
        {
            self maps\mp\zombies\_zm_spawner::zombie_head_gib();
        }

        self.health = 1;
        self._killed_with_instakill = true;
        self dodamage(self.health + 666, self.origin, player, self, hit_location, modname);
        player notify("zombie_killed");
    }

    if (isdefined(player) && isalive(player) && (level.zombie_vars[player.team]["zombie_insta_kill"] || isdefined(player.personal_instakill) && player.personal_instakill))
    {
        if (is_magic_bullet_shield_enabled(self))
        {
            return;
        }

        if (isdefined(self.instakill_func))
        {
            self thread [[self.instakill_func]]();
            return;
        }

        if (player.use_weapon_type == "MOD_MELEE")
        {
            player.last_kill_method = "MOD_MELEE";
        }
        else
        {
            player.last_kill_method = "MOD_UNKNOWN";
        }

        modname = remove_mod_from_methodofdeath(mod);

        if (flag("dog_round"))
        {
            self.health = 1;
            self._killed_with_instakill = true;
            self dodamage(self.health + 666, self.origin, player, self, hit_location, modname);
            player notify("zombie_killed");
        }
        else
        {
            if (!(isdefined(self.no_gib) && self.no_gib))
            {
                self maps\mp\zombies\_zm_spawner::zombie_head_gib();
            }

            self.health = 1;
            self._killed_with_instakill = true;
            self dodamage(self.health + 666, self.origin, player, self, hit_location, modname);
            player notify("zombie_killed");
        }
    }
}

gauntlet_staff_lightning_death_event()
{
    TRACE(sstr(self) + " gauntlet_staff_lightning_death_event");
    if (self maps\mp\zombies\_zm_weap_staff_lightning::is_staff_lightning_damage() && self.damagemod != "MOD_MELEE")
    {
        if (is_true(self.is_mechz))
        {
            return;
        }

        /* Injecting the check here, as the callback chain is broken in this if statement block */
        self gauntlet_zombie_death_callback();

        self thread maps\mp\zombies\_zm_audio::do_zombies_playvocals("death", self.animname);
        self thread maps\mp\zombies\_zm_spawner::zombie_eye_glow_stop();

        if (is_true(self.has_legs))
        {
            if (!self hasanimstatefromasd("zm_death_tesla"))
            {
                return;
            }

            self.deathanim = "zm_death_tesla";
        }
        else
        {
            if (!self hasanimstatefromasd("zm_death_tesla_crawl"))
            {
                return;
            }

            self.deathanim = "zm_death_tesla_crawl";
        }

        if (is_true(self.is_traversing))
        {
            self.deathanim = undefined;
        }

        tag = "J_SpineUpper";
        self setclientfield("lightning_impact_fx", 1);
        self thread maps\mp\zombies\_zm_audio::do_zombies_playvocals("electrocute", self.animname);
        self thread maps\mp\zombies\_zm_weap_staff_lightning::zombie_shock_eyes();

        if (isdefined(self.deathanim))
        {
            self waittillmatch("death_anim", "die");
        }

        DEBUG("gauntlet_staff_lightning_death_event do_damage_network_safe " + sstr(self.attacker) + " " + sstr(self.health) + " " + sstr(self.damageweapon));
        self do_damage_network_safe(self.attacker, self.health, self.damageweapon, "MOD_RIFLE_BULLET");
    }
}

gauntlet_player_out_of_playable_area_monitor()
{
    self notify("stop_player_out_of_playable_area_monitor");
    self endon("stop_player_out_of_playable_area_monitor");
    self endon("disconnect");
    level endon("end_game");

    while (!isdefined(self.characterindex))
    {
        wait 0.05;
    }

    wait(0.15 * self.characterindex);

    while (true)
    {
        self._gauntlet_last_deathbarrier_tick = gettime();
        if (self.sessionstate == "spectator")
        {
            wait get_player_out_of_playable_area_monitor_wait_time() ;
            continue;
        }

        if (is_true(level.hostmigration_occured))
        {
            wait get_player_out_of_playable_area_monitor_wait_time();
            continue;
        }

        if (!self in_life_brush() && (self in_kill_brush() || !self in_enabled_playable_area()))
        {
            if (!isdefined(level.player_out_of_playable_area_monitor_callback) || self [[level.player_out_of_playable_area_monitor_callback]]())
            {
                if (isdefined(self._gauntlet_r2l_hud))
                {
                    self._gauntlet_r2l_hud.color = COLOR_RED;
                    level notify("gauntlet_end_r2l_watcher");
                }
                self maps\mp\zombies\_zm_stats::increment_map_cheat_stat("cheat_out_of_playable");
                self maps\mp\zombies\_zm_stats::increment_client_stat("cheat_out_of_playable", 0);
                self maps\mp\zombies\_zm_stats::increment_client_stat("cheat_total", 0);
                self playlocalsound(level.zmb_laugh_alias);
                wait 0.5;

                if ( get_players().size == 1 && flag("solo_game") && (isdefined(self.waiting_to_revive) && self.waiting_to_revive))
                {
                    level notify("end_game");
                }
                else
                {
                    self disableinvulnerability();
                    self.lives = 0;
                    self dodamage(self.health + 1000, self.origin);
                    self.bleedout_time = 0;
                }
            }
        }

        wait get_player_out_of_playable_area_monitor_wait_time();
    }
}

/*********************************************************************************/
/*                                   SECTION: HUD                                */
/*********************************************************************************/

gauntlet_round_hud_config()
{
    TRACE("gauntlet_round_hud_config");
    /* Gauntlet title, Gauntlet description, ?Gauntlet status, ?Gauntlet status color */
    gauntlet_hud = [];
    gauntlet_hud[1] =  array("Power outage", "The team must activate a generator by the end of the round.");
    gauntlet_hud[2] =  array("Sabertooth", "The team may only kill zombies using melee weapons.", "MELEE KILLS ONLY", COLOR_ORANGE);
    gauntlet_hud[3] =  array("Anchored", "The team's movement is restricted until all zombies in the round are killed.", "SURVIVE", COLOR_ORANGE);
    gauntlet_hud[4] =  array("One pint, mate", "You must have an active perk at the end of the round.");
    gauntlet_hud[5] =  array("Bless the RNG gods", "You must obtain a weapon from the Mystery Box by the end of the round.");
    gauntlet_hud[6] =  array("Where are my keys?", "The team must dig up a specified number of dig piles by the end of the round.");
    gauntlet_hud[7] =  array("Shit got personal", "The team must kill a specified number of zombies with melee attacks by the end of the round.");
    gauntlet_hud[8] =  array("Stay healthy", "You must have the Jugger-Nog perk at the end of the round.");
    gauntlet_hud[9] =  array("German tech", "The team may only kill zombies using the MP40.", "MP40 KILLS ONLY", COLOR_ORANGE);
    gauntlet_hud[10] = array("You took an arrow to the knee", "The team's ability to jump is restricted until all zombies in the round are killed.", "SURVIVE", COLOR_ORANGE);
    gauntlet_hud[11] = array("POV: You're a cheap bastard", "The team is not allowed to spend any points.", "SURVIVE", COLOR_ORANGE);
    gauntlet_hud[12] = array("Gimme my magic stick", "The team must fulfill the staff upgrade objective by the end of the round.");
    gauntlet_hud[13] = array("Leg day", "You lose points, ammo, or health while standing still.", "MOVE", COLOR_ORANGE);
    gauntlet_hud[14] = array("They're on crack", "The team must survive a round with faster and stronger zombies.", "SURVIVE", COLOR_ORANGE);
    gauntlet_hud[15] = array("Vibe killing", "The round can only be progress if all 6 generators are on and uninterrupted.");
    gauntlet_hud[16] = array("Metal overdose", "The team must survive a round with Panzer Soldats.", "SURVIVE", COLOR_ORANGE);
    gauntlet_hud[17] = array("So you've got a shovel", "The team must dig up a specified number of dig piles by the end of the round.");
    gauntlet_hud[18] = array("Fast AF boiii", "The team must survive a round with sped-up time.", "SURVIVE", COLOR_ORANGE);
    gauntlet_hud[19] = array("German tech", "The team may only kill zombies using the MP40.", "MP40 KILLS ONLY", COLOR_ORANGE);
    gauntlet_hud[20] = array("Say your prayers", "The team must reach the church by Generator 6 and defend it.");
    gauntlet_hud[21] = array("The drunk monk", "You must have a specified number of active perks at the end of the round.");
    gauntlet_hud[22] = array("Hungover", "The perks are taken away, and the team cannot repurchase them until the end of the round.", "SURVIVE", COLOR_ORANGE);
    gauntlet_hud[23] = array("Bob the Builder", "The team must kill a zombie using equipment from all 4 action slots.");
    gauntlet_hud[24] = array("Behind Closed Doors", "The team may only kill zombies with weapons available in the first room.", "FIRST ROOM WEAPON KILLS ONLY", COLOR_ORANGE);
    gauntlet_hud[25] = array("No touching grass", "The team may only kill zombies while indoors.", "INDOORS KILLS ONLY", COLOR_ORANGE);
    gauntlet_hud[26] = array("Ammo is taxed", "You consume twice as much ammo.", "SURVIVE", COLOR_ORANGE);
    gauntlet_hud[27] = array("Hands off", "The team may not pick up any power-ups, and there are many of them.", "SURVIVE", COLOR_ORANGE);
    gauntlet_hud[28] = array("2013 strats", "The team must kill a specified number of zombies with the tank.");
    gauntlet_hud[29] = array("Gun game", "The team must survive with a randomized loadout.", "SURVIVE", COLOR_ORANGE);
    gauntlet_hud[30] = array("Grand finale", "The team must reach the chamber in the center of the map (beneath Pack-a-Punch) and survive.");
    return gauntlet_hud;
}

setup_gauntlet_round_hud()
{
    TRACE("setup_gauntlet_round_hud");

    level.round_hud settimerup(0);

    cfg = gauntlet_round_hud_config()[level.gauntlet_round];
    if (!isdefined(cfg))
    {
        return;
    }

    set_title_hud_property(GAUNTLET_HUD_SET_TEXT, cfg[0]);
    set_title_hud_property(GAUNTLET_HUD_FADE_IN, 1);
    say(cfg[1]);

    foreach (player in level.players)
    {
        if (isdefined(cfg[2]))
        {
            player set_status_hud_property(GAUNTLET_HUD_SET_TEXT, cfg[2]);
        }
        if (isdefined(cfg[3]))
        {
            player set_status_hud_property(GAUNTLET_HUD_SET_COLOR, cfg[3]);
        }
    }
}

set_text_safe(text)
{
    TRACE("set_text_safe " + sstr(text));
    self settext(text);
}

welcome_prints()
{
    TRACE(sstr(self) + " welcome_prints");
    level endon("end_game");

    if (flag("start_zombie_round_logic"))
    {
        self waittill("spawned_player");
    }
    else
    {
        flag_wait("start_zombie_round_logic");
    }
    wait 0.75;
    self iprintln("B2^1GAUNTLET ^7V^1" + GAUNTLET_VERSION);
    wait 0.75;
    self iprintln("Source: ^1github.com/B2ORG/T6-TOMB-GAUNTLET");
}

flash_hash()
{
    TRACE("flash_hash");
    cmdexec("flashscripthashes");
}

gauntlet_hud()
{
    TRACE("gauntlet_hud");
    level endon("end_game");

    timer_hud = createserverfontstring("default" , 1.6);
    timer_hud setpoint("TOPRIGHT", "TOPRIGHT", 0, 0);
    timer_hud.alpha = 1;
    timer_hud.color = (0.6, 0.8, 1);
    timer_hud settimerup(0);

    level.round_hud = createserverfontstring("default" , 1.6);
    level.round_hud setpoint("TOPRIGHT", "TOPRIGHT", 0, 15);
    level.round_hud.alpha = 1;
    level.round_hud.color = (0.6, 0.75, 1);
    level.round_hud set_text_safe("0:00");

    counter_hud = createserverfontstring("default" , 1.4);
    counter_hud setpoint("CENTER", "CENTER", 0, 185);
    counter_hud.alpha = 1;
    counter_hud.label = &"ZOMBIES: ^1";
    counter_hud setvalue(0);

    /* Display title of the gauntlet on the side throught the entire round */
    level.gauntlet_challenge_title = createserverfontstring("default", 1.4);
    level.gauntlet_challenge_title setpoint("TOPRIGHT", "TOPRIGHT", 0, 50);
    level.gauntlet_challenge_title.alpha = 0;
    level.gauntlet_challenge_title.color = (0.6, 0.8, 1);

    while (true)
    {
        if (isdefined(level.zombie_total))
        {
            count = get_round_count();
            if (count == 0)
            {
                counter_hud.label = &"ZOMBIES: ^1";
            }
            else if (level.gauntlet_round >= 10 && count <= 12)
            {
                counter_hud.label = &"ZOMBIES: ^3";
            }
            else
            {
                counter_hud.label = &"ZOMBIES: ^5";
            }
            counter_hud setvalue(count);
        }

        foreach (player in level.players)
        {
            if (!is_true(player._gauntlet_hud_initialized))
            {
                continue;
            }

            if (isalive(player))
            {
                player.gauntlet_zone_hud.alpha = 0.9;
                z = zone_friendly_name(player get_current_zone());
                player.gauntlet_zone_hud settext(z);
            }
            else
            {
                player.gauntlet_zone_hud.alpha = 0;
            }
            if (isdefined(level.gauntlet_zone_hud_processing))
            {
                player [[level.gauntlet_zone_hud_processing]](player.gauntlet_zone_hud);
            }

            if (is_player_valid(player, false, true))
            {
                v = int(length(player getvelocity() * (1, 1, player isonground() ? 1 : 0)));
                player.gauntlet_velocity_hud.alpha = 0.75;
                player.gauntlet_velocity_hud velocity_scale(v, player);
                player.gauntlet_velocity_hud setvalue(v);
            }
            else
            {
                player.gauntlet_velocity_hud.alpha = 0;
            }
            if (isdefined(level.gauntlet_velocity_hud_processing))
            {
                player [[level.gauntlet_velocity_hud_processing]](player.gauntlet_velocity_hud);
            }
        }

        wait 0.05;
    }
}

player_gauntlet_hud()
{
    TRACE("player_gauntlet_hud");
    self waittill("spawned_player");
    flag_wait("initial_blackscreen_passed");

    self.gauntlet_challenge_player_status = self createfontstring("default", 1.9);
    self.gauntlet_challenge_player_status setpoint("TOPRIGHT", "TOPRIGHT", 0, 70);
    self.gauntlet_challenge_player_status.alpha = 0;
    self.gauntlet_challenge_player_status.color = (1, 0.7, 0.4);

    self.gauntlet_timer_player_status = self createfontstring("default", 1.9);
    self.gauntlet_timer_player_status setpoint("TOPRIGHT", "TOPRIGHT", 0, 90);
    self.gauntlet_timer_player_status.alpha = 0;
    self.gauntlet_timer_player_status.color = (1, 0.7, 0.4);

    self.gauntlet_velocity_hud = self createfontstring("default", 1.1);
    self.gauntlet_velocity_hud setpoint("CENTER", "CENTER", 0, 200);
    self.gauntlet_velocity_hud.alpha = 0.75;

    self.gauntlet_zone_hud = self createfontstring("default", 1);
    self.gauntlet_zone_hud setpoint("CENTER", "CENTER", 0, 215);
    self.gauntlet_zone_hud.alpha = 0.9;
    self.gauntlet_zone_hud.color = (0.85, 0.85, 0.85);

    self thread _coordinate_hud();

    self._gauntlet_hud_initialized = true;
}

custom_win_screen()
{
    TRACE("custom_win_screen");
    win_hud = createserverfontstring("default" , 2.4);
    win_hud setpoint("CENTER", "CENTER", 0, -50);
    win_hud.alpha = 0;
    win_hud settext("You Win!");
    win_hud fadeovertime(1);
    win_hud.alpha = 1;

    win_hud2 = createserverfontstring("default" , 2.2);
    win_hud2 setpoint("CENTER", "CENTER", 0, -25);
    win_hud2.alpha = 0;
    win_hud2 settext("TIME: " + convert_time(gettime() - level.gauntlet_game_start, TIME_MMSSVV)); 
    win_hud2 fadeovertime(1);
    win_hud2.alpha = 1;

    features = STR(level.b2_gauntlet_state);
    foreach (player in level.players)
    {
        features += isdefined(level.b2_gauntlet_player_state[STR(player.entity_num)])
            ? " " + level.b2_gauntlet_player_state[STR(player.entity_num)]
            : " 0";
    }
    win_hud3 = createserverfontstring("default" , 1.8);
    win_hud3 setpoint("CENTER", "CENTER", 0, 0);
    win_hud3.alpha = 0;
    win_hud3.color = (0.75, 0.75, 0.75);
    win_hud3 settext(features); 
    win_hud3 fadeovertime(1);
    win_hud3.alpha = 1;
}

custom_lose_screen()
{
    TRACE("custom_lose_screen");
    win_hud = createserverfontstring("default" , 2.4);
    win_hud setpoint("CENTER", "CENTER", 0, -50);
    win_hud.alpha = 0;
    win_hud settext("GAUNTLET LOST");
    win_hud fadeovertime(1);
    win_hud.alpha = 1;
}

second_chance_hud(team_size)
{
    TRACE("second_chance_hud " + sstr(team_size));
    level endon("end_game");

    chance_hud = createserverfontstring("default" , 2.2);
    chance_hud setpoint("CENTER", "CENTER", 0, -10);
    chance_hud.alpha = 0;
    chance_hud.color = (1, 0.8, 0.6);
    chance_hud settext("SECOND CHANCE"); 
    if (team_size == 1)
    {
        chance_hud settext("CHALLENGE FAILED"); 
    }

    chance_hud fadeovertime(1);
    chance_hud.alpha = 1;
    wait 7;
    chance_hud fadeovertime(1);
    chance_hud.alpha = 0;
}

_coordinate_hud()
{
#ifdef ENABLE_DEBUG
    TRACE("_coordinate_hud");
    level endon("end_game");
    self endon("disconnect");

    self.coordinates_x_hud = self createfontstring("objective" , 1.1);
    self.coordinates_x_hud setpoint("CENTER", "CENTER", -40, 225);
    self.coordinates_x_hud.color = (1, 1, 1);
    self.coordinates_x_hud.hidewheninmenu = 0;

    self.coordinates_y_hud = self createfontstring("objective" , 1.1);
    self.coordinates_y_hud setpoint("CENTER", "CENTER", 0, 225);
    self.coordinates_y_hud.color = (1, 1, 1);
    self.coordinates_y_hud.hidewheninmenu = 0;

    self.coordinates_z_hud = self createfontstring("objective" , 1.1);
    self.coordinates_z_hud setpoint("CENTER", "CENTER", 40, 225);
    self.coordinates_z_hud.color = (1, 1, 1);
    self.coordinates_z_hud.hidewheninmenu = 0;

    while (true)
    {
        if (isalive(self))
        {
            self.coordinates_x_hud setvalue(int(self.origin[0] * 1000) / 1000);
            self.coordinates_y_hud setvalue(int(self.origin[1] * 1000) / 1000);
            self.coordinates_z_hud setvalue(int(self.origin[2] * 1000) / 1000);
            self.coordinates_x_hud.alpha = 0.66;
            self.coordinates_y_hud.alpha = 0.66;
            self.coordinates_z_hud.alpha = 0.66;
        }
        else
        {
            self.coordinates_x_hud.alpha = 0;
            self.coordinates_y_hud.alpha = 0;
            self.coordinates_z_hud.alpha = 0;
        }

        wait 0.05;
    }
#endif
}

fade_out_hud_after(delay = 4, fade_duration = 1)
{
    TRACE("fade_out_hud_after " + sstr(delay) + " " + sstr(fade_duration));
    wait delay;
    set_title_hud_property(GAUNTLET_HUD_FADE_OUT, fade_duration);
    set_status_hud_property(GAUNTLET_HUD_FADE_OUT, fade_duration);
}

set_title_hud_property(instruction, data)
{
    TRACE("set_title_hud_property " + sstr(instruction) + " " + sstr(data));
    switch (instruction)
    {
        case GAUNTLET_HUD_SET_VALUE:
            level.gauntlet_challenge_title setvalue(data);
            break;
        case GAUNTLET_HUD_SET_TEXT:
            level.gauntlet_challenge_title set_text_safe(data);
            break;
        case GAUNTLET_HUD_SET_COLOR:
            level.gauntlet_challenge_title.color = data;
            break;
        case GAUNTLET_HUD_FADE_IN:
            level.gauntlet_challenge_title fadeovertime(data);
            level.gauntlet_challenge_title.alpha = 1;
            break;
        case GAUNTLET_HUD_FADE_OUT:
            level.gauntlet_challenge_title fadeovertime(data);
            level.gauntlet_challenge_title.alpha = 0;
            break;
        case GAUNTLET_HUD_SET_POINT:
            level.gauntlet_challenge_title setpoint(data[0], data[1], data[2], data[3]);
            break;
    }
}

set_status_hud_property(instruction, data)
{
    TRACE("set_status_hud_property " + sstr(instruction) + " " + sstr(data));
    if (self is_player())
    {
        players = array(self);
    }
    else
    {
        players = get_players();
    }

    foreach (player in players)
    {
        switch (instruction)
        {
            case GAUNTLET_HUD_SET_VALUE:
                player.gauntlet_challenge_player_status setvalue(data);
                break;
            case GAUNTLET_HUD_SET_TEXT:
                player.gauntlet_challenge_player_status set_text_safe(data);
                break;
            case GAUNTLET_HUD_SET_COLOR:
                player.gauntlet_challenge_player_status.color = data;
                break;
            case GAUNTLET_HUD_FADE_IN:
                player.gauntlet_challenge_player_status fadeovertime(data);
                player.gauntlet_challenge_player_status.alpha = 1;
                break;
            case GAUNTLET_HUD_FADE_OUT:
                player.gauntlet_challenge_player_status fadeovertime(data);
                player.gauntlet_challenge_player_status.alpha = 0;
                break;
            case GAUNTLET_HUD_SET_POINT:
                player.gauntlet_challenge_player_status setpoint(data[0], data[1], data[2], data[3]);
                break;
        }
    }
}

set_zone_hud_property(instruction, data)
{
    TRACE("set_zone_hud_property " + sstr(instruction) + " " + sstr(data));
    if (self is_player())
    {
        players = array(self);
    }
    else
    {
        players = get_players();
    }

    foreach (player in players)
    {
        switch (instruction)
        {
            case GAUNTLET_HUD_SET_VALUE:
                player.gauntlet_zone_hud setvalue(data);
                break;
            case GAUNTLET_HUD_SET_TEXT:
                player.gauntlet_zone_hud set_text_safe(data);
                break;
            case GAUNTLET_HUD_SET_COLOR:
                player.gauntlet_zone_hud.color = data;
                break;
            case GAUNTLET_HUD_FADE_IN:
                player.gauntlet_zone_hud fadeovertime(data);
                player.gauntlet_zone_hud.alpha = 1;
                break;
            case GAUNTLET_HUD_FADE_OUT:
                player.gauntlet_zone_hud fadeovertime(data);
                player.gauntlet_zone_hud.alpha = 0;
                break;
            case GAUNTLET_HUD_SET_POINT:
                player.gauntlet_zone_hud setpoint(data[0], data[1], data[2], data[3]);
                break;
        }
    }
}

stop_round_timer_hud()
{
    TRACE("stop_round_timer_hud");
    timer_text = convert_time(gettime() - level.gauntlet_game_start, TIME_MSSVV);
    split_text = convert_time(gettime() - level.round_start_time, TIME_MSSVV);
    level.round_hud set_text_safe(strtok(split_text, ".")[0]);
    // say("Game: " + timer_text + " | Round: " + split_text);
}

_cleanup_dev_hud()
{
    TRACE("_cleanup_dev_hud");
    foreach (player in level.players)
    {
        if (isdefined(player._gauntlet_dev_hud_movement_points))
        {
            player._gauntlet_dev_hud_movement_points destroyelem();
        }
    }
}

velocity_scale(vel, player)
{
    self.color = (0.6, 0, 0);
    self.glowcolor = (0.3, 0, 0);

    if (player hasperk("specialty_longersprint"))
    {
        vel -= 40;
    }

    if (vel < 330)
    {
        self.color = (0.6, 1, 0.6);
        self.glowcolor = (0.4, 0.7, 0.4);
    }
    else if (vel <= 340)
    {
        self.color = (0.8, 1, 0.6);
        self.glowcolor = (0.6, 0.7, 0.4);
    }
    else if (vel <= 350)
    {
        self.color = (1, 1, 0.6);
        self.glowcolor = (0.7, 0.7, 0.4);
    }
    else if (vel <= 360)
    {
        self.color = (1, 0.8, 0.4);
        self.glowcolor = (0.7, 0.6, 0.2);
    }
    else if (vel <= 370)
    {
        self.color = (1, 0.6, 0.2);
        self.glowcolor = (0.7, 0.4, 0.1);
    }
    else if (vel <= 380)
    {
        self.color = (1, 0.2, 0);
        self.glowcolor = (0.7, 0.1, 0);
    }
}

zone_friendly_name(zone)
{
    if (!isdefined(zone))
    {
        return "";
    }

    name = zone;

    if (level.script == "zm_transit" || level.script == "zm_transit_dr")
    {
        if (zone == "zone_pri")
            name = "Bus Depot";
        else if (zone == "zone_pri2")
            name = "Bus Depot Hallway";
        else if (zone == "zone_station_ext")
            name = "Outside Bus Depot";
        else if (zone == "zone_trans_2b")
            name = "Fog After Bus Depot";
        else if (zone == "zone_trans_2")
            name = "Tunnel Entrance";
        else if (zone == "zone_amb_tunnel")
            name = "Tunnel";
        else if (zone == "zone_trans_3")
            name = "Tunnel Exit";
        else if (zone == "zone_roadside_west")
            name = "Outside Diner";
        else if (zone == "zone_gas")
            name = "Gas Station";
        else if (zone == "zone_roadside_east")
            name = "Outside Garage";
        else if (zone == "zone_trans_diner")
            name = "Fog Outside Diner";
        else if (zone == "zone_trans_diner2")
            name = "Fog Outside Garage";
        else if (zone == "zone_gar")
            name = "Garage";
        else if (zone == "zone_din")
            name = "Diner";
        else if (zone == "zone_diner_roof")
            name = "Diner Roof";
        else if (zone == "zone_trans_4")
            name = "Fog After Diner";
        else if (zone == "zone_amb_forest")
            name = "Forest";
        else if (zone == "zone_trans_10")
            name = "Outside Church";
        else if (zone == "zone_town_church")
            name = "Outside Church To Town";
        else if (zone == "zone_trans_5")
            name = "Fog Before Farm";
        else if (zone == "zone_far")
            name = "Outside Farm";
        else if (zone == "zone_far_ext")
            name = "Farm";
        else if (zone == "zone_brn")
            name = "Barn";
        else if (zone == "zone_farm_house")
            name = "Farmhouse";
        else if (zone == "zone_trans_6")
            name = "Fog After Farm";
        else if (zone == "zone_amb_cornfield")
            name = "Cornfield";
        else if (zone == "zone_cornfield_prototype")
            name = "Prototype";
        else if (zone == "zone_trans_7")
            name = "Upper Fog Before Power Station";
        else if (zone == "zone_trans_pow_ext1")
            name = "Fog Before Power Station";
        else if (zone == "zone_pow")
            name = "Outside Power Station";
        else if (zone == "zone_prr")
            name = "Power Station";
        else if (zone == "zone_pcr")
            name = "Power Station Control Room";
        else if (zone == "zone_pow_warehouse")
            name = "Warehouse";
        else if (zone == "zone_trans_8")
            name = "Fog After Power Station";
        else if (zone == "zone_amb_power2town")
            name = "Cabin";
        else if (zone == "zone_trans_9")
            name = "Fog Before Town";
        else if (zone == "zone_town_north")
            name = "North Town";
        else if (zone == "zone_tow")
            name = "Center Town";
        else if (zone == "zone_town_east")
            name = "East Town";
        else if (zone == "zone_town_west")
            name = "West Town";
        else if (zone == "zone_town_south")
            name = "South Town";
        else if (zone == "zone_bar")
            name = "Bar";
        else if (zone == "zone_town_barber")
            name = "Bookstore";
        else if (zone == "zone_ban")
            name = "Bank";
        else if (zone == "zone_ban_vault")
            name = "Bank Vault";
        else if (zone == "zone_tbu")
            name = "Below Bank";
        else if (zone == "zone_trans_11")
            name = "Fog After Town";
        else if (zone == "zone_amb_bridge")
            name = "Bridge";
        else if (zone == "zone_trans_1")
            name = "Fog Before Bus Depot";
    }
    else if (level.script == "zm_nuked")
    {
        if (zone == "culdesac_yellow_zone")
            name = "Yellow House Cul-de-sac";
        else if (zone == "culdesac_green_zone")
            name = "Green House Cul-de-sac";
        else if (zone == "truck_zone")
            name = "Truck";
        else if (zone == "openhouse1_f1_zone")
            name = "Green House Downstairs";
        else if (zone == "openhouse1_f2_zone")
            name = "Green House Upstairs";
        else if (zone == "openhouse1_backyard_zone")
            name = "Green House Backyard";
        else if (zone == "openhouse2_f1_zone")
            name = "Yellow House Downstairs";
        else if (zone == "openhouse2_f2_zone")
            name = "Yellow House Upstairs";
        else if (zone == "openhouse2_backyard_zone")
            name = "Yellow House Backyard";
        else if (zone == "ammo_door_zone")
            name = "Yellow House Backyard Door";
    }
    else if (level.script == "zm_highrise")
    {
        if (zone == "zone_green_start")
            name = "Green Highrise Level 3b";
        else if (zone == "zone_green_escape_pod")
            name = "Escape Pod";
        else if (zone == "zone_green_escape_pod_ground")
            name = "Escape Pod Shaft";
        else if (zone == "zone_green_level1")
            name = "Green Highrise Level 3a";
        else if (zone == "zone_green_level2a")
            name = "Green Highrise Level 2a";
        else if (zone == "zone_green_level2b")
            name = "Green Highrise Level 2b";
        else if (zone == "zone_green_level3a")
            name = "Green Highrise Restaurant";
        else if (zone == "zone_green_level3b")
            name = "Green Highrise Level 1a";
        else if (zone == "zone_green_level3c")
            name = "Green Highrise Level 1b";
        else if (zone == "zone_green_level3d")
            name = "Green Highrise Behind Restaurant";
        else if (zone == "zone_orange_level1")
            name = "Upper Orange Highrise Level 2";
        else if (zone == "zone_orange_level2")
            name = "Upper Orange Highrise Level 1";
        else if (zone == "zone_orange_elevator_shaft_top")
            name = "Elevator Shaft Level 3";
        else if (zone == "zone_orange_elevator_shaft_middle_1")
            name = "Elevator Shaft Level 2";
        else if (zone == "zone_orange_elevator_shaft_middle_2")
            name = "Elevator Shaft Level 1";
        else if (zone == "zone_orange_elevator_shaft_bottom")
            name = "Elevator Shaft Bottom";
        else if (zone == "zone_orange_level3a")
            name = "Lower Orange Highrise Level 1a";
        else if (zone == "zone_orange_level3b")
            name = "Lower Orange Highrise Level 1b";
        else if (zone == "zone_blue_level5")
            name = "Lower Blue Highrise Level 1";
        else if (zone == "zone_blue_level4a")
            name = "Lower Blue Highrise Level 2a";
        else if (zone == "zone_blue_level4b")
            name = "Lower Blue Highrise Level 2b";
        else if (zone == "zone_blue_level4c")
            name = "Lower Blue Highrise Level 2c";
        else if (zone == "zone_blue_level2a")
            name = "Upper Blue Highrise Level 1a";
        else if (zone == "zone_blue_level2b")
            name = "Upper Blue Highrise Level 1b";
        else if (zone == "zone_blue_level2c")
            name = "Upper Blue Highrise Level 1c";
        else if (zone == "zone_blue_level2d")
            name = "Upper Blue Highrise Level 1d";
        else if (zone == "zone_blue_level1a")
            name = "Upper Blue Highrise Level 2a";
        else if (zone == "zone_blue_level1b")
            name = "Upper Blue Highrise Level 2b";
        else if (zone == "zone_blue_level1c")
            name = "Upper Blue Highrise Level 2c";
    }
    else if (level.script == "zm_prison")
    {
        if (zone == "zone_start")
            name = "D-Block";
        else if (zone == "zone_library")
            name = "Library";
        else if (zone == "zone_cellblock_west")
            name = "Cell Block 2nd Floor";
        else if (zone == "zone_cellblock_west_gondola")
            name = "Cell Block 3rd Floor";
        else if (zone == "zone_cellblock_west_gondola_dock")
            name = "Cell Block Gondola";
        else if (zone == "zone_cellblock_west_barber")
            name = "Michigan Avenue";
        else if (zone == "zone_cellblock_east")
            name = "Times Square";
        else if (zone == "zone_cafeteria")
            name = "Cafeteria";
        else if (zone == "zone_cafeteria_end")
            name = "Cafeteria End";
        else if (zone == "zone_infirmary")
            name = "Infirmary 1";
        else if (zone == "zone_infirmary_roof")
            name = "Infirmary 2";
        else if (zone == "zone_roof_infirmary")
            name = "Roof 1";
        else if (zone == "zone_roof")
            name = "Roof 2";
        else if (zone == "zone_cellblock_west_warden")
            name = "Sally Port";
        else if (zone == "zone_warden_office")
            name = "Warden's Office";
        else if (zone == "cellblock_shower")
            name = "Showers";
        else if (zone == "zone_citadel_shower")
            name = "Citadel To Showers";
        else if (zone == "zone_citadel")
            name = "Citadel";
        else if (zone == "zone_citadel_warden")
            name = "Citadel To Warden's Office";
        else if (zone == "zone_citadel_stairs")
            name = "Citadel Tunnels";
        else if (zone == "zone_citadel_basement")
            name = "Citadel Basement";
        else if (zone == "zone_citadel_basement_building")
            name = "China Alley";
        else if (zone == "zone_studio")
            name = "Building 64";
        else if (zone == "zone_dock")
            name = "Docks";
        else if (zone == "zone_dock_puzzle")
            name = "Docks Gates";
        else if (zone == "zone_dock_gondola")
            name = "Upper Docks";
        else if (zone == "zone_golden_gate_bridge")
            name = "Golden Gate Bridge";
        else if (zone == "zone_gondola_ride")
            name = "Gondola";
    }
    else if (level.script == "zm_buried")
    {
        if (zone == "zone_start")
            name = "Processing";
        else if (zone == "zone_start_lower")
            name = "Lower Processing";
        else if (zone == "zone_tunnels_center")
            name = "Center Tunnels";
        else if (zone == "zone_tunnels_north")
            name = "Courthouse Tunnels 2";
        else if (zone == "zone_tunnels_north2")
            name = "Courthouse Tunnels 1";
        else if (zone == "zone_tunnels_south")
            name = "Saloon Tunnels 3";
        else if (zone == "zone_tunnels_south2")
            name = "Saloon Tunnels 2";
        else if (zone == "zone_tunnels_south3")
            name = "Saloon Tunnels 1";
        else if (zone == "zone_street_lightwest")
            name = "Outside General Store & Bank";
        else if (zone == "zone_street_lightwest_alley")
            name = "Outside General Store & Bank Alley";
        else if (zone == "zone_morgue_upstairs")
            name = "Morgue";
        else if (zone == "zone_underground_jail")
            name = "Jail Downstairs";
        else if (zone == "zone_underground_jail2")
            name = "Jail Upstairs";
        else if (zone == "zone_general_store")
            name = "General Store";
        else if (zone == "zone_stables")
            name = "Stables";
        else if (zone == "zone_street_darkwest")
            name = "Outside Gunsmith";
        else if (zone == "zone_street_darkwest_nook")
            name = "Outside Gunsmith Nook";
        else if (zone == "zone_gun_store")
            name = "Gunsmith";
        else if (zone == "zone_bank")
            name = "Bank";
        else if (zone == "zone_tunnel_gun2stables")
            name = "Stables To Gunsmith Tunnel 2";
        else if (zone == "zone_tunnel_gun2stables2")
            name = "Stables To Gunsmith Tunnel";
        else if (zone == "zone_street_darkeast")
            name = "Outside Saloon & Toy Store";
        else if (zone == "zone_street_darkeast_nook")
            name = "Outside Saloon & Toy Store Nook";
        else if (zone == "zone_underground_bar")
            name = "Saloon";
        else if (zone == "zone_tunnel_gun2saloon")
            name = "Saloon To Gunsmith Tunnel";
        else if (zone == "zone_toy_store")
            name = "Toy Store Downstairs";
        else if (zone == "zone_toy_store_floor2")
            name = "Toy Store Upstairs";
        else if (zone == "zone_toy_store_tunnel")
            name = "Toy Store Tunnel";
        else if (zone == "zone_candy_store")
            name = "Candy Store Downstairs";
        else if (zone == "zone_candy_store_floor2")
            name = "Candy Store Upstairs";
        else if (zone == "zone_street_lighteast")
            name = "Outside Courthouse & Candy Store";
        else if (zone == "zone_underground_courthouse")
            name = "Courthouse Downstairs";
        else if (zone == "zone_underground_courthouse2")
            name = "Courthouse Upstairs";
        else if (zone == "zone_street_fountain")
            name = "Fountain";
        else if (zone == "zone_church_graveyard")
            name = "Graveyard";
        else if (zone == "zone_church_main")
            name = "Church Downstairs";
        else if (zone == "zone_church_upstairs")
            name = "Church Upstairs";
        else if (zone == "zone_mansion_lawn")
            name = "Mansion Lawn";
        else if (zone == "zone_mansion")
            name = "Mansion";
        else if (zone == "zone_mansion_backyard")
            name = "Mansion Backyard";
        else if (zone == "zone_maze")
            name = "Maze";
        else if (zone == "zone_maze_staircase")
            name = "Maze Staircase";
    }
    else if (level.script == "zm_tomb")
    {
        if (isDefined(self.teleporting) && self.teleporting)
            return "";

        if (zone == "zone_start")
            name = "Lower Laboratory";
        else if (zone == "zone_start_a")
            name = "Upper Laboratory";
        else if (zone == "zone_start_b")
            name = "Generator 1";
        else if (zone == "zone_bunker_1a")
            name = "Generator 3 Bunker 1";
        else if (zone == "zone_fire_stairs")
            name = "Fire Tunnel";
        else if (zone == "zone_bunker_1")
            name = "Generator 3 Bunker 2";
        else if (zone == "zone_bunker_3a")
            name = "Generator 3";
        else if (zone == "zone_bunker_3b")
            name = "Generator 3 Bunker 3";
        else if (zone == "zone_bunker_2a")
            name = "Generator 2 Bunker 1";
        else if (zone == "zone_bunker_2")
            name = "Generator 2 Bunker 2";
        else if (zone == "zone_bunker_4a")
            name = "Generator 2";
        else if (zone == "zone_bunker_4b")
            name = "Generator 2 Bunker 3";
        else if (zone == "zone_bunker_4c")
            name = "Tank Station";
        else if (zone == "zone_bunker_4d")
            name = "Above Tank Station";
        else if (zone == "zone_bunker_tank_c")
            name = "Generator 2 Tank Route 1";
        else if (zone == "zone_bunker_tank_c1")
            name = "Generator 2 Tank Route 2";
        else if (zone == "zone_bunker_4e")
            name = "Generator 2 Tank Route 3";
        else if (zone == "zone_bunker_tank_d")
            name = "Generator 2 Tank Route 4";
        else if (zone == "zone_bunker_tank_d1")
            name = "Generator 2 Tank Route 5";
        else if (zone == "zone_bunker_4f")
            name = "zone_bunker_4f";
        else if (zone == "zone_bunker_5a")
            name = "Workshop Downstairs";
        else if (zone == "zone_bunker_5b")
            name = "Workshop Upstairs";
        else if (zone == "zone_nml_2a")
            name = "No Man's Land Walkway";
        else if (zone == "zone_nml_2")
            name = "No Man's Land Entrance";
        else if (zone == "zone_bunker_tank_e")
            name = "Generator 5 Tank Route 1";
        else if (zone == "zone_bunker_tank_e1")
            name = "Generator 5 Tank Route 2";
        else if (zone == "zone_bunker_tank_e2")
            name = "zone_bunker_tank_e2";
        else if (zone == "zone_bunker_tank_f")
            name = "Generator 5 Tank Route 3";
        else if (zone == "zone_nml_1")
            name = "Generator 5 Tank Route 4";
        else if (zone == "zone_nml_4")
            name = "Generator 5 Tank Route 5";
        else if (zone == "zone_nml_0")
            name = "Generator 5 Left Footstep";
        else if (zone == "zone_nml_5")
            name = "Generator 5 Right Footstep Walkway";
        else if (zone == "zone_nml_farm")
            name = "Generator 5";
        else if (zone == "zone_nml_celllar")
            name = "Generator 5 Cellar";
        else if (zone == "zone_bolt_stairs")
            name = "Lightning Tunnel";
        else if (zone == "zone_nml_3")
            name = "No Man's Land 1st Right Footstep";
        else if (zone == "zone_nml_2b")
            name = "No Man's Land Stairs";
        else if (zone == "zone_nml_6")
            name = "No Man's Land Left Footstep";
        else if (zone == "zone_nml_8")
            name = "No Man's Land 2nd Right Footstep";
        else if (zone == "zone_nml_10a")
            name = "Generator 4 Tank Route 1";
        else if (zone == "zone_nml_10")
            name = "Generator 4 Tank Route 2";
        else if (zone == "zone_nml_7")
            name = "Generator 4 Tank Route 3";
        else if (zone == "zone_bunker_tank_a")
            name = "Generator 4 Tank Route 4";
        else if (zone == "zone_bunker_tank_a1")
            name = "Generator 4 Tank Route 5";
        else if (zone == "zone_bunker_tank_a2")
            name = "zone_bunker_tank_a2";
        else if (zone == "zone_bunker_tank_b")
            name = "Generator 4 Tank Route 6";
        else if (zone == "zone_nml_9")
            name = "Generator 4 Left Footstep";
        else if (zone == "zone_air_stairs")
            name = "Wind Tunnel";
        else if (zone == "zone_nml_11")
            name = "Generator 4";
        else if (zone == "zone_nml_12")
            name = "Generator 4 Right Footstep";
        else if (zone == "zone_nml_16")
            name = "Excavation Site Front Path";
        else if (zone == "zone_nml_17")
            name = "Excavation Site Back Path";
        else if (zone == "zone_nml_18")
            name = "Excavation Site Level 3";
        else if (zone == "zone_nml_19")
            name = "Excavation Site Level 2";
        else if (zone == "ug_bottom_zone")
            name = "Excavation Site Level 1";
        else if (zone == "zone_nml_13")
            name = "Generator 5 To Generator 6 Path";
        else if (zone == "zone_nml_14")
            name = "Generator 4 To Generator 6 Path";
        else if (zone == "zone_nml_15")
            name = "Generator 6 Entrance";
        else if (zone == "zone_village_0")
            name = "Generator 6 Left Footstep";
        else if (zone == "zone_village_5")
            name = "Generator 6 Tank Route 1";
        else if (zone == "zone_village_5a")
            name = "Generator 6 Tank Route 2";
        else if (zone == "zone_village_5b")
            name = "Generator 6 Tank Route 3";
        else if (zone == "zone_village_1")
            name = "Generator 6 Tank Route 4";
        else if (zone == "zone_village_4b")
            name = "Generator 6 Tank Route 5";
        else if (zone == "zone_village_4a")
            name = "Generator 6 Tank Route 6";
        else if (zone == "zone_village_4")
            name = "Generator 6 Tank Route 7";
        else if (zone == "zone_village_2")
            name = "Church";
        else if (zone == "zone_village_3")
            name = "Generator 6 Right Footstep";
        else if (zone == "zone_village_3a")
            name = "Generator 6";
        else if (zone == "zone_ice_stairs")
            name = "Ice Tunnel";
        else if (zone == "zone_bunker_6")
            name = "Above Generator 3 Bunker";
        else if (zone == "zone_nml_20")
            name = "Above No Man's Land";
        else if (zone == "zone_village_6")
            name = "Behind Church";
        else if (zone == "zone_chamber_0")
            name = "The Crazy Place Lightning Chamber";
        else if (zone == "zone_chamber_1")
            name = "The Crazy Place Lightning & Ice";
        else if (zone == "zone_chamber_2")
            name = "The Crazy Place Ice Chamber";
        else if (zone == "zone_chamber_3")
            name = "The Crazy Place Fire & Lightning";
        else if (zone == "zone_chamber_4")
            name = "The Crazy Place Center";
        else if (zone == "zone_chamber_5")
            name = "The Crazy Place Ice & Wind";
        else if (zone == "zone_chamber_6")
            name = "The Crazy Place Fire Chamber";
        else if (zone == "zone_chamber_7")
            name = "The Crazy Place Wind & Fire";
        else if (zone == "zone_chamber_8")
            name = "The Crazy Place Wind Chamber";
        else if (zone == "zone_robot_head")
            name = "Robot's Head";
    }

#ifdef ENABLE_DEBUG
    return name + " (" + zone + ")";
#else
    return name;
#endif
}

_dev_handle_doors()
{
    TRACE("_dev_handle_doors");
#ifdef DEV_OPEN_DOORS
#endif
}
