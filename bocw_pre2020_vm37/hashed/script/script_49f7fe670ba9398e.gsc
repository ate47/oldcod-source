#using script_17dcb1172e441bf6;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_634ae70c663d1cc9;
#using script_774302f762d76254;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_a7c12078;

// Namespace namespace_a7c12078/namespace_a7c12078
// Params 0
// Checksum 0x80f724d1, Offset: 0x200
// Size: 0x4
function init()
{
    
}

// Namespace namespace_a7c12078/namespace_a7c12078
// Params 0
// Checksum 0xb7cee99d, Offset: 0x210
// Size: 0x16
function main()
{
    level.doa.var_ea40471b = [];
}

// Namespace namespace_a7c12078/namespace_a7c12078
// Params 0
// Checksum 0x5673b765, Offset: 0x230
// Size: 0x144
function function_c6453062()
{
    self notify( "2f25b26e22f30a5c" );
    self endon( "2f25b26e22f30a5c" );
    self thread namespace_268747c0::function_978c05b5();
    result = self waittill( #"destroy_hazard" );
    
    if ( is_true( self.var_7c56394 ) && is_true( result.var_760a0807 ) )
    {
        arrayremovevalue( level.doa.var_ea40471b, self );
        namespace_1e25ad94::debugmsg( "Deleting LogDrop trap permenently at:" + self.origin );
    }
    
    util::wait_network_frame();
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger namespace_268747c0::function_54f185a();
    }
    
    if ( isdefined( self.script_model ) )
    {
        self.script_model delete();
    }
}

// Namespace namespace_a7c12078/namespace_a7c12078
// Params 2
// Checksum 0x380f1dee, Offset: 0x380
// Size: 0xd0
function function_cb1b5203( trap, var_7c56394 = 0 )
{
    hazard = namespace_ec06fe4a::spawnmodel( trap.origin, "p8_fxanim_zm_towers_trap_blade_01_mod" );
    
    if ( isdefined( hazard ) )
    {
        hazard.targetname = "hazard";
        hazard.var_fd5301f9 = "logdrop";
        hazard.angles = trap.angles;
        hazard enablelinkto();
    }
    
    trap.script_model = hazard;
    trap.var_7c56394 = var_7c56394;
    trap thread function_62ba9be4();
    return trap;
}

// Namespace namespace_a7c12078/namespace_a7c12078
// Params 2
// Checksum 0x270b53dc, Offset: 0x458
// Size: 0x10c
function function_7f3d5e5d( trap, page = 0 )
{
    if ( !mayspawnentity() )
    {
        return;
    }
    
    if ( page )
    {
        if ( !isdefined( level.doa.var_ea40471b ) )
        {
            level.doa.var_ea40471b = [];
        }
        else if ( !isarray( level.doa.var_ea40471b ) )
        {
            level.doa.var_ea40471b = array( level.doa.var_ea40471b );
        }
        
        level.doa.var_ea40471b[ level.doa.var_ea40471b.size ] = trap;
        return;
    }
    
    function_cb1b5203( trap );
}

// Namespace namespace_a7c12078/namespace_a7c12078
// Params 0
// Checksum 0x8f056415, Offset: 0x570
// Size: 0x334
function function_d4a86caf()
{
    self notify( "70f59fe74d0cba7d" );
    self endon( "70f59fe74d0cba7d" );
    level endon( #"game_over" );
    
    while ( true )
    {
        wait 0.5;
        state = namespace_4dae815d::function_59a9cf1d();
        
        if ( state == 0 )
        {
            continue;
        }
        
        foreach ( trap in level.doa.var_ea40471b )
        {
            time = gettime();
            
            if ( isdefined( trap.var_eb9d64bb ) && time < trap.var_eb9d64bb )
            {
                continue;
            }
            
            trap.var_eb9d64bb = time + 2000 + randomint( 600 );
            
            if ( !isdefined( trap.script_model ) )
            {
                activate = 0;
                
                if ( isdefined( trap.var_f8660931 ) )
                {
                    distsq = distancesquared( trap.origin, trap.var_f8660931.origin );
                    
                    if ( distsq < sqr( 3200 ) )
                    {
                        activate = 1;
                    }
                }
                
                if ( !activate )
                {
                    trap.var_f8660931 = namespace_ec06fe4a::function_6eacecf5( trap.origin, 3200 );
                    
                    if ( isdefined( trap.var_f8660931 ) )
                    {
                        activate = 1;
                    }
                    else
                    {
                        trap.var_f8660931 = namespace_ec06fe4a::function_bd3709ce( trap.origin, 1200 );
                        
                        if ( isdefined( trap.var_f8660931 ) )
                        {
                            activate = 1;
                        }
                    }
                }
                
                if ( activate )
                {
                    function_cb1b5203( trap, 1 );
                    trap.var_eb9d64bb += 5000;
                    namespace_1e25ad94::debugmsg( "Paging IN logdrop trap at:" + trap.origin );
                }
                
                continue;
            }
            
            trap.var_f8660931 = namespace_ec06fe4a::function_f3eab80e( trap.origin, 3600 );
            
            if ( !isdefined( trap.var_f8660931 ) )
            {
                trap notify( #"destroy_hazard", { #var_760a0807:0 } );
                namespace_1e25ad94::debugmsg( "Paging out logdrop trap at:" + trap.origin );
            }
        }
    }
}

// Namespace namespace_a7c12078/namespace_a7c12078
// Params 0
// Checksum 0x40940282, Offset: 0x8b0
// Size: 0x130
function function_237de89e()
{
    level.doa.var_ea40471b = [];
    level thread function_d4a86caf();
    
    if ( isdefined( level.doa.var_a77e6349 ) )
    {
        traps = [[ level.doa.var_a77e6349 ]]->function_87f950c1( "logdrop" );
        page = 1;
    }
    else
    {
        traps = [[ level.doa.var_39e3fa99 ]]->function_242886d5( "logdrop" );
    }
    
    foreach ( trap in traps )
    {
        function_7f3d5e5d( trap, page );
    }
}

// Namespace namespace_a7c12078/namespace_a7c12078
// Params 0
// Checksum 0x763cd8, Offset: 0x9e8
// Size: 0x382
function function_62ba9be4()
{
    self notify( "5d24fcac1775ac5c" );
    self endon( "5d24fcac1775ac5c" );
    level endon( #"game_over" );
    self endon( #"destroy_hazard" );
    self thread function_c6453062();
    
    if ( !isdefined( self.script_model ) )
    {
        self notify( #"destroy_hazard" );
    }
    
    while ( true )
    {
        if ( !isdefined( self.trigger ) )
        {
            self.trigger = namespace_268747c0::function_5bfa98c9( "logdrop", self.origin );
        }
        
        if ( isdefined( self.trigger ) )
        {
            break;
        }
        
        wait 0.5;
    }
    
    self.trigger.origin = self.origin + ( 0, 0, 80 );
    self.trigger.angles = self.angles;
    self.trigger thread function_b31750de();
    self.script_model useanimtree( "generic" );
    self.script_model solid();
    var_ba28dc68 = getanimlength( #"p8_fxanim_zm_towers_trap_blade_01_start_anim" ) - 0.2;
    var_fb7d52cb = getanimlength( #"p8_fxanim_zm_towers_trap_blade_01_loop_anim" ) - 0.2;
    var_3493b9e = getanimlength( #"p8_fxanim_zm_towers_trap_blade_01_end_anim" ) - 0.2;
    
    while ( true )
    {
        self.script_model stopanimscripted();
        self.trigger triggerenable( 0 );
        wait randomfloatrange( 5, 10 );
        self.script_model namespace_268747c0::play_anim( #"p8_fxanim_zm_towers_trap_blade_01_start_anim", 1 );
        wait var_ba28dc68;
        self.trigger triggerenable( 1 );
        
        for ( loops = randomintrange( 5, 15 ); loops ; loops-- )
        {
            self.script_model namespace_268747c0::play_anim( #"p8_fxanim_zm_towers_trap_blade_01_loop_anim", 1 );
            wait var_fb7d52cb;
        }
        
        self.trigger triggerenable( 0 );
        self.script_model namespace_268747c0::play_anim( #"p8_fxanim_zm_towers_trap_blade_01_end_anim", 1 );
        wait var_3493b9e + randomintrange( 1, 4 );
    }
}

// Namespace namespace_a7c12078/namespace_a7c12078
// Params 0
// Checksum 0xf32b6ab7, Offset: 0xd78
// Size: 0x198
function function_b31750de()
{
    self notify( "148b647a3fb8973c" );
    self endon( "148b647a3fb8973c" );
    self endon( #"hash_5dc5b7f198cd1bec", #"death" );
    
    while ( isdefined( self ) )
    {
        result = self waittill( #"trigger" );
        guy = result.activator;
        
        if ( isdefined( guy ) && isalive( guy ) )
        {
            if ( is_true( guy.boss ) )
            {
                continue;
            }
            
            if ( !isdefined( guy.var_ef6bca09 ) )
            {
                guy.var_ef6bca09 = 0;
            }
            
            if ( guy.var_ef6bca09 < gettime() )
            {
                guy namespace_83eb6304::function_3ecfde67( "pungi_damage" );
                guy.var_ef6bca09 = gettime() + 1000;
            }
            
            if ( isplayer( guy ) )
            {
                guy dodamage( guy.health + 100, guy.origin );
                continue;
            }
            
            guy thread namespace_ec06fe4a::function_570729f0( 0.1 );
            guy thread namespace_ed80aead::function_586ef822();
        }
    }
}

