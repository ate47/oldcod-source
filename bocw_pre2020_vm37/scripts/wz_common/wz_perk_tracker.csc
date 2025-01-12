#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace wz_perk_tracker;

// Namespace wz_perk_tracker/wz_perk_tracker
// Params 0, eflags: 0x6
// Checksum 0x183626b8, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_perk_tracker", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace wz_perk_tracker/wz_perk_tracker
// Params 0, eflags: 0x5 linked
// Checksum 0x2220f7e8, Offset: 0xd0
// Size: 0x5c
function private function_70a657d8() {
    if (is_true(getgametypesetting(#"hash_1d02e28ba907a343"))) {
        return;
    }
    callback::on_localclient_connect(&on_player_connect);
}

// Namespace wz_perk_tracker/wz_perk_tracker
// Params 1, eflags: 0x1 linked
// Checksum 0xdbf145ba, Offset: 0x138
// Size: 0x24
function on_player_connect(localclientnum) {
    level thread tracker(localclientnum);
}

// Namespace wz_perk_tracker/wz_perk_tracker
// Params 1, eflags: 0x1 linked
// Checksum 0x6fa30211, Offset: 0x168
// Size: 0x20a
function tracker(localclientnum) {
    while (true) {
        wait 0.2;
        if (!function_5778f82(localclientnum, #"specialty_tracker")) {
            continue;
        }
        origin = getlocalclientpos(localclientnum);
        players = getplayers(localclientnum);
        players = arraysortclosest(players, origin, undefined, 1, 6000);
        tracked = 0;
        foreach (player in players) {
            if (tracked >= 10 || !isalive(player) || player function_ca024039() || isdefined(getplayervehicle(player)) || player hasperk(localclientnum, "specialty_spycraft")) {
                player.tracker_last_pos = undefined;
                continue;
            }
            tracked++;
            if (!isdefined(player.tracker_last_pos)) {
                player.tracker_last_pos = player.origin;
            }
            positionandrotationstruct = player gettrackerfxposition(localclientnum);
            if (isdefined(positionandrotationstruct)) {
                player tracker_playfx(localclientnum, positionandrotationstruct);
            }
        }
        players = undefined;
    }
}

// Namespace wz_perk_tracker/wz_perk_tracker
// Params 1, eflags: 0x1 linked
// Checksum 0x419de9b4, Offset: 0x380
// Size: 0x26e
function gettrackerfxposition(*localclientnum) {
    positionandrotation = undefined;
    offset = (0, 0, getdvarfloat(#"perk_tracker_fx_foot_height", 0));
    dist2 = 1024;
    if (is_true(self.trailrightfoot)) {
        fx = #"player/fx9_perk_tracker_footstep_rgt";
    } else {
        fx = #"player/fx9_perk_tracker_footstep_lft";
    }
    pos = self.origin + offset;
    fwd = anglestoforward(self.angles);
    right = anglestoright(self.angles);
    up = anglestoup(self.angles);
    vel = self getvelocity();
    if (lengthsquared(vel) > 1) {
        up = vectorcross(vel, right);
        if (lengthsquared(up) < 0.0001) {
            up = vectorcross(fwd, vel);
        }
        fwd = vel;
    }
    if (distancesquared(self.tracker_last_pos, pos) > dist2) {
        positionandrotation = spawnstruct();
        positionandrotation.fx = fx;
        positionandrotation.pos = pos;
        positionandrotation.fwd = fwd;
        positionandrotation.up = up;
        self.tracker_last_pos = self.origin;
        if (is_true(self.trailrightfoot)) {
            self.trailrightfoot = 0;
        } else {
            self.trailrightfoot = 1;
        }
    }
    return positionandrotation;
}

// Namespace wz_perk_tracker/wz_perk_tracker
// Params 2, eflags: 0x1 linked
// Checksum 0xf9cf7bc5, Offset: 0x5f8
// Size: 0x56
function tracker_playfx(localclientnum, positionandrotationstruct) {
    handle = playfx(localclientnum, positionandrotationstruct.fx, positionandrotationstruct.pos, positionandrotationstruct.fwd, positionandrotationstruct.up);
}

