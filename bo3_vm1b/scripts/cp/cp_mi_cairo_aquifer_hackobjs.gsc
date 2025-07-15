#using scripts/codescripts/struct;
#using scripts/cp/_hacking;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/shared/flag_shared;

#namespace cp_mi_cairo_aquifer_hackobjs;

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 0
// Checksum 0x53825017, Offset: 0x210
// Size: 0x12
function main()
{
    init_skiptos();
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 0
// Checksum 0xe9c07cd6, Offset: 0x230
// Size: 0x2
function init_skiptos()
{
    
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2
// Checksum 0x15407d2, Offset: 0x240
// Size: 0xd2
function skipto_attack_tanks( a, b )
{
    tank_obj = getent( "tank_obj_target", "targetname" );
    level.tank_targ = spawnstruct();
    level.tank_targ.origin = tank_obj.origin;
    objectives::set( "obj_attack_tanks", level.tank_targ );
    iprintln( "waiting placeholder for attack tanks" );
    wait 5;
    objectives::complete( "obj_attack_tanks", level.tank_targ );
    skipto::objective_completed( a );
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2
// Checksum 0xba82e5ad, Offset: 0x320
// Size: 0xd2
function skipto_hack_1( a, b )
{
    hack_trig_1 = getent( "exterior_hack_trig_1", "targetname" );
    level.hack_trig1 = struct::get( hack_trig_1.target, "targetname" );
    objectives::set( "cp_mi_cairo_aquifer_hack_obj1", level.hack_trig1 );
    hack_trig_1 hacking::init_hack_trigger( 1 );
    hack_trig_1 hacking::trigger_wait();
    objectives::complete( "cp_mi_cairo_aquifer_hack_obj1", level.hack_trig1 );
    skipto::objective_completed( a );
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2
// Checksum 0x2a33f35f, Offset: 0x400
// Size: 0xd2
function skipto_hack_2( a, b )
{
    hack_trig_2 = getent( "exterior_hack_trig_2", "targetname" );
    level.hack_trig2 = struct::get( hack_trig_2.target, "targetname" );
    objectives::set( "cp_mi_cairo_aquifer_hack_obj2", level.hack_trig2 );
    hack_trig_2 hacking::init_hack_trigger( 1 );
    hack_trig_2 hacking::trigger_wait();
    objectives::complete( "cp_mi_cairo_aquifer_hack_obj2", level.hack_trig2 );
    skipto::objective_completed( a );
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 2
// Checksum 0xf13313b1, Offset: 0x4e0
// Size: 0xda
function skipto_hack_3( a, b )
{
    hack_trig_3 = getent( "exterior_hack_trig_3", "targetname" );
    level.hack_trig3 = spawnstruct();
    level.hack_trig3.origin = hack_trig_3.origin;
    objectives::set( "cp_mi_cairo_aquifer_hack_obj3", level.hack_trig3 );
    hack_trig_3 hacking::init_hack_trigger( 5 );
    hack_trig_3 hacking::trigger_wait();
    objectives::complete( "cp_mi_cairo_aquifer_hack_obj3", level.hack_trig3 );
    skipto::objective_completed( a );
}

// Namespace cp_mi_cairo_aquifer_hackobjs
// Params 4
// Checksum 0xe83695b5, Offset: 0x5c8
// Size: 0x42
function done( a, b, c, d )
{
    iprintln( "######## " + a + " is completed ########" );
}

