#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\hms_util;

#namespace cp_explosive_barrel;

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0, eflags: 0x6
// Checksum 0x991c87b, Offset: 0x130
// Size: 0x4c
function private autoexec __init__system__()
{
    system::register( #"cp_explosive_barrel", &preload, &postload, undefined, undefined );
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0
// Checksum 0xf3aece50, Offset: 0x188
// Size: 0x14
function preload()
{
    init_clientfields();
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0
// Checksum 0x3b1504f7, Offset: 0x1a8
// Size: 0x64
function init_clientfields()
{
    clientfield::register( "scriptmover", "barrel_effects", 1, 2, "int" );
    clientfield::register( "scriptmover", "barrel_effects_fire", 1, 1, "int" );
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0
// Checksum 0x3315ff49, Offset: 0x218
// Size: 0x1c
function postload()
{
    level thread function_573bc4d2();
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0
// Checksum 0xa7e63b8d, Offset: 0x240
// Size: 0x200
function function_573bc4d2()
{
    var_cd88ab02 = getentarray( "cp_explosive_barrel", "targetname" );
    
    foreach ( var_fc3729bf in var_cd88ab02 )
    {
        var_fc3729bf.var_ccfafb9 = 0.01;
        var_fc3729bf.var_628bf12a = 260;
        var_fc3729bf.var_b5183cec = 260;
        var_fc3729bf.var_369a1b0e = 25;
        var_fc3729bf.var_40545cd8 = 200;
        var_fc3729bf.var_ac267381 = 1;
        
        if ( isdefined( var_fc3729bf.var_3029be11 ) && var_fc3729bf.var_3029be11 != -1 )
        {
            var_fc3729bf.var_628bf12a = var_fc3729bf.var_3029be11;
        }
        
        if ( isdefined( var_fc3729bf.damage_min ) && var_fc3729bf.damage_min != -1 )
        {
            var_fc3729bf.var_369a1b0e = var_fc3729bf.damage_min;
        }
        
        if ( isdefined( var_fc3729bf.var_a7069114 ) && var_fc3729bf.var_a7069114 != -1 )
        {
            var_fc3729bf.var_40545cd8 = var_fc3729bf.var_a7069114;
        }
        
        if ( isdefined( var_fc3729bf.var_12000c02 ) && var_fc3729bf.var_12000c02 != -1 )
        {
            var_fc3729bf.var_ac267381 = var_fc3729bf.var_12000c02;
        }
        
        if ( isdefined( var_fc3729bf.damage_radius ) && var_fc3729bf.damage_radius != -1 )
        {
            var_fc3729bf.var_b5183cec = var_fc3729bf.damage_radius;
        }
        
        var_fc3729bf thread function_fa18dccd();
    }
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0
// Checksum 0xeeb2522f, Offset: 0x448
// Size: 0x32c
function function_fa18dccd()
{
    self endon( #"death" );
    self setcandamage( 1 );
    self val::set( #"explosive_barrel", "allowdeath", 0 );
    self.var_b032cc15 = 0;
    self clientfield::set( "barrel_effects", 1 );
    s_results = self waittill( #"damage" );
    
    if ( isdefined( s_results.weapon ) && s_results.weapon hms_util::function_17fe30b7() || s_results hms_util::function_1062a852() )
    {
        n_damage = s_results.amount;
        n_damage *= 7;
        
        if ( n_damage < self.health )
        {
            self clientfield::set( "barrel_effects_fire", 1 );
            self.var_b032cc15 = 1;
        }
        
        self dodamage( n_damage, self.origin );
    }
    else if ( isdefined( s_results.attacker ) && isvehicle( s_results.attacker ) )
    {
        self dodamage( 10000, self.origin );
    }
    else
    {
        self thread function_cba8ac4e();
    }
    
    while ( self.health > 1 )
    {
        n_damage = 10;
        self dodamage( n_damage, self.origin );
        wait 0.1;
    }
    
    self notify( #"exploding" );
    self clientfield::set( "barrel_effects", 2 );
    wait 0.1;
    var_bdf01ff7 = randomintrange( 1, 3 );
    self setmodel( "p9_rus_barrel_explosive_red_01_dmg_0" + var_bdf01ff7 );
    physicsexplosionsphere( self.origin + ( 0, 0, 50 ), self.var_628bf12a, self.var_ccfafb9, self.var_ac267381 );
    radiusdamage( self.origin + ( 0, 0, 25 ), self.var_b5183cec, self.var_40545cd8, self.var_369a1b0e, undefined, "MOD_EXPLOSIVE" );
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0
// Checksum 0xe64a4bd9, Offset: 0x780
// Size: 0x130
function function_cba8ac4e()
{
    self endon( #"death", #"exploding" );
    
    while ( true )
    {
        s_results = self waittill( #"damage" );
        
        if ( isdefined( s_results.weapon ) && s_results.weapon hms_util::function_17fe30b7() || s_results hms_util::function_1062a852() )
        {
            n_damage = s_results.amount;
            n_damage *= 7;
            
            if ( n_damage < self.health && !self.var_b032cc15 )
            {
                self clientfield::set( "barrel_effects_fire", 1 );
                self.var_b032cc15 = 1;
            }
            
            self dodamage( n_damage, self.origin );
        }
    }
}

