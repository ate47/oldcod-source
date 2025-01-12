#using script_1caf36ff04a85ff6;
#using script_36f4be19da8eb6d0;
#using script_b9d273dc917ee1f;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_silver_ww_quest;

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xeb5aa38b, Offset: 0x6a0
// Size: 0x284
function init() {
    /#
        execdevgui("<dev string:x38>");
        level thread function_233ed9b4();
    #/
    clientfield::register("scriptmover", "" + #"hash_3654e70518cd9bb5", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_7159facf785aad53", 1, 1, "int");
    clientfield::register("toplayer", "" + #"hash_864ef374ea11ea7", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_3fc8d4cd56e4e9b0", 1, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_18f64f139f905f76", 1, 1, "int");
    clientfield::register("scriptmover", "crystal_energy_fx", 1, 1, "int");
    clientfield::register("allplayers", "ww_vacuum_crystal_fx", 1, 1, "int");
    clientfield::register("allplayers", "hold_crystal_energy", 1, 1, "int");
    level thread function_7b4dc906();
    level thread function_c436fc75();
    level thread function_17329c15();
    level thread function_78d3b53b();
    level thread function_77fdf8f3();
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xff932008, Offset: 0x930
// Size: 0x5c
function function_7b4dc906() {
    level endon(#"end_game");
    level.var_632fe5ca = 0;
    function_aee47035();
    callback::on_weapon_change(&function_b8a1fcc2);
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x59f3cd4a, Offset: 0x998
// Size: 0x7c
function function_aee47035() {
    level thread function_284b43aa();
    level thread function_5adab0a2();
    level thread function_afba0d4c();
    level thread function_23ac3e06();
    level thread function_67144513();
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x143dafd1, Offset: 0xa20
// Size: 0x13c
function function_284b43aa() {
    waitresult = level waittill(#"hash_7e3660d8d125a63a");
    model = util::spawn_model(#"hash_57b2f3d240186aa8", waitresult.position + (0, 0, 50), (0, 0, 90));
    model rotate((0, 90, 0));
    model clientfield::set("" + #"hash_3654e70518cd9bb5", 1);
    model zm_unitrigger::function_fac87205(#"hash_69dc1e9c343f7311", 32);
    model delete();
    level flag::set("player_got_card");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x67d7f928, Offset: 0xb68
// Size: 0x39c
function function_5adab0a2() {
    level flag::wait_till("player_got_card");
    reader = getent("ww_reader_ent", "script_noteworthy");
    var_dae3aab3 = getent("ww_drawer_ent", "script_noteworthy");
    var_bc4ce35d = getent(var_dae3aab3.target, "targetname");
    remote = util::spawn_model(#"hash_774392b790d6de08", var_dae3aab3.origin + (0, -10, 0));
    remote linkto(var_dae3aab3);
    var_bc4ce35d linkto(var_dae3aab3);
    /#
        iprintlnbold("<dev string:x5c>");
    #/
    reader zm_unitrigger::function_fac87205(#"hash_4472d2ff9d015c5e", 48);
    var_493bf9de = util::spawn_model(#"hash_57b2f3d240186aa8", struct::get("ww_keycard_insert_loc").origin, struct::get("ww_keycard_insert_loc").angles);
    var_493bf9de moveto(var_493bf9de.origin + (0, -8, 0), 1, 0.25, 0.25);
    var_493bf9de waittill(#"movedone");
    var_dae3aab3 moveto(var_dae3aab3.origin + (0, 15, 0), 2, 0.5, 0.5);
    var_dae3aab3 waittill(#"movedone");
    remote unlink();
    remote moveto(remote.origin + (0, 0, 10), 1, 0.25, 0.25);
    remote waittill(#"movedone");
    var_4fa2cce2 = remote zm_unitrigger::function_fac87205(#"hash_5bf26e431ba2f609", 48);
    if (isdefined(var_4fa2cce2)) {
        var_51909d32 = getent("ww_ieu_ent", "script_noteworthy");
        var_4fa2cce2 thread function_34ba4d65(var_51909d32, 1000);
    }
    remote delete();
    level flag::set("player_got_remote");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x27f0f8a2, Offset: 0xf10
// Size: 0x8c
function function_afba0d4c() {
    var_51909d32 = getent("ww_ieu_ent", "script_noteworthy");
    level flag::wait_till("player_got_remote");
    /#
        iprintlnbold("<dev string:x85>");
    #/
    level thread function_eb0fb7fc(30, 10);
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x45173b82, Offset: 0xfa8
// Size: 0xd6
function function_34ba4d65(ent, max_distance) {
    level endon(#"hash_41f5f07f48f61c32");
    self endon(#"disconnect");
    while (true) {
        var_310f9e44 = distance(self.origin, ent.origin);
        if (isalive(self) && var_310f9e44 <= max_distance) {
            self playsoundtoplayer("zmb_ww_quest_chirp_2d", self);
            wait var_310f9e44 / 500;
            continue;
        }
        wait 1;
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x864108d4, Offset: 0x1088
// Size: 0x27e
function function_eb0fb7fc(duration, cooldown) {
    level endon(#"hash_688da970d6800901");
    var_f769654e = getent("ieu_interact_volume", "script_noteworthy");
    ww_room_door = getent("ww_room_door", "script_noteworthy");
    var_2f3cc38 = getent("ww_room_glass", "script_noteworthy");
    var_7ee5c5e3 = 0;
    while (true) {
        var_f769654e setvisibletoall();
        var_f769654e sethintstring(#"hash_14c27f71630de2a6");
        var_f769654e waittill(#"trigger");
        var_7ee5c5e3 += 1;
        level notify(#"hash_41f5f07f48f61c32");
        var_f769654e setinvisibletoall();
        level notify(#"hash_3a8ba71d0dfe9582");
        level.var_75a20fe3 = util::spawn_model("tag_origin", ww_room_door.origin + (-10, -20, 50), ww_room_door.angles + (0, -90, 0));
        level.var_75a20fe3 clientfield::set("" + #"hash_7159facf785aad53", 1);
        if (var_7ee5c5e3 == 1) {
            wait 5;
            var_2f3cc38 thread scene::play(#"hash_44c12ff8dba02b49", var_2f3cc38);
            wait duration - 5;
        } else {
            wait duration;
        }
        level notify(#"hash_38e1cbcaef1b44c9");
        if (isdefined(level.var_75a20fe3)) {
            level.var_75a20fe3 delete();
        }
        wait cooldown;
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xaca8593, Offset: 0x1310
// Size: 0xf4
function function_23ac3e06() {
    vol_death_zone = getent("vol_death_zone", "script_noteworthy");
    level thread function_890f302c();
    while (true) {
        if (level.var_632fe5ca >= 10) {
            break;
        }
        level waittill(#"hash_3a8ba71d0dfe9582");
        vol_death_zone thread function_37ba0961();
        vol_death_zone function_67a6fd4();
    }
    level notify(#"hash_688da970d6800901");
    if (isdefined(level.var_75a20fe3)) {
        level.var_75a20fe3 delete();
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x49357404, Offset: 0x1410
// Size: 0x14a
function function_37ba0961() {
    level endon(#"hash_38e1cbcaef1b44c9", #"hash_688da970d6800901");
    while (true) {
        all_players = getplayers();
        foreach (player in all_players) {
            if (player istouching(self)) {
                player clientfield::set_to_player("" + #"hash_864ef374ea11ea7", 1);
                continue;
            }
            player clientfield::set_to_player("" + #"hash_864ef374ea11ea7", 0);
        }
        waitframe(1);
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x20cb48f8, Offset: 0x1568
// Size: 0x11c
function function_890f302c() {
    level endon(#"game_ended", #"ww_quest_completed");
    while (true) {
        level waittill(#"hash_38e1cbcaef1b44c9", #"hash_688da970d6800901");
        all_players = getplayers();
        foreach (player in all_players) {
            player clientfield::set_to_player("" + #"hash_864ef374ea11ea7", 0);
        }
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xfab8bbfe, Offset: 0x1690
// Size: 0x12e
function function_67a6fd4() {
    level endon(#"hash_38e1cbcaef1b44c9");
    while (level.var_632fe5ca < 10) {
        ai_zombies = getactorarray();
        foreach (actor in ai_zombies) {
            if (isalive(actor) && actor istouching(self)) {
                actor.allowdeath = 1;
                actor kill();
                level.var_632fe5ca += 1;
            }
        }
        wait 1;
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xf3abeaf3, Offset: 0x17c8
// Size: 0x4a4
function function_67144513() {
    var_ed63dcf1 = getent("ieu_interact_volume", "script_noteworthy");
    vol_door_path = getent("vol_door_path", "script_noteworthy");
    var_ed63dcf1 setinvisibletoall();
    vol_door_path setinvisibletoall();
    var_51909d32 = getent("ww_ieu_ent", "script_noteworthy");
    var_c18965d8 = getent(var_51909d32.target, "targetname");
    var_6f9f2cf2 = getent("ww_ieu_trig", "script_noteworthy");
    var_6f9f2cf2 setinvisibletoall();
    level waittill(#"hash_688da970d6800901");
    var_ed63dcf1 setvisibletoall();
    var_ed63dcf1 sethintstring(#"hash_7c3dc5c3150a3e79");
    while (true) {
        var_ed63dcf1 waittill(#"trigger");
        all_players = getplayers();
        var_8c1c026 = 0;
        foreach (player in all_players) {
            if (player istouching(vol_door_path)) {
                vol_door_path setvisibletoplayer(player);
                vol_door_path sethintstringforplayer(player, #"hash_77954608933b42ed");
                var_8c1c026 += 1;
            }
        }
        if (var_8c1c026 == 0) {
            break;
        }
        wait 2;
        vol_door_path setinvisibletoall();
    }
    var_51909d32 clientfield::set("" + #"hash_18f64f139f905f76", 1);
    var_ed63dcf1 delete();
    namespace_4abf1500::function_23255935("ww_quest_audiolog");
    ww_room_door = getent("ww_room_door", "script_noteworthy");
    var_a0f325fa = getent(ww_room_door.target, "targetname");
    ww_room_door scene::play(#"hash_65505ba29fee0a2f", ww_room_door);
    var_a0f325fa delete();
    /#
        iprintlnbold("<dev string:x97>");
    #/
    var_6f9f2cf2 thread function_1a9c15f7();
    waitresult = var_6f9f2cf2 waittill(#"trigger");
    waitresult.activator zm_weapons::weapon_give(getweapon(#"ww_ieu_shockwave_t9"));
    var_c18965d8 delete();
    var_51909d32 delete();
    var_6f9f2cf2 setinvisibletoall();
    level flag::set("ww_quest_completed");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x76908dbf, Offset: 0x1c78
// Size: 0x152
function function_1a9c15f7() {
    level endon(#"end_game", #"ww_quest_completed");
    while (true) {
        all_players = getplayers();
        foreach (player in all_players) {
            if (!player hasweapon(getweapon(#"ww_ieu_shockwave_t9"), 1)) {
                self setvisibletoplayer(player);
                self sethintstringforplayer(player, #"hash_61e689ba63c1f01c");
                continue;
            }
            self setinvisibletoplayer(player);
        }
        waitframe(1);
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xefda315c, Offset: 0x1dd8
// Size: 0x344
function function_c436fc75() {
    level thread function_8fa801ac();
    level.var_a1b709cb = getent("ww_nitrogen_crate", "script_noteworthy");
    var_1a3ee7c1 = getent(level.var_a1b709cb.target, "targetname");
    var_1a3ee7c1 setinvisibletoall();
    var_127d143e = getent("ww_nitrogen_fungus", "script_noteworthy");
    var_811ae6d7 = getent("ww_nitrogen_fungus_dmg_trig", "script_noteworthy");
    var_811ae6d7 enablegrenadetouchdamage();
    while (true) {
        waitresult = var_811ae6d7 waittill(#"damage");
        if (isdefined(waitresult) && waitresult.weapon.name == #"hash_67307aa00ad6f686") {
            /#
                iprintlnbold("<dev string:xba>");
            #/
            break;
        }
    }
    while (!level flag::get("player_got_the_flask")) {
        wait 1;
    }
    var_127d143e zm_unitrigger::function_fac87205(#"hash_305fa71dfcc314d1", 64);
    var_ed7b24c9 = struct::get("drip_nitrogen_loc", "targetname");
    var_4db6fabc = util::spawn_model(#"hash_7c1403e813c1a62e", var_ed7b24c9.origin);
    var_4db6fabc setscale(2);
    wait 60;
    var_127d143e delete();
    var_4db6fabc zm_unitrigger::function_fac87205(#"hash_79bfe8ceb4fd7ed4", 64);
    var_4db6fabc delete();
    var_1a3ee7c1 setvisibletoall();
    var_1a3ee7c1 sethintstring(#"hash_235cdbad8044e4c2");
    var_1a3ee7c1 waittill(#"trigger");
    var_1a3ee7c1 setinvisibletoall();
    /#
        iprintlnbold("<dev string:xcc>");
    #/
    level.var_a1b709cb thread function_8d9ddc22("NITROGEN");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x994b5c21, Offset: 0x2128
// Size: 0x224
function function_8fa801ac() {
    var_6dad8de0 = getent("ww_nitrogen_wooden_box", "script_noteworthy");
    var_6954c829 = spawn("trigger_damage", var_6dad8de0.origin, 0, 64, 64);
    var_b14c0d6c = struct::get("ww_nitrogen_wooden_box_target_loc");
    var_6954c829.var_22cea3da = &function_72c756bc;
    while (true) {
        waitresult = var_6954c829 waittill(#"damage");
        if (isplayer(waitresult.attacker)) {
            if (isdefined(waitresult.weapon) && namespace_b376a999::function_7c292369(waitresult.weapon)) {
                time = var_6dad8de0 zm_utility::fake_physicslaunch(var_b14c0d6c.origin, 500);
                wait time;
                var_df1fc1f0 = util::spawn_model(#"hash_7c1403e813c1a62e", var_b14c0d6c.origin + (0, 0, 20));
                var_df1fc1f0 setscale(2);
                var_df1fc1f0 zm_unitrigger::function_fac87205(#"hash_79bfe8ceb4fd7ed4", 64);
                var_df1fc1f0 delete();
                break;
            }
        }
    }
    var_6954c829 delete();
    level flag::set("player_got_the_flask");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x125874b8, Offset: 0x2358
// Size: 0x314
function function_17329c15() {
    level thread function_dc2acb90();
    level.var_74ec088f = getent("ww_gas_crate", "script_noteworthy");
    container = getent("ww_gas_container", "script_noteworthy");
    container thread function_cb5d3089();
    level flag::wait_till("player_got_the_canister");
    container zm_unitrigger::function_fac87205(#"hash_4e599abcf42324d0", (64, 64, 64));
    var_5ac7d534 = util::spawn_model(#"hash_5995b3cc741a38e", struct::get("ww_gas_canister_armory_loc").origin);
    level flag::wait_till("container_filled_with_gas");
    /#
        iprintlnbold("<dev string:xe2>");
    #/
    wait 3;
    container zm_unitrigger::function_fac87205(#"hash_5df80307d66340d8", (64, 64, 64));
    var_5ac7d534 delete();
    level.var_74ec088f zm_unitrigger::function_fac87205(#"hash_4e599abcf42324d0", (96, 96, 96));
    var_b04e724c = util::spawn_model(#"hash_5995b3cc741a38e", struct::get("ww_gas_canister_crash_loc").origin);
    t_damage = spawn("trigger_damage", var_b04e724c.origin, 0, 32, 32);
    while (true) {
        waitresult = t_damage waittill(#"damage");
        if (isdefined(waitresult) && isplayer(waitresult.attacker)) {
            var_b04e724c delete();
            break;
        }
    }
    /#
        iprintlnbold("<dev string:x102>");
    #/
    level.var_74ec088f thread function_8d9ddc22("GAS");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x9c13c4b1, Offset: 0x2678
// Size: 0x16a
function function_cb5d3089() {
    level endon(#"game_ended");
    var_3789aef6 = getent(self.target, "targetname");
    while (!level flag::get("container_filled_with_gas")) {
        corpses = getcorpsearray();
        foreach (var_9a6b444a in corpses) {
            if (var_9a6b444a istouching(var_3789aef6) && var_9a6b444a.var_9fde8624 === #"hash_2a5479b83161cb35") {
                /#
                    iprintlnbold("<dev string:x117>");
                #/
                level flag::set("container_filled_with_gas");
            }
        }
        wait 1;
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xcfdbab3e, Offset: 0x27f0
// Size: 0x13c
function function_dc2acb90() {
    canister = getent("ww_gas_canister", "script_noteworthy");
    var_56bd59dc = getent("ww_gas_canister_dmg_trig", "script_noteworthy");
    var_56bd59dc.var_22cea3da = &function_72c756bc;
    waitresult = var_56bd59dc waittill(#"hash_31c03401c377e12b");
    time = canister zm_utility::fake_physicslaunch(getclosestpointonnavmesh(waitresult.player.origin), 500);
    wait time;
    canister zm_unitrigger::function_fac87205(#"hash_5df80307d66340d8", (64, 64, 64));
    canister delete();
    level flag::set("player_got_the_canister");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x79cb95e4, Offset: 0x2938
// Size: 0x4e
function function_72c756bc(player, time) {
    if (time >= 2000) {
        self notify(#"hash_31c03401c377e12b", {#player:player});
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x1 linked
// Checksum 0xb6e80d69, Offset: 0x2990
// Size: 0x11c
function function_3ca2b2c1(var_fd6475b5, var_743c16e0) {
    level endon(var_743c16e0);
    level flag::wait_till("power_on");
    var_7f76a0b6 = struct::get(var_fd6475b5);
    var_f2484ed9 = util::spawn_model("tag_origin", var_7f76a0b6.origin);
    var_f2484ed9 thread function_a5ae82b0(var_743c16e0);
    while (true) {
        var_f2484ed9 zm_unitrigger::function_fac87205(&function_ad3081a9, 96);
        var_f2484ed9 clientfield::set("" + #"hash_7ec80a02e9bb051a", 0);
        level notify(#"into_the_dark_side");
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xf41ceea2, Offset: 0x2ab8
// Size: 0x216
function function_a5ae82b0(var_743c16e0) {
    level endon(var_743c16e0);
    while (true) {
        if (!level flag::get("dark_aether_active") && (isdefined(level.var_181060cf) || isdefined(level.var_c3accf46) || isdefined(level.var_ae002b60) || isdefined(level.var_42000fd0) || isdefined(level.var_c8a2dc28)) && !level flag::get("on_mq_step_0_2")) {
            self clientfield::set("" + #"hash_7ec80a02e9bb051a", 1);
            if (!self flag::get(#"hash_7a42d508140ae262")) {
                foreach (player in getplayers()) {
                    player clientfield::set_to_player("" + #"hash_1fa45e1c3652d753", 1);
                }
            }
            self flag::set(#"hash_7a42d508140ae262");
        } else {
            self clientfield::set("" + #"hash_7ec80a02e9bb051a", 0);
        }
        wait 1;
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xd7c9ac3b, Offset: 0x2cd8
// Size: 0xda
function function_ad3081a9(*e_player) {
    if (!level flag::get("dark_aether_active") && (isdefined(level.var_181060cf) || isdefined(level.var_c3accf46) || isdefined(level.var_ae002b60) || isdefined(level.var_42000fd0) || isdefined(level.var_c8a2dc28)) && !level flag::get("on_mq_step_0_2")) {
        self sethintstring(#"hash_622731cfc9a72bfa");
        return 1;
    }
    return 0;
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x36797429, Offset: 0x2dc0
// Size: 0x2ac
function function_78d3b53b() {
    level endon(#"game_ended");
    level thread function_3ca2b2c1("ww_plasma_dark_aether_tear", "ww_plasma_dark_crate_unfolded");
    level thread function_312cd4cd();
    level.var_267fe17e = getent("ww_plasma_crate", "script_noteworthy");
    level.var_267fe17e thread function_d4647e9c();
    var_9c4b1962 = getent("ww_plasma_dark_crate", "script_noteworthy");
    var_a2f087af = getent("ww_plasma_dark_crate_clip", "targetname");
    var_d8e6cd43 = getent(var_9c4b1962.target, "targetname");
    var_ae13d215 = [var_9c4b1962, var_a2f087af, var_d8e6cd43];
    array::run_all(var_ae13d215, &hide);
    while (!level flag::get("ww_plasma_dark_crate_unfolded")) {
        level flag::wait_till(#"dark_aether_active");
        array::run_all(var_ae13d215, &show);
        if (isdefined(var_9c4b1962.var_ab549ef1)) {
            var_9c4b1962.var_ab549ef1 show();
        }
        var_9c4b1962 thread function_ead1edac();
        level flag::wait_till_clear(#"dark_aether_active");
        if (isdefined(var_9c4b1962.var_ab549ef1)) {
            var_9c4b1962.var_ab549ef1 hide();
        }
        array::run_all(var_ae13d215, &hide);
    }
    var_9c4b1962.var_ab549ef1 delete();
    array::run_all(var_ae13d215, &delete);
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xc7b91794, Offset: 0x3078
// Size: 0xfc
function function_ead1edac() {
    level endon(#"dark_side_timeout", #"pap_quest_completed", #"hash_61e8a39b3a4bee6a");
    self zm_unitrigger::function_fac87205(&function_95913408, (64, 64, 64));
    self.var_ab549ef1 = util::spawn_model(#"hash_f3cb57bd11ff214", self.origin + (0, 0, 20), self.angles);
    /#
        iprintlnbold("<dev string:x128>");
    #/
    level.var_ba3a0e1f += 60;
    level flag::set("ww_plasma_dark_crate_unfolded");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xd01252d9, Offset: 0x3180
// Size: 0x94
function function_95913408(*e_player) {
    level endon(#"ww_plasma_dark_crate_unfolded");
    if (level flag::get(#"dark_aether_active") && level flag::get("player_got_the_fuse")) {
        self sethintstring(#"hash_f829dbd87edb790");
        return true;
    }
    return false;
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x2c0cc26a, Offset: 0x3220
// Size: 0x1d4
function function_312cd4cd() {
    var_fcb6d06e = getent("ww_plasma_fuse_box", "script_noteworthy");
    var_11a6696e = spawn("trigger_damage", var_fcb6d06e.origin, 0, 96, 96);
    while (true) {
        waitresult = var_11a6696e waittill(#"damage");
        if (isplayer(waitresult.attacker)) {
            if (isdefined(waitresult.weapon) && is_true(waitresult.weapon.isbulletweapon)) {
                break;
            }
        }
    }
    var_fcb6d06e clientfield::set("" + #"hash_3fc8d4cd56e4e9b0", 1);
    var_fcb6d06e scene::play(#"hash_6e29beca7d26695", var_fcb6d06e);
    fuse = getent("ww_plasma_fuse", "script_noteworthy");
    fuse zm_unitrigger::function_fac87205(#"hash_6061e48d7ac6a4d6", (64, 64, 64));
    fuse delete();
    level flag::set("player_got_the_fuse");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xd9d784d4, Offset: 0x3400
// Size: 0x1c4
function function_d4647e9c() {
    level endon(#"game_ended");
    var_64b5a257 = getent(self.target, "targetname");
    var_64b5a257 solid();
    var_64b5a257 disconnectpaths();
    while (true) {
        level waittill(#"into_the_dark_side");
        if (!level flag::get("ww_plasma_dark_crate_unfolded")) {
            self hide();
            var_64b5a257 notsolid();
            var_64b5a257 connectpaths();
        }
        level waittill(#"dark_side_timeout", #"pap_quest_completed", #"hash_61e8a39b3a4bee6a");
        self show();
        var_64b5a257 solid();
        var_64b5a257 disconnectpaths();
        if (level flag::get("ww_plasma_dark_crate_unfolded")) {
            break;
        }
    }
    self thread function_8d9ddc22("PLASMA");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x69a4cad9, Offset: 0x35d0
// Size: 0x28c
function function_77fdf8f3() {
    level thread function_3ca2b2c1("ww_beam_dark_aether_tear", "ww_beam_crate_unfolded");
    callback::on_disconnect(&function_196740ae);
    level.var_a6639798 = getent("ww_beam_crate", "script_noteworthy");
    var_53ecb724 = getent(level.var_a6639798.target, "targetname");
    var_53ecb724 setinvisibletoall();
    for (n = 1; n <= 3; n++) {
        var_677810e4 = getentarray("ww_beam_crystal_" + n, "script_noteworthy");
        foreach (crystal in var_677810e4) {
            crystal hide();
        }
        var_9c7fd811 = var_677810e4[randomint(var_677810e4.size)];
        var_9c7fd811 flag::set("crystal_active");
        var_9c7fd811 thread function_d9046ad7(level.var_a6639798, n);
        var_9c7fd811 thread function_43073640(level.var_a6639798, n);
    }
    level flag::wait_till_all(array("receptacle_1_powered", "receptacle_2_powered", "receptacle_3_powered"));
    level flag::set("ww_beam_crate_unfolded");
    level.var_a6639798 thread function_8d9ddc22("BEAM");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x94034e64, Offset: 0x3868
// Size: 0xc8
function function_196740ae(b_delay) {
    if (self flag::get("hold_crystal_energy")) {
        self notify(#"hash_4035b9734da08f79");
        self clientfield::set("hold_crystal_energy", 0);
        if (is_true(b_delay)) {
            wait 1;
        }
        profilestart();
        if (isdefined(self)) {
            self flag::clear("hold_crystal_energy");
            if (isdefined(self.crystal)) {
                self.crystal.player = undefined;
                self.crystal = undefined;
            }
        }
        profilestop();
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x92f2c522, Offset: 0x3938
// Size: 0x1d0
function function_d9046ad7(*crate, num) {
    level endon(#"game_ended");
    while (true) {
        level waittill(#"into_the_dark_side");
        self show();
        do {
            if (!level flag::get("receptacle_" + num + "_powered")) {
                var_db089991 = getent(self.target, "targetname");
                var_45f8349d = self function_fbce146e(var_db089991);
                var_db089991 function_56aa61f0(0);
                if (is_true(var_45f8349d)) {
                    /#
                        iprintlnbold("<dev string:x13a>" + num + "<dev string:x146>");
                    #/
                    self flag::clear("crystal_active");
                    self thread function_6c729e(num);
                    self notify(#"hash_33fac1f6f3a6dcc");
                }
                self clientfield::set("crystal_energy_fx", 0);
            }
            waitframe(1);
        } while (level.var_ba3a0e1f > 0);
        self hide();
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x93c88cce, Offset: 0x3b10
// Size: 0x86
function function_56aa61f0(b_enable) {
    if (is_true(b_enable)) {
        self.var_22cea3da = &function_971d0ec8;
        self.var_37d2c8f6 = &function_ba51c33f;
        self.var_4ffc53f = &function_e0e08fa2;
        return;
    }
    self.var_22cea3da = undefined;
    self.var_37d2c8f6 = undefined;
    self.var_4ffc53f = undefined;
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xfc65d8a6, Offset: 0x3ba0
// Size: 0x140
function function_fbce146e(var_db089991) {
    level endon(#"dark_side_timeout", #"pap_quest_completed", #"hash_61e8a39b3a4bee6a");
    self flag::wait_till("crystal_active");
    self clientfield::set("crystal_energy_fx", 1);
    var_db089991 function_56aa61f0(1);
    waitresult = var_db089991 waittill(#"hash_33fac1f6f3a6dcc");
    self.player = waitresult.player;
    self.player.crystal = self;
    self.player flag::set("hold_crystal_energy");
    self.player clientfield::set("hold_crystal_energy", 1);
    self.player thread function_f5eebd57();
    return true;
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x1d494424, Offset: 0x3ce8
// Size: 0x13c
function function_f5eebd57() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    var_105682f = 0;
    while (true) {
        waitresult = self waittill(#"weapon_fired", #"weapon_change");
        if (waitresult._notify === "weapon_fired" && namespace_b376a999::function_7c292369(waitresult.weapon)) {
            var_105682f = 1;
            break;
        }
        if (waitresult._notify === "weapon_change" && !self hasweapon(getweapon(#"ww_ieu_shockwave_t9"), 1, 1)) {
            break;
        }
    }
    self function_196740ae(var_105682f);
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x3d5120e, Offset: 0x3e30
// Size: 0x74
function function_6c729e(num) {
    level endon(#"game_ended", "receptacle_" + num + "_powered");
    self.player waittill(#"hash_4035b9734da08f79");
    wait 30;
    self flag::set("crystal_active");
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x1 linked
// Checksum 0xc2af7a6e, Offset: 0x3eb0
// Size: 0x8c
function function_971d0ec8(player, time) {
    if (time >= 2000 && !player flag::get("hold_crystal_energy")) {
        self notify(#"hash_33fac1f6f3a6dcc", {#player:player});
        player clientfield::set("ww_vacuum_crystal_fx", 0);
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x364d22e, Offset: 0x3f48
// Size: 0x54
function function_ba51c33f(e_player, *n_start_time) {
    if (!n_start_time flag::get("hold_crystal_energy")) {
        n_start_time clientfield::set("ww_vacuum_crystal_fx", 1);
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x6438f7e4, Offset: 0x3fa8
// Size: 0x2c
function function_e0e08fa2(e_player) {
    e_player clientfield::set("ww_vacuum_crystal_fx", 0);
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x28e95a5, Offset: 0x3fe0
// Size: 0xdc
function function_43073640(crate, num) {
    level endon(#"game_ended");
    var_15f88bee = getent(crate.target, "targetname");
    t_damage = spawn("trigger_damage", crate.origin, 0, 64, 64);
    self function_746a64df(var_15f88bee, t_damage, num);
    var_15f88bee setinvisibletoall();
    t_damage delete();
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 3, eflags: 0x1 linked
// Checksum 0x319bb88c, Offset: 0x40c8
// Size: 0x118
function function_746a64df(var_15f88bee, t_damage, num) {
    level endon(#"game_ended", "receptacle_" + num + "_powered");
    while (true) {
        self waittill(#"hash_33fac1f6f3a6dcc");
        assert(isdefined(self.player));
        var_15f88bee setvisibletoplayer(self.player);
        var_15f88bee sethintstringforplayer(self.player, #"hash_9a36cd75f8acaee");
        t_damage thread function_ef55bb22(self, num);
        self.player waittill(#"hash_4035b9734da08f79");
        var_15f88bee setinvisibletoall();
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 2, eflags: 0x1 linked
// Checksum 0xa8f01286, Offset: 0x41e8
// Size: 0x15c
function function_ef55bb22(var_53f12789, num) {
    self notify("7fbd86af883672fd");
    self endon("7fbd86af883672fd");
    level endon(#"game_ended");
    while (true) {
        waitresult = self waittill(#"damage");
        if (waitresult.attacker === var_53f12789.player && waitresult.attacker flag::get("hold_crystal_energy")) {
            if (isdefined(waitresult.weapon) && namespace_b376a999::function_7c292369(waitresult.weapon) && !is_true(waitresult.var_98e101b0)) {
                break;
            }
        }
    }
    level flag::set("receptacle_" + num + "_powered");
    /#
        iprintlnbold("<dev string:x153>" + num + "<dev string:x162>");
    #/
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0xc9639393, Offset: 0x4350
// Size: 0x700
function function_8d9ddc22(var_e7772c37) {
    level endon(#"end_game");
    callback::on_weapon_change(&function_b8a1fcc2);
    switch (var_e7772c37) {
    case #"nitrogen":
        var_6bdde8a3 = getweapon(#"ww_ieu_acid_t9");
        self zm_unitrigger::create(&function_91807eb1, (128, 128, 128));
        self.var_37023f0e = "base";
        break;
    case #"gas":
        var_6bdde8a3 = getweapon(#"ww_ieu_gas_t9");
        self zm_unitrigger::create(&function_4d97eda3, (128, 128, 128));
        self.var_37023f0e = "base";
        break;
    case #"plasma":
        var_6bdde8a3 = getweapon(#"ww_ieu_plasma_t9");
        self zm_unitrigger::create(&function_b75d50b5, (128, 128, 128));
        self.var_37023f0e = "rust";
        break;
    case #"beam":
        var_6bdde8a3 = getweapon(#"ww_ieu_electric_t9");
        self zm_unitrigger::create(&function_8a172c28, (128, 128, 128));
        self.var_37023f0e = "electric";
        break;
    }
    while (true) {
        waitresult = self waittill(#"trigger_activated");
        player = waitresult.e_who;
        var_1cfeb1ae = self gettagorigin("tag_tank");
        var_9e88496a = self gettagangles("tag_tank");
        if (player hasweapon(var_6bdde8a3, 1)) {
            var_2faa8624 = util::spawn_model(#"hash_9549d4549a59df5", var_1cfeb1ae, var_9e88496a);
        } else {
            switch (var_e7772c37) {
            case #"nitrogen":
                var_2faa8624 = util::spawn_model(#"hash_4a6d2f6f49885950", var_1cfeb1ae, var_9e88496a);
                break;
            case #"gas":
                var_2faa8624 = util::spawn_model(#"hash_2a78ff7b18517c52", var_1cfeb1ae, var_9e88496a);
                break;
            case #"plasma":
                var_2faa8624 = util::spawn_model(#"hash_9549d4549a59df5", var_1cfeb1ae, var_9e88496a);
                break;
            case #"beam":
                var_2faa8624 = util::spawn_model(#"hash_65d816e81ae7ddbb", var_1cfeb1ae, var_9e88496a);
                break;
            }
        }
        var_2faa8624 setscale(1.5);
        var_2faa8624 linkto(self, "tag_tank", (0, 0, 0), (-28, 0, 0));
        self scene::play(#"hash_340eb7e983e34e72" + self.var_37023f0e + "_open_bundle", self);
        wait 1;
        if (isplayer(player)) {
            primaryweapon = player namespace_a0d533d1::function_2b83d3ff(player item_inventory::function_2e711614(17 + 1));
            secondaryweapon = player namespace_a0d533d1::function_2b83d3ff(player item_inventory::function_2e711614(17 + 1 + 8 + 1));
            if (namespace_b376a999::function_5fef4201(primaryweapon)) {
                player zm_weapons::weapon_take(primaryweapon);
                var_30e8f559 = primaryweapon;
            } else {
                player zm_weapons::weapon_take(secondaryweapon);
                var_30e8f559 = secondaryweapon;
            }
            if (zm_weapons::function_386dacbc(var_30e8f559) != var_6bdde8a3) {
                player zm_weapons::weapon_give(var_6bdde8a3);
            } else {
                switch (var_e7772c37) {
                case #"nitrogen":
                    level.var_c3accf46 = undefined;
                    break;
                case #"gas":
                    level.var_ae002b60 = undefined;
                    break;
                case #"plasma":
                    level.var_42000fd0 = undefined;
                    break;
                case #"beam":
                    level.var_c8a2dc28 = undefined;
                    break;
                }
                player zm_weapons::weapon_give(getweapon(#"ww_ieu_shockwave_t9"));
            }
            var_2faa8624 delete();
        }
        self scene::play(#"hash_340eb7e983e34e72" + self.var_37023f0e + "_close_bundle", self);
        if (isdefined(var_2faa8624)) {
            var_2faa8624 delete();
        }
    }
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x8aff0bed, Offset: 0x4a58
// Size: 0x408
function function_b8a1fcc2() {
    all_players = getplayers();
    foreach (player in all_players) {
        if (player hasweapon(getweapon(#"ww_ieu_shockwave_t9"), 1)) {
            level.var_181060cf = player;
        }
        if (player hasweapon(getweapon(#"ww_ieu_acid_t9"), 1)) {
            level.var_c3accf46 = player;
        }
        if (player hasweapon(getweapon(#"ww_ieu_gas_t9"), 1)) {
            level.var_ae002b60 = player;
        }
        if (player hasweapon(getweapon(#"ww_ieu_plasma_t9"), 1)) {
            level.var_42000fd0 = player;
        }
        if (player hasweapon(getweapon(#"ww_ieu_electric_t9"), 1)) {
            level.var_c8a2dc28 = player;
        }
    }
    if (isdefined(level.var_181060cf)) {
        if (!level.var_181060cf hasweapon(getweapon(#"ww_ieu_shockwave_t9"), 1)) {
            level.var_181060cf = undefined;
        }
    }
    if (isdefined(level.var_c3accf46)) {
        if (!level.var_c3accf46 hasweapon(getweapon(#"ww_ieu_acid_t9"), 1)) {
            level.var_c3accf46 = undefined;
        }
    }
    if (isdefined(level.var_ae002b60)) {
        if (!level.var_ae002b60 hasweapon(getweapon(#"ww_ieu_gas_t9"), 1)) {
            level.var_ae002b60 = undefined;
        }
    }
    if (isdefined(level.var_42000fd0)) {
        if (!level.var_42000fd0 hasweapon(getweapon(#"ww_ieu_plasma_t9"), 1)) {
            level.var_42000fd0 = undefined;
        }
    }
    if (isdefined(level.var_c8a2dc28)) {
        if (!level.var_c8a2dc28 hasweapon(getweapon(#"ww_ieu_electric_t9"), 1)) {
            level.var_c8a2dc28 = undefined;
        }
    }
    level.var_5afc47ea = [level.var_c3accf46, level.var_ae002b60, level.var_42000fd0, level.var_c8a2dc28];
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x2737738a, Offset: 0x4e68
// Size: 0x152
function function_91807eb1(e_player) {
    if (!isdefined(level.var_c3accf46) && (e_player hasweapon(level.var_652bc5ed, 1) || e_player hasweapon(level.var_fb37bf51, 1) || e_player hasweapon(level.var_12b450dc, 1) || e_player hasweapon(level.var_e0be56c0, 1))) {
        self sethintstringforplayer(e_player, #"hash_23ffe27517c6140c");
        return 1;
    }
    if (isdefined(level.var_c3accf46) && e_player == level.var_c3accf46) {
        self sethintstringforplayer(e_player, #"hash_4425ec8a1a0dcd32");
        return 1;
    }
    return 0;
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x46b101e7, Offset: 0x4fc8
// Size: 0x152
function function_4d97eda3(e_player) {
    if (!isdefined(level.var_ae002b60) && (e_player hasweapon(level.var_652bc5ed, 1) || e_player hasweapon(level.var_810eda2b, 1) || e_player hasweapon(level.var_12b450dc, 1) || e_player hasweapon(level.var_e0be56c0, 1))) {
        self sethintstringforplayer(e_player, #"hash_1f88bf6da4e314");
        return 1;
    }
    if (isdefined(level.var_ae002b60) && e_player == level.var_ae002b60) {
        self sethintstringforplayer(e_player, #"hash_4425ec8a1a0dcd32");
        return 1;
    }
    return 0;
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x799084e1, Offset: 0x5128
// Size: 0x152
function function_b75d50b5(e_player) {
    if (!isdefined(level.var_42000fd0) && (e_player hasweapon(level.var_652bc5ed, 1) || e_player hasweapon(level.var_fb37bf51, 1) || e_player hasweapon(level.var_810eda2b, 1) || e_player hasweapon(level.var_e0be56c0, 1))) {
        self sethintstringforplayer(e_player, #"hash_3122d671887ef5a5");
        return 1;
    }
    if (isdefined(level.var_42000fd0) && e_player == level.var_42000fd0) {
        self sethintstringforplayer(e_player, #"hash_4425ec8a1a0dcd32");
        return 1;
    }
    return 0;
}

// Namespace zm_silver_ww_quest/zm_silver_ww_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x8c291ad3, Offset: 0x5288
// Size: 0x152
function function_8a172c28(e_player) {
    if (!isdefined(level.var_c8a2dc28) && (e_player hasweapon(level.var_652bc5ed, 1) || e_player hasweapon(level.var_fb37bf51, 1) || e_player hasweapon(level.var_12b450dc, 1) || e_player hasweapon(level.var_810eda2b, 1))) {
        self sethintstringforplayer(e_player, #"hash_448d0fa028c30675");
        return 1;
    }
    if (isdefined(level.var_c8a2dc28) && e_player == level.var_c8a2dc28) {
        self sethintstringforplayer(e_player, #"hash_4425ec8a1a0dcd32");
        return 1;
    }
    return 0;
}

/#

    // Namespace zm_silver_ww_quest/zm_silver_ww_quest
    // Params 0, eflags: 0x4
    // Checksum 0xc8b664fa, Offset: 0x53e8
    // Size: 0x44
    function private function_233ed9b4() {
        level flag::wait_till("<dev string:x16e>");
        zm_devgui::add_custom_devgui_callback(&function_98af2074);
    }

    // Namespace zm_silver_ww_quest/zm_silver_ww_quest
    // Params 1, eflags: 0x4
    // Checksum 0x6f2e6c80, Offset: 0x5438
    // Size: 0x1ca
    function private function_98af2074(cmd) {
        switch (cmd) {
        case #"hash_58dc6f7eb86ecf83":
            level.var_a1b709cb thread function_8d9ddc22("<dev string:x18a>");
            break;
        case #"hash_45e13a127a63e1f5":
            level.var_74ec088f thread function_8d9ddc22("<dev string:x196>");
            break;
        case #"hash_42477421da15ff00":
            level.var_267fe17e thread function_8d9ddc22("<dev string:x19d>");
            break;
        case #"hash_1c88a4f3e72d4479":
            level.var_a6639798 thread function_8d9ddc22("<dev string:x1a7>");
            namespace_4abf1500::function_23255935("<dev string:x1af>");
            ww_room_door = getent("<dev string:x1c4>", "<dev string:x1d4>");
            var_a0f325fa = getent(ww_room_door.target, "<dev string:x1e9>");
            if (isdefined(ww_room_door)) {
                ww_room_door scene::play(#"hash_65505ba29fee0a2f", ww_room_door);
            }
            if (isdefined(var_a0f325fa)) {
                var_a0f325fa delete();
            }
            break;
        default:
            break;
        }
    }

#/
