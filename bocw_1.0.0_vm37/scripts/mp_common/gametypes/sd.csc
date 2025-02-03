#using script_13da4e6b98ca81a1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace sd;

// Namespace sd/gametype_init
// Params 1, eflags: 0x40
// Checksum 0xf07d7740, Offset: 0xe8
// Size: 0xfc
function event_handler[gametype_init] main(*eventstruct) {
    if (getgametypesetting(#"silentplant") != 0) {
        setsoundcontext("bomb_plant", "silent");
    }
    level.var_e4935474 = [];
    clientfield::function_5b7d846d("hudItems.war.attackingTeam", #"war_data", #"attackingteam", 1, 2, "int", undefined, 0, 1);
    clientfield::register("scriptmover", "entityModelsNum", 1, 10, "int", &function_e116df6c, 0, 0);
}

// Namespace sd/sd
// Params 7, eflags: 0x0
// Checksum 0x43dd84a8, Offset: 0x1f0
// Size: 0xac
function function_e116df6c(*localclientnum, oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(level.var_e4935474)) {
        level.var_e4935474 = [];
    }
    if (bwastimejump != fieldname) {
        entitynumber = self getentitynumber();
        if (bwastimejump != -1) {
            level.var_e4935474[entitynumber] = bwastimejump;
        }
        codcaster::function_12acfa84();
    }
}

