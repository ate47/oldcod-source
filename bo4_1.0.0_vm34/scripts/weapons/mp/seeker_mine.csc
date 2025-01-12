#using script_36556543de898549;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\seeker_mine;

#namespace seeker_mine_mp;

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x2
// Checksum 0x6498c17a, Offset: 0x1b0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"seeker_mine_mp", &__init__, undefined, undefined);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 0, eflags: 0x0
// Checksum 0x2ca97876, Offset: 0x1f8
// Size: 0xfc
function __init__() {
    vehicle::add_vehicletype_callback("veh_seeker_mine_mp", &spawned);
    clientfield::register("allplayers", "seeker_mine_shock", 1, 1, "int", &function_9dd9b86, 0, 0);
    clientfield::register("scriptmover", "seeker_mine_fx", 1, 2, "int", &seeker_mine_fx, 0, 0);
    level.seeker_mine_prompt = seeker_mine_prompt::register("seeker_mine_prompt");
    callback::on_player_corpse(&on_player_corpse);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 7, eflags: 0x0
// Checksum 0x65d250b4, Offset: 0x300
// Size: 0x10e
function function_9dd9b86(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_9dd9b86 = 1;
        if (self function_60dbc438()) {
            camfx = playfxoncamera(localclientnum, "player/fx8_plyr_pstfx_paralyze_screen");
            setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.playerIsShocked"), 1);
            self function_3917f637(localclientnum, camfx);
        }
        return;
    }
    self.var_9dd9b86 = 0;
    self notify(#"hash_43f06be9944cddc1");
}

// Namespace seeker_mine_mp/seeker_mine
// Params 7, eflags: 0x0
// Checksum 0xdc6dc320, Offset: 0x418
// Size: 0x114
function seeker_mine_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval > 0) {
        if (isdefined(self.seeker_fx)) {
            stopfx(localclientnum, self.seeker_fx);
            self notify(#"hash_6b4bac2b8c2122ef");
        }
        if (newval == 1) {
            self.seeker_fx = util::playfxontag(localclientnum, "player/fx8_plyr_shocked_stage1_3p", self, "tag_origin");
        } else {
            self.seeker_fx = util::playfxontag(localclientnum, "player/fx8_plyr_shocked_stage2_3p", self, "tag_origin");
        }
        self thread function_b46b8c04(localclientnum, self.seeker_fx);
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x11d2b48c, Offset: 0x538
// Size: 0x5c
function function_b46b8c04(localclientnum, fx) {
    self waittill(#"death", #"hash_6b4bac2b8c2122ef");
    if (isdefined(fx)) {
        stopfx(localclientnum, fx);
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0x1a54b846, Offset: 0x5a0
// Size: 0x8c
function on_player_corpse(localclientnum, params) {
    self endon(#"death");
    if (isdefined(params.player.var_9dd9b86) && params.player.var_9dd9b86) {
        self util::waittill_dobj(localclientnum);
        playtagfxset(localclientnum, "weapon_hero_seeker_drone_death", self);
    }
}

// Namespace seeker_mine_mp/seeker_mine
// Params 2, eflags: 0x0
// Checksum 0xbe5863f9, Offset: 0x638
// Size: 0x9c
function function_3917f637(localclientnum, camfx) {
    self waittill(#"death", #"hash_43f06be9944cddc1");
    if (isdefined(camfx)) {
        stopfx(localclientnum, camfx);
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.playerIsShocked"), 0);
}

// Namespace seeker_mine_mp/seeker_mine
// Params 1, eflags: 0x4
// Checksum 0xe4947bb5, Offset: 0x6e0
// Size: 0x3c
function private spawned(localclientnum) {
    self function_636e7d72(1);
    self seeker_mine::spawned(localclientnum);
}

