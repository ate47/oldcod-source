#using script_6fb84768f1f09fe;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\easing;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace snipercam;

// Namespace snipercam/snipercam
// Params 0, eflags: 0x6
// Checksum 0x28f2529b, Offset: 0x200
// Size: 0x34
function private autoexec __init__system__()
{
    system::register( "snipercam", &function_f64316de, undefined, undefined, undefined );
}

// Namespace snipercam/snipercam
// Params 0, eflags: 0x4
// Checksum 0x429e3ef7, Offset: 0x240
// Size: 0x6c
function private function_f64316de()
{
    callback::on_localplayer_spawned( &on_local_player_spawned );
    clientfield::register( "actor", "start_snipercam", 1, 2, "int", &function_36f6ea28, 0, 0 );
}

// Namespace snipercam/snipercam
// Params 1
// Checksum 0xc9c8838b, Offset: 0x2b8
// Size: 0x5c
function on_local_player_spawned( localclientnum )
{
    if ( !self function_21c0fa55() )
    {
        return;
    }
    
    local_player = function_5c10bd79( localclientnum );
    forcestreamxmodel( "attach_t9_bullet_762_tip_view" );
}

// Namespace snipercam/snipercam
// Params 7, eflags: 0x4
// Checksum 0xad3b3d2b, Offset: 0x320
// Size: 0x7c
function private function_36f6ea28( localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump )
{
    local_player = function_5c10bd79( fieldname );
    local_player thread function_7f8d6723( fieldname, self, bwastimejump );
}

// Namespace snipercam/snipercam
// Params 3, eflags: 0x4
// Checksum 0x450a3b2f, Offset: 0x3a8
// Size: 0x55c
function private function_7f8d6723( localclientnum, victim, var_d21483a5 )
{
    parms = function_83d35e98( self, self geteye(), self getplayerangles(), victim, var_d21483a5 );
    setsaveddvar( #"hash_697fd86393b91fae", 1 );
    var_ef954e24 = spawn( localclientnum, parms.startpos, "script_model" );
    bullet = util::spawn_model( localclientnum, "attach_t9_bullet_762_tip_view", parms.startpos, parms.angles );
    var_ef954e24.angles = parms.angles;
    bullet linkto( var_ef954e24 );
    bullet rotatevelocity( ( 0, 0, 4000 ), 9999 );
    var_ef954e24 moveto( parms.targetpos, parms.time );
    util::playfxontag( localclientnum, "maps/cp_takedown/fx9_hit3_sniper_trail", bullet, "tag_bullet_fx" );
    playmaincamxcam( localclientnum, #"hash_5c6d1cccae8395ba", 10, undefined, undefined, var_ef954e24 );
    level easing::ease_dvar( localclientnum, "runtime_time_scale", 0, 0.5, 0.1, #"linear" );
    var_cbcfc238 = self function_82f1cbd2();
    var_1cb86e4a = parms.time - 0.5 * parms.timescale;
    
    if ( var_1cb86e4a > 0 )
    {
        self util::delay( var_1cb86e4a, undefined, &function_49cdf043, 200, 0.4 * parms.timescale );
    }
    
    var_b487436a = 1.3 * 0.1;
    
    if ( parms.time - var_b487436a - 0.1 > 0 )
    {
        level util::delay( parms.time - var_b487436a - 0.1, undefined, &easing::ease_dvar, localclientnum, "runtime_time_scale", 0, 0.1, 0.1, #"linear" );
    }
    
    bullet util::delay( parms.time, undefined, &hide );
    
    if ( var_d21483a5 == 1 )
    {
        util::delay( parms.time + 0.1, undefined, &function_3992911, localclientnum, parms );
    }
    
    self thread function_9fb8e309( parms.time * 0.25 );
    
    if ( parms.time - 0.1 > 0 )
    {
        wait parms.time - 0.1;
    }
    else
    {
        wait parms.time;
    }
    
    self thread function_a2717a3e( 0.1 );
    level thread easing::ease_dvar( localclientnum, "runtime_time_scale", 0, 1, 0.05, #"linear" );
    wait 1;
    var_d41b03f9 = 0.1;
    var_6d8b2bec = parms.forward * vectordot( self getcampos() - var_ef954e24.origin, parms.forward );
    self function_c2856ebd( var_d41b03f9 * 0.5 );
    wait var_d41b03f9 * 0.4;
    setsaveddvar( #"hash_697fd86393b91fae", 0 );
    stopmaincamxcam( localclientnum );
    bullet delete();
    var_ef954e24 delete();
}

// Namespace snipercam/snipercam
// Params 1, eflags: 0x4
// Checksum 0xaa7fc874, Offset: 0x910
// Size: 0x114
function private function_9fb8e309( lerptime )
{
    if ( self postfx::function_556665f2( "pstfx_speedblur" ) )
    {
        self postfx::stoppostfxbundle( "pstfx_speedblur" );
    }
    
    self postfx::playpostfxbundle( "pstfx_speedblur" );
    self postfx::function_c8b5f318( "pstfx_speedblur", "Blur", 0 );
    self postfx::function_c8b5f318( "pstfx_speedblur", "Inner Mask", 0.4 );
    self postfx::function_c8b5f318( "pstfx_speedblur", "Outer Mask", 0.9 );
    self thread function_63a2faff( 0, 0.1, lerptime );
}

// Namespace snipercam/snipercam
// Params 1, eflags: 0x4
// Checksum 0x313b83d7, Offset: 0xa30
// Size: 0x5c
function private function_a2717a3e( lerptime )
{
    self thread function_63a2faff( 0.1, 0, lerptime );
    self waittill( #"hash_3999b38781a1f7c1" );
    self postfx::stoppostfxbundle( "pstfx_speedblur" );
}

// Namespace snipercam/snipercam
// Params 3, eflags: 0x4
// Checksum 0x5e5868eb, Offset: 0xa98
// Size: 0x1b6
function private function_63a2faff( startval, endval, lerptime )
{
    self notify( "5e7dc1da09cca3c8" );
    self endon( "5e7dc1da09cca3c8" );
    self endon( #"death" );
    
    if ( !self postfx::function_556665f2( "pstfx_speedblur" ) )
    {
        println( "<dev string:x38>" );
        return;
    }
    
    i = 0;
    rate = 1 / lerptime;
    startval = isdefined( self.var_2ba6387e ) ? self.var_2ba6387e : startval;
    self postfx::function_c8b5f318( "pstfx_speedblur", "Blur", startval );
    
    while ( i < 1 )
    {
        i += self function_8e4cd43b() / 1000 * rate;
        self.var_2ba6387e = lerpfloat( startval, endval, i );
        self postfx::function_c8b5f318( "pstfx_speedblur", "Blur", self.var_2ba6387e );
        println( "<dev string:x96>" + self.var_2ba6387e );
        waitframe( 1 );
    }
    
    self notify( #"hash_3999b38781a1f7c1" );
}

// Namespace snipercam/snipercam
// Params 2, eflags: 0x4
// Checksum 0x24f73679, Offset: 0xc58
// Size: 0x9c
function private function_3992911( localclientnum, parms )
{
    headpos = parms.victim gettagorigin( "j_head" );
    playfx( localclientnum, "impacts/fx8_bul_impact_blood_head_fatal", headpos, parms.forward );
    playfx( localclientnum, "impacts/fx8_bul_impact_blood_head_fatal_exit", headpos, parms.forward * -1 );
}

