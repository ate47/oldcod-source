#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/abilities/ability_power;
#using scripts/core_common/abilities/ability_util;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/duplicaterender_mgr;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace gadget_armor;

// Namespace gadget_armor/gadget_armor
// Params 0, eflags: 0x2
// Checksum 0x1cce98d4, Offset: 0x320
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_armor", &__init__, undefined, undefined);
}

// Namespace gadget_armor/gadget_armor
// Params 0, eflags: 0x0
// Checksum 0xc825859b, Offset: 0x360
// Size: 0xfc
function __init__() {
    callback::on_localplayer_spawned(&on_local_player_spawned);
    clientfield::register("allplayers", "armor_status", 1, 5, "int", &player_armor_changed, 0, 0);
    clientfield::register("toplayer", "player_damage_type", 1, 1, "int", &player_damage_type_changed, 0, 0);
    duplicate_render::set_dr_filter_framebuffer_duplicate("armor_pl", 40, "armor_on", undefined, 1, "mc/mtl_power_armor", 0);
    /#
        level thread armor_overlay_think();
    #/
}

// Namespace gadget_armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0xbd270c72, Offset: 0x468
// Size: 0x6c
function on_local_player_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    newval = self clientfield::get("armor_status");
    self player_armor_changed_event(localclientnum, newval);
}

// Namespace gadget_armor/gadget_armor
// Params 7, eflags: 0x0
// Checksum 0x18d9fbc0, Offset: 0x4e0
// Size: 0x5c
function player_damage_type_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self armor_update_fx_event(localclientnum, newval);
}

// Namespace gadget_armor/gadget_armor
// Params 7, eflags: 0x0
// Checksum 0x83b202e3, Offset: 0x548
// Size: 0x5c
function player_armor_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self player_armor_changed_event(localclientnum, newval);
}

// Namespace gadget_armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x2ccd3ef8, Offset: 0x5b0
// Size: 0x54
function player_armor_changed_event(localclientnum, newval) {
    self armor_update_fx_event(localclientnum, newval);
    self armor_update_shader_event(localclientnum, newval);
}

// Namespace gadget_armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0x5917de43, Offset: 0x610
// Size: 0x224
function armor_update_shader_event(localclientnum, armorstatusnew) {
    if (armorstatusnew) {
        self duplicate_render::update_dr_flag(localclientnum, "armor_on", 1);
        shieldexpansionncolor = "scriptVector3";
        shieldexpansionvaluex = 0.3;
        colorvector = armor_get_shader_color(armorstatusnew);
        if (getdvarint("scr_armor_dev")) {
            shieldexpansionvaluex = getdvarfloat("scr_armor_expand", shieldexpansionvaluex);
            colorvector = (getdvarfloat("scr_armor_colorR", colorvector[0]), getdvarfloat("scr_armor_colorG", colorvector[1]), getdvarfloat("scr_armor_colorB", colorvector[2]));
        }
        colortintvaluey = colorvector[0];
        colortintvaluez = colorvector[1];
        colortintvaluew = colorvector[2];
        damagestate = "scriptVector4";
        damagestatevalue = armorstatusnew / 5;
        self mapshaderconstant(localclientnum, 0, shieldexpansionncolor, shieldexpansionvaluex, colortintvaluey, colortintvaluez, colortintvaluew);
        self mapshaderconstant(localclientnum, 0, damagestate, damagestatevalue);
        return;
    }
    self duplicate_render::update_dr_flag(localclientnum, "armor_on", 0);
}

// Namespace gadget_armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0x1d45bc47, Offset: 0x840
// Size: 0x36
function armor_get_shader_color(armorstatusnew) {
    color = (0.3, 0.3, 0.2);
    return color;
}

// Namespace gadget_armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0xb1a4137e, Offset: 0x880
// Size: 0xac
function armor_update_fx_event(localclientnum, doarmorfx) {
    if (!self armor_is_local_player(localclientnum)) {
        return;
    }
    if (doarmorfx) {
        self setdamagedirectionindicator(1);
        setsoundcontext("plr_impact", "pwr_armor");
        return;
    }
    self setdamagedirectionindicator(0);
    setsoundcontext("plr_impact", "");
}

// Namespace gadget_armor/gadget_armor
// Params 2, eflags: 0x0
// Checksum 0xe68d773c, Offset: 0x938
// Size: 0x168
function armor_overlay_transition_fx(localclientnum, armorstatusnew) {
    self endon(#"disconnect");
    if (!isdefined(self._gadget_armor_state)) {
        self._gadget_armor_state = 0;
    }
    if (armorstatusnew == self._gadget_armor_state) {
        return;
    }
    self._gadget_armor_state = armorstatusnew;
    if (armorstatusnew == 5) {
        return;
    }
    if (isdefined(self._armor_doing_transition) && self._armor_doing_transition) {
        return;
    }
    self._armor_doing_transition = 1;
    transition = 0;
    flicker_start_time = getrealtime();
    saved_vision = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "taser_mine_shock", transition);
    self playsound(0, "wpn_taser_mine_tacmask");
    wait 0.3;
    visionsetnaked(localclientnum, saved_vision, transition);
    self._armor_doing_transition = 0;
}

// Namespace gadget_armor/gadget_armor
// Params 1, eflags: 0x0
// Checksum 0x1c2c7656, Offset: 0xaa8
// Size: 0x4a
function armor_is_local_player(localclientnum) {
    player_view = getlocalplayer(localclientnum);
    sameentity = self == player_view;
    return sameentity;
}

/#

    // Namespace gadget_armor/gadget_armor
    // Params 0, eflags: 0x0
    // Checksum 0x61627685, Offset: 0xb00
    // Size: 0x140
    function armor_overlay_think() {
        armorstatus = 0;
        setdvar("<dev string:x28>", 0);
        while (true) {
            wait 0.1;
            armorstatusnew = getdvarint("<dev string:x28>");
            if (armorstatusnew != armorstatus) {
                players = getlocalplayers();
                foreach (i, localplayer in players) {
                    if (!isdefined(localplayer)) {
                        continue;
                    }
                    localplayer player_armor_changed_event(i, armorstatusnew);
                }
                armorstatus = armorstatusnew;
            }
        }
    }

#/
