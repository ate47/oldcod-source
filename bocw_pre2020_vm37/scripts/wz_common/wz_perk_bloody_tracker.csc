#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace wz_perk_bloody_tracker;

// Namespace wz_perk_bloody_tracker/wz_perk_bloody_tracker
// Params 0, eflags: 0x6
// Checksum 0x29bf2f11, Offset: 0xc8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_perk_bloody_tracker", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace wz_perk_bloody_tracker/wz_perk_bloody_tracker
// Params 0, eflags: 0x4
// Checksum 0xe7c45502, Offset: 0x110
// Size: 0x5c
function private function_70a657d8() {
    if (!is_true(getgametypesetting(#"hash_1d02e28ba907a343"))) {
        return;
    }
    callback::on_localclient_connect(&on_player_connect);
}

// Namespace wz_perk_bloody_tracker/wz_perk_bloody_tracker
// Params 1, eflags: 0x0
// Checksum 0x11746868, Offset: 0x178
// Size: 0x24
function on_player_connect(localclientnum) {
    level thread bloody_tracker(localclientnum);
}

// Namespace wz_perk_bloody_tracker/wz_perk_bloody_tracker
// Params 1, eflags: 0x0
// Checksum 0x5e5ae0a8, Offset: 0x1a8
// Size: 0x1ea
function bloody_tracker(localclientnum) {
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
            if (tracked >= 10 || !isalive(player) || player function_ca024039() || isdefined(getplayervehicle(player))) {
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

// Namespace wz_perk_bloody_tracker/wz_perk_bloody_tracker
// Params 1, eflags: 0x0
// Checksum 0xa19733cf, Offset: 0x3a0
// Size: 0x2de
function gettrackerfxposition(*localclientnum) {
    positionandrotation = undefined;
    player = self;
    offset = (0, 0, 1);
    dist2 = 1024;
    if (is_true(self.trailrightfoot)) {
        fx = "player/fx8_plyr_footstep_tracker_blood_r";
    } else {
        fx = "player/fx8_plyr_footstep_tracker_blood_l";
    }
    pos = self.origin + offset;
    if (distancesquared(self.tracker_last_pos, pos) > dist2) {
        trace = physicstraceex(pos, pos + (0, 0, -10), (0, 0, 0), (0, 0, 0), self, 1);
        if (trace[#"fraction"] < 1) {
            up = trace[#"normal"];
            up = (0, 0, 0) - up;
            if (lengthsquared(up) <= 0) {
                return undefined;
            }
            fwd = anglestoforward(self.angles);
            vel = self getvelocity();
            if (lengthsquared(vel) > 1) {
                fwd = vel;
            }
            right = vectorcross(fwd, up);
            if (lengthsquared(right) <= 0) {
                return undefined;
            }
            fwd = vectorcross(up, right);
            pos = trace[#"position"] + trace[#"normal"];
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
    }
    return positionandrotation;
}

// Namespace wz_perk_bloody_tracker/wz_perk_bloody_tracker
// Params 2, eflags: 0x0
// Checksum 0x5c79a07e, Offset: 0x688
// Size: 0x56
function tracker_playfx(localclientnum, positionandrotationstruct) {
    handle = playfx(localclientnum, positionandrotationstruct.fx, positionandrotationstruct.pos, positionandrotationstruct.fwd, positionandrotationstruct.up);
}

