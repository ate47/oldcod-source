#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\bots\bot;

#namespace botinterface;

// Namespace botinterface/bot_interface
// Params 0, eflags: 0x1 linked
// Checksum 0xf2ba9de7, Offset: 0x90
// Size: 0x33c
function registerbotinterfaceattributes() {
    ai::registermatchedinterface(#"bot", #"control", "commander", array("commander", "autonomous"), &bot::function_b5dd2fd2);
    ai::registermatchedinterface(#"bot", #"reload", 1, array(1, 0), undefined);
    ai::registermatchedinterface(#"bot", #"revive", 1, array(1, 0), undefined);
    ai::registermatchedinterface(#"bot", #"sprint", 1, array(1, 0), undefined);
    ai::registermatchedinterface(#"bot", #"slide", 1, array(1, 0), undefined);
    ai::registermatchedinterface(#"bot", #"swim", 1, array(1, 0), undefined);
    ai::registermatchedinterface(#"bot", #"primaryoffhand", 1, array(1, 0), undefined);
    ai::registermatchedinterface(#"bot", #"secondaryoffhand", 1, array(1, 0), undefined);
    ai::registermatchedinterface(#"bot", #"specialoffhand", 1, array(1, 0), undefined);
    ai::registermatchedinterface(#"bot", #"scorestreak", 1, array(1, 0), undefined);
}

