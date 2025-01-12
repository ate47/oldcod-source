#using scripts/core_common/array_shared;
#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;

#namespace clientfaceanim;

// Namespace clientfaceanim/clientfaceanim_shared
// Params 0, eflags: 0x2
// Checksum 0x4f9fd567, Offset: 0x348
// Size: 0x2c
function autoexec function_2dc19561() {
    system::register("clientfaceanim_shared", undefined, &main, undefined);
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x380
// Size: 0x4
function main() {
    
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x1ab91bf9, Offset: 0x390
// Size: 0x5c
function private on_player_spawned(localclientnum) {
    function_4f353102(localclientnum);
    self callback::on_shutdown(&on_player_shutdown);
    self thread on_player_death(localclientnum);
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x3e758f5a, Offset: 0x3f8
// Size: 0xd8
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
// Params 1, eflags: 0x4
// Checksum 0x7579ae91, Offset: 0x4d8
// Size: 0xd8
function private on_player_death(localclientnum) {
    self waittill("death");
    if (self isplayer()) {
        self notify(#"stopfacialthread");
        corpse = self getplayercorpse();
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
// Params 1, eflags: 0x4
// Checksum 0x9b9e9d00, Offset: 0x5b8
// Size: 0x54
function private function_4f353102(localclientnum) {
    buildandvalidatefacialanimationlist(localclientnum);
    if (self isplayer()) {
        self thread function_48af690b(localclientnum);
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x0
// Checksum 0x99f8df9b, Offset: 0x618
// Size: 0x312
function buildandvalidatefacialanimationlist(localclientnum) {
    if (!isdefined(level.__clientfacialanimationslist)) {
        level.__clientfacialanimationslist = [];
        level.__clientfacialanimationslist["combat"] = array("ai_face_male_generic_idle_1", "ai_face_male_generic_idle_2", "ai_face_male_generic_idle_3");
        level.__clientfacialanimationslist["combat_shoot"] = array("ai_face_male_aim_fire_1", "ai_face_male_aim_fire_2", "ai_face_male_aim_fire_3");
        level.__clientfacialanimationslist["death"] = array("ai_face_male_death_1", "ai_face_male_death_2", "ai_face_male_death_3");
        level.__clientfacialanimationslist["melee"] = array("ai_face_male_melee_1");
        level.__clientfacialanimationslist["pain"] = array("ai_face_male_pain_1");
        level.__clientfacialanimationslist["swimming"] = array("mp_face_male_swim_idle_1");
        level.__clientfacialanimationslist["jumping"] = array("mp_face_male_jump_idle_1");
        level.__clientfacialanimationslist["sliding"] = array("mp_face_male_slides_1");
        level.__clientfacialanimationslist["sprinting"] = array("mp_face_male_sprint_1");
        level.__clientfacialanimationslist["wallrunning"] = array("mp_face_male_wall_run_1");
        deathanims = level.__clientfacialanimationslist["death"];
        foreach (deathanim in deathanims) {
            /#
                assert(!isanimlooping(localclientnum, deathanim), "<dev string:x28>" + deathanim + "<dev string:x4e>");
            #/
        }
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x1e7944e4, Offset: 0x938
// Size: 0x150
function private facialanimationthink_getwaittime(localclientnum) {
    min_wait = 0.1;
    max_wait = 1;
    min_wait_distance_sq = 2500;
    max_wait_distance_sq = 640000;
    local_player = getlocalplayer(localclientnum);
    if (local_player == self && !isthirdperson(localclientnum)) {
        return max_wait;
    }
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
// Checksum 0x48a2211e, Offset: 0xa90
// Size: 0xe2
function private function_48af690b(localclientnum) {
    self endon(#"death");
    self notify(#"stopfacialthread");
    self endon(#"stopfacialthread");
    if (isdefined(self.var_d4f49ba0)) {
        return;
    }
    self.var_d4f49ba0 = 1;
    /#
        assert(self isplayer());
    #/
    self util::waittill_dobj(localclientnum);
    while (true) {
        updatefacialanimforplayer(localclientnum, self);
        wait_time = self facialanimationthink_getwaittime(localclientnum);
        wait wait_time;
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 2, eflags: 0x4
// Checksum 0xe558bf3f, Offset: 0xb80
// Size: 0x298
function private updatefacialanimforplayer(localclientnum, player) {
    if (!isdefined(player._currentfacestate)) {
        player._currentfacestate = "inactive";
    }
    currfacestate = player._currentfacestate;
    nextfacestate = player._currentfacestate;
    if (player isinscritpedanim()) {
        clearallfacialanims(localclientnum);
        player._currentfacestate = "inactive";
        return;
    }
    if (player isplayerdead()) {
        nextfacestate = "death";
    } else if (player isplayerfiring()) {
        nextfacestate = "combat_shoot";
    } else if (player isplayersliding()) {
        nextfacestate = "sliding";
    } else if (player isplayerwallrunning()) {
        nextfacestate = "wallrunning";
    } else if (player isplayersprinting()) {
        nextfacestate = "sprinting";
    } else if (player isplayerjumping() || player isplayerdoublejumping()) {
        nextfacestate = "jumping";
    } else if (player isplayerswimming()) {
        nextfacestate = "swimming";
    } else {
        nextfacestate = "combat";
    }
    if (player._currentfacestate == "inactive" || currfacestate != nextfacestate) {
        /#
            assert(isdefined(level.__clientfacialanimationslist[nextfacestate]));
        #/
        applynewfaceanim(localclientnum, array::random(level.__clientfacialanimationslist[nextfacestate]));
        player._currentfacestate = nextfacestate;
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 2, eflags: 0x4
// Checksum 0xc858540, Offset: 0xe20
// Size: 0x7c
function private applynewfaceanim(localclientnum, animation) {
    clearallfacialanims(localclientnum);
    if (isdefined(animation)) {
        self._currentfaceanim = animation;
        self setflaggedanimknob("ai_secondary_facial_anim", animation, 1, 0.1, 1);
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x91ec889c, Offset: 0xea8
// Size: 0xb4
function private applydeathanim(localclientnum) {
    if (isdefined(self._currentfacestate) && self._currentfacestate == "death") {
        return;
    }
    if (isdefined(self) && isdefined(level.__clientfacialanimationslist) && isdefined(level.__clientfacialanimationslist["death"])) {
        self._currentfacestate = "death";
        applynewfaceanim(localclientnum, array::random(level.__clientfacialanimationslist["death"]));
    }
}

// Namespace clientfaceanim/clientfaceanim_shared
// Params 1, eflags: 0x4
// Checksum 0x4e3b822e, Offset: 0xf68
// Size: 0x66
function private clearallfacialanims(localclientnum) {
    if (isdefined(self._currentfaceanim) && self hasdobj(localclientnum)) {
        self clearanim(self._currentfaceanim, 0.2);
    }
    self._currentfaceanim = undefined;
}

