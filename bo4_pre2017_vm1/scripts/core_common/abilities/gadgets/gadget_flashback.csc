#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/visionset_mgr_shared;

#namespace gadget_flashback;

// Namespace gadget_flashback/gadget_flashback
// Params 0, eflags: 0x2
// Checksum 0xc9975a24, Offset: 0x3d0
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_flashback", &__init__, undefined, undefined);
}

// Namespace gadget_flashback/gadget_flashback
// Params 0, eflags: 0x0
// Checksum 0x87e45e0a, Offset: 0x410
// Size: 0x144
function __init__() {
    clientfield::register("scriptmover", "flashback_trail_fx", 1, 1, "int", &set_flashback_trail_fx, 0, 0);
    clientfield::register("playercorpse", "flashback_clone", 1, 1, "int", &clone_flashback_changed, 0, 0);
    clientfield::register("allplayers", "flashback_activated", 1, 1, "int", &flashback_activated, 0, 0);
    visionset_mgr::register_overlay_info_style_postfx_bundle("flashback_warp", 1, 1, "pstfx_flashback_warp", 0.8);
    duplicate_render::set_dr_filter_framebuffer("flashback", 90, "flashback_on", "", 0, "mc/mtl_glitch", 0);
}

// Namespace gadget_flashback/gadget_flashback
// Params 7, eflags: 0x0
// Checksum 0x537cd437, Offset: 0x560
// Size: 0x134
function flashback_activated(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"player_flashback");
    player = getlocalplayer(localclientnum);
    isfirstperson = !isthirdperson(localclientnum) && player == self;
    if (newval) {
        if (isfirstperson) {
            self playsound(localclientnum, "mpl_flashback_reappear_plr");
            return;
        }
        self endon(#"death");
        self util::waittill_dobj(localclientnum);
        self playsound(localclientnum, "mpl_flashback_reappear_npc");
        playtagfxset(localclientnum, "gadget_flashback_3p_off", self);
    }
}

// Namespace gadget_flashback/gadget_flashback
// Params 7, eflags: 0x0
// Checksum 0xbdf08950, Offset: 0x6a0
// Size: 0x174
function set_flashback_trail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    isfirstperson = !isthirdperson(localclientnum) && isdefined(self.owner) && isdefined(player) && self.owner == player;
    if (newval) {
        if (isfirstperson) {
            player playsound(localclientnum, "mpl_flashback_disappear_plr");
            return;
        }
        self endon(#"death");
        self util::waittill_dobj(localclientnum);
        self playsound(localclientnum, "mpl_flashback_disappear_npc");
        playfxontag(localclientnum, "player/fx_plyr_flashback_demat", self, "tag_origin");
        playfxontag(localclientnum, "player/fx_plyr_flashback_trail", self, "tag_origin");
    }
}

// Namespace gadget_flashback/gadget_flashback
// Params 7, eflags: 0x0
// Checksum 0xcd60477e, Offset: 0x820
// Size: 0x64
function clone_flashback_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self clone_flashback_changed_event(localclientnum, newval);
    }
}

// Namespace gadget_flashback/gadget_flashback
// Params 1, eflags: 0x0
// Checksum 0xa4b16587, Offset: 0x890
// Size: 0x13a
function clone_fade(localclientnum) {
    self endon(#"death");
    starttime = getservertime(localclientnum);
    while (true) {
        currenttime = getservertime(localclientnum);
        elapsedtime = currenttime - starttime;
        elapsedtime = float(elapsedtime / 1000);
        if (elapsedtime < 1) {
            amount = 1 - elapsedtime / 1;
            self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, 1, 0, amount);
        } else {
            self mapshaderconstant(localclientnum, 0, "scriptVector3", 1, 1, 0, 0);
            break;
        }
        waitframe(1);
    }
}

// Namespace gadget_flashback/gadget_flashback
// Params 2, eflags: 0x0
// Checksum 0x7e321f45, Offset: 0x9d8
// Size: 0x6c
function clone_flashback_changed_event(localclientnum, armorstatusnew) {
    if (armorstatusnew) {
        self duplicate_render::set_dr_flag("flashback_on", 1);
        self duplicate_render::update_dr_filters(localclientnum);
        self clone_fade(localclientnum);
    }
}

