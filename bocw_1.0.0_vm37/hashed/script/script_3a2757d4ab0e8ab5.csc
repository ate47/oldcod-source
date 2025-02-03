#using script_18910f59cc847b42;
#using script_1b2f6ef7778cf920;
#using script_582965dd053f648e;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\wz_common\hud;

#namespace brawl;

// Namespace brawl/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x69e343a0, Offset: 0xe8
// Size: 0x194
function event_handler[gametype_init] main(*eventstruct) {
    clientfield::function_5b7d846d("Brawl.prematchCountdown", #"hash_4f957dda4b1fb14d", #"hash_4d5a06fe6fb857de", 1, 6, "int", undefined, 0, 0);
    callback::on_spawned(&on_player_spawned);
    level.default_mapping = "brawl";
    level.var_fb0679ad = 1;
    function_1001f0ac();
    hud::function_9b9cecdf();
    setsaveddvar(#"enable_global_wind", 1);
    setsaveddvar(#"wind_global_vector", "88 0 0");
    setsaveddvar(#"wind_global_low_altitude", 0);
    setsaveddvar(#"wind_global_hi_altitude", 10000);
    setsaveddvar(#"wind_global_low_strength_percent", 100);
    util::waitforclient(0);
}

// Namespace brawl/brawl
// Params 0, eflags: 0x0
// Checksum 0x3a7d5095, Offset: 0x288
// Size: 0x1c
function function_1001f0ac() {
    level thread namespace_4dae815d::init();
}

// Namespace brawl/brawl
// Params 1, eflags: 0x0
// Checksum 0x37b63da8, Offset: 0x2b0
// Size: 0x166
function on_player_spawned(localclientnum) {
    self endon(#"death");
    if (self function_21c0fa55()) {
        level namespace_ac2a80f5::changecamera(localclientnum, self, 6);
    }
    self util::waittill_dobj(localclientnum);
    self playrenderoverridebundle(#"hash_7974d58ec2b1797e");
    while (true) {
        var_8b8faf32 = self getplayerarmor();
        maxarmor = self function_a07288ec();
        var_563bbb8e = 0;
        if (var_8b8faf32 > 0) {
            var_563bbb8e = 1;
        }
        self function_78233d29(#"hash_7974d58ec2b1797e", "", "Alpha", var_563bbb8e);
        self function_78233d29(#"hash_7974d58ec2b1797e", "", "Brightness", var_563bbb8e);
        waitframe(1);
    }
}

