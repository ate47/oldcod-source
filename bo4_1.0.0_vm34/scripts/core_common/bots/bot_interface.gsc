#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\bots\bot;

#namespace botinterface;

// Namespace botinterface/bot_interface
// Params 0, eflags: 0x0
// Checksum 0x19df6126, Offset: 0x118
// Size: 0x25c
function registerbotinterfaceattributes() {
    ai::registermatchedinterface("bot", "control", "commander", array("commander", "autonomous"), &bot::function_42bd6558);
    ai::registermatchedinterface("bot", "sprint", 0, array(1, 0), undefined);
    ai::registermatchedinterface("bot", "revive", 1, array(1, 0), undefined);
    ai::registermatchedinterface("bot", "slide", 1, array(1, 0), undefined);
    ai::registermatchedinterface("bot", "ignorepathenemyfightdist", 0, array(1, 0), undefined);
    ai::registermatchedinterface("bot", "allowprimaryoffhand", 1, array(1, 0), undefined);
    ai::registermatchedinterface("bot", "allowsecondaryoffhand", 1, array(1, 0), undefined);
    ai::registermatchedinterface("bot", "allowspecialoffhand", 1, array(1, 0), undefined);
    ai::registermatchedinterface("bot", "allowscorestreak", 1, array(1, 0), undefined);
}

