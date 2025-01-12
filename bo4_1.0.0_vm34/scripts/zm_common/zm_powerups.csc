#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace zm_powerups;

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x2e26cce3, Offset: 0x1a8
// Size: 0x15c
function init() {
    if (!isdefined(level.zombie_powerups)) {
        level.zombie_powerups = [];
    }
    add_zombie_powerup("insta_kill_ug", "powerup_instant_kill_ug", 1);
    level._effect[#"powerup_on"] = #"zombie/fx_powerup_on_green_zmb";
    if (isdefined(level.using_zombie_powerups) && level.using_zombie_powerups) {
        level._effect[#"powerup_on_red"] = #"zombie/fx_powerup_on_red_zmb";
    }
    level._effect[#"powerup_on_solo"] = #"zombie/fx_powerup_on_solo_zmb";
    level._effect[#"powerup_on_caution"] = #"zombie/fx_powerup_on_caution_zmb";
    clientfield::register("scriptmover", "powerup_fx", 1, 3, "int", &powerup_fx_callback, 0, 0);
}

// Namespace zm_powerups/zm_powerups
// Params 3, eflags: 0x0
// Checksum 0x8fd0a691, Offset: 0x310
// Size: 0x2da
function add_zombie_powerup(powerup_name, client_field_name, clientfield_version = 1) {
    if (isdefined(level.zombie_include_powerups) && !isdefined(level.zombie_include_powerups[powerup_name])) {
        return;
    }
    switch (powerup_name) {
    case #"full_ammo":
        str_rule = "zmPowerupMaxAmmo";
        break;
    case #"fire_sale":
        str_rule = "zmPowerupFireSale";
        break;
    case #"bonus_points_player_shared":
    case #"bonus_points_player":
    case #"bonus_points_team":
        str_rule = "zmPowerupChaosPoints";
        break;
    case #"free_perk":
        str_rule = "zmPowerupFreePerk";
        break;
    case #"nuke":
        str_rule = "zmPowerupNuke";
        break;
    case #"hero_weapon_power":
        str_rule = "zmPowerupSpecialWeapon";
        break;
    case #"insta_kill":
        str_rule = "zmPowerupInstakill";
        break;
    case #"double_points":
        str_rule = "zmPowerupDouble";
        break;
    case #"carpenter":
        str_rule = "zmPowerupCarpenter";
        break;
    default:
        str_rule = "";
        break;
    }
    if (str_rule != "" && !(isdefined(getgametypesetting(str_rule)) && getgametypesetting(str_rule))) {
        return;
    }
    struct = spawnstruct();
    struct.powerup_name = powerup_name;
    level.zombie_powerups[powerup_name] = struct;
    if (isdefined(client_field_name)) {
        var_239542ef = "hudItems.zmPowerUps." + client_field_name + ".state";
        clientfield::register("clientuimodel", var_239542ef, clientfield_version, 2, "int", &powerup_state_callback, 0, 1);
        struct.client_field_name = var_239542ef;
    }
}

// Namespace zm_powerups/zm_powerups
// Params 1, eflags: 0x0
// Checksum 0xac02f20f, Offset: 0x5f8
// Size: 0x42
function include_zombie_powerup(powerup_name) {
    if (!isdefined(level.zombie_include_powerups)) {
        level.zombie_include_powerups = [];
    }
    level.zombie_include_powerups[powerup_name] = 1;
}

// Namespace zm_powerups/zm_powerups
// Params 7, eflags: 0x0
// Checksum 0x91bad651, Offset: 0x648
// Size: 0x76
function powerup_state_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"powerup", {#powerup:fieldname, #state:newval});
}

// Namespace zm_powerups/zm_powerups
// Params 7, eflags: 0x0
// Checksum 0x6a976b4f, Offset: 0x6c8
// Size: 0x17c
function powerup_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        fx = level._effect[#"powerup_on"];
        break;
    case 2:
        fx = level._effect[#"powerup_on_solo"];
        break;
    case 3:
        fx = level._effect[#"powerup_on_red"];
        break;
    case 4:
        fx = level._effect[#"powerup_on_caution"];
        break;
    default:
        return;
    }
    if (!isdefined(fx)) {
        return;
    }
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    util::playfxontag(localclientnum, fx, self, "tag_origin");
}

// Namespace zm_powerups/zm_powerups
// Params 0, eflags: 0x0
// Checksum 0x31487add, Offset: 0x850
// Size: 0x1c
function function_b2585f85() {
    return util::get_game_type() != "zcleansed";
}

