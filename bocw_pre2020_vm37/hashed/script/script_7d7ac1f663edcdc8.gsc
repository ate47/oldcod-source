#using script_113dd7f0ea2a1d4f;
#using script_1cc417743d7c262d;
#using script_2618e0f3e5e11649;
#using script_6a4a2311f8a4697;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\gametypes\globallogic;

#namespace namespace_553954de;

// Namespace namespace_553954de/namespace_553954de
// Params 0, eflags: 0x1 linked
// Checksum 0xb58a3994, Offset: 0xe8
// Size: 0x34
function function_14bada94() {
    self.var_7aa0d894 = 1;
    self clientfield::set_player_uimodel("hudItems.survivalOverlayOpen", 1);
}

// Namespace namespace_553954de/namespace_553954de
// Params 0, eflags: 0x1 linked
// Checksum 0x9c735596, Offset: 0x128
// Size: 0x2c
function function_548f282() {
    self.var_7aa0d894 = 0;
    self clientfield::set_player_uimodel("hudItems.survivalOverlayOpen", 0);
}

// Namespace namespace_553954de/namespace_553954de
// Params 1, eflags: 0x1 linked
// Checksum 0x6a3c2d3f, Offset: 0x160
// Size: 0x17c
function end_match(b_success = 1) {
    foreach (player in getplayers()) {
        level.var_31028c5d prototype_hud::function_817e4d10(player, 0);
    }
    if (b_success || getdvarint(#"hash_15b141da1584bd0d", 1) == 0) {
        level thread function_8e066676();
        wait 1;
        level globallogic::endgame(#"allies");
        return;
    }
    level.var_1726e2c7 = 1;
    level globallogic_audio::leader_dialog("matchEndLoseObjectiveFail");
    wait 4;
    level thread globallogic::endgame(#"axis");
}

// Namespace namespace_553954de/namespace_553954de
// Params 0, eflags: 0x1 linked
// Checksum 0x15668359, Offset: 0x2e8
// Size: 0x11e
function function_8e066676() {
    foreach (ai in getaiarray()) {
        if (isalive(ai) && !function_3132f113(ai)) {
            util::stop_magic_bullet_shield(ai);
            ai.allowdeath = 1;
            ai.takedamage = 1;
            ai kill(undefined, undefined, undefined, undefined, undefined, 1);
            waitframe(randomint(3) + 1);
        }
    }
}

// Namespace namespace_553954de/namespace_553954de
// Params 1, eflags: 0x1 linked
// Checksum 0x1120326d, Offset: 0x410
// Size: 0x154
function function_7c97e961(var_661691aa) {
    assert(isdefined(var_661691aa), "<dev string:x38>");
    var_88710b09 = zombie_utility::function_d2dfacfd(#"hash_6ba259e60f87bb15");
    if (isdefined(var_88710b09)) {
        var_661691aa = math::clamp(var_661691aa, 1, var_88710b09.size);
    }
    level.var_b48509f9 = var_661691aa;
    switch (level.var_b48509f9) {
    case 1:
        level.realm = 1;
        break;
    case 2:
    case 3:
        level.realm = 2;
        break;
    default:
        level.realm = 3;
        break;
    }
    namespace_60c38ce9::function_855c828f(level.realm);
    namespace_ce1f29cc::function_15bf0b91(level.realm);
}

