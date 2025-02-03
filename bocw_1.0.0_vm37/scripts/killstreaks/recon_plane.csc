#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace recon_plane;

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x6
// Checksum 0x148bf626, Offset: 0x118
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"recon_plane", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace recon_plane/recon_plane
// Params 0, eflags: 0x4
// Checksum 0x7c50d7cb, Offset: 0x168
// Size: 0x118
function private preinit() {
    clientfield::register("scriptmover", "recon_plane", 1, 1, "int", &function_1f842f91, 0, 0);
    clientfield::register("scriptmover", "recon_plane_reveal", 1, 1, "int", &recon_plane_reveal, 0, 0);
    callback::on_localclient_connect(&player_init);
    bundlename = "killstreak_recon_plane";
    if (sessionmodeiswarzonegame()) {
        bundlename += "_wz";
    }
    level.var_d9ef3e7c = getscriptbundle(bundlename);
    level.var_d84f0c02 = [];
}

// Namespace recon_plane/recon_plane
// Params 1, eflags: 0x0
// Checksum 0xd547e8ae, Offset: 0x288
// Size: 0x24
function player_init(localclientnum) {
    self thread on_game_ended(localclientnum);
}

// Namespace recon_plane/recon_plane
// Params 7, eflags: 0x0
// Checksum 0x411b2dfb, Offset: 0x2b8
// Size: 0x1e4
function function_1f842f91(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    if (!isdefined(self.killstreakbundle)) {
        self.killstreakbundle = level.var_d9ef3e7c;
    }
    self util::waittill_dobj(fieldname);
    if (!isdefined(self)) {
        return;
    }
    self function_8e04481f();
    if (bwastimejump == 1) {
        self function_1f0c7136(2);
        var_2c9baa0c = level.var_d9ef3e7c.var_7249d50f;
        if (isdefined(var_2c9baa0c) && var_2c9baa0c > 0) {
            self enablevisioncircle(fieldname, var_2c9baa0c);
            if (!self function_ca024039()) {
                self.var_2695439d = self playloopsound(#"veh_uav_engine_loop", 1);
            }
            self thread function_4ee8c344(fieldname);
            self setcompassicon("icon_minimap_sensor_dart");
            self function_8e04481f();
            self hideunseencompassicon();
            self function_811196d1(1);
        }
    }
}

// Namespace recon_plane/recon_plane
// Params 1, eflags: 0x4
// Checksum 0x28547fb6, Offset: 0x4a8
// Size: 0x84
function private function_4ee8c344(localclientnum) {
    entnum = self getentitynumber();
    self waittill(#"death");
    if (isdefined(self.var_2695439d)) {
        self stoploopsound(self.var_2695439d);
    }
    disablevisioncirclebyentnum(localclientnum, entnum);
}

// Namespace recon_plane/recon_plane
// Params 1, eflags: 0x4
// Checksum 0x3b2fdf99, Offset: 0x538
// Size: 0x3c
function private on_game_ended(localclientnum) {
    level waittill(#"game_ended");
    disableallvisioncircles(localclientnum);
}

// Namespace recon_plane/recon_plane
// Params 7, eflags: 0x0
// Checksum 0x776e7a63, Offset: 0x580
// Size: 0xec
function recon_plane_reveal(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (self function_ca024039()) {
            entnum = self getentitynumber();
            function_947d2fc2(fieldname, entnum, level.var_d9ef3e7c.var_e77ca4a1);
            self thread function_af19a98(fieldname, entnum);
            return;
        }
        level.var_d84f0c02[level.var_d84f0c02.size] = self;
        self thread function_6f689c85(fieldname);
    }
}

// Namespace recon_plane/recon_plane
// Params 1, eflags: 0x4
// Checksum 0x7573dbb3, Offset: 0x678
// Size: 0x28e
function private function_6f689c85(localclientnum) {
    self notify("40e65c694de244bd");
    self endon("40e65c694de244bd");
    var_c2b8dfe0 = sqr((isdefined(level.var_d9ef3e7c.var_e77ca4a1) ? level.var_d9ef3e7c.var_e77ca4a1 : 0) / 2);
    arrayremovevalue(level.var_d84f0c02, undefined);
    while (level.var_d84f0c02.size) {
        player = function_27673a7(localclientnum);
        var_6685c065 = 0;
        if (isalive(player)) {
            foreach (var_82d4c496 in level.var_d84f0c02) {
                if (distance2dsquared(player.origin, var_82d4c496.origin) <= var_c2b8dfe0) {
                    var_6685c065 = 1;
                    break;
                }
            }
        }
        if (var_6685c065) {
            if (!isdefined(player.var_59f39e8a)) {
                player.var_59f39e8a = player playloopsound(#"hash_4665942676cd6feb");
            }
        } else if (isdefined(player.var_59f39e8a)) {
            player stoploopsound(player.var_59f39e8a);
            player.var_59f39e8a = undefined;
        }
        wait 0.25;
        arrayremovevalue(level.var_d84f0c02, undefined);
    }
    player = function_27673a7(localclientnum);
    if (isdefined(player.var_59f39e8a)) {
        player stoploopsound(player.var_59f39e8a);
        player.var_59f39e8a = undefined;
    }
}

// Namespace recon_plane/recon_plane
// Params 2, eflags: 0x4
// Checksum 0x5f8d7c33, Offset: 0x910
// Size: 0x44
function private function_af19a98(localclientnum, entnum) {
    self waittill(#"death");
    function_1e5c5bb9(localclientnum, entnum);
}

