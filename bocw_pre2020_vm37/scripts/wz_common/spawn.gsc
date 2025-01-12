#using script_1d29de500c266470;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\match_record;
#using scripts\core_common\player\player_free_fall;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\mp_common\gametypes\spawning;

#namespace spawn;

// Namespace spawn/spawn
// Params 1, eflags: 0x0
// Checksum 0x29945d82, Offset: 0x178
// Size: 0x1c4
function function_f468d9a5(spawnpoint) {
    distance = getdvarfloat(#"hash_69b296d9dc607a9a", 4350);
    height = getdvarfloat(#"hash_73c6222ce96fa34a", 5000);
    velocity = getdvarfloat(#"hash_ae6b05a24ae0d2a", 1760);
    dir = anglestoforward(spawnpoint.angles);
    pos = spawnpoint.origin - dir * distance;
    hold_origin = (pos[0], pos[1], spawnpoint.origin[2] + height);
    hold_angles = vectortoangles(vectornormalize(spawnpoint.origin - pos));
    vec = anglestoforward(hold_angles);
    vec = vectornormalize(vec);
    vec *= velocity;
    return {#origin:hold_origin, #angles:hold_angles, #freefall:vec};
}

// Namespace spawn/spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x7d907e29, Offset: 0x348
// Size: 0x3a8
function function_e93291ff() {
    if (isdefined(level.var_1710ced9)) {
        destinations = [[ level.var_1710ced9 ]]();
    } else {
        destinations = struct::get_array("destination_influencer");
    }
    if (destinations.size <= 0) {
        return;
    }
    destinations = arraysortclosest(destinations, (0, 0, 0));
    for (destindex = 0; destindex < destinations.size; destindex++) {
        destinations[destindex].globalindex = destindex;
    }
    level.var_7767cea8 = [];
    /#
        if (getdvarint(#"hash_270a21a654a1a79f", 0)) {
            level.var_94cbd997 = [];
            foreach (destination in destinations) {
                level.var_94cbd997 = arraycombine(level.var_94cbd997, struct::get_array(destination.target, "<dev string:x38>"), 0, 0);
            }
        }
    #/
    var_137456fd = getdvarint(#"wz_dest_id", -1);
    if (var_137456fd >= 0 && var_137456fd < destinations.size) {
        level.var_7767cea8[0] = destinations[var_137456fd];
        arrayremoveindex(destinations, var_137456fd);
    } else {
        while (destinations.size > 0 && level.var_7767cea8.size < 5) {
            destindex = randomint(destinations.size);
            level.var_7767cea8[level.var_7767cea8.size] = destinations[destindex];
            arrayremoveindex(destinations, destindex);
        }
    }
    foreach (dest in level.var_7767cea8) {
        dest.spawns = struct::get_array(dest.target, "targetname");
    }
    foreach (dest in destinations) {
        function_3b1d0553(dest);
    }
}

// Namespace spawn/spawn
// Params 0, eflags: 0x1 linked
// Checksum 0xca058e11, Offset: 0x6f8
// Size: 0x98
function function_cb5864fc() {
    if (isdefined(level.var_7767cea8)) {
        foreach (dest in level.var_7767cea8) {
            function_3b1d0553(dest);
        }
    }
}

// Namespace spawn/spawn
// Params 1, eflags: 0x1 linked
// Checksum 0xd1f2c462, Offset: 0x798
// Size: 0x10c
function on_spawn_player(predictedspawn) {
    self.usingobj = undefined;
    if (!isdefined(self.var_63af7f75)) {
        self.var_63af7f75 = -1;
    }
    if (isdefined(level.deathcircleindex)) {
        self.var_63af7f75 = level.deathcircleindex;
    }
    self.var_c5134737 = 0;
    spawnstruct = spawning::onspawnplayer(predictedspawn);
    if (level.ingraceperiod) {
        self.startspawn = spawnstruct;
    }
    if (self.pers[#"spawns"] == 1) {
        if (level.var_f2814a96 === 0) {
            self thread function_c263fd97();
        } else {
            self function_8cef1872();
        }
    }
    self function_ea62f5af();
}

// Namespace spawn/spawn
// Params 0, eflags: 0x1 linked
// Checksum 0x9d981cfd, Offset: 0x8b0
// Size: 0x13c
function function_ea62f5af() {
    var_a56604c5 = namespace_eb06e24d::get_parachute_kit().lootid;
    var_c9b1d229 = namespace_eb06e24d::function_4a39b434().lootid;
    var_42b02106 = namespace_eb06e24d::get_wingsuit_kit().lootid;
    var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
    if (isdefined(var_f8e6b703)) {
        self match_record::set_stat(#"lives", var_f8e6b703, #"hash_4f557c87c0538129", var_a56604c5);
        self match_record::set_stat(#"lives", var_f8e6b703, #"hash_4b4bd85ab964d386", var_c9b1d229);
        self match_record::set_stat(#"lives", var_f8e6b703, #"hash_63862160f8335af2", var_42b02106);
    }
}

// Namespace spawn/spawn
// Params 0, eflags: 0x1 linked
// Checksum 0xac9f2a94, Offset: 0x9f8
// Size: 0x94
function function_8cef1872() {
    self clientfield::set_player_uimodel("hudItems.wzLoadFinished", 1);
    self clientfield::set_player_uimodel("hudItems.streamerLoadFraction", 1);
    self val::reset(#"hash_5bb0dd6b277fc20c", "freezecontrols");
    self val::reset(#"hash_5bb0dd6b277fc20c", "disablegadgets");
}

// Namespace spawn/spawn
// Params 0, eflags: 0x5 linked
// Checksum 0xebcb31ad, Offset: 0xa98
// Size: 0x42c
function private function_c263fd97() {
    level endon(#"start_warzone");
    self endon(#"disconnect");
    self ghost();
    self notsolid();
    self val::set(#"hash_5bb0dd6b277fc20c", "freezecontrols", 1);
    self val::set(#"hash_5bb0dd6b277fc20c", "disablegadgets", 1);
    var_80e2abb1 = getdvarfloat(#"hash_78198bd3a356f650", 0.5);
    starttime = gettime();
    var_ffa47239 = getdvarint(#"hash_24ce936622303dc1", 4000);
    var_2ee361bf = getdvarint(#"hash_6e24885f4fa8a2a2", 10000);
    println("<dev string:x46>");
    while (gettime() < starttime + var_ffa47239) {
        wait 0.5;
        now = gettime();
        self clientfield::set_player_uimodel("hudItems.streamerLoadFraction", (now - starttime) / (var_ffa47239 + var_2ee361bf));
    }
    println("<dev string:x69>");
    var_4fcc3493 = starttime + var_ffa47239 + var_2ee361bf;
    var_8cd82180 = getdvarint(#"hash_723f28907e9e4cd0", 3);
    var_45d7d746 = 0;
    while (true) {
        wait 0.5;
        now = gettime();
        self clientfield::set_player_uimodel("hudItems.streamerLoadFraction", (now - starttime) / (var_ffa47239 + var_2ee361bf));
        if (now > var_4fcc3493) {
            println("<dev string:x84>");
            break;
        }
        stability = 1;
        if (isdefined(self.var_72d32640)) {
            stability = self.var_72d32640;
        }
        if (self isstreamerready() && stability > var_80e2abb1) {
            var_45d7d746++;
        } else {
            var_45d7d746 = 0;
        }
        println("<dev string:x96>" + var_45d7d746);
        if (var_45d7d746 >= var_8cd82180) {
            println("<dev string:xae>");
            break;
        }
    }
    self function_8cef1872();
    self show();
    self solid();
    if (game.state == "pregame") {
        if (isdefined(level.var_fd167bf6)) {
            self luinotifyevent(#"create_prematch_timer", 2, level.var_fd167bf6, level.var_5654073f);
            return;
        }
        self luinotifyevent(#"hash_2a9f7ecda8e925f6", 0);
    }
}

// Namespace spawn/spawn
// Params 1, eflags: 0x1 linked
// Checksum 0x89035b80, Offset: 0xed0
// Size: 0xcc
function function_3b1d0553(dest) {
    targets = struct::get_array(dest.target, "targetname");
    foreach (target in targets) {
        target struct::delete();
    }
    dest struct::delete();
}

// Namespace spawn/spawn
// Params 1, eflags: 0x1 linked
// Checksum 0xd74690ad, Offset: 0xfa8
// Size: 0x64
function function_1390f875(*num_lives) {
    var_c6328f73 = self.pers[#"lives"] - 1;
    if (var_c6328f73 < 0) {
        var_c6328f73 = 0;
    }
    self clientfield::set_player_uimodel("hudItems.playerLivesRemaining", var_c6328f73);
}

