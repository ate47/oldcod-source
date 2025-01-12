#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;

#namespace wz_array_broadcast;

// Namespace wz_array_broadcast/wz_array_broadcast
// Params 0, eflags: 0x2
// Checksum 0xd38c3220, Offset: 0x118
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_array_broadcast", &__init__, undefined, undefined);
}

// Namespace wz_array_broadcast/wz_array_broadcast
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x160
// Size: 0x4
function __init__() {
    
}

// Namespace wz_array_broadcast/event_57a8880c
// Params 1, eflags: 0x40
// Checksum 0x3408b6a4, Offset: 0x170
// Size: 0x1cc
function event_handler[event_57a8880c] function_565a245e(eventstruct) {
    if (eventstruct.ent.targetname === "array_broadcast") {
        if (eventstruct.state == 0) {
            eventstruct.ent thread broadcast_off();
            return;
        }
        exploder::exploder(#"fxexp_radar_activation");
        playsound(0, "evt_power_up", (4292, 18990, 6528));
        var_8ce003bd = struct::get_array("amb_local_alarm", "targetname");
        foreach (struct in var_8ce003bd) {
            struct thread function_83274488();
            waitframe(1);
        }
        wait 20;
        playsound(0, "evt_broadcast_alarm", (4292, 18990, 6528));
        wait 2;
        playsound(0, "evt_broadcast_alarm", (4292, 18990, 6528));
        eventstruct.ent thread function_e4679b3a(0);
    }
}

// Namespace wz_array_broadcast/wz_array_broadcast
// Params 0, eflags: 0x0
// Checksum 0xdc7cf7cb, Offset: 0x348
// Size: 0x1a0
function broadcast_off() {
    self notify(#"broadcast_off");
    var_5ad2c361 = struct::get_array("array_emergency_broadcast", "targetname");
    foreach (struct in var_5ad2c361) {
        audio::stoploopat(#"hash_39c8dfc4efa25b26", struct.origin);
    }
    exploder::kill_exploder("fxexp_radar_activation");
    foreach (struct in var_5ad2c361) {
        struct notify(#"broadcast_off");
        audio::stoploopat(#"hash_39c8dfc4efa25b26", struct.origin);
        if (isdefined(struct.var_ebbea10a)) {
            stopsound(struct.var_ebbea10a);
        }
    }
}

// Namespace wz_array_broadcast/wz_array_broadcast
// Params 1, eflags: 0x0
// Checksum 0xcfb72a8a, Offset: 0x4f0
// Size: 0x440
function function_e4679b3a(var_4d24a084 = 0) {
    var_5ad2c361 = struct::get_array("array_emergency_broadcast", "targetname");
    foreach (struct in var_5ad2c361) {
        if (var_4d24a084 == 0) {
            audio::playloopat(#"hash_39c8dfc4efa25b26", struct.origin);
        }
    }
    wait 30;
    self endon(#"broadcast_off");
    var_5ad2c361 = struct::get_array("array_emergency_broadcast", "targetname");
    foreach (struct in var_5ad2c361) {
        audio::playloopat(#"hash_39c8dfc4efa25b26", struct.origin);
    }
    wait 3;
    while (var_4d24a084 < 5) {
        foreach (struct in var_5ad2c361) {
            if (var_4d24a084 == 0) {
                struct.var_ebbea10a = playsound(0, #"hash_6ee08a10b9c18ba7", struct.origin);
                continue;
            }
            sound_id = var_4d24a084 - 1;
            sound_alias = #"hash_59821865a3dff39c" + sound_id;
            struct.var_ebbea10a = playsound(0, sound_alias, struct.origin);
        }
        var_c52a9024 = 0;
        while (!var_c52a9024) {
            var_b6e31fdb = 0;
            foreach (struct in var_5ad2c361) {
                if (isdefined(struct.var_ebbea10a) && soundplaying(struct.var_ebbea10a)) {
                    var_b6e31fdb = 1;
                    break;
                }
            }
            if (!var_b6e31fdb) {
                var_c52a9024 = 1;
            }
            wait 1;
        }
        wait 1;
        var_4d24a084++;
        struct.var_ebbea10a = playsound(0, #"hash_6ee08a10b9c18ba7", struct.origin);
    }
    wait 10;
    foreach (struct in var_5ad2c361) {
        audio::stoploopat(#"hash_39c8dfc4efa25b26", struct.origin);
    }
}

// Namespace wz_array_broadcast/wz_array_broadcast
// Params 0, eflags: 0x0
// Checksum 0x3b3be172, Offset: 0x938
// Size: 0x74
function function_83274488() {
    for (loopcount = 0; loopcount < 10; loopcount++) {
        wait randomintrange(1, 2);
        playsound(0, #"hash_7e2183e61d5335a8", self.origin);
        wait 3;
    }
}

