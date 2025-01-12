#using scripts/core_common/audio_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace tacticalinsertion;

// Namespace tacticalinsertion/tacticalinsertion
// Params 0, eflags: 0x0
// Checksum 0xb4272b26, Offset: 0x228
// Size: 0x21c
function init_shared() {
    level._effect["tacticalInsertionFriendly"] = "_t6/misc/fx_equip_tac_insert_light_grn";
    level._effect["tacticalInsertionEnemy"] = "_t6/misc/fx_equip_tac_insert_light_red";
    clientfield::register("scriptmover", "tacticalinsertion", 1, 1, "int", &spawned, 0, 0);
    latlongstruct = struct::get("lat_long", "targetname");
    if (isdefined(latlongstruct)) {
        mapx = latlongstruct.origin[0];
        mapy = latlongstruct.origin[1];
        lat = latlongstruct.script_vector[0];
        long = latlongstruct.script_vector[1];
    } else {
        if (isdefined(level.worldmapx) && isdefined(level.worldmapy)) {
            mapx = level.worldmapx;
            mapy = level.worldmapy;
        } else {
            mapx = 0;
            mapy = 0;
        }
        if (isdefined(level.worldlat) && isdefined(level.worldlong)) {
            lat = level.worldlat;
            long = level.worldlong;
        } else {
            lat = 34.0216;
            long = -118.449;
        }
    }
    setmaplatlong(mapx, mapy, long, lat);
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 7, eflags: 0x0
// Checksum 0xe87053a9, Offset: 0x450
// Size: 0x74
function spawned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self thread playflarefx(localclientnum);
    self thread checkforplayerswitch(localclientnum);
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 1, eflags: 0x0
// Checksum 0x120a7079, Offset: 0x4d0
// Size: 0x12c
function playflarefx(localclientnum) {
    self endon(#"death");
    level endon(#"player_switch");
    if (util::function_f36b8920(localclientnum)) {
        self.tacticalinsertionfx = playfxontag(localclientnum, level._effect["tacticalInsertionFriendly"], self, "tag_flash");
    } else {
        self.tacticalinsertionfx = playfxontag(localclientnum, level._effect["tacticalInsertionEnemy"], self, "tag_flash");
    }
    self thread watchtacinsertshutdown(localclientnum, self.tacticalinsertionfx);
    looporigin = self.origin;
    audio::playloopat("fly_tinsert_beep", looporigin);
    self thread stopflareloopwatcher(looporigin);
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 2, eflags: 0x0
// Checksum 0x8c3cffa5, Offset: 0x608
// Size: 0x3c
function watchtacinsertshutdown(localclientnum, fxhandle) {
    self waittill("death");
    stopfx(localclientnum, fxhandle);
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 1, eflags: 0x0
// Checksum 0xc03f6050, Offset: 0x650
// Size: 0x5c
function stopflareloopwatcher(looporigin) {
    while (true) {
        if (!isdefined(self) || !isdefined(self.tacticalinsertionfx)) {
            audio::stoploopat("fly_tinsert_beep", looporigin);
            break;
        }
        wait 0.5;
    }
}

// Namespace tacticalinsertion/tacticalinsertion
// Params 1, eflags: 0x0
// Checksum 0xf0f5dd77, Offset: 0x6b8
// Size: 0x88
function checkforplayerswitch(localclientnum) {
    self endon(#"death");
    while (true) {
        level waittill("player_switch");
        if (isdefined(self.tacticalinsertionfx)) {
            stopfx(localclientnum, self.tacticalinsertionfx);
            self.tacticalinsertionfx = undefined;
        }
        waittillframeend();
        self thread playflarefx(localclientnum);
    }
}

