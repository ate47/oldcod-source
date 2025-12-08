#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_37bec8bde3259abd;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using script_d3ced43465e5aec;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_dfc652ee;

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 0
// Checksum 0x905d2532, Offset: 0x1c8
// Size: 0x1b4
function init()
{
    clientfield::register( "scriptmover", "pickuprotate", 1, 1, "int", &pickuprotate, 0, 0 );
    clientfield::register( "scriptmover", "pickupsettype", 1, 6 + 3, "int", &pickupsettype, 0, 0 );
    clientfield::register( "scriptmover", "pickupvisibility", 1, 1, "int", &function_d04f663, 0, 0 );
    clientfield::register( "scriptmover", "pickuptimeout", 1, 1, "int", &function_727ce85b, 0, 0 );
    clientfield::register( "scriptmover", "pickupmoveto", 1, 4, "int", &function_3577c445, 0, 0 );
    level.doa.pickups = [];
    namespace_c501aa2e::init();
    namespace_5d515bd5::init();
    function_32d5e898();
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 1
// Checksum 0x43204d18, Offset: 0x388
// Size: 0xc
function function_32d5e898( *localclientnum )
{
    
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 2
// Checksum 0x1f80aacd, Offset: 0x3a0
// Size: 0xb6
function function_c9502d74( type, variant )
{
    foreach ( pickup in level.doa.pickups )
    {
        if ( pickup.type == type )
        {
            if ( variant == pickup.variant )
            {
                return pickup;
            }
        }
    }
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 7
// Checksum 0x97d4e85, Offset: 0x460
// Size: 0xb0
function function_c1018360( modelname, type, variant, *rarity, modelscale, *angles, *data )
{
    pickup = spawnstruct();
    pickup.modelname = rarity;
    pickup.scale = data;
    pickup.type = modelscale;
    pickup.variant = angles;
    level.doa.pickups[ level.doa.pickups.size ] = pickup;
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 0
// Checksum 0x74b10b41, Offset: 0x518
// Size: 0xe6
function function_3c872f01()
{
    self notify( "18efc16b8ff7b50c" );
    self endon( "18efc16b8ff7b50c" );
    self endon( #"hash_326008b133edf46a", #"death", #"entityshutdown" );
    dir = 180;
    
    if ( randomint( 100 ) > 50 )
    {
        dir = -180;
    }
    
    time = randomfloatrange( 3, 7 );
    
    while ( isdefined( self ) )
    {
        self rotateto( self.angles + ( 0, dir, 0 ), time );
        wait time;
    }
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 7
// Checksum 0xb5e72e3f, Offset: 0x608
// Size: 0x1ac
function pickupsettype( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    self.pickuptype = bwastimejump & ( 1 << 6 ) - 1;
    self.variant = bwastimejump >> 6;
    def = function_c9502d74( self.pickuptype, self.variant );
    assert( isdefined( def ), "<dev string:x38>" );
    self.fakemodel = spawn( fieldname, self.origin, "script_model" );
    
    if ( isdefined( self.fakemodel ) )
    {
        self.fakemodel setmodel( def.modelname );
        self.fakemodel notsolid();
        self.fakemodel setscale( self.scale );
        self.fakemodel linkto( self );
        self.fakemodel.angles = self.angles;
        self.fakemodel.pickup = self;
        self.fakemodel thread namespace_ec06fe4a::function_d55f042c( self, "death" );
    }
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 7
// Checksum 0x29e97a63, Offset: 0x7c0
// Size: 0xa4
function pickuprotate( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( self.fakemodel ) )
    {
        return;
    }
    
    self.fakemodel.angles = self.angles;
    
    if ( bwastimejump )
    {
        self.fakemodel thread function_3c872f01();
        return;
    }
    
    self.fakemodel notify( #"hash_326008b133edf46a" );
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 7
// Checksum 0x7e2c8a8e, Offset: 0x870
// Size: 0x94
function function_d04f663( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( self.fakemodel ) )
    {
        return;
    }
    
    if ( bwastimejump == 0 )
    {
        self.fakemodel show();
        return;
    }
    
    if ( bwastimejump == 1 )
    {
        self.fakemodel hide();
    }
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 7
// Checksum 0x68d9c7e8, Offset: 0x910
// Size: 0x8c
function function_727ce85b( *localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( self.fakemodel ) )
    {
        return;
    }
    
    if ( bwastimejump )
    {
        self.fakemodel thread pickuptimeout( 10 );
        return;
    }
    
    self.fakemodel notify( #"hash_2a866f50cc161ca8" );
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 1
// Checksum 0x971f7efd, Offset: 0x9a8
// Size: 0xe4
function pickuptimeout( timetowait )
{
    if ( timetowait <= 0 )
    {
        return;
    }
    
    self endon( #"death", #"hash_2a866f50cc161ca8" );
    wait timetowait;
    
    for ( i = 0; i < 40 ; i++ )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( i % 2 )
        {
            self hide();
        }
        else
        {
            self show();
        }
        
        if ( i < 15 )
        {
            wait 0.5;
            continue;
        }
        
        if ( i < 25 )
        {
            wait 0.25;
            continue;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 7
// Checksum 0x212a9cea, Offset: 0xa98
// Size: 0x1a4
function function_3577c445( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    if ( !isdefined( self.fakemodel ) )
    {
        return;
    }
    
    player = undefined;
    bwastimejump -= 1;
    
    if ( bwastimejump > 0 )
    {
        if ( bwastimejump == 15 )
        {
            player = undefined;
        }
        else
        {
            entnum = ( bwastimejump >> 1 ) - 1;
            players = getplayers( fieldname );
            
            foreach ( guy in players )
            {
                if ( guy getentitynumber() == entnum )
                {
                    player = guy;
                    break;
                }
            }
        }
    }
    
    self.fakemodel unlink();
    self.fakemodel notify( #"hash_2a866f50cc161ca8" );
    self.fakemodel thread function_4ecd84a8( player );
}

// Namespace namespace_dfc652ee/namespace_dfc652ee
// Params 1
// Checksum 0xd4a84ec1, Offset: 0xc48
// Size: 0x184
function function_4ecd84a8( player )
{
    self endon( #"death" );
    self show();
    
    if ( isdefined( player ) )
    {
        x = 2000;
        y = 3000;
        z = 1000;
        
        if ( level.doa.flipped )
        {
            x = 0 - x;
            y = 0 - y;
        }
        
        var_a3046af4 = player.origin;
        entnum = player getentitynumber();
        
        if ( entnum == 1 )
        {
            y = 0 - y;
        }
        else if ( entnum == 2 )
        {
            x = 0 - x;
        }
        else if ( entnum == 3 )
        {
            y = 0 - y;
            x = 0 - x;
        }
        
        var_a3046af4 += ( x, y, z );
    }
    else
    {
        var_a3046af4 = self.origin + ( 0, 0, 3000 );
    }
    
    waitframe( 1 );
    self moveto( var_a3046af4, 2, 0, 0 );
}

