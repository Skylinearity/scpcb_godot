extends Node
class_name FMod

const Freq		=	44100	#Hz
const Channels	=	64		#Standartwert
const Flags		=	0
const Mode		=	2		#Mode = 2 means that the sounds play in a loop
const F_Offset	=	0
const Lenght	=	0
const MaxVol	=	255
const MinVol	=	0
const PanLeft	=	0
const PanRight	=	255
const PanMid	=	-1
const AllChannel=	-3
const FreeChannel = -1

func _ready():
	FSOUND_Init(Freq, Channels, Flags)
