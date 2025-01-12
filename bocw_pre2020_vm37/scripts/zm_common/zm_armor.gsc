#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_net;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;

#namespace zm_armor;

// Namespace zm_armor/zm_armor
// Params 0, eflags: 0x6
// Checksum 0x3372fc2c, Offset: 0xd0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_armor", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_armor/zm_armor
// Params 0, eflags: 0x5 linked
// Checksum 0x80f724d1, Offset: 0x118
// Size: 0x4
function private function_70a657d8() {
    
}

// Namespace zm_armor/zm_armor
// Params 0, eflags: 0x0
// Checksum 0xbbe06df4, Offset: 0x128
// Size: 0x1c
function on_connect() {
    self thread function_49f4b6ee();
}

// Namespace zm_armor/zm_armor
// Params 2, eflags: 0x1 linked
// Checksum 0xe1bbf669, Offset: 0x150
// Size: 0x94
function register(var_7c8fcded, is_permanent = 1) {
    if (!isdefined(level.var_9555ebfb)) {
        level.var_9555ebfb = [];
    } else if (!isarray(level.var_9555ebfb)) {
        level.var_9555ebfb = array(level.var_9555ebfb);
    }
    level.var_9555ebfb[var_7c8fcded] = is_permanent;
}

// Namespace zm_armor/zm_armor
// Params 0, eflags: 0x1 linked
// Checksum 0xd8d3f068, Offset: 0x1f0
// Size: 0x15c
function function_49f4b6ee() {
    self.var_9555ebfb = [];
    if (!isdefined(level.var_9555ebfb)) {
        return;
    }
    a_keys = getarraykeys(level.var_9555ebfb);
    foreach (key in a_keys) {
        if (level.var_9555ebfb[key]) {
            self.var_9555ebfb[key] = 0;
        }
    }
    foreach (key in a_keys) {
        if (!level.var_9555ebfb[key]) {
            self.var_9555ebfb[key] = 0;
        }
    }
}

// Namespace zm_armor/zm_armor
// Params 4, eflags: 0x1 linked
// Checksum 0x9f004ab0, Offset: 0x358
// Size: 0x138
function add(var_7c8fcded, var_3ed63752, var_28066539, var_df7ee5d1 = #"hash_2082da6662372184") {
    var_4812bba2 = 0;
    if (isdefined(var_28066539)) {
        var_d7de78d3 = var_28066539 - self get(var_7c8fcded);
        if (var_3ed63752 <= var_d7de78d3) {
            self.armor += var_3ed63752;
            var_4812bba2 = var_3ed63752;
        } else {
            self.armor += var_d7de78d3;
            var_4812bba2 = var_d7de78d3;
        }
    } else {
        self.armor += var_3ed63752;
        var_4812bba2 = var_3ed63752;
    }
    if (var_4812bba2 > 0) {
        self playsound(var_df7ee5d1);
    }
    var_4812bba2 += self get(var_7c8fcded);
    self.var_9555ebfb[var_7c8fcded] = var_4812bba2;
}

// Namespace zm_armor/zm_armor
// Params 2, eflags: 0x1 linked
// Checksum 0x2761e3b4, Offset: 0x498
// Size: 0x1ec
function remove(var_7c8fcded, var_2cd89ceb = 0) {
    if (isdefined(self.var_9555ebfb[var_7c8fcded]) && self.var_9555ebfb[var_7c8fcded] > 0) {
        if (var_2cd89ceb) {
            self.armor -= self.var_9555ebfb[var_7c8fcded];
            a_keys = getarraykeys(level.var_9555ebfb);
            var_d42adc5 = 0;
            foreach (key in a_keys) {
                if (key !== var_7c8fcded && (level.var_9555ebfb[key] || is_true(self.var_bacee63b) && key == #"hero_weapon_armor")) {
                    var_d42adc5 += get(key);
                }
            }
            var_d42adc5 = min(var_d42adc5, 100);
            self.armor = int(max(var_d42adc5, self.armor));
        }
        self.var_9555ebfb[var_7c8fcded] = 0;
    }
}

// Namespace zm_armor/zm_armor
// Params 1, eflags: 0x1 linked
// Checksum 0xd843e148, Offset: 0x690
// Size: 0x30
function get(var_7c8fcded) {
    if (isdefined(self.var_9555ebfb[var_7c8fcded])) {
        return self.var_9555ebfb[var_7c8fcded];
    }
    return 0;
}

// Namespace zm_armor/zm_armor
// Params 3, eflags: 0x0
// Checksum 0x9f07f4ae, Offset: 0x6c8
// Size: 0x2fa
function damage(n_damage, mod_type, e_attacker) {
    if (self.armor <= 0) {
        return n_damage;
    }
    var_ee47fd1b = int(self.armor * 2);
    a_keys = getarraykeys(self.var_9555ebfb);
    if (n_damage > var_ee47fd1b) {
        foreach (key in a_keys) {
            self remove(key, 1);
        }
        self.armor = 0;
        self playsound(#"hash_2817ca3f96127e62");
        return (n_damage - var_ee47fd1b);
    }
    if (n_damage > 0) {
        var_ee47fd1b = int(max(1, n_damage / 2));
    } else {
        var_ee47fd1b = 0;
    }
    self.armor -= var_ee47fd1b;
    var_c5aebd9f = 0;
    for (n_index = 0; var_c5aebd9f < var_ee47fd1b && n_index < a_keys.size; n_index++) {
        var_b12ac727 = a_keys[n_index];
        var_2a0d4230 = self get(var_b12ac727);
        if (var_2a0d4230 > var_ee47fd1b) {
            var_34ada56f = var_2a0d4230 - var_ee47fd1b - var_c5aebd9f;
            self.var_9555ebfb[var_b12ac727] = var_34ada56f;
            var_c5aebd9f += var_ee47fd1b;
            n_index++;
            continue;
        }
        if (var_2a0d4230 > 0) {
            var_c5aebd9f += var_2a0d4230;
            self remove(var_b12ac727);
            if (self.armor <= 0) {
                self playsound(#"hash_2817ca3f96127e62");
            }
            n_index++;
            continue;
        }
    }
    self notify(#"damage_armor", {#mod:mod_type, #attacker:e_attacker});
    return 0;
}

