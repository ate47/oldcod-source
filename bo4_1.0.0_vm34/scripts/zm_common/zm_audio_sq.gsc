#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_sq;

#namespace zm_audio_sq;

// Namespace zm_audio_sq/zm_audio_sq
// Params 0, eflags: 0x0
// Checksum 0x4e4c9afa, Offset: 0xb8
// Size: 0xbc
function init() {
    clientfield::register("scriptmover", "medallion_fx", 1, 1, "int");
    zm_sq::register(#"music_sq", #"first_location", #"hash_3531cfab5aa57f4b", &function_69cce269, &function_69c0d882);
    zm_sq::start(#"music_sq", 1);
}

// Namespace zm_audio_sq/zm_audio_sq
// Params 1, eflags: 0x4
// Checksum 0xf9807115, Offset: 0x180
// Size: 0x74
function private function_69cce269(var_4df52d26) {
    level endon(#"end_game");
    if (!isdefined(level.var_79f8907c)) {
        level.var_79f8907c = 0;
    }
    level.var_79f8907c++;
    if (!var_4df52d26) {
        function_f04e04bb();
        function_90e5fdf9();
    }
}

// Namespace zm_audio_sq/zm_audio_sq
// Params 2, eflags: 0x4
// Checksum 0xe66befb, Offset: 0x200
// Size: 0x34
function private function_69c0d882(var_4df52d26, var_c86ff890) {
    if (!var_4df52d26) {
        if (var_c86ff890) {
            music_sq_cleanup();
        }
    }
}

// Namespace zm_audio_sq/zm_audio_sq
// Params 0, eflags: 0x0
// Checksum 0x5324e880, Offset: 0x240
// Size: 0xa
function function_90e5fdf9() {
    wait 10;
}

// Namespace zm_audio_sq/zm_audio_sq
// Params 0, eflags: 0x0
// Checksum 0xefd02ed6, Offset: 0x258
// Size: 0x128
function function_f04e04bb() {
    var_6806772c = 0;
    var_481580e2 = struct::get_array(#"s_music_sq_location", "targetname");
    foreach (s_music_sq_location in var_481580e2) {
        if (isdefined(s_music_sq_location.script_int) && s_music_sq_location.script_int == level.var_79f8907c) {
            s_music_sq_location thread function_651501d5();
            util::wait_network_frame();
        }
    }
    while (true) {
        level waittill(#"hash_71162ec98b670d92");
        var_6806772c++;
        if (var_6806772c >= 4) {
            break;
        }
    }
}

// Namespace zm_audio_sq/zm_audio_sq
// Params 0, eflags: 0x0
// Checksum 0x1da1b6bc, Offset: 0x388
// Size: 0x176
function function_651501d5() {
    self.var_52546060 = util::spawn_model(self.model, self.origin, self.angles);
    self.var_52546060 setcandamage(1);
    self.var_52546060.health = 1000000;
    while (true) {
        waitresult = self.var_52546060 waittill(#"damage");
        if (!isdefined(waitresult.attacker) || !isplayer(waitresult.attacker)) {
            continue;
        }
        waitresult.attacker playsoundtoplayer(#"hash_3ffdc84cf43cae2b", waitresult.attacker);
        level notify(#"hash_71162ec98b670d92");
        break;
    }
    self.var_52546060 clientfield::set("medallion_fx", 1);
    util::wait_network_frame();
    self.var_52546060 delete();
    self.var_52546060 = undefined;
}

// Namespace zm_audio_sq/zm_audio_sq
// Params 0, eflags: 0x0
// Checksum 0xa93f36fc, Offset: 0x508
// Size: 0xd0
function music_sq_cleanup() {
    var_481580e2 = struct::get_array(#"s_music_sq_location", "targetname");
    foreach (s_music_sq_location in var_481580e2) {
        if (isdefined(s_music_sq_location.var_52546060)) {
            s_music_sq_location.var_52546060 delete();
            util::wait_network_frame();
        }
    }
}

