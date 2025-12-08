#using scripts\abilities\gadgets\gadget_concertina_wire;
#using scripts\core_common\system_shared;

#namespace concertina_wire;

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x6
// Checksum 0xce5036ba, Offset: 0x90
// Size: 0x44
function private autoexec __init__system__()
{
    system::register( #"gadget_concertina_wire", &preinit, undefined, undefined, #"weapons" );
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 0, eflags: 0x4
// Checksum 0xc1bb01a3, Offset: 0xe0
// Size: 0x3c
function private preinit()
{
    init_shared( "concertina_wire_settings_wz" );
    function_c5f0b9e7( &onconcertinawireplaced );
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1
// Checksum 0xef59130b, Offset: 0x128
// Size: 0xc
function onconcertinawireplaced( *concertinawire )
{
    
}

