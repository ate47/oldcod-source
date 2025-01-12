#using scripts\core_common\struct;
#using scripts\zm_common\gametypes\ztcm;

#namespace ztcm_towers;

// Namespace ztcm_towers/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x53f1342, Offset: 0x78
// Size: 0x24
function event_handler[gametype_init] main(eventstruct) {
    ztcm::main(eventstruct);
}

