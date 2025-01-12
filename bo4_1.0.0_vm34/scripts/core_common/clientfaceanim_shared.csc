#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace clientfaceanim;

// Namespace clientfaceanim/clientfaceanim_shared
// Params 0, eflags: 0x2
// Checksum 0xc7617312, Offset: 0xa0
// Size: 0x34
function autoexec __init__system__() {
    system::register(#"clientfaceanim_shared", undefined, &main, undefined);
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 0, eflags: 0x0
// Checksum 0x11ad2b25, Offset: 0xe0
// Size: 0x8c
function main() {
    callback::on_spawned(&on_player_spawned);
    callback::on_localclient_connect(&on_localclient_connect);
    buildandvalidatefacialanimationlist(0);
    animation::add_notetrack_func(#"clientfaceanim::deathanimshutdown", &deathanimshutdown);
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x3ef2db1e, Offset: 0x178
// Size: 0x24
function private on_localclient_connect(localclientnum) {
    thread update_players(localclientnum);
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x1a949665, Offset: 0x1a8
// Size: 0x2c
function private on_player_spawned(localclientnum) {
    self callback::on_shutdown(&on_player_shutdown);
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0xf5f172cc, Offset: 0x1e0
// Size: 0xca
function private on_player_shutdown(localclientnum) {
    if (self isplayer()) {
        self notify(#"stopfacialthread");
        corpse = self getplayercorpse();
        if (!isdefined(corpse)) {
            return;
        }
        if (isdefined(corpse.facialdeathanimstarted) && corpse.facialdeathanimstarted) {
            return;
        }
        corpse util::waittill_dobj(localclientnum);
        if (isdefined(corpse)) {
            corpse applydeathanim(localclientnum);
            corpse.facialdeathanimstarted = 1;
        }
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x0
// Checksum 0xcbd5ae96, Offset: 0x2b8
// Size: 0x3c0
function buildandvalidatefacialanimationlist(localclientnum) {
    if (!isdefined(level.__clientfacialanimationslist)) {
        level.__clientfacialanimationslist = [];
        level.__clientfacialanimationslist[#"combat"] = array(#"ai_t8_face_hero_generic_idle_1", #"ai_t8_face_hero_generic_idle_2", #"ai_t8_face_hero_generic_idle_3");
        level.__clientfacialanimationslist[#"combat_shoot"] = array(#"ai_t8_face_hero_aim_fire_1", #"ai_t8_face_hero_aim_fire_2");
        level.__clientfacialanimationslist[#"death"] = array(#"ai_t8_face_hero_dth_1", #"ai_t8_face_hero_dth_2", #"ai_t8_face_hero_dth_3");
        level.__clientfacialanimationslist[#"melee"] = array(#"ai_t8_face_hero_melee_1");
        level.__clientfacialanimationslist[#"pain"] = array(#"ai_t8_face_hero_pain_1");
        level.__clientfacialanimationslist[#"swimming"] = array(#"mp_t8_face_hero_swim_idle_1");
        level.__clientfacialanimationslist[#"jumping"] = array(#"mp_t8_face_hero_jump_idle_1");
        level.__clientfacialanimationslist[#"sliding"] = array(#"mp_t8_face_hero_slides_1");
        level.__clientfacialanimationslist[#"sprinting"] = array(#"mp_t8_face_hero_sprint_1");
        level.__clientfacialanimationslist[#"wallrunning"] = array(#"mp_t8_face_hero_wall_run_1");
        deathanims = level.__clientfacialanimationslist[#"death"];
        foreach (deathanim in deathanims) {
            assert(!isanimlooping(localclientnum, deathanim), "<dev string:x30>" + deathanim + "<dev string:x56>");
        }
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x3130e9b1, Offset: 0x680
// Size: 0x144
function private facialanimationthink_getwaittime(localclientnum) {
    min_wait = 0.1;
    max_wait = 1;
    min_wait_distance_sq = 2500;
    max_wait_distance_sq = 640000;
    if (self function_60dbc438() && !isthirdperson(localclientnum)) {
        return max_wait;
    }
    local_player = function_f97e7787(localclientnum);
    distancesq = distancesquared(local_player.origin, self.origin);
    if (distancesq > max_wait_distance_sq) {
        distance_factor = 1;
    } else if (distancesq < min_wait_distance_sq) {
        distance_factor = 0;
    } else {
        distance_factor = (distancesq - min_wait_distance_sq) / (max_wait_distance_sq - min_wait_distance_sq);
    }
    return (max_wait - min_wait) * distance_factor + min_wait;
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0xe29eb7f8, Offset: 0x7d0
// Size: 0x206
function private function_7206ea49(local_client_num) {
    max_players = 10;
    max_distance = 2000;
    var_4209d54 = max_distance * max_distance;
    camera_origin = getcamposbylocalclientnum(local_client_num);
    players = getplayers(local_client_num);
    players = arraysort(players, camera_origin);
    first_person = function_5459d334(local_client_num);
    time = gettime();
    count = 0;
    foreach (player in players) {
        if (first_person && player function_60dbc438()) {
            continue;
        }
        if (player.team == #"spectator") {
            continue;
        }
        distance_sq = distancesquared(camera_origin, player.origin);
        if (distance_sq > var_4209d54) {
            return;
        }
        if ((isdefined(player.var_35808940) ? player.var_35808940 : 0) < time) {
            updatefacialanimforplayer(local_client_num, player);
        }
        count++;
        if (count == max_players) {
            return;
        }
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x9448f5c7, Offset: 0x9e0
// Size: 0x46
function private update_players(local_client_num) {
    var_51119eef = 1;
    while (true) {
        function_7206ea49(local_client_num);
        wait var_51119eef;
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 2, eflags: 0x4
// Checksum 0x4fd916d1, Offset: 0xa30
// Size: 0x2ce
function private updatefacialanimforplayer(localclientnum, player) {
    if (!isdefined(player._currentfacestate)) {
        player._currentfacestate = "inactive";
    }
    if (!player hasdobj(localclientnum)) {
        return;
    }
    currfacestate = player._currentfacestate;
    nextfacestate = player._currentfacestate;
    currenttime = gettime();
    if (player isinscritpedanim()) {
        clearallfacialanims(localclientnum);
        player._currentfacestate = "inactive";
        return;
    }
    if (player isplayerdead()) {
        nextfacestate = #"death";
    } else if (player isplayerfiring()) {
        nextfacestate = #"combat_shoot";
    } else if (player isplayersliding()) {
        nextfacestate = #"sliding";
    } else if (player isplayerwallrunning()) {
        nextfacestate = #"wallrunning";
    } else if (player isplayersprinting()) {
        nextfacestate = #"sprinting";
    } else if (player isplayerjumping() || player isplayerdoublejumping()) {
        nextfacestate = #"jumping";
    } else if (player isplayerswimming()) {
        nextfacestate = #"swimming";
    } else {
        nextfacestate = #"combat";
    }
    if (player._currentfacestate == "inactive" || currfacestate != nextfacestate) {
        assert(isdefined(level.__clientfacialanimationslist[nextfacestate]));
        player applynewfaceanim(localclientnum, array::random(level.__clientfacialanimationslist[nextfacestate]));
        player._currentfacestate = nextfacestate;
    }
    player.var_35808940 = gettime() + player facialanimationthink_getwaittime(localclientnum);
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 2, eflags: 0x4
// Checksum 0x1d2af366, Offset: 0xd08
// Size: 0x7c
function private applynewfaceanim(localclientnum, animation) {
    clearallfacialanims(localclientnum);
    if (isdefined(animation)) {
        self._currentfaceanim = animation;
        self setflaggedanimknob(#"ai_secondary_facial_anim", animation, 0.9, 0.1, 1);
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0xfd051606, Offset: 0xd90
// Size: 0xbc
function private applydeathanim(localclientnum) {
    if (isdefined(self._currentfacestate) && self._currentfacestate == #"death") {
        return;
    }
    if (isdefined(self) && isdefined(level.__clientfacialanimationslist) && isdefined(level.__clientfacialanimationslist[#"death"])) {
        self._currentfacestate = #"death";
        applynewfaceanim(localclientnum, array::random(level.__clientfacialanimationslist[#"death"]));
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x36eed9ce, Offset: 0xe58
// Size: 0x2c
function private deathanimshutdown(notifystring) {
    self clearallfacialanims(self.localclientnum);
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x7a7de6a6, Offset: 0xe90
// Size: 0x5e
function private clearallfacialanims(localclientnum) {
    if (isdefined(self._currentfaceanim) && self hasdobj(localclientnum)) {
        self clearanim(self._currentfaceanim, 0.2);
    }
    self._currentfaceanim = undefined;
}

