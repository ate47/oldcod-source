#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace namespace_36694555;

// Namespace namespace_36694555/namespace_36694555
// Params 0, eflags: 0x2
// Checksum 0x856388e8, Offset: 0x200
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("sensor_arrow", &init_shared, undefined, undefined);
}

// Namespace namespace_36694555/namespace_36694555
// Params 1, eflags: 0x0
// Checksum 0xfcbda951, Offset: 0x240
// Size: 0x114
function init_shared(localclientnum) {
    clientfield::register("missile", "sensor_arrow_state", 1, 1, "int", &function_5551eab6, 0, 1);
    callback::on_localclient_connect(&player_init);
    callback::add_weapon_type("sig_bow_sensor", &arrow_spawned);
    callback::add_weapon_type("sig_bow_sensor2", &arrow_spawned);
    callback::add_weapon_type("sig_bow_sensor3", &arrow_spawned);
    callback::add_weapon_type("sig_bow_sensor4", &arrow_spawned);
}

// Namespace namespace_36694555/namespace_36694555
// Params 1, eflags: 0x0
// Checksum 0xe981401f, Offset: 0x360
// Size: 0x1c
function arrow_spawned(localclientnum) {
    self.var_519dd23d = 1;
}

// Namespace namespace_36694555/namespace_36694555
// Params 1, eflags: 0x0
// Checksum 0xfccf950e, Offset: 0x388
// Size: 0x24
function player_init(localclientnum) {
    self thread on_game_ended(localclientnum);
}

// Namespace namespace_36694555/namespace_36694555
// Params 7, eflags: 0x4
// Checksum 0xd561756a, Offset: 0x3b8
// Size: 0x126
function private function_5551eab6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    switch (newval) {
    case 0:
    default:
        self disablevisioncircle(localclientnum);
        break;
    case 1:
        self enablevisioncircle(localclientnum, 500);
        self thread function_fb404fbf(localclientnum);
        self setcompassicon("compass_hk");
        self hideunseencompassicon();
        break;
    }
}

// Namespace namespace_36694555/namespace_36694555
// Params 1, eflags: 0x4
// Checksum 0x89a18e85, Offset: 0x4e8
// Size: 0x5c
function private function_fb404fbf(localclientnum) {
    var_e14cea2 = self getentitynumber();
    self waittill("death");
    disablevisioncirclebyentnum(localclientnum, var_e14cea2);
}

// Namespace namespace_36694555/namespace_36694555
// Params 1, eflags: 0x4
// Checksum 0x9cc15f05, Offset: 0x550
// Size: 0x34
function private on_game_ended(localclientnum) {
    level waittill("game_ended");
    disableallvisioncircles(localclientnum);
}

