#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_weapons;

#namespace zm_utility;

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x2
// Checksum 0x4e80ced3, Offset: 0x150
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_utility", &__init__, &__main__, undefined);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xb039a763, Offset: 0x1a0
// Size: 0xcc
function __init__() {
    level._effect[#"zm_zone_edge_marker"] = #"hash_3002526b7ff53cbf";
    clientfield::register("scriptmover", "zm_zone_edge_marker_count", 1, getminbitcountfornum(15), "int", &zm_zone_edge_marker_count, 0, 0);
    clientfield::register("toplayer", "zm_zone_out_of_bounds", 1, 1, "int", &zm_zone_out_of_bounds, 0, 0);
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x278
// Size: 0x4
function __main__() {
    
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xbced3960, Offset: 0x288
// Size: 0x52
function ignore_triggers(timer) {
    self endon(#"death");
    self.ignoretriggers = 1;
    if (isdefined(timer)) {
        wait timer;
    } else {
        wait 0.5;
    }
    self.ignoretriggers = 0;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x851add0e, Offset: 0x2e8
// Size: 0x6
function is_encounter() {
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x388aade6, Offset: 0x2f8
// Size: 0x46
function round_up_to_ten(score) {
    new_score = score - score % 10;
    if (new_score < score) {
        new_score += 10;
    }
    return new_score;
}

// Namespace zm_utility/zm_utility
// Params 2, eflags: 0x0
// Checksum 0x7072f7f9, Offset: 0x348
// Size: 0x68
function round_up_score(score, value) {
    score = int(score);
    new_score = score - score % value;
    if (new_score < score) {
        new_score += value;
    }
    return new_score;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x4254bf56, Offset: 0x3b8
// Size: 0x3a
function halve_score(n_score) {
    n_score /= 2;
    n_score = round_up_score(n_score, 10);
    return n_score;
}

// Namespace zm_utility/zm_utility
// Params 6, eflags: 0x0
// Checksum 0xef95db05, Offset: 0x400
// Size: 0xd8
function spawn_weapon_model(localclientnum, weapon, model = weapon.worldmodel, origin, angles, options) {
    weapon_model = spawn(localclientnum, origin, "script_model");
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    if (isdefined(options)) {
        weapon_model useweaponmodel(weapon, model, options);
    } else {
        weapon_model useweaponmodel(weapon, model);
    }
    return weapon_model;
}

// Namespace zm_utility/zm_utility
// Params 5, eflags: 0x0
// Checksum 0xe8d0f348, Offset: 0x4e0
// Size: 0x90
function spawn_buildkit_weapon_model(localclientnum, weapon, camo, origin, angles) {
    weapon_model = spawn(localclientnum, origin, "script_model");
    if (isdefined(angles)) {
        weapon_model.angles = angles;
    }
    weapon_model usebuildkitweaponmodel(localclientnum, weapon, camo);
    return weapon_model;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x673e705f, Offset: 0x578
// Size: 0x40
function is_classic() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zclassic") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xe00b26b8, Offset: 0x5c0
// Size: 0x40
function is_standard() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zstandard") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xffb66f14, Offset: 0x608
// Size: 0x40
function is_trials() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"ztrials") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x1c84e69d, Offset: 0x650
// Size: 0x40
function is_tutorial() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"ztutorial") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x4bc76560, Offset: 0x698
// Size: 0x40
function is_grief() {
    str_gametype = util::get_game_type();
    if (str_gametype == #"zgrief") {
        return true;
    }
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x9b2bd164, Offset: 0x6e0
// Size: 0x98
function is_gametype_active(a_gametypes) {
    b_is_gametype_active = 0;
    if (!isarray(a_gametypes)) {
        a_gametypes = array(a_gametypes);
    }
    for (i = 0; i < a_gametypes.size; i++) {
        if (util::get_game_type() == a_gametypes[i]) {
            b_is_gametype_active = 1;
        }
    }
    return b_is_gametype_active;
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x0
// Checksum 0xaea2113a, Offset: 0x780
// Size: 0xa4
function setinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (function_9a47ed7f(localclientnum)) {
        return;
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory." + fieldname), newval);
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x0
// Checksum 0x2dd13ba2, Offset: 0x830
// Size: 0x84
function setsharedinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory." + fieldname), newval);
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x0
// Checksum 0x1f4ecfb9, Offset: 0x8c0
// Size: 0xcc
function zm_ui_infotext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory.infoText"), fieldname);
        return;
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory.infoText"), "");
}

/#

    // Namespace zm_utility/zm_utility
    // Params 4, eflags: 0x0
    // Checksum 0x185b3e7e, Offset: 0x998
    // Size: 0x296
    function drawcylinder(pos, rad, height, color) {
        currad = rad;
        curheight = height;
        debugstar(pos, 1, color);
        for (r = 0; r < 20; r++) {
            theta = r / 20 * 360;
            theta2 = (r + 1) / 20 * 360;
            line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, 1, 1, 100);
            line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, 1, 1, 100);
            line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, 1, 1, 100);
        }
    }

#/

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x9b120c9a, Offset: 0xc38
// Size: 0xb6
function umbra_fix_logic(localclientnum) {
    self endon(#"disconnect");
    self endon(#"death");
    umbra_settometrigger(localclientnum, "");
    while (true) {
        in_fix_area = 0;
        if (isdefined(level.custom_umbra_hotfix)) {
            in_fix_area = self thread [[ level.custom_umbra_hotfix ]](localclientnum);
        }
        if (in_fix_area == 0) {
            umbra_settometrigger(localclientnum, "");
        }
        waitframe(1);
    }
}

// Namespace zm_utility/zm_utility
// Params 5, eflags: 0x0
// Checksum 0x6262f2b5, Offset: 0xcf8
// Size: 0x12e
function umbra_fix_trigger(localclientnum, pos, height, radius, umbra_name) {
    bottomy = pos[2];
    topy = pos[2] + height;
    if (self.origin[2] > bottomy && self.origin[2] < topy) {
        if (distance2dsquared(self.origin, pos) < radius * radius) {
            umbra_settometrigger(localclientnum, umbra_name);
            /#
                drawcylinder(pos, radius, height, (0, 1, 0));
            #/
            return true;
        }
    }
    /#
        drawcylinder(pos, radius, height, (1, 0, 0));
    #/
    return false;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0xdee28a91, Offset: 0xe30
// Size: 0xa6
function function_a96d4c46(localclientnum) {
    b_first = 0;
    if (self isplayer() && self function_60dbc438() && !isdemoplaying()) {
        if (!isdefined(self getlocalclientnumber()) || localclientnum == self getlocalclientnumber()) {
            b_first = 1;
        }
    }
    return b_first;
}

// Namespace zm_utility/zm_utility
// Params 1, eflags: 0x0
// Checksum 0x8a062ab8, Offset: 0xee0
// Size: 0x13e
function function_a7776589(var_e85fd563 = 0) {
    if (!isdefined(self.archetype)) {
        return "tag_origin";
    }
    switch (self.archetype) {
    case #"stoker":
    case #"catalyst":
    case #"gladiator":
    case #"zombie":
    case #"ghost":
    case #"brutus":
        if (var_e85fd563) {
            str_tag = "j_spine4";
        } else {
            str_tag = "j_spineupper";
        }
        break;
    case #"blight_father":
    case #"tiger":
    case #"elephant":
        str_tag = "j_head";
        break;
    default:
        str_tag = "tag_origin";
        break;
    }
    return str_tag;
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0x18e9aa9f, Offset: 0x1028
// Size: 0xf8
function function_7bcc2e7e(localclientnum, var_96ff220b, var_4a790bc1) {
    self endon(var_4a790bc1);
    s_result = level waittill(#"respawn");
    a_e_players = getlocalplayers();
    foreach (e_player in a_e_players) {
        if (e_player postfx::function_7348f3a5(var_96ff220b)) {
            e_player postfx::exitpostfxbundle(var_96ff220b);
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 3, eflags: 0x0
// Checksum 0xc9dac0f9, Offset: 0x1128
// Size: 0xee
function function_7be7b2d8(localclientnum, n_fx_id, var_4a790bc1) {
    self endon(var_4a790bc1);
    s_result = level waittill(#"respawn");
    a_e_players = getlocalplayers();
    foreach (e_player in a_e_players) {
        if (isdefined(n_fx_id)) {
            deletefx(localclientnum, n_fx_id);
            n_fx_id = undefined;
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0x65b9add0, Offset: 0x1220
// Size: 0x12
function get_cast() {
    return zm_maptable::get_cast();
}

// Namespace zm_utility/zm_utility
// Params 0, eflags: 0x0
// Checksum 0xca49f0fc, Offset: 0x1240
// Size: 0x12
function get_story() {
    return zm_maptable::get_story();
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x0
// Checksum 0x4abc9fd2, Offset: 0x1260
// Size: 0x220
function zm_zone_edge_marker_count(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        v_forward = anglestoforward(self.angles);
        v_right = anglestoright(self.angles);
        v_spacing = (0, 0, 0);
        for (i = 1; i <= newval; i++) {
            var_35404285 = playfx(localclientnum, level._effect[#"zm_zone_edge_marker"], self.origin + v_spacing, v_forward);
            if (!isdefined(self.var_dfbcfe5)) {
                self.var_dfbcfe5 = [];
            } else if (!isarray(self.var_dfbcfe5)) {
                self.var_dfbcfe5 = array(self.var_dfbcfe5);
            }
            self.var_dfbcfe5[self.var_dfbcfe5.size] = var_35404285;
            v_spacing = v_right * 27 * i;
        }
        return;
    }
    if (isarray(self.var_dfbcfe5)) {
        foreach (var_35404285 in self.var_dfbcfe5) {
            stopfx(localclientnum, var_35404285);
        }
    }
}

// Namespace zm_utility/zm_utility
// Params 7, eflags: 0x0
// Checksum 0xcdd4af8a, Offset: 0x1488
// Size: 0x8c
function zm_zone_out_of_bounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self postfx::playpostfxbundle(#"hash_798237aa1bad3d7d");
        return;
    }
    self postfx::stoppostfxbundle(#"hash_798237aa1bad3d7d");
}

