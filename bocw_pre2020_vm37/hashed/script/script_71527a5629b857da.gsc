#using script_1162c195eb8dd834;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\smart_bundle;

#namespace smart_bundle;

// Namespace smart_bundle/namespace_e534a4e2
// Params 0
// Checksum 0x10a3e632, Offset: 0xe8
// Size: 0x2ac
function function_4e82b483()
{
    while ( true )
    {
        level waittill( #"spawner_added_sb_q" );
        
        while ( level.smart_bundle.spawnq_next < level.smart_bundle.spawnq.size )
        {
            waittillframeend();
            
            if ( isdefined( level.smart_bundle.spawn_wait ) )
            {
                wait level.smart_bundle.spawn_wait;
                level.smart_bundle.spawn_wait = undefined;
            }
            
            if ( !( level.smart_bundle.spawnq[ level.smart_bundle.spawnq_next ].var_9785b19e.var_39a8d200 == "active" || level.smart_bundle.spawnq[ level.smart_bundle.spawnq_next ].var_9785b19e.var_39a8d200 == "wait_deactivate" ) )
            {
                level.smart_bundle.spawnq_next++;
                continue;
            }
            
            spawner = level.smart_bundle.spawnq[ level.smart_bundle.spawnq_next ];
            
            if ( spawner.classname == "script_vehicle" )
            {
                ai = spawner spawner::spawn( 1 );
                
                if ( isdefined( ai ) && isdefined( spawner.target ) )
                {
                    ai thread vehicle::go_path();
                }
                
                spawner.var_9785b19e thread function_cf2b1b9b( ai );
            }
            else
            {
                if ( isdefined( spawner.script_suspend ) && isdefined( spawner.suspended_ai ) )
                {
                    spawner prespawn_suspended_ai();
                }
                
                ai = spawner spawner::spawn( 1 );
            }
            
            spawner.var_9785b19e thread function_c0ea60b9( spawner, ai );
            level.smart_bundle.spawnq_next++;
            waitframe( 1 );
        }
        
        level.smart_bundle.spawnq = [];
        level.smart_bundle.spawnq_next = 0;
        level notify( #"resume_sb_ai_queue" );
    }
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 1
// Checksum 0x728d457c, Offset: 0x3a0
// Size: 0xaa
function function_cf2b1b9b( vehicle )
{
    vehicle endon( #"death" );
    waitframe( 4 );
    
    if ( isdefined( vehicle.var_761c973.riders ) && vehicle.var_761c973.riders.size > 0 )
    {
        if ( !isdefined( self.var_60efc9d0 ) )
        {
            self.var_60efc9d0 = [];
        }
        
        self.var_60efc9d0 = arraycombine( self.var_60efc9d0, vehicle.var_761c973.riders, 1, 0 );
    }
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 1
// Checksum 0x2e768be2, Offset: 0x458
// Size: 0x80
function function_8760a4bd( spawner )
{
    if ( level.smart_bundle.spawnq.size > 64 )
    {
        level waittill( #"resume_sb_ai_queue" );
        waitframe( 2 );
    }
    
    level.smart_bundle.spawnq[ level.smart_bundle.spawnq.size ] = spawner;
    level notify( #"spawner_added_sb_q" );
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 0
// Checksum 0xfcd2c6a8, Offset: 0x4e0
// Size: 0x13c
function function_bc78de5d()
{
    self.var_f0a4c650 = [];
    self.var_fe336ab9 = 0;
    a_ai = [];
    
    foreach ( spawner in self.spawner_ents )
    {
        self function_4f5c58a1( spawner );
        self function_214a640( spawner );
        ai = spawner spawner::spawn( 1 );
        
        if ( isdefined( ai ) )
        {
            a_ai[ a_ai.size ] = ai;
        }
        
        spawner.var_9785b19e thread function_c0ea60b9( spawner, ai );
    }
    
    scene::play( self.scene_name, a_ai );
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 0
// Checksum 0x6cf7a99b, Offset: 0x628
// Size: 0xac
function function_30e5290f()
{
    self.var_f0a4c650 = [];
    self.var_fe336ab9 = 0;
    
    if ( self.spawner_ents.size == 0 || !is_true( self.var_2b96e535 ) )
    {
        return;
    }
    
    for ( i = 0; i < self.spawner_ents.size ; i++ )
    {
        self thread function_4783d4fa( self.spawner_ents[ i ] );
    }
    
    self thread function_f029622c();
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 1
// Checksum 0x4e9b9821, Offset: 0x6e0
// Size: 0x4e
function function_4f5c58a1( spawner )
{
    spawner.script_suspend = 1;
    
    if ( isdefined( self.script_suspend_group ) )
    {
        spawner.script_suspend_group = self.script_suspend_group;
    }
    
    spawner.count = 99;
    spawner.suspended_ai = undefined;
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 1
// Checksum 0x37ceaa79, Offset: 0x738
// Size: 0xc4
function function_4783d4fa( spawner )
{
    if ( !isdefined( spawner ) )
    {
        /#
            if ( isdefined( self.targetname ) )
            {
                println( "<dev string:x38>" + self.targetname + "<dev string:x43>" );
            }
        #/
        
        return;
    }
    
    self endon( #"hash_740faf03c1eeca5b" );
    function_4f5c58a1( spawner );
    self function_214a640( spawner );
    spawner function_9a0ffb73();
    function_8760a4bd( spawner );
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 1
// Checksum 0xc8e0ba25, Offset: 0x808
// Size: 0x44
function function_214a640( spawner )
{
    spawner.var_9785b19e = self;
    spawner.stub_index = self.var_f0a4c650.size;
    self.var_f0a4c650[ self.var_f0a4c650.size ] = spawner;
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 1
// Checksum 0x2d55c425, Offset: 0x858
// Size: 0xbe
function function_fe336ab9( spawner )
{
    assert( spawner.stub_index < self.var_f0a4c650.size );
    assert( self.var_fe336ab9 < self.var_f0a4c650.size );
    assert( self.var_f0a4c650[ spawner.stub_index ] != self );
    self.var_f0a4c650[ spawner.stub_index ] = self;
    self.var_fe336ab9++;
    self notify( #"hash_7fafbdd20ef09362" );
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 0
// Checksum 0x3d6a87c9, Offset: 0x920
// Size: 0x12
function function_2264f2c4()
{
    self.despawned = 1;
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 2
// Checksum 0x2502166d, Offset: 0x940
// Size: 0x2e4
function function_c0ea60b9( spawner, ai )
{
    self endon( #"hash_740faf03c1eeca5b" );
    
    if ( !isdefined( ai ) )
    {
        function_fe336ab9( spawner );
        return;
    }
    
    self.dynamic_ents[ self.dynamic_ents.size ] = ai;
    self notify( #"bundle_ai_spawned" );
    ai.var_9785b19e = self;
    ai.spawner = spawner;
    spawner.var_de1cdf28 = ai;
    
    if ( isdefined( spawner.script_suspend ) && isdefined( spawner.suspended_ai ) )
    {
        ai thread postspawn_suspended_ai();
    }
    
    ret = ai waittill( #"death", #"pain_death", #"smart_bundle_suspended_ai" );
    
    if ( ret._notify != "smart_bundle_suspended_ai" )
    {
        if ( !is_true( ai.despawned ) )
        {
            function_fe336ab9( spawner );
            return;
        }
        
        ai function_2c2c15de( spawner );
        
        if ( isdefined( spawner.script_suspend_group ) )
        {
            level.smart_bundle.spawn_wait = 0.5;
            self util::delay( 0.05, undefined, &function_764d4b74 );
            
            /#
                if ( isdefined( self.targetname ) )
                {
                    iprintln( self.targetname + "<dev string:x68>" );
                }
            #/
            
            self notify( #"despawn" );
            return;
        }
    }
    
    if ( isdefined( self.var_38a97b32 ) )
    {
        wait 2;
        
        while ( true )
        {
            level waittill( self.var_38a97b32 );
            
            if ( level flag::get( self.var_38a97b32 ) )
            {
                function_8760a4bd( spawner );
                return;
            }
        }
    }
    
    /#
        name = "<dev string:x98>";
        
        if ( isdefined( spawner.targetname ) )
        {
            name = spawner.targetname;
        }
        
        iprintln( "<dev string:xa5>" + name + "<dev string:xbd>" + spawner.origin );
    #/
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 1
// Checksum 0x95800389, Offset: 0xc30
// Size: 0x1a6
function function_2c2c15de( spawner )
{
    if ( !isdefined( self.spawner ) || !isdefined( self.script_suspend ) )
    {
        return;
    }
    
    spawner = self.spawner;
    struct = spawnstruct();
    struct.origin = self.origin;
    struct.angles = self.angles;
    struct.suspendtime = gettime();
    
    if ( isdefined( self.suspendvars ) )
    {
        struct.suspendvars = self.suspendvars;
    }
    else
    {
        struct.suspendvars = spawnstruct();
    }
    
    if ( isdefined( self.stealth ) )
    {
        struct.stealth = spawnstruct();
        struct.stealth.bsmstate = self.stealth.bsmstate;
        struct.stealth.investigateevent = self.stealth.investigateevent;
    }
    
    if ( isdefined( self.node ) )
    {
        if ( isdefined( self.using_goto_node ) )
        {
            if ( isdefined( self.node.targetname ) )
            {
                struct.target = self.node.targetname;
            }
            
            struct.node = self.node;
        }
        
        struct.target = self.node.targetname;
    }
    
    spawner.suspended_ai = struct;
    spawner.postspawnresetorigin = 1;
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 0
// Checksum 0x20a43bf3, Offset: 0xde0
// Size: 0xf6
function prespawn_suspended_ai()
{
    if ( !isdefined( self.script_suspend ) )
    {
        return undefined;
    }
    
    if ( !isdefined( self.suspended_ai ) )
    {
        return 0;
    }
    
    self.count++;
    
    if ( !isdefined( self.og_spawner_origin ) )
    {
        self.og_spawner_origin = self.origin;
    }
    
    if ( !isdefined( self.og_spawner_angles ) )
    {
        self.og_spawner_angles = self.angles;
    }
    
    if ( isdefined( self.try_og_origin ) )
    {
        self.origin = self.og_spawner_origin;
        self.angles = self.og_spawner_angles;
    }
    else
    {
        self.origin = self.suspended_ai.origin;
        self.angles = self.suspended_ai.angles;
    }
    
    if ( isdefined( self.suspended_ai.suspendvars ) )
    {
        self.suspendvars = self.suspended_ai.suspendvars;
    }
    
    return 1;
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 0
// Checksum 0x74cb33a2, Offset: 0xee0
// Size: 0xae
function postspawn_suspended_ai()
{
    suspendstruct = self.spawner.suspended_ai;
    
    if ( isdefined( self.spawner.postspawnresetorigin ) )
    {
        self.spawner.origin = self.og_spawner_origin;
        self.spawner.angles = self.og_spawner_angles;
    }
    
    self thread postspawn_suspend_ai_framedelay( suspendstruct );
    
    if ( !isdefined( suspendstruct.suspendvars ) )
    {
        return;
    }
    
    self.suspendvars = suspendstruct.suspendvars;
    self.spawner.suspended_ai = undefined;
}

// Namespace smart_bundle/namespace_e534a4e2
// Params 1
// Checksum 0x44962caf, Offset: 0xf98
// Size: 0x5c
function postspawn_suspend_ai_framedelay( suspendstruct )
{
    waittillframeend();
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( suspendstruct.stealth ) )
    {
        assert( self.team == "<dev string:xf6>", "<dev string:xfe>" );
    }
}

