#using scripts\core_common\ai\archetype_human_rpg_interface;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai_shared;
#using scripts\core_common\spawner_shared;

#namespace archetype_human_rpg;

// Namespace archetype_human_rpg/archetype_human_rpg
// Params 0, eflags: 0x2
// Checksum 0x7ef1c9d9, Offset: 0xa8
// Size: 0x74
function autoexec main() {
    spawner::add_archetype_spawn_function("human_rpg", &humanrpgbehavior::archetypehumanrpgblackboardinit);
    spawner::add_archetype_spawn_function("human", &humanrpgbehavior::function_a429e19d);
    humanrpgbehavior::registerbehaviorscriptfunctions();
    humanrpginterface::registerhumanrpginterfaceattributes();
}

#namespace humanrpgbehavior;

// Namespace humanrpgbehavior/archetype_human_rpg
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x128
// Size: 0x4
function registerbehaviorscriptfunctions() {
    
}

// Namespace humanrpgbehavior/archetype_human_rpg
// Params 0, eflags: 0x4
// Checksum 0x4c2ec189, Offset: 0x138
// Size: 0x6c
function private archetypehumanrpgblackboardinit() {
    entity = self;
    blackboard::createblackboardforentity(entity);
    ai::createinterfaceforentity(entity);
    self.___archetypeonanimscriptedcallback = &archetypehumanrpgonanimscriptedcallback;
    entity asmchangeanimmappingtable(1);
}

// Namespace humanrpgbehavior/archetype_human_rpg
// Params 1, eflags: 0x4
// Checksum 0xb5543bd4, Offset: 0x1b0
// Size: 0x2c
function private archetypehumanrpgonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypehumanrpgblackboardinit();
}

// Namespace humanrpgbehavior/archetype_human_rpg
// Params 0, eflags: 0x4
// Checksum 0xb222db9d, Offset: 0x1e8
// Size: 0x8c
function private function_a429e19d() {
    if (self.var_ea94c12a === "human_rpg") {
        self.var_a780187 = getweapon(#"hash_3b5610f58856b4ea");
        self.var_20bee58a = getweapon(#"hash_1d8ec79043d16eb");
        self.var_860b2ca = 0;
        self thread function_a8f03a7f();
    }
}

// Namespace humanrpgbehavior/archetype_human_rpg
// Params 0, eflags: 0x4
// Checksum 0xd5108d49, Offset: 0x280
// Size: 0x218
function private function_a8f03a7f() {
    self endon(#"death");
    self ai::gun_remove();
    self ai::gun_switchto(self.var_a780187, "right");
    while (self.weapon !== self.var_a780187) {
        waitframe(1);
    }
    while (isalive(self)) {
        var_b039bd07 = self ai::function_8bd47b7e(self.enemy);
        if (isdefined(var_b039bd07) && var_b039bd07 && !(isdefined(self.var_860b2ca) && self.var_860b2ca)) {
            self ai::gun_remove();
            self ai::gun_switchto(self.var_20bee58a, "right");
            while (self.weapon !== self.var_20bee58a) {
                waitframe(1);
            }
            self.var_860b2ca = 1;
            self waittill(#"weapon_fired", #"enemy", #"missile_fire");
        }
        if (!(isdefined(var_b039bd07) && var_b039bd07) && isdefined(self.var_860b2ca) && self.var_860b2ca) {
            self ai::gun_remove();
            self ai::gun_switchto(self.var_a780187, "right");
            while (self.weapon !== self.var_a780187) {
                waitframe(1);
            }
            self.var_860b2ca = 0;
        }
        waitframe(1);
    }
}

