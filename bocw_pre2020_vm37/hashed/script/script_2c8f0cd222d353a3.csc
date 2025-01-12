#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace namespace_daf1661f;

// Namespace namespace_daf1661f/namespace_daf1661f
// Params 0, eflags: 0x1 linked
// Checksum 0x46088e79, Offset: 0x70
// Size: 0x24
function init() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace namespace_daf1661f/namespace_daf1661f
// Params 1, eflags: 0x1 linked
// Checksum 0x768ee768, Offset: 0xa0
// Size: 0x2c
function on_player_spawned(*local_client_num) {
    level callback::function_6231c19(&on_weapon_change);
}

// Namespace namespace_daf1661f/namespace_daf1661f
// Params 1, eflags: 0x1 linked
// Checksum 0xaa86bbe2, Offset: 0xd8
// Size: 0xb4
function on_weapon_change(params) {
    if (params.weapon.name == #"none") {
        return;
    }
    if (isstruct(self)) {
        return;
    }
    if (!self function_da43934d() || !isplayer(self) || !isalive(self)) {
        return;
    }
    function_fad60cb1(params.localclientnum, params.weapon);
}

