#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#using scripts\killstreaks\ac130_shared;

#namespace ac130;

// Namespace ac130/ac130
// Params 0, eflags: 0x6
// Checksum 0xc18ae413, Offset: 0x100
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"ac130", &preinit, undefined, undefined, #"killstreaks" );
}

// Namespace ac130/ac130
// Params 0, eflags: 0x4
// Checksum 0xe817762, Offset: 0x150
// Size: 0x5c
function private preinit()
{
    init_shared();
    clientfield::register( "toplayer", "inAC130", 1, 1, "int", &function_555656fe, 0, 1 );
}

// Namespace ac130/ac130
// Params 2, eflags: 0x4
// Checksum 0x1d80d746, Offset: 0x1b8
// Size: 0x52, Type: bool
function private function_35aed314( localplayerteam, otherteam )
{
    if ( !isdefined( localplayerteam ) || !isdefined( otherteam ) )
    {
        return false;
    }
    
    if ( otherteam == #"neutral" )
    {
        return false;
    }
    
    return localplayerteam != otherteam;
}

// Namespace ac130/ac130
// Params 1, eflags: 0x4
// Checksum 0xd4759a83, Offset: 0x218
// Size: 0x84
function private function_7b91bbdd( localclientnum )
{
    vehicle = self;
    vehicle endon( #"death", #"hash_67080015640c605d" );
    vehicle waittill( #"vehicle_death_fx" );
    vehicle renderoverridebundle::function_f4eab437( localclientnum, 0, #"hash_2c6fce4151016478" );
}

// Namespace ac130/ac130
// Params 4, eflags: 0x4
// Checksum 0x9ba48f7a, Offset: 0x2a8
// Size: 0x140
function private function_7415e9d3( localclientnum, var_634b8583, entitytype, var_e186bbd8 )
{
    entarray = getentarraybytype( localclientnum, entitytype );
    
    foreach ( ent in entarray )
    {
        if ( function_35aed314( var_634b8583, ent.team ) )
        {
            ent renderoverridebundle::function_f4eab437( localclientnum, var_e186bbd8, #"hash_2c6fce4151016478" );
            
            if ( entitytype == 12 )
            {
                ent notify( #"hash_67080015640c605d" );
                
                if ( var_e186bbd8 )
                {
                    ent thread function_7b91bbdd( localclientnum );
                }
            }
        }
    }
}

// Namespace ac130/ac130
// Params 1, eflags: 0x4
// Checksum 0x3374dc07, Offset: 0x3f0
// Size: 0xb4
function private function_e6d3dbbc( localclientnum )
{
    entity = self;
    localplayer = function_5c10bd79( localclientnum );
    
    if ( function_35aed314( localplayer.team, entity.team ) )
    {
        entity renderoverridebundle::function_f4eab437( localclientnum, 1, #"hash_2c6fce4151016478" );
        
        if ( entity.type == "vehicle" )
        {
            entity thread function_7b91bbdd( localclientnum );
        }
    }
}

// Namespace ac130/ac130
// Params 7, eflags: 0x4
// Checksum 0xb804b9ef, Offset: 0x4b0
// Size: 0x2ac
function private function_555656fe( localclientnum, *oldval, newval, *bnewent, binitialsnap, *fieldname, *bwastimejump )
{
    bundle = getscriptbundle( "killstreak_ac130" + "_cp" );
    postfxbundle = bundle.( "ksVehiclePostEffectBun" );
    
    if ( !isdefined( postfxbundle ) )
    {
        return;
    }
    
    self util::waittill_dobj( binitialsnap );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( bwastimejump && self postfx::function_556665f2( postfxbundle ) )
    {
        self codestoppostfxbundle( postfxbundle );
    }
    
    if ( fieldname )
    {
        if ( self postfx::function_556665f2( postfxbundle ) == 0 )
        {
            self codeplaypostfxbundle( postfxbundle );
            function_7415e9d3( binitialsnap, self.team, 15, 1 );
            callback::function_675f0963( &function_e6d3dbbc );
            function_7415e9d3( binitialsnap, self.team, 12, 1 );
            callback::on_vehicle_spawned( &function_e6d3dbbc );
        }
        
        self thread util::function_8e4d84eb( binitialsnap, #"hash_62b451624327f582" );
        return;
    }
    
    if ( self postfx::function_556665f2( postfxbundle ) )
    {
        self codestoppostfxbundle( postfxbundle );
        function_7415e9d3( binitialsnap, self.team, 15, 0 );
        callback::function_ce9bb4ec( &function_e6d3dbbc );
        function_7415e9d3( binitialsnap, self.team, 12, 0 );
        callback::remove_on_vehicle_spawned( &function_e6d3dbbc );
    }
    
    self util::function_e706c315();
}

