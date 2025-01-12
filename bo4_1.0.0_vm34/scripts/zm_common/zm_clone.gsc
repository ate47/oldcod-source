#using scripts\core_common\struct;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_clone;

// Namespace zm_clone/zm_clone
// Params 4, eflags: 0x0
// Checksum 0xa109bc59, Offset: 0xf0
// Size: 0x4fa
function spawn_player_clone(player, origin = player.origin, forceweapon, forcemodel) {
    primaryweapons = player getweaponslistprimaries();
    if (isdefined(forceweapon)) {
        weapon = forceweapon;
    } else if (primaryweapons.size) {
        weapon = primaryweapons[0];
    } else {
        weapon = player getcurrentweapon();
    }
    weaponmodel = weapon.worldmodel;
    spawner = getent("fake_player_spawner", "targetname");
    if (isdefined(spawner)) {
        clone = spawner spawnfromspawner();
        clone.origin = origin;
        clone.isactor = 1;
    } else {
        clone = spawn("script_model", origin);
        clone.isactor = 0;
    }
    if (isdefined(forcemodel)) {
        clone setmodel(forcemodel);
    } else {
        if (player function_7cc69e51()) {
            var_30f28185 = player function_fb7ff145();
            if (isdefined(var_30f28185)) {
                clone setmodel(var_30f28185);
            }
            headmodel = player function_48b6673e();
            if (isdefined(headmodel)) {
                if (isdefined(clone.head)) {
                    clone detach(clone.head);
                }
                clone attach(headmodel);
            }
            if (isdefined(clone.legs)) {
                clone detach(clone.legs);
            }
            if (isdefined(clone.torso)) {
                clone detach(clone.torso);
            }
        } else {
            var_b6982d63 = player function_dd025223();
            if (isdefined(var_b6982d63)) {
                clone setmodel(var_b6982d63);
            }
            headmodel = player function_48b6673e();
            if (isdefined(headmodel)) {
                if (isdefined(clone.head)) {
                    clone detach(clone.head);
                }
                clone attach(headmodel);
            }
            var_eb59dd61 = player function_2d8b2021();
            if (isdefined(var_eb59dd61)) {
                if (isdefined(clone.legs)) {
                    clone detach(clone.legs);
                }
                clone attach(var_eb59dd61);
            }
            var_30f28185 = player function_fb7ff145();
            if (isdefined(var_30f28185)) {
                if (isdefined(clone.torso)) {
                    clone detach(clone.torso);
                }
                clone attach(var_30f28185);
            }
        }
        clone setbodyrenderoptionspacked(player getcharacterbodyrenderoptions());
    }
    if (weaponmodel != "" && weaponmodel != "none") {
        clone attach(weaponmodel, "tag_weapon_right");
    }
    clone.team = player.team;
    clone.is_inert = 1;
    clone.zombie_move_speed = "walk";
    clone.script_noteworthy = "corpse_clone";
    clone.actor_damage_func = &clone_damage_func;
    return clone;
}

// Namespace zm_clone/zm_clone
// Params 11, eflags: 0x0
// Checksum 0x72173953, Offset: 0x5f8
// Size: 0xb2
function clone_damage_func(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    idamage = 0;
    if (weapon.isballisticknife && zm_weapons::is_weapon_upgraded(weapon)) {
        self notify(#"player_revived", {#reviver:eattacker});
    }
    return idamage;
}

// Namespace zm_clone/zm_clone
// Params 1, eflags: 0x0
// Checksum 0xf63921ef, Offset: 0x6b8
// Size: 0x64
function clone_give_weapon(weapon) {
    weaponmodel = weapon.worldmodel;
    if (weaponmodel != "" && weaponmodel != "none") {
        self attach(weaponmodel, "tag_weapon_right");
    }
}

// Namespace zm_clone/zm_clone
// Params 1, eflags: 0x0
// Checksum 0x845ec222, Offset: 0x728
// Size: 0x44
function clone_animate(animtype) {
    if (self.isactor) {
        self thread clone_actor_animate(animtype);
        return;
    }
    self thread clone_mover_animate(animtype);
}

// Namespace zm_clone/zm_clone
// Params 1, eflags: 0x0
// Checksum 0x79962732, Offset: 0x778
// Size: 0x9a
function clone_actor_animate(animtype) {
    wait 0.1;
    switch (animtype) {
    case #"laststand":
        self setanimstatefromasd("laststand");
        break;
    case #"idle":
    default:
        self setanimstatefromasd("idle");
        break;
    }
}

// Namespace zm_clone/zm_clone
// Params 1, eflags: 0x0
// Checksum 0xdcdbd652, Offset: 0x820
// Size: 0x162
function clone_mover_animate(animtype) {
    self useanimtree("generic");
    switch (animtype) {
    case #"laststand":
        self setanim(#"pb_laststand_idle");
        break;
    case #"afterlife":
        self setanim(#"pb_afterlife_laststand_idle");
        break;
    case #"chair":
        self setanim(#"ai_actor_elec_chair_idle");
        break;
    case #"falling":
        self setanim(#"pb_falling_loop");
        break;
    case #"idle":
    default:
        self setanim(#"pb_stand_alert");
        break;
    }
}

