#using script_3dc93ca9902a9cda;
#using scripts\cp_common\snd;

#namespace snd;

// Namespace snd/namespace_33f8f0d7
// Params 2
// Checksum 0xe7ae1c20, Offset: 0x70
// Size: 0x2a
function function_9ae4fc6f( soundalias, targets )
{
    return play( soundalias, targets );
}

// Namespace snd/namespace_33f8f0d7
// Params 2
// Checksum 0xe637055, Offset: 0xa8
// Size: 0x2c
function function_4286bd2c( soundobject, fadeoutseconds )
{
    stop( soundobject, fadeoutseconds );
}

// Namespace snd/namespace_33f8f0d7
// Params 3
// Checksum 0x906da29f, Offset: 0xe0
// Size: 0x34
function function_2e9b6265( soundobject, levelnotifystring, fadeoutseconds )
{
    stop_on_level_notify( soundobject, levelnotifystring, fadeoutseconds );
}

// Namespace snd/namespace_33f8f0d7
// Params 3
// Checksum 0x45da5f6d, Offset: 0x120
// Size: 0x34
function function_b33d1cfe( soundobject, volume, timeinseconds )
{
    set_volume( soundobject, volume, timeinseconds );
}

