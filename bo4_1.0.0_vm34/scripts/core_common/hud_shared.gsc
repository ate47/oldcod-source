#using script_6103fadfc4a82745;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;

#namespace hud;

// Namespace hud/hud_shared
// Params 0, eflags: 0x2
// Checksum 0xfacdefcf, Offset: 0x310
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hud", &__init__, undefined, undefined);
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0x924bc4e7, Offset: 0x358
// Size: 0x64
function __init__() {
    callback::on_start_gametype(&init);
    level.scavenger_icon = scavenger_icon::register("scavenger_pickup");
    mission flag::init("pvp_objectives_updating");
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0x78c72e80, Offset: 0x3c8
// Size: 0x2dc
function init() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    level.uiparent = spawnstruct();
    level.uiparent.horzalign = "left";
    level.uiparent.vertalign = "top";
    level.uiparent.alignx = "left";
    level.uiparent.aligny = "top";
    level.uiparent.x = 0;
    level.uiparent.y = 0;
    level.uiparent.width = 0;
    level.uiparent.height = 0;
    level.uiparent.children = [];
    level.fontheight = 12;
    level.primaryprogressbary = -61;
    level.primaryprogressbarx = 0;
    level.primaryprogressbarheight = 9;
    level.primaryprogressbarwidth = 120;
    level.primaryprogressbartexty = -75;
    level.primaryprogressbartextx = 0;
    level.primaryprogressbarfontsize = 1.4;
    if (level.splitscreen) {
        level.primaryprogressbarx = 20;
        level.primaryprogressbartextx = 20;
        level.primaryprogressbary = 15;
        level.primaryprogressbartexty = 0;
        level.primaryprogressbarheight = 2;
    }
    level.secondaryprogressbary = -85;
    level.secondaryprogressbarx = 0;
    level.secondaryprogressbarheight = 9;
    level.secondaryprogressbarwidth = 120;
    level.secondaryprogressbartexty = -100;
    level.secondaryprogressbartextx = 0;
    level.secondaryprogressbarfontsize = 1.4;
    if (level.splitscreen) {
        level.secondaryprogressbarx = 20;
        level.secondaryprogressbartextx = 20;
        level.secondaryprogressbary = 15;
        level.secondaryprogressbartexty = 0;
        level.secondaryprogressbarheight = 2;
    }
    setdvar(#"ui_generic_status_bar", 0);
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0x1c500fa1, Offset: 0x6b0
// Size: 0x1c
function on_player_connect() {
    self scavenger_hud_create();
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x6d8
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace hud/hud_shared
// Params 5, eflags: 0x0
// Checksum 0x7c957983, Offset: 0x6e8
// Size: 0x84
function fade_to_black_for_x_sec(startwait, blackscreenwait, fadeintime, fadeouttime, shadername) {
    self endon(#"disconnect");
    wait startwait;
    self lui::screen_fade_out(fadeintime, shadername);
    wait blackscreenwait;
    self lui::screen_fade_in(fadeouttime, shadername);
}

// Namespace hud/hud_shared
// Params 1, eflags: 0x0
// Checksum 0xf0f3cfdb, Offset: 0x778
// Size: 0x24
function screen_fade_in(fadeintime) {
    self lui::screen_fade_in(fadeintime);
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0x91c6c397, Offset: 0x7a8
// Size: 0x44
function scavenger_hud_create() {
    if (!level.scavenger_icon scavenger_icon::is_open(self)) {
        level.scavenger_icon scavenger_icon::open(self, 1);
    }
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0xd96e63fe, Offset: 0x7f8
// Size: 0x44
function flash_scavenger_icon() {
    if (level.scavenger_icon scavenger_icon::is_open(self)) {
        level.scavenger_icon scavenger_icon::increment_pulse(self);
    }
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0x13ac3c31, Offset: 0x848
// Size: 0x118
function function_62933add() {
    level.var_fd960914 = [];
    foreach (var_f84d75dc in array(#"axis", #"allies")) {
        level.var_fd960914[var_f84d75dc] = {#var_d7d1d7d4:[], #var_24acd6cf:[], #var_a30a0b3e:[], #var_4bfba692:[]};
        level.var_fd960914[var_f84d75dc] flag::init("updating");
    }
}

// Namespace hud/hud_shared
// Params 6, eflags: 0x0
// Checksum 0xfe17cbad, Offset: 0x968
// Size: 0x4bc
function set_team_objective(var_29b65fe0, var_f84d75dc, n_obj_id, n_widget, var_369cd3c9, b_pvp) {
    if (!isdefined(level.var_fd960914)) {
        level function_62933add();
    }
    var_f84d75dc = util::get_team_mapping(var_f84d75dc);
    if (isstruct(var_29b65fe0)) {
        s_objective = var_29b65fe0;
    } else {
        s_objective = {#str_identifier:var_29b65fe0, #n_obj_id:n_obj_id, #n_widget:n_widget, #s_radiant:self};
    }
    var_2a8ed81a = level.var_fd960914[var_f84d75dc];
    str_team = level.teams[var_f84d75dc];
    var_59d61543 = "hudItems.cpObjective." + str_team;
    s_radiant = s_objective.s_radiant;
    var_2a8ed81a flag::wait_till_clear("updating");
    if (isdefined(s_radiant.var_bc22a0c6) && s_radiant.var_bc22a0c6) {
        if (isdefined(b_pvp) && b_pvp) {
            s_radiant flag::set("pvp_objective_set_" + str_team);
        }
        return;
    }
    self function_1ae159b1(var_2a8ed81a, var_59d61543, s_radiant, var_f84d75dc);
    level function_124728d4(var_2a8ed81a, var_59d61543, s_objective, var_f84d75dc);
    if (!isinarray(var_2a8ed81a.var_d7d1d7d4, s_objective)) {
        level function_dc17b826(s_objective, var_2a8ed81a);
    }
    if (!isdefined(var_369cd3c9)) {
        var_369cd3c9 = isdefined(s_radiant.var_499bf9af) && s_radiant.var_499bf9af;
    }
    if (var_369cd3c9) {
        var_2a8ed81a.var_2a8f9bb3 = s_objective;
        if (var_2a8ed81a.var_d7d1d7d4[0] != s_objective) {
            var_2a8ed81a.var_d7d1d7d4[0].s_radiant flagsys::set(#"hud_pause_tracking_" + str_team);
        }
    } else if (isdefined(var_2a8ed81a.var_2a8f9bb3) || var_2a8ed81a.var_d7d1d7d4[0] != s_objective || isdefined(s_radiant.var_f93b0c80) && s_radiant.var_f93b0c80) {
        s_radiant flagsys::set(#"hud_pause_tracking_" + str_team);
        if (isdefined(b_pvp) && b_pvp) {
            s_radiant flag::set("pvp_objective_set_" + str_team);
        }
        return;
    }
    var_e7aae02c = var_2a8ed81a.var_24acd6cf[0];
    if (isdefined(var_e7aae02c) && isdefined(s_objective.n_widget)) {
        if (var_e7aae02c == s_radiant) {
            s_radiant function_5932cf50(var_f84d75dc);
        } else {
            var_e7aae02c flagsys::set(#"hud_pause_tracking_" + str_team);
        }
    }
    if (isdefined(s_objective.n_widget)) {
        clientfield::set_world_uimodel(var_59d61543 + ".objWidgetId", s_objective.n_widget);
        clientfield::set_world_uimodel(var_59d61543 + ".objectiveIconObjId", s_objective.n_obj_id);
    }
    if (isdefined(b_pvp) && b_pvp) {
        s_radiant flag::set("pvp_objective_set_" + str_team);
    }
}

// Namespace hud/hud_shared
// Params 3, eflags: 0x4
// Checksum 0xca63533, Offset: 0xe30
// Size: 0xe8
function private function_a7a340b7(var_2a8ed81a, var_59d61543, var_f84d75dc) {
    s_objective = var_2a8ed81a.var_d7d1d7d4[0];
    s_radiant = s_objective.s_radiant;
    s_radiant function_5932cf50(var_f84d75dc);
    if (isdefined(s_objective.n_widget)) {
        clientfield::set_world_uimodel(var_59d61543 + ".objWidgetId", s_objective.n_widget);
        clientfield::set_world_uimodel(var_59d61543 + ".objectiveIconObjId", s_objective.n_obj_id);
        if (isdefined(s_radiant.var_124a1de4)) {
            s_radiant thread [[ s_radiant.var_124a1de4 ]]();
        }
    }
}

// Namespace hud/hud_shared
// Params 1, eflags: 0x4
// Checksum 0x2b105929, Offset: 0xf20
// Size: 0x78
function private function_5932cf50(var_f84d75dc) {
    str_flag = "hud_pause_tracking_" + level.teams[var_f84d75dc];
    if (self flagsys::get(str_flag)) {
        self flagsys::clear(str_flag);
        if (isdefined(self.var_d26737b1)) {
            self thread [[ self.var_d26737b1 ]]();
        }
    }
}

// Namespace hud/hud_shared
// Params 5, eflags: 0x0
// Checksum 0xe2057f43, Offset: 0xfa0
// Size: 0x54c
function function_cc438a9c(str_identifier, var_f84d75dc, b_success = 1, e_player, b_pvp) {
    if (!isdefined(level.var_fd960914)) {
        return;
    }
    if (!(isdefined(self.var_997d0361) && self.var_997d0361)) {
        self.var_bc22a0c6 = 1;
    }
    var_f84d75dc = util::get_team_mapping(var_f84d75dc);
    var_2a8ed81a = level.var_fd960914[var_f84d75dc];
    var_59d61543 = "hudItems.cpObjective." + level.teams[var_f84d75dc];
    if (b_success) {
        str_winning_team = var_f84d75dc;
        n_state = 1;
    } else {
        if (isdefined(b_pvp) && b_pvp) {
            str_winning_team = util::get_enemy_team(var_f84d75dc);
        } else {
            str_winning_team = #"none";
        }
        n_state = 2;
    }
    s_objective = function_83cbb936(str_identifier, var_2a8ed81a);
    if (!isdefined(s_objective)) {
        if (var_2a8ed81a.var_24acd6cf.size) {
            self thread function_5429dec0(str_winning_team, 0);
        }
        return;
    }
    var_2a8ed81a flag::set("updating");
    wait 0.75;
    if (isdefined(s_objective.s_radiant.var_c646bf10) && isdefined(s_objective.s_radiant.var_c646bf10[var_f84d75dc]) && s_objective.s_radiant.var_c646bf10[var_f84d75dc]) {
        clientfield::set_world_uimodel(var_59d61543 + ".progressType", 0);
        s_objective.s_radiant.var_c646bf10[var_f84d75dc] = undefined;
    }
    if (var_2a8ed81a.var_24acd6cf.size) {
        s_objective.s_radiant thread function_5429dec0(str_winning_team, 0);
    }
    if (isdefined(self.m_str_objective)) {
        if (!isdefined(world.var_1cb6888)) {
            world.var_1cb6888 = [];
        }
        if (!isdefined(world.var_1cb6888[var_f84d75dc])) {
            world.var_1cb6888[var_f84d75dc] = [];
        }
        if (!isdefined(world.var_1cb6888[var_f84d75dc][self.m_str_objective])) {
            world.var_1cb6888[var_f84d75dc][self.m_str_objective] = n_state;
        }
    }
    if (isdefined(s_objective.var_9b0e0b82)) {
        if (s_objective.var_9b0e0b82 <= 3) {
            clientfield::set_world_uimodel(var_59d61543 + ".teamSubObjective" + s_objective.var_9b0e0b82 + ".state", n_state);
        }
        s_objective.var_8fec8087 = n_state;
    }
    if (isdefined(e_player)) {
        a_e_players = array(e_player);
    } else {
        a_e_players = util::get_players(var_f84d75dc);
    }
    s_objective function_d0ff121f(a_e_players, var_f84d75dc, n_state);
    wait 5;
    var_eff5135 = 0;
    if (var_2a8ed81a.var_2a8f9bb3 === s_objective) {
        var_eff5135 = 1;
        var_2a8ed81a.var_2a8f9bb3 = undefined;
    } else {
        var_eff5135 = var_2a8ed81a.var_d7d1d7d4[0] === s_objective;
    }
    if (isdefined(s_objective.var_9b0e0b82)) {
        level function_9cdeeb1b(var_2a8ed81a, var_59d61543, s_objective, util::get_players(var_f84d75dc));
    }
    arrayremovevalue(var_2a8ed81a.var_d7d1d7d4, s_objective, 0);
    if (var_eff5135) {
        if (var_2a8ed81a.var_d7d1d7d4.size && !(isdefined(var_2a8ed81a.var_d7d1d7d4[0].var_f93b0c80) && var_2a8ed81a.var_d7d1d7d4[0].var_f93b0c80)) {
            level function_a7a340b7(var_2a8ed81a, var_59d61543, var_f84d75dc);
        } else {
            clientfield::set_world_uimodel(var_59d61543 + ".objWidgetId", 0);
        }
    }
    var_2a8ed81a flag::clear("updating");
}

// Namespace hud/hud_shared
// Params 2, eflags: 0x4
// Checksum 0x478e33f3, Offset: 0x14f8
// Size: 0x256
function private function_dc17b826(var_984a4bab, var_2a8ed81a) {
    s_radiant = var_984a4bab.s_radiant;
    if (!(isdefined(s_radiant.var_f93b0c80) && s_radiant.var_f93b0c80)) {
        var_312e6d0b = var_2a8ed81a.var_24acd6cf.size && (!isinarray(var_2a8ed81a.var_24acd6cf, s_radiant) || isdefined(s_radiant.var_3265275d) && s_radiant.var_3265275d);
        foreach (n_index, s_objective in var_2a8ed81a.var_d7d1d7d4) {
            if (var_312e6d0b && isinarray(var_2a8ed81a.var_24acd6cf, s_objective.s_radiant)) {
                break;
            }
            if (isdefined(s_objective.s_radiant.var_f93b0c80) && s_objective.s_radiant.var_f93b0c80) {
                break;
            }
        }
        if (isdefined(n_index)) {
            arrayinsert(var_2a8ed81a.var_d7d1d7d4, var_984a4bab, n_index);
            return;
        }
    }
    if (!isdefined(var_2a8ed81a.var_d7d1d7d4)) {
        var_2a8ed81a.var_d7d1d7d4 = [];
    } else if (!isarray(var_2a8ed81a.var_d7d1d7d4)) {
        var_2a8ed81a.var_d7d1d7d4 = array(var_2a8ed81a.var_d7d1d7d4);
    }
    if (!isinarray(var_2a8ed81a.var_d7d1d7d4, var_984a4bab)) {
        var_2a8ed81a.var_d7d1d7d4[var_2a8ed81a.var_d7d1d7d4.size] = var_984a4bab;
    }
}

// Namespace hud/hud_shared
// Params 2, eflags: 0x4
// Checksum 0x67db9098, Offset: 0x1758
// Size: 0x94
function private function_83cbb936(str_identifier, var_2a8ed81a) {
    foreach (s_objective in var_2a8ed81a.var_d7d1d7d4) {
        if (s_objective.str_identifier == str_identifier) {
            return s_objective;
        }
    }
    return undefined;
}

// Namespace hud/hud_shared
// Params 4, eflags: 0x0
// Checksum 0xf8dac654, Offset: 0x17f8
// Size: 0x2cc
function function_1ae159b1(var_2a8ed81a, var_59d61543, s_radiant, var_f84d75dc) {
    if (!isdefined(var_2a8ed81a)) {
        if (!isdefined(level.var_fd960914)) {
            level function_62933add();
        }
        var_f84d75dc = util::get_team_mapping(self.script_team);
        var_2a8ed81a = level.var_fd960914[var_f84d75dc];
        var_59d61543 = "hudItems.cpObjective." + level.teams[var_f84d75dc];
        s_radiant = self;
    }
    if (!isdefined(s_radiant.var_e7aae02c)) {
        if (isdefined(s_radiant.var_1be37e08)) {
            var_e7aae02c = struct::get(s_radiant.var_1be37e08, "script_main_objective_src");
            var_e7aae02c function_943fe2cd();
        } else if (isdefined(s_radiant.var_e7c3a654)) {
            s_radiant.var_e7aae02c = s_radiant;
        }
    }
    var_e7aae02c = isdefined(s_radiant.var_e7aae02c) ? s_radiant.var_e7aae02c : s_radiant;
    if (isinarray(var_2a8ed81a.var_24acd6cf, var_e7aae02c)) {
        return;
    }
    if (isdefined(var_e7aae02c.var_3cf7a3b) && var_e7aae02c.var_3cf7a3b) {
        return;
    }
    if (var_e7aae02c != self) {
        var_e7aae02c.var_f03e5576 = self;
    }
    if (isdefined(var_e7aae02c.var_3265275d) && var_e7aae02c.var_3265275d) {
        arrayinsert(var_2a8ed81a.var_24acd6cf, var_e7aae02c, 0);
    } else {
        if (!isdefined(var_2a8ed81a.var_24acd6cf)) {
            var_2a8ed81a.var_24acd6cf = [];
        } else if (!isarray(var_2a8ed81a.var_24acd6cf)) {
            var_2a8ed81a.var_24acd6cf = array(var_2a8ed81a.var_24acd6cf);
        }
        var_2a8ed81a.var_24acd6cf[var_2a8ed81a.var_24acd6cf.size] = var_e7aae02c;
    }
    if (!isdefined(var_e7aae02c.var_e7c3a654)) {
        var_e7aae02c.var_48e7c676 = 1;
    }
    if (var_e7aae02c == var_2a8ed81a.var_24acd6cf[0]) {
        level thread function_83cd2e53(var_2a8ed81a, var_59d61543, var_f84d75dc);
    }
}

// Namespace hud/hud_shared
// Params 3, eflags: 0x4
// Checksum 0xdb0ce4f0, Offset: 0x1ad0
// Size: 0x408
function private function_83cd2e53(var_2a8ed81a, var_59d61543, var_f84d75dc) {
    var_e7aae02c = var_2a8ed81a.var_24acd6cf[0];
    if (!isdefined(var_e7aae02c.var_25dbdf2f)) {
        var_e7aae02c.var_25dbdf2f = gameobjects::get_next_obj_id();
        if (isdefined(var_e7aae02c.var_e7c3a654)) {
            var_e7aae02c.str_objective_name = var_e7aae02c.var_e7c3a654;
            str_objective = var_e7aae02c.var_e7c3a654;
            if (!isdefined(var_e7aae02c.var_a30a0b3e)) {
                var_e7aae02c.var_a30a0b3e = [];
            } else if (!isarray(var_e7aae02c.var_a30a0b3e)) {
                var_e7aae02c.var_a30a0b3e = array(var_e7aae02c.var_a30a0b3e);
            }
            if (!isinarray(var_e7aae02c.var_a30a0b3e, var_e7aae02c)) {
                var_e7aae02c.var_a30a0b3e[var_e7aae02c.var_a30a0b3e.size] = var_e7aae02c;
            }
        } else {
            str_objective = var_e7aae02c [[ var_e7aae02c.var_38e380b3 ]]();
        }
        if (isdefined(str_objective)) {
            objective_add(var_e7aae02c.var_25dbdf2f, "invisible", var_e7aae02c.origin, str_objective);
            var_858d7291 = var_e7aae02c [[ var_e7aae02c.var_f5896223 ]]();
            if (isdefined(var_858d7291)) {
                objective_setteam(var_e7aae02c.var_25dbdf2f, var_858d7291);
            }
            if (isdefined(var_e7aae02c.var_be280400)) {
                var_e7aae02c thread [[ var_e7aae02c.var_be280400 ]]();
            }
        }
    }
    if (clientfield::get_world_uimodel(var_59d61543 + ".activeObjective.objId") != var_e7aae02c.var_25dbdf2f) {
        clientfield::set_world_uimodel(var_59d61543 + ".activeObjective.objId", var_e7aae02c.var_25dbdf2f);
        clientfield::set_world_uimodel(var_59d61543 + ".activeObjective.state", 0);
        wait 1;
        var_e7aae02c.var_54dc3e08[var_f84d75dc] = 1;
        if (isdefined(var_e7aae02c.var_1e982191) && var_e7aae02c.var_1e982191) {
            var_2a8ed81a.var_2f50f33 = 1;
        }
        if (isdefined(var_e7aae02c.var_24319d1) && var_e7aae02c.var_24319d1 || var_e7aae02c.script_team === #"any") {
            level function_8235e78f(1, var_f84d75dc);
        }
        foreach (var_2f915a7 in arraycopy(var_2a8ed81a.var_4bfba692)) {
            if (var_2f915a7 function_8c174754(var_f84d75dc, var_2a8ed81a)) {
                arrayremovevalue(var_2a8ed81a.var_4bfba692, var_2f915a7, 0);
                level function_2ba9da54(var_2a8ed81a, var_2f915a7, var_59d61543, var_f84d75dc);
            }
        }
    }
}

// Namespace hud/hud_shared
// Params 2, eflags: 0x0
// Checksum 0xdb350b6d, Offset: 0x1ee0
// Size: 0x732
function function_5429dec0(var_eaafc8f = #"none", var_9927e929 = 1) {
    if (!isdefined(level.var_fd960914)) {
        level function_62933add();
    }
    var_eaafc8f = util::get_team_mapping(var_eaafc8f);
    if (isdefined(self.var_e7aae02c)) {
        var_e7aae02c = self.var_e7aae02c;
    } else if (isdefined(self.var_a30a0b3e)) {
        var_e7aae02c = self;
    } else {
        foreach (var_2a8ed81a in level.var_fd960914) {
            if (isinarray(var_2a8ed81a.var_24acd6cf, self)) {
                var_e7aae02c = self;
                break;
            }
        }
    }
    if (!isdefined(var_e7aae02c)) {
        if (isdefined(self.script_main_objective_src)) {
            self.script_main_objective_src = undefined;
            return;
        }
        if (isdefined(self.var_1be37e08)) {
            self.var_1be37e08 = undefined;
        }
        return;
    }
    b_clear = 0;
    if (var_e7aae02c == self && !isdefined(var_e7aae02c.var_e7c3a654)) {
        b_clear = 1;
    } else if (isdefined(var_e7aae02c.var_a30a0b3e) && var_e7aae02c.var_a30a0b3e.size) {
        arrayremovevalue(var_e7aae02c.var_a30a0b3e, self, 0);
        if (!var_e7aae02c.var_a30a0b3e.size) {
            var_e7aae02c.var_a30a0b3e = undefined;
            if (isdefined(var_e7aae02c.var_e7c3a654)) {
                b_clear = 1;
            }
        }
    }
    if (self == var_e7aae02c) {
        self.var_eaafc8f = var_eaafc8f;
    }
    var_514c2d7b = [];
    if (b_clear) {
        if (isdefined(var_e7aae02c.var_f583c48c) && var_e7aae02c.var_f583c48c) {
            var_e7aae02c function_18e673f9();
        } else {
            wait 2.25;
        }
        foreach (var_f84d75dc in array(#"axis", #"allies")) {
            var_2a8ed81a = level.var_fd960914[var_f84d75dc];
            if (isinarray(var_2a8ed81a.var_24acd6cf, var_e7aae02c)) {
                if (var_2a8ed81a.var_24acd6cf[0] == var_e7aae02c) {
                    if (!isdefined(var_514c2d7b)) {
                        var_514c2d7b = [];
                    } else if (!isarray(var_514c2d7b)) {
                        var_514c2d7b = array(var_514c2d7b);
                    }
                    var_514c2d7b[var_514c2d7b.size] = var_f84d75dc;
                    var_59d61543 = "hudItems.cpObjective." + level.teams[var_f84d75dc];
                    if (var_eaafc8f == var_f84d75dc || var_eaafc8f == #"none" && var_9927e929) {
                        n_state = 1;
                    } else {
                        n_state = 2;
                    }
                    if (isdefined(var_e7aae02c.str_objective_name)) {
                        if (!isdefined(world.var_1cb6888)) {
                            world.var_1cb6888 = [];
                        }
                        if (!isdefined(world.var_1cb6888[var_f84d75dc])) {
                            world.var_1cb6888[var_f84d75dc] = [];
                        }
                        if (!isdefined(world.var_1cb6888[var_f84d75dc][var_e7aae02c.str_objective_name])) {
                            world.var_1cb6888[var_f84d75dc][var_e7aae02c.str_objective_name] = n_state;
                        }
                    }
                    clientfield::set_world_uimodel(var_59d61543 + ".activeObjective.state", n_state);
                    level function_a8aed1b2(var_2a8ed81a, var_59d61543, var_f84d75dc, var_e7aae02c);
                    continue;
                }
                arrayremovevalue(var_2a8ed81a.var_24acd6cf, var_e7aae02c, 0);
            }
        }
    }
    if (var_514c2d7b.size) {
        wait 5;
        foreach (var_f84d75dc in var_514c2d7b) {
            var_2a8ed81a = level.var_fd960914[var_f84d75dc];
            var_59d61543 = "hudItems.cpObjective." + level.teams[var_f84d75dc];
            clientfield::set_world_uimodel(var_59d61543 + ".activeObjective.objId", 0);
            clientfield::set_world_uimodel(var_59d61543 + ".activeObjective.state", 0);
            if (isdefined(var_e7aae02c.var_25dbdf2f)) {
                gameobjects::release_obj_id(var_e7aae02c.var_25dbdf2f);
                var_e7aae02c.var_25dbdf2f = undefined;
            }
            arrayremovevalue(var_2a8ed81a.var_24acd6cf, var_e7aae02c, 0);
            if (isdefined(var_e7aae02c.var_24319d1) && var_e7aae02c.var_24319d1 || var_e7aae02c.script_team === #"any") {
                level function_8235e78f(0, var_f84d75dc);
            }
            level function_f31a47d5(var_2a8ed81a, var_59d61543, var_f84d75dc, var_e7aae02c);
            if (var_2a8ed81a.var_24acd6cf.size) {
                level thread function_83cd2e53(var_2a8ed81a, var_59d61543, var_f84d75dc);
            }
        }
        var_e7aae02c.var_54dc3e08 = undefined;
    }
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0xb8a45eb5, Offset: 0x2620
// Size: 0xb2
function function_943fe2cd() {
    if (!isdefined(self.var_a30a0b3e)) {
        self.var_a30a0b3e = self namespace_8955127e::get_target_structs("script_main_objective");
        foreach (var_2f915a7 in arraycopy(self.var_a30a0b3e)) {
            var_2f915a7.var_e7aae02c = self;
        }
    }
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x4
// Checksum 0x50ccd6f6, Offset: 0x26e0
// Size: 0x148
function private function_18e673f9() {
    var_eaafc8f = self.var_eaafc8f;
    if (var_eaafc8f == #"allies" && isdefined(self.var_1802943b)) {
        var_24b7fc67 = self.var_1802943b;
        if (isdefined(self.var_6d0b5fd)) {
            var_d2392da0 = self.var_6d0b5fd;
        } else {
            var_d2392da0 = self.var_1802943b;
        }
    } else if (var_eaafc8f == #"axis" && isdefined(self.var_7f990e0a)) {
        var_24b7fc67 = self.var_7f990e0a;
        if (isdefined(self.var_3d0d1a9a)) {
            var_d2392da0 = self.var_3d0d1a9a;
        } else {
            var_d2392da0 = self.var_7f990e0a;
        }
    } else {
        level notify(#"hash_3a83767fc316ef21");
        return;
    }
    level thread objective_result(var_eaafc8f, var_24b7fc67, var_d2392da0);
    wait 5;
    function_a51f5a1a();
    level notify(#"hash_3a83767fc316ef21");
}

// Namespace hud/hud_shared
// Params 4, eflags: 0x4
// Checksum 0x233fccbd, Offset: 0x2830
// Size: 0x272
function private function_a8aed1b2(var_2a8ed81a, var_59d61543, var_f84d75dc, var_e7aae02c) {
    foreach (e_player in util::get_players(var_f84d75dc)) {
        if (isdefined(e_player.var_a30a0b3e)) {
            foreach (var_2f915a7 in e_player.var_a30a0b3e) {
                if (isdefined(e_player.var_d20403b5) && isinarray(e_player.var_d20403b5, var_2f915a7)) {
                    continue;
                }
                if (function_ee1e7b01(var_2f915a7, var_e7aae02c)) {
                    var_9b0e0b82 = var_2f915a7.var_905e4750[e_player getentitynumber()];
                    if (isdefined(var_9b0e0b82) && var_9b0e0b82 <= 3) {
                        e_player clientfield::set_player_uimodel("hudItems.cpObjective.perPlayer.subObjective" + var_9b0e0b82 + ".state", 2);
                    }
                    if (isinarray(var_2a8ed81a.var_a30a0b3e, var_2f915a7) && var_2f915a7.var_8fec8087 !== 0) {
                        if (isdefined(var_2f915a7.var_9b0e0b82)) {
                            if (var_2f915a7.var_9b0e0b82 <= 3) {
                                clientfield::set_world_uimodel(var_59d61543 + ".teamSubObjective" + var_2f915a7.var_9b0e0b82 + ".state", 2);
                            }
                            var_2f915a7.var_8fec8087 = 2;
                        }
                    }
                }
            }
        }
    }
}

// Namespace hud/hud_shared
// Params 4, eflags: 0x4
// Checksum 0x169a0d25, Offset: 0x2ab0
// Size: 0x2a0
function private function_f31a47d5(var_2a8ed81a, var_59d61543, var_f84d75dc, var_e7aae02c) {
    a_e_players = util::get_players(var_f84d75dc);
    var_1d3101e9 = [];
    foreach (e_player in a_e_players) {
        if (isdefined(e_player.var_a30a0b3e)) {
            foreach (var_2f915a7 in e_player.var_a30a0b3e) {
                if (isdefined(e_player.var_d20403b5) && isinarray(e_player.var_d20403b5, var_2f915a7)) {
                    continue;
                }
                if (function_ee1e7b01(var_2f915a7, var_e7aae02c)) {
                    if (isinarray(var_2a8ed81a.var_a30a0b3e, var_2f915a7)) {
                        if (!isdefined(var_1d3101e9)) {
                            var_1d3101e9 = [];
                        } else if (!isarray(var_1d3101e9)) {
                            var_1d3101e9 = array(var_1d3101e9);
                        }
                        if (!isinarray(var_1d3101e9, var_2f915a7)) {
                            var_1d3101e9[var_1d3101e9.size] = var_2f915a7;
                        }
                        continue;
                    }
                    e_player function_9b2f9303(var_2f915a7);
                }
            }
        }
    }
    foreach (var_1365ca49 in var_1d3101e9) {
        level function_9cdeeb1b(var_2a8ed81a, var_59d61543, var_1365ca49, a_e_players);
    }
}

// Namespace hud/hud_shared
// Params 2, eflags: 0x4
// Checksum 0xc8ef2730, Offset: 0x2d58
// Size: 0x6c
function private function_ee1e7b01(var_2f915a7, var_e7aae02c) {
    if (!isdefined(var_2f915a7.var_e7aae02c)) {
        if (isdefined(var_2f915a7.var_f7583ada) && var_2f915a7.var_f7583ada) {
            return true;
        }
    } else if (var_2f915a7.var_e7aae02c == var_e7aae02c) {
        return true;
    }
    return false;
}

// Namespace hud/hud_shared
// Params 5, eflags: 0x4
// Checksum 0x7dfef148, Offset: 0x2dd0
// Size: 0x16e
function private function_124728d4(var_2a8ed81a, var_59d61543, s_objective, var_f84d75dc, e_player) {
    if (isdefined(s_objective.s_radiant)) {
        var_915f9cbd = s_objective.s_radiant;
    } else {
        var_915f9cbd = s_objective;
    }
    if (isdefined(var_915f9cbd.var_48e7c676) && var_915f9cbd.var_48e7c676) {
        return;
    }
    if (var_915f9cbd function_8c174754(var_f84d75dc, var_2a8ed81a)) {
        level function_2ba9da54(var_2a8ed81a, s_objective, var_59d61543, var_f84d75dc, e_player);
        return;
    }
    if (!isdefined(var_2a8ed81a.var_4bfba692)) {
        var_2a8ed81a.var_4bfba692 = [];
    } else if (!isarray(var_2a8ed81a.var_4bfba692)) {
        var_2a8ed81a.var_4bfba692 = array(var_2a8ed81a.var_4bfba692);
    }
    if (!isinarray(var_2a8ed81a.var_4bfba692, s_objective)) {
        var_2a8ed81a.var_4bfba692[var_2a8ed81a.var_4bfba692.size] = s_objective;
    }
}

// Namespace hud/hud_shared
// Params 2, eflags: 0x4
// Checksum 0xd977add, Offset: 0x2f48
// Size: 0x146
function private function_8c174754(var_f84d75dc, var_2a8ed81a) {
    if (var_2a8ed81a.var_24acd6cf.size == 0) {
        return false;
    }
    if (isdefined(self.var_e7aae02c)) {
        return (self.var_e7aae02c == var_2a8ed81a.var_24acd6cf[0] && isdefined(self.var_e7aae02c.var_54dc3e08) && isdefined(self.var_e7aae02c.var_54dc3e08[var_f84d75dc]) && self.var_e7aae02c.var_54dc3e08[var_f84d75dc]);
    } else if (isdefined(self.s_radiant)) {
        s_radiant = self.s_radiant;
        return (s_radiant.var_e7aae02c == var_2a8ed81a.var_24acd6cf[0] && isdefined(s_radiant.var_e7aae02c.var_54dc3e08) && isdefined(s_radiant.var_e7aae02c.var_54dc3e08[var_f84d75dc]) && s_radiant.var_e7aae02c.var_54dc3e08[var_f84d75dc]);
    }
    return true;
}

// Namespace hud/hud_shared
// Params 5, eflags: 0x4
// Checksum 0xfac89606, Offset: 0x3098
// Size: 0x1ac
function private function_2ba9da54(var_2a8ed81a, s_objective, var_59d61543, var_f84d75dc, e_player) {
    if (!isdefined(var_2a8ed81a.var_a30a0b3e)) {
        var_2a8ed81a.var_a30a0b3e = [];
    } else if (!isarray(var_2a8ed81a.var_a30a0b3e)) {
        var_2a8ed81a.var_a30a0b3e = array(var_2a8ed81a.var_a30a0b3e);
    }
    if (!isinarray(var_2a8ed81a.var_a30a0b3e, s_objective)) {
        var_2a8ed81a.var_a30a0b3e[var_2a8ed81a.var_a30a0b3e.size] = s_objective;
    }
    var_9b0e0b82 = getlastarraykey(var_2a8ed81a.var_a30a0b3e) + 1;
    s_objective.var_9b0e0b82 = var_9b0e0b82;
    s_objective.var_8fec8087 = 0;
    if (var_9b0e0b82 <= 3) {
        var_59d61543 = var_59d61543 + ".teamSubObjective" + var_9b0e0b82;
        clientfield::set_world_uimodel(var_59d61543 + ".objId", s_objective.n_obj_id);
        clientfield::set_world_uimodel(var_59d61543 + ".state", 0);
    }
    s_objective function_ad7e7db1(e_player, var_f84d75dc);
}

// Namespace hud/hud_shared
// Params 4, eflags: 0x4
// Checksum 0x5c9f7296, Offset: 0x3250
// Size: 0x286
function private function_9cdeeb1b(var_2a8ed81a, var_59d61543, s_objective, a_e_players) {
    if (isinarray(var_2a8ed81a.var_4bfba692, s_objective)) {
        arrayremovevalue(var_2a8ed81a.var_4bfba692, s_objective, 0);
        s_objective.b_clearing = undefined;
        return;
    }
    arrayremovevalue(var_2a8ed81a.var_a30a0b3e, s_objective, 0);
    for (i = 0; i < 3; i++) {
        var_9b0e0b82 = i + 1;
        var_2f915a7 = var_2a8ed81a.var_a30a0b3e[i];
        var_5e4bcfc6 = var_59d61543 + ".teamSubObjective" + var_9b0e0b82;
        if (isdefined(var_2f915a7)) {
            if (var_2f915a7.var_9b0e0b82 != var_9b0e0b82) {
                clientfield::set_world_uimodel(var_5e4bcfc6 + ".objId", var_2f915a7.n_obj_id);
                clientfield::set_world_uimodel(var_5e4bcfc6 + ".state", var_2f915a7.var_8fec8087);
                var_2f915a7.var_9b0e0b82 = var_9b0e0b82;
            }
            continue;
        }
        if (clientfield::get_world_uimodel(var_5e4bcfc6 + ".objId") != 0) {
            clientfield::set_world_uimodel(var_5e4bcfc6 + ".objId", 0);
            clientfield::set_world_uimodel(var_5e4bcfc6 + ".state", 0);
        }
    }
    foreach (e_player in a_e_players) {
        e_player function_9b2f9303(s_objective);
    }
    s_objective.var_9b0e0b82 = undefined;
    s_objective.b_clearing = undefined;
}

// Namespace hud/hud_shared
// Params 2, eflags: 0x4
// Checksum 0xbe44e76e, Offset: 0x34e0
// Size: 0x238
function private function_ad7e7db1(e_player, var_f84d75dc) {
    if (isdefined(e_player)) {
        a_e_players = array(e_player);
    } else {
        a_e_players = util::get_players(var_f84d75dc);
    }
    var_59d61543 = "hudItems.cpObjective.perPlayer.subObjective";
    foreach (e_player in a_e_players) {
        if (!isdefined(e_player.var_a30a0b3e)) {
            e_player.var_a30a0b3e = [];
        } else if (!isarray(e_player.var_a30a0b3e)) {
            e_player.var_a30a0b3e = array(e_player.var_a30a0b3e);
        }
        if (!isinarray(e_player.var_a30a0b3e, self)) {
            e_player.var_a30a0b3e[e_player.var_a30a0b3e.size] = self;
        }
        var_9b0e0b82 = getlastarraykey(e_player.var_a30a0b3e) + 1;
        if (!isdefined(self.var_905e4750)) {
            self.var_905e4750 = [];
        }
        self.var_905e4750[e_player getentitynumber()] = var_9b0e0b82;
        if (var_9b0e0b82 <= 3) {
            e_player clientfield::set_player_uimodel(var_59d61543 + var_9b0e0b82 + ".objId", self.n_obj_id);
            e_player clientfield::set_player_uimodel(var_59d61543 + var_9b0e0b82 + ".state", 0);
        }
    }
}

// Namespace hud/hud_shared
// Params 3, eflags: 0x4
// Checksum 0x922cc843, Offset: 0x3720
// Size: 0x196
function private function_d0ff121f(a_e_players, var_f84d75dc, n_state) {
    if (isdefined(self.var_905e4750)) {
        foreach (e_player in a_e_players) {
            var_9b0e0b82 = self.var_905e4750[e_player getentitynumber()];
            if (isdefined(var_9b0e0b82) && var_9b0e0b82 <= 3) {
                e_player clientfield::set_player_uimodel("hudItems.cpObjective.perPlayer.subObjective" + var_9b0e0b82 + ".state", n_state);
                if (!isdefined(e_player.var_d20403b5)) {
                    e_player.var_d20403b5 = [];
                } else if (!isarray(e_player.var_d20403b5)) {
                    e_player.var_d20403b5 = array(e_player.var_d20403b5);
                }
                if (!isinarray(e_player.var_d20403b5, self)) {
                    e_player.var_d20403b5[e_player.var_d20403b5.size] = self;
                }
            }
        }
    }
}

// Namespace hud/hud_shared
// Params 1, eflags: 0x4
// Checksum 0xa2952263, Offset: 0x38c0
// Size: 0x284
function private function_9b2f9303(s_objective) {
    if (isdefined(self.var_a30a0b3e)) {
        arrayremovevalue(self.var_a30a0b3e, s_objective, 0);
        for (i = 0; i < 3; i++) {
            var_9b0e0b82 = i + 1;
            var_2f915a7 = self.var_a30a0b3e[i];
            var_59d61543 = "hudItems.cpObjective.perPlayer.subObjective" + var_9b0e0b82;
            if (isdefined(var_2f915a7)) {
                if (var_2f915a7.var_905e4750[self getentitynumber()] != var_9b0e0b82) {
                    self clientfield::set_player_uimodel(var_59d61543 + ".objId", var_2f915a7.n_obj_id);
                    self clientfield::set_player_uimodel(var_59d61543 + ".state", var_2f915a7.var_8fec8087);
                    var_2f915a7.var_905e4750[self getentitynumber()] = var_9b0e0b82;
                }
                continue;
            }
            if (clientfield::get_player_uimodel(var_59d61543 + ".objId") != 0) {
                self clientfield::set_player_uimodel(var_59d61543 + ".objId", 0);
                self clientfield::set_player_uimodel(var_59d61543 + ".state", 0);
            }
        }
        if (isdefined(self.var_d20403b5)) {
            arrayremovevalue(self.var_d20403b5, s_objective, 0);
        }
        s_objective.var_905e4750[self getentitynumber()] = undefined;
        if (!isdefined(s_objective.var_905e4750) || !s_objective.var_905e4750.size) {
            s_objective.var_905e4750 = undefined;
            if (isdefined(s_objective.var_da25e20f) && s_objective.var_da25e20f) {
                s_objective.var_8fec8087 = undefined;
                gameobjects::release_obj_id(s_objective.n_obj_id);
            }
        }
    }
}

// Namespace hud/hud_shared
// Params 6, eflags: 0x0
// Checksum 0x463bdafe, Offset: 0x3b50
// Size: 0x284
function set_pvp_objective(str_identifier, n_obj_id, n_widget, var_369cd3c9, var_8546e417, var_2f9ed402) {
    foreach (str_flag in array("pvp_objective_set_allies", "pvp_objective_set_axis")) {
        self flag::init(str_flag);
    }
    mission flag::wait_till_clear("pvp_objectives_updating");
    mission flag::set("pvp_objectives_updating");
    var_960b19b6 = 1;
    foreach (var_f84d75dc in array(#"axis", #"allies")) {
        if (var_2f9ed402 === var_f84d75dc) {
            var_612c536 = var_8546e417;
        } else {
            var_612c536 = n_widget;
        }
        if (isdefined(var_960b19b6) && var_960b19b6) {
            var_960b19b6 = undefined;
            self thread set_team_objective(str_identifier, var_f84d75dc, n_obj_id, var_612c536, var_369cd3c9, 1);
            continue;
        }
        self set_team_objective(str_identifier, var_f84d75dc, n_obj_id, var_612c536, var_369cd3c9, 1);
    }
    flag::wait_till_all(array("pvp_objective_set_allies", "pvp_objective_set_axis"));
    mission flag::clear("pvp_objectives_updating");
}

// Namespace hud/hud_shared
// Params 3, eflags: 0x0
// Checksum 0x98d12323, Offset: 0x3de0
// Size: 0x1c0
function function_5c9ebeef(str_identifier, str_winning_team = #"none", var_9927e929 = 1) {
    var_eaafc8f = util::get_team_mapping(str_winning_team);
    var_960b19b6 = 1;
    var_9927e929 = str_winning_team == #"none" && var_9927e929;
    foreach (var_f84d75dc in array(#"axis", #"allies")) {
        if (var_9927e929 || var_eaafc8f == var_f84d75dc) {
            b_success = 1;
        } else {
            b_success = 0;
        }
        if (isdefined(var_960b19b6) && var_960b19b6) {
            var_960b19b6 = undefined;
            self thread function_cc438a9c(str_identifier, var_f84d75dc, b_success, undefined, 1);
            continue;
        }
        self function_cc438a9c(str_identifier, var_f84d75dc, b_success, undefined, 1);
    }
}

// Namespace hud/hud_shared
// Params 3, eflags: 0x0
// Checksum 0x21300e44, Offset: 0x3fa8
// Size: 0x24c
function function_fce4945(str_team, var_98b35460 = 1, var_8f10b446) {
    var_f84d75dc = util::get_team_mapping(str_team);
    var_93bc6578 = 0;
    if (var_f84d75dc == #"allies") {
        if (isdefined(self.var_a902757b) && self.var_a902757b > 0) {
            n_progress = self.var_a902757b;
        }
        if (1 && (!isdefined(self.var_2a83638e) || self.var_2a83638e == 0)) {
            var_93bc6578 = 1;
        }
    } else if (var_f84d75dc == #"axis") {
        if (isdefined(self.var_2a83638e) && self.var_2a83638e > 0) {
            n_progress = self.var_2a83638e;
        }
        if (1 && (!isdefined(self.var_a902757b) || self.var_a902757b == 0)) {
            var_93bc6578 = 1;
        }
    }
    if (!isdefined(n_progress)) {
        return;
    }
    level function_16be43d7();
    n_progress *= var_98b35460;
    if (isdefined(self.var_3233af7) && isdefined(self.var_3233af7[var_f84d75dc])) {
        if (n_progress <= self.var_3233af7[var_f84d75dc]) {
            return;
        }
        var_c33d32cf = n_progress - self.var_3233af7[var_f84d75dc];
    } else {
        var_c33d32cf = n_progress;
    }
    if (!isdefined(self.var_3233af7)) {
        self.var_3233af7 = [];
    }
    self.var_3233af7[var_f84d75dc] = n_progress;
    var_60d31e08 = var_c33d32cf + level.var_78fc3773[var_f84d75dc];
    level function_86f89220(var_f84d75dc, var_60d31e08, var_93bc6578);
}

// Namespace hud/hud_shared
// Params 3, eflags: 0x4
// Checksum 0x3e1e0b27, Offset: 0x4200
// Size: 0x134
function private function_86f89220(var_f84d75dc, n_progress, var_93bc6578) {
    n_progress = math::clamp(n_progress, 0, 100);
    if (n_progress > level.var_78fc3773[var_f84d75dc]) {
        level.var_78fc3773[var_f84d75dc] = n_progress;
        if (isdefined(level.var_f5de7589) && isdefined(level.var_f5de7589[var_f84d75dc]) && level.var_f5de7589[var_f84d75dc] > n_progress) {
            return;
        }
        clientfield::set_world_uimodel("hudItems.cpObjective." + level.teams[var_f84d75dc] + ".totalProgress", n_progress / 100);
        if (var_93bc6578 && !(isdefined(level.var_8ed85d1e) && level.var_8ed85d1e)) {
            level thread function_72778e2d(var_f84d75dc, n_progress);
        }
    }
}

// Namespace hud/hud_shared
// Params 2, eflags: 0x4
// Checksum 0xbb0fbabe, Offset: 0x4340
// Size: 0x1e4
function private function_72778e2d(var_f84d75dc, n_progress) {
    if (n_progress >= 100) {
        return;
    }
    var_f75257ef = util::get_enemy_team(var_f84d75dc);
    if (!isdefined(level.var_f5de7589)) {
        level.var_f5de7589 = [];
    }
    if (!isdefined(level.var_f5de7589[var_f75257ef])) {
        level.var_f5de7589[var_f75257ef] = 0;
    }
    wait randomfloatrange(0.5, 3);
    var_b4e6c6b2 = n_progress - 10;
    if (randomint(100) > 90 && n_progress + 2.5 < 100) {
        var_7243b78 = n_progress + 2.5;
    } else {
        var_7243b78 = n_progress;
    }
    n_progress = randomfloatrange(var_b4e6c6b2, var_7243b78);
    n_progress = math::clamp(n_progress, 0, 100);
    if (n_progress > level.var_f5de7589[var_f75257ef]) {
        level.var_f5de7589[var_f75257ef] = n_progress;
        if (n_progress > level.var_78fc3773[var_f75257ef]) {
            clientfield::set_world_uimodel("hudItems.cpObjective." + level.teams[var_f75257ef] + ".totalProgress", n_progress / 100);
        }
    }
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x4
// Checksum 0x26885c7b, Offset: 0x4530
// Size: 0xc2
function private function_16be43d7() {
    if (!isdefined(level.var_78fc3773)) {
        level.var_78fc3773 = [];
        foreach (var_51f4b5ae in array(#"axis", #"allies")) {
            level.var_78fc3773[var_51f4b5ae] = 0;
        }
    }
}

// Namespace hud/hud_shared
// Params 1, eflags: 0x0
// Checksum 0x69656d46, Offset: 0x4600
// Size: 0x1a
function function_932e3eac(var_d26737b1) {
    self.var_d26737b1 = var_d26737b1;
}

// Namespace hud/hud_shared
// Params 1, eflags: 0x0
// Checksum 0x3aca8b, Offset: 0x4628
// Size: 0x1a
function function_9326c2b8(var_38e380b3) {
    self.var_38e380b3 = var_38e380b3;
}

// Namespace hud/hud_shared
// Params 1, eflags: 0x0
// Checksum 0x28ada1e7, Offset: 0x4650
// Size: 0x1a
function function_f0a5c700(var_f5896223) {
    self.var_f5896223 = var_f5896223;
}

// Namespace hud/hud_shared
// Params 1, eflags: 0x0
// Checksum 0xc2179af7, Offset: 0x4678
// Size: 0x1a
function function_bee6f5f1(var_be280400) {
    self.var_be280400 = var_be280400;
}

// Namespace hud/hud_shared
// Params 1, eflags: 0x0
// Checksum 0xce6b6ab, Offset: 0x46a0
// Size: 0x1a
function function_f9d38dd1(var_124a1de4) {
    self.var_124a1de4 = var_124a1de4;
}

// Namespace hud/hud_shared
// Params 5, eflags: 0x0
// Checksum 0x8e19c8d3, Offset: 0x46c8
// Size: 0x78c
function mission_result(str_winning_team, var_c95b80c2 = #"hash_6ef5bcff7fb1d1ab", var_119a0567 = #"hash_6ef5bcff7fb1d1ab", var_fd8edd85 = 0, var_65b381b5 = 0.5) {
    foreach (e_player in util::get_human_players()) {
        if (e_player util::is_on_side(str_winning_team)) {
            var_779bc121 = #"hash_7fd63164f504dda1";
            var_f9200575 = var_c95b80c2;
        } else {
            var_779bc121 = #"hash_294bb2c7021b1b72";
            var_f9200575 = var_119a0567;
        }
        if (isdefined(level.var_fd960914)) {
            var_2a8ed81a = level.var_fd960914[e_player.team];
        }
        if (isdefined(var_2a8ed81a) && !(isdefined(var_2a8ed81a.var_2f50f33) && var_2a8ed81a.var_2f50f33)) {
            e_player.var_45319e28 = e_player openluimenu("CPLoseTransition");
            e_player setluimenudata(e_player.var_45319e28, #"fade_out", 0);
        }
    }
    world.str_winning_team = str_winning_team;
    if (var_fd8edd85) {
        function_cf892131();
        a_players = util::get_players();
        array::run_all(a_players, &setlowready, 1);
        array::thread_all(a_players, &val::set, "mission_result", "show_hud", 0);
        array::thread_all(a_players, &val::set, "mission_result", "ignoreme", 1);
        array::thread_all(a_players, &val::set, "mission_result", "takedamage", 0);
        if (str_winning_team == #"allies") {
            voiceparams = {#team:#"allies", #side:#"allies", #targetname:level.mission_name};
            voiceevent("mssn_succ", undefined, voiceparams);
            voiceparams = {#team:#"axis", #side:#"axis", #targetname:level.mission_name};
            voiceevent("mssn_fail", undefined, voiceparams);
        } else {
            voiceparams = {#team:#"axis", #side:#"axis", #targetname:level.mission_name};
            voiceevent("mssn_succ", undefined, voiceparams);
            voiceparams = {#team:#"allies", #side:#"allies", #targetname:level.mission_name};
            voiceevent("mssn_fail", undefined, voiceparams);
        }
        wait 1;
        array::thread_all(a_players, &val::set, "mission_result", "freezecontrols_allowlook", 1);
        wait 1;
        array::thread_all(a_players, &lui::screen_fade_out, 2, undefined, "mission_result", 1);
        wait 2.5;
        /#
            iprintln("<dev string:x30>" + var_65b381b5 + "<dev string:x59>");
        #/
        level util::streamer_wait(undefined, undefined, var_65b381b5);
        function_a51f5a1a();
        foreach (player in a_players) {
            player util::delay(0.25, "disconnect", &lui::screen_fade_in, 0.25, undefined, "mission_result");
        }
        array::run_all(a_players, &setlowready, 0);
        array::thread_all(a_players, &val::reset, "mission_result", "show_hud");
        array::thread_all(a_players, &val::reset, "mission_result", "freezecontrols_allowlook");
        array::thread_all(a_players, &val::reset, "mission_result", "ignoreme");
        array::thread_all(a_players, &val::reset, "mission_result", "takedamage");
        return;
    }
    wait 4;
    function_a51f5a1a();
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x4
// Checksum 0xb0c237d, Offset: 0x4e60
// Size: 0xdc
function private function_cf892131() {
    a_players = util::get_players();
    foreach (player in a_players) {
        if (player.sessionstate === #"spectator") {
            player thread [[ level.spawnplayer ]]();
            continue;
        }
        if (player laststand::player_is_in_laststand()) {
            player notify(#"auto_revive");
        }
    }
}

// Namespace hud/hud_shared
// Params 0, eflags: 0x0
// Checksum 0x60e152f1, Offset: 0x4f48
// Size: 0x1e0
function function_a51f5a1a() {
    if (!isdefined(level.var_fd960914)) {
        level function_62933add();
    }
    var_e7e2ef51 = [];
    foreach (e_player in util::get_human_players()) {
        var_2a8ed81a = level.var_fd960914[e_player.team];
        if (isdefined(e_player.var_45319e28)) {
            e_player setluimenudata(e_player.var_45319e28, #"fade_out", 1);
            if (!isdefined(var_e7e2ef51)) {
                var_e7e2ef51 = [];
            } else if (!isarray(var_e7e2ef51)) {
                var_e7e2ef51 = array(var_e7e2ef51);
            }
            var_e7e2ef51[var_e7e2ef51.size] = e_player;
        }
    }
    if (var_e7e2ef51.size) {
        wait 1;
        foreach (e_player in var_e7e2ef51) {
            e_player closeluimenu(e_player.var_45319e28);
        }
    }
}

// Namespace hud/hud_shared
// Params 3, eflags: 0x0
// Checksum 0x5c7798fc, Offset: 0x5130
// Size: 0x116
function objective_result(str_winning_team, var_c95b80c2 = #"hash_6ef5bcff7fb1d1ab", var_119a0567 = #"hash_6ef5bcff7fb1d1ab") {
    var_779bc121 = #"hash_70cccbb95b710d8c";
    foreach (e_player in level.players) {
        if (isalive(e_player)) {
            if (e_player util::is_on_side(str_winning_team)) {
                var_f9200575 = var_c95b80c2;
                continue;
            }
            var_f9200575 = var_119a0567;
        }
    }
}

// Namespace hud/hud_shared
// Params 6, eflags: 0x0
// Checksum 0xc597c9d3, Offset: 0x5250
// Size: 0x1b4
function function_eb3ab4c(str_team, str_objective, var_e7aae02c, e_player, var_58904c59 = 0, var_f7583ada = 0) {
    if (!isdefined(level.var_fd960914)) {
        level function_62933add();
    }
    var_f84d75dc = util::get_team_mapping(str_team);
    var_2a8ed81a = level.var_fd960914[var_f84d75dc];
    var_59d61543 = "hudItems.cpObjective." + level.teams[var_f84d75dc];
    n_obj_id = gameobjects::get_next_obj_id();
    objective_add(n_obj_id, "invisible", undefined, str_objective);
    objective_setteam(n_obj_id, var_f84d75dc);
    var_fc85577e = {#n_obj_id:n_obj_id, #var_da25e20f:1, #str_objective:str_objective, #var_f7583ada:var_f7583ada};
    if (isdefined(var_e7aae02c)) {
        var_fc85577e.var_e7aae02c = var_e7aae02c;
    }
    level function_124728d4(var_2a8ed81a, var_59d61543, var_fc85577e, var_f84d75dc, e_player);
}

// Namespace hud/hud_shared
// Params 4, eflags: 0x0
// Checksum 0x4f8af3ac, Offset: 0x5410
// Size: 0x394
function function_17d37069(str_team, str_objective, b_success = 1, e_player) {
    if (!isdefined(level.var_fd960914)) {
        level function_62933add();
    }
    var_f84d75dc = util::get_team_mapping(str_team);
    var_2a8ed81a = level.var_fd960914[var_f84d75dc];
    var_59d61543 = "hudItems.cpObjective." + level.teams[var_f84d75dc];
    foreach (var_2f915a7 in var_2a8ed81a.var_a30a0b3e) {
        if (var_2f915a7.str_objective === str_objective && !(isdefined(var_2f915a7.b_clearing) && var_2f915a7.b_clearing)) {
            var_2f915a7.b_clearing = 1;
            var_b9a5ac4e = var_2f915a7;
            var_9ec5bf61 = 1;
            break;
        }
    }
    if (!isdefined(var_b9a5ac4e) && isdefined(e_player) && isdefined(e_player.var_a30a0b3e)) {
        foreach (var_2f915a7 in e_player.var_a30a0b3e) {
            if (isdefined(e_player.var_d20403b5) && isinarray(e_player.var_d20403b5, var_2f915a7)) {
                continue;
            }
            if (var_2f915a7.str_objective === str_objective) {
                var_2f915a7.b_clearing = 1;
                var_b9a5ac4e = var_2f915a7;
                var_9ec5bf61 = 0;
                break;
            }
        }
    }
    if (!isdefined(var_b9a5ac4e)) {
        return;
    }
    if (b_success) {
        n_state = 1;
    } else {
        n_state = 2;
    }
    if (var_9ec5bf61 && var_b9a5ac4e.var_9b0e0b82 <= 3) {
        clientfield::set_world_uimodel(var_59d61543 + ".teamSubObjective" + var_b9a5ac4e.var_9b0e0b82 + ".state", n_state);
    }
    var_b9a5ac4e.var_8fec8087 = n_state;
    if (isdefined(e_player)) {
        a_e_players = array(e_player);
    } else {
        a_e_players = util::get_players(var_f84d75dc);
    }
    var_b9a5ac4e function_d0ff121f(a_e_players, var_f84d75dc, n_state);
    wait 5;
    level function_9cdeeb1b(var_2a8ed81a, var_59d61543, var_b9a5ac4e, a_e_players);
}

// Namespace hud/hud_shared
// Params 4, eflags: 0x0
// Checksum 0x7ed82c26, Offset: 0x57b0
// Size: 0xcc
function function_7d39f651(str_team, n_progress, b_additive = 0, var_b8447fa5 = 0) {
    level function_16be43d7();
    var_f84d75dc = util::get_team_mapping(str_team);
    var_b8447fa5 = var_b8447fa5 && true;
    if (b_additive) {
        n_progress += level.var_78fc3773[var_f84d75dc];
    }
    level function_86f89220(var_f84d75dc, n_progress, var_b8447fa5);
}

// Namespace hud/hud_shared
// Params 2, eflags: 0x0
// Checksum 0x4ffeec18, Offset: 0x5888
// Size: 0x30c
function function_8235e78f(b_active, var_add577bc = array(#"axis", #"allies")) {
    if (!isdefined(level.var_bda11954)) {
        level.var_bda11954 = [];
        level.var_bda11954[#"allies"] = 0;
        level.var_bda11954[#"axis"] = 0;
    }
    if (!isarray(var_add577bc)) {
        if (!isdefined(var_add577bc)) {
            var_add577bc = [];
        } else if (!isarray(var_add577bc)) {
            var_add577bc = array(var_add577bc);
        }
    }
    if (b_active) {
        foreach (var_f84d75dc in var_add577bc) {
            foreach (e_player in util::get_players(var_f84d75dc)) {
                e_player clientfield::set_player_uimodel("hudItems.cpObjective.perPlayer.isPvp", 1);
            }
            level.var_bda11954[var_f84d75dc]++;
        }
        return;
    }
    foreach (var_f84d75dc in var_add577bc) {
        level.var_bda11954[var_f84d75dc]--;
        if (level.var_bda11954[var_f84d75dc] <= 0) {
            foreach (e_player in util::get_players(var_f84d75dc)) {
                e_player clientfield::set_player_uimodel("hudItems.cpObjective.perPlayer.isPvp", 0);
            }
        }
    }
}

