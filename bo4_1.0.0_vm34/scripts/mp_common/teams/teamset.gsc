#namespace teamset;

// Namespace teamset/teamset
// Params 0, eflags: 0x0
// Checksum 0x38222f5, Offset: 0x80
// Size: 0x82
function init() {
    if (!isdefined(game.flagmodels)) {
        game.flagmodels = [];
    }
    if (!isdefined(game.carry_flagmodels)) {
        game.carry_flagmodels = [];
    }
    if (!isdefined(game.carry_icon)) {
        game.carry_icon = [];
    }
    game.flagmodels[#"neutral"] = "p7_mp_flag_neutral";
}

// Namespace teamset/teamset
// Params 0, eflags: 0x0
// Checksum 0xd6a2c0a6, Offset: 0x110
// Size: 0xe4
function customteam_init() {
    if (getdvarstring(#"g_customteamname_allies") != "") {
        setdvar(#"g_teamname_allies", getdvarstring(#"g_customteamname_allies"));
    }
    if (getdvarstring(#"g_customteamname_axis") != "") {
        setdvar(#"g_teamname_axis", getdvarstring(#"g_customteamname_axis"));
    }
}

