#using scripts\core\core_frontend_fx;
#using scripts\core\core_frontend_sound;
#using scripts\core_common\util_shared;

#namespace core_frontend;

// Namespace core_frontend/level_init
// Params 1, eflags: 0x40
// Checksum 0xc87d5609, Offset: 0x78
// Size: 0xbc
function event_handler[level_init] main(*eventstruct) {
    core_frontend_fx::main();
    core_frontend_sound::main();
    setdvar(#"hash_59cffccc9729732f", -40);
    setdvar(#"hash_7633a587d5705d08", 1);
    setdvar(#"hash_3fe46a1700f8faf6", 0.25);
    util::waitforclient(0);
}

