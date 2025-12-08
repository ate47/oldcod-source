#using script_1cd690a97dfca36e;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace cp_explosive_barrel;

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0, eflags: 0x6
// Checksum 0x468743bb, Offset: 0x178
// Size: 0x3c
function private autoexec __init__system__()
{
    system::register( #"cp_explosive_barrel", &preload, undefined, undefined, undefined );
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0
// Checksum 0x1b3435a3, Offset: 0x1c0
// Size: 0x24
function preload()
{
    init_clientfields();
    init_fx();
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0
// Checksum 0xeace0f7b, Offset: 0x1f0
// Size: 0x94
function init_clientfields()
{
    clientfield::register( "scriptmover", "barrel_effects", 1, 2, "int", &function_c4e043ee, 0, 0 );
    clientfield::register( "scriptmover", "barrel_effects_fire", 1, 1, "int", &function_fa9bea36, 0, 0 );
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 0
// Checksum 0x9e677017, Offset: 0x290
// Size: 0x64
function init_fx()
{
    level._effect[ #"hash_6eed38de2452398a" ] = "maps/cp_rus_siege/fx9_fire_gas_leak_impact_sm_runner";
    level._effect[ #"hash_2713fd7d423c75c5" ] = "maps/cp_rus_siege/fx9_exp_fuel_barrel_runner";
    level._effect[ #"hash_254b2ba7e3542938" ] = "destruct/fx8_red_barrel_fire";
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 7
// Checksum 0xaa0d00c2, Offset: 0x300
// Size: 0x1c0
function function_c4e043ee( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( self.var_59419da4 ) )
    {
        self.var_59419da4 = [];
    }
    
    if ( bwastimejump == 1 )
    {
        self.notifyonbulletimpact = 1;
        self thread function_f1bf9643( fieldname );
        return;
    }
    
    if ( bwastimejump == 2 )
    {
        n_fx = playfx( fieldname, level._effect[ #"hash_2713fd7d423c75c5" ], self.origin );
        snd::play( "exp_redbarrel", self.origin );
        self thread function_c1e7f821( fieldname, n_fx );
        self notify( #"exploded" );
        waitframe( 1 );
        
        foreach ( n_fx in self.var_59419da4 )
        {
            snd::stop( level.var_d83adbeb );
            killfx( fieldname, n_fx );
        }
    }
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 2
// Checksum 0x1046a248, Offset: 0x4c8
// Size: 0x8c
function function_c1e7f821( localclientnum, n_fx )
{
    e_sound = snd::play( "evt_incendiary_fire_barrel_sm", self.origin + ( 0, 0, 40 ) );
    
    while ( isfxplaying( localclientnum, n_fx ) )
    {
        waitframe( 1 );
    }
    
    snd::stop( e_sound, 0.25 );
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 1
// Checksum 0x9ef3803e, Offset: 0x560
// Size: 0x98
function function_f1bf9643( localclientnum )
{
    self endon( #"death", #"exploded" );
    
    while ( self.var_59419da4.size < 7 )
    {
        var_e5818e0c = self waittill( #"damage" );
        self function_e14eea31( localclientnum, var_e5818e0c, level._effect[ #"hash_6eed38de2452398a" ] );
    }
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 3
// Checksum 0x78cf2346, Offset: 0x600
// Size: 0x12c
function function_e14eea31( localclientnum, var_26fce16e, fx )
{
    if ( isdefined( var_26fce16e.position ) && isdefined( var_26fce16e.direction ) )
    {
        n_fx = playfx( localclientnum, fx, var_26fce16e.position, var_26fce16e.direction * -1 );
        
        if ( !isdefined( self.var_59419da4 ) )
        {
            self.var_59419da4 = [];
        }
        else if ( !isarray( self.var_59419da4 ) )
        {
            self.var_59419da4 = array( self.var_59419da4 );
        }
        
        self.var_59419da4[ self.var_59419da4.size ] = n_fx;
        
        if ( self.var_59419da4.size == 1 )
        {
            level.var_d83adbeb = snd::play( "evt_incendiary_fire_barrel_sm", self.origin + ( 0, 0, 40 ) );
        }
    }
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 7
// Checksum 0xc498f582, Offset: 0x738
// Size: 0x94
function function_fa9bea36( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( bwastimejump && !is_true( self.destroyed ) )
    {
        self function_ad8beac( fieldname, level._effect[ #"hash_254b2ba7e3542938" ] );
    }
}

// Namespace cp_explosive_barrel/cp_explosive_barrel
// Params 2
// Checksum 0x5b5c73a4, Offset: 0x7d8
// Size: 0xbc
function function_ad8beac( localclientnum, fx )
{
    n_fx = playfx( localclientnum, fx, self.origin + ( 10, 0, 40 ) );
    
    if ( !isdefined( self.var_59419da4 ) )
    {
        self.var_59419da4 = [];
    }
    else if ( !isarray( self.var_59419da4 ) )
    {
        self.var_59419da4 = array( self.var_59419da4 );
    }
    
    self.var_59419da4[ self.var_59419da4.size ] = n_fx;
}

