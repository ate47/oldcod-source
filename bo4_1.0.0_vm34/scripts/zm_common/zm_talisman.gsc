#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_loadout;

#namespace zm_talisman;

// Namespace zm_talisman/zm_talisman
// Params 0, eflags: 0x0
// Checksum 0x1a988af9, Offset: 0xc0
// Size: 0x44
function init() {
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace zm_talisman/zm_talisman
// Params 0, eflags: 0x0
// Checksum 0x346eb907, Offset: 0x110
// Size: 0x20c
function on_player_connect() {
    var_960f8a65 = self zm_loadout::get_loadout_item("talisman1");
    s_talisman = getunlockableiteminfofromindex(var_960f8a65, 4);
    var_9e05d1a2 = function_b679234(var_960f8a65, 4);
    if (isdefined(s_talisman)) {
        if (!isdefined(var_9e05d1a2.talismanrarity)) {
            var_9e05d1a2.talismanrarity = 0;
        }
        s_talisman.rarity = var_9e05d1a2.talismanrarity;
    }
    if (isdefined(s_talisman) && zm_custom::function_4e389f8(s_talisman)) {
        str_talisman = s_talisman.namehash;
        if (isdefined(level.var_d13bfb7d[str_talisman])) {
            if (isdefined(level.var_d13bfb7d[str_talisman].activate_talisman) && !(isdefined(level.var_d13bfb7d[str_talisman].is_activated[self.clientid]) && level.var_d13bfb7d[str_talisman].is_activated[self.clientid])) {
                self thread [[ level.var_d13bfb7d[str_talisman].activate_talisman ]]();
                level.var_d13bfb7d[str_talisman].is_activated[self.clientid] = 1;
                self stats::inc_stat(#"itemstats", s_talisman.var_eba4dbee, #"stats", #"used", #"statvalue", 1);
            }
        }
    }
}

// Namespace zm_talisman/zm_talisman
// Params 0, eflags: 0x0
// Checksum 0xcab38d2d, Offset: 0x328
// Size: 0x142
function on_player_disconnect() {
    if (!isdefined(self.clientid)) {
        return;
    }
    var_960f8a65 = self zm_loadout::get_loadout_item("talisman1");
    s_talisman = getunlockableiteminfofromindex(var_960f8a65, 4);
    var_9e05d1a2 = function_b679234(var_960f8a65, 4);
    if (isdefined(s_talisman)) {
        str_talisman = s_talisman.namehash;
        if (isdefined(level.var_d13bfb7d[str_talisman])) {
            if (isdefined(level.var_d13bfb7d[str_talisman].activate_talisman) && isdefined(level.var_d13bfb7d[str_talisman].is_activated[self.clientid]) && level.var_d13bfb7d[str_talisman].is_activated[self.clientid]) {
                level.var_d13bfb7d[str_talisman].is_activated[self.clientid] = 0;
            }
        }
    }
}

// Namespace zm_talisman/zm_talisman
// Params 2, eflags: 0x0
// Checksum 0xf4216496, Offset: 0x478
// Size: 0xf2
function register_talisman(str_talisman, activate_talisman) {
    assert(isdefined(str_talisman), "<dev string:x30>");
    assert(isdefined(activate_talisman), "<dev string:x6b>");
    if (!isdefined(level.var_d13bfb7d)) {
        level.var_d13bfb7d = [];
    }
    if (!isdefined(level.var_d13bfb7d[str_talisman])) {
        level.var_d13bfb7d[str_talisman] = spawnstruct();
        level.var_d13bfb7d[str_talisman].activate_talisman = activate_talisman;
        level.var_d13bfb7d[str_talisman].is_activated = array();
    }
}

