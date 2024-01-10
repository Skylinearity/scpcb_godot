extends Node

var BurntNote: int
var ItemAmount: int

var InvSelect: int
var SelectedItem: Items

var ClosestItem: Items

var LastItemID: int


Global Mesh_MinX: float, Mesh_MinY: float, Mesh_MinZ: float
Global Mesh_MaxX: float, Mesh_MaxY: float, Mesh_MaxZ: float
Global Mesh_MagX: float, Mesh_MagY: float, Mesh_MagZ: float


Global KillTimer: float, KillAnim: int, FallTimer: float, DeathTimer: float
Global Sanity: float, ForceMove: float, ForceAngle: float
Global RestoreSanity: int

Global Playable: int = True

Global BLINKFREQ: float
Global BlinkTimer: float, EyeIrritation: float, EyeStuck: float, BlinkEffect: float = 1.0, BlinkEffectTimer: float

Global Stamina: float, StaminaEffect: float=1.0, StaminaEffectTimer: float


Global CameraShakeTimer: float, Vomit: int, VomitTimer: float, Regurgitate: int

Global SCP1025state: float[6]

Global HeartBeatRate: float, HeartBeatTimer: float, HeartBeatVolume: float

Global WearingGasMask: int, WearingHazmat: int, WearingVest: int, Wearing714: int, WearingNightVision: int
Global NVTimer: float

Global SuperMan: int, SuperManTimer: float

Global Injuries: float, Bloodloss: float, Infect: float, HealTimer: float

Global RefinedItems: int

Global DropSpeed: float, HeadDropSpeed: float, CurrSpeed: float
Global user_camera_pitch: float, side: float
Global Crouch: int, CrouchState: float

Global PlayerZone: int, PlayerRoom.Rooms

Global GrabbedEntity: int

Global InvertMouse: int = GetINIInt(OptionFile, "options", "invert mouse y")
Global MouseHit1: int, MouseDown1: int, MouseHit2: int, DoubleClick: int, LastMouseHit1: int, MouseUp1: int

Global GodMode: int, NoClip: int, NoClipSpeed: float = 2.0

Global CoffinDistance: float = 100.0

Global PlayerSoundVolume: float


Global Shake: float

Global ExplosionTimer: float, ExplosionSFX: int

Global LightsOn: int = True

Global SoundTransmission: int


Global MainMenuOpen: int, MenuOpen: int, StopHidingTimer: float, InvOpen: int
Global OtherOpen.Items = Null

Global SelectedEnding$, EndingScreen: int, EndingTimer: float


Global MsgTimer: float, Msg$, DeathMSG$

Global AccessCode: int, KeypadInput$, KeypadTimer: float, KeypadMSG$

Global DrawHandIcon: int

Global PlayTime: int
Global ConsoleFlush: int
Global ConsoleFlushSnd: int = 0, ConsoleMusFlush: int = 0, ConsoleMusPlay: int = 0

Global InfiniteStamina: int = false
Global NVBlink: int
Global IsNVGBlinking: int = false



Global ConsoleOpen: int, ConsoleInput$
Global ConsoleScroll: float,ConsoleScrollDragging: int
Global ConsoleMouseMem: int
Global ConsoleReissue.ConsoleMsg = Null
Global ConsoleR: int = 255,ConsoleG: int = 255,ConsoleB: int = 255

Global UpdaterFont: int
Global Font1: int, Font2: int, Font3: int, Font4: int, Font5: int
Global ConsoleFont: int

Global VersionNumber: String = "1.3.11"
Global CompatibleNumber: String = "1.3.11" 

Global MenuWhite: int, MenuBlack: int
Global ButtonSFX: int

Global EnableSFXRelease: int = GetINIInt(OptionFile, "audio", "sfx release")
Global EnableSFXRelease_Prev: int = EnableSFXRelease: int

Global CanOpenConsole: int = GetINIInt(OptionFile, "console", "enabled")

Global LauncherWidth: int= Min(GetINIInt(OptionFile, "launcher", "launcher width"), 1024)
Global LauncherHeight: int = Min(GetINIInt(OptionFile, "launcher", "launcher height"), 768)
Global LauncherEnabled: int = GetINIInt(OptionFile, "launcher", "launcher enabled")
Global LauncherIMG: int

Global GraphicWidth: int = GetINIInt(OptionFile, "options", "width")
Global GraphicHeight: int = GetINIInt(OptionFile, "options", "height")
Global Depth: int = 0, Fullscreen: int = GetINIInt(OptionFile, "options", "fullscreen")

Global SelectedGFXMode: int
Global SelectedGFXDriver: int = Max(GetINIInt(OptionFile, "options", "gfx driver"), 1)

Global fresize_image: int, fresize_texture: int, fresize_texture2: int
Global fresize_cam: int

Global ShowFPS = GetINIInt(OptionFile, "options", "show FPS")

Global WireframeState
Global HalloweenTex

Global TotalGFXModes: int = CountGfxModes3D(), GFXModes: int


Global BorderlessWindowed: int = GetINIInt(OptionFile, "options", "borderless windowed")
Global RealGraphicWidth: int,RealGraphicHeight: int
Global AspectRatioRatio: float

Global EnableRoomLights: int = GetINIInt(OptionFile, "options", "room lights enabled")

Global TextureDetails: int = GetINIInt(OptionFile, "options", "texture details")
Global TextureFloat: float

Global ConsoleOpening: int = GetINIInt(OptionFile, "console", "auto opening")
Global SFXVolume: float = GetINIFloat(OptionFile, "audio", "sound volume")

Global Bit16Mode = GetINIInt(OptionFile, "options", "16bit")



Global Framelimit: int = GetINIInt(OptionFile, "options", "framelimit")
Global Vsync: int = GetINIInt(OptionFile, "options", "vsync")

Global Opt_AntiAlias = GetINIInt(OptionFile, "options", "antialias")

Global CurrFrameLimit: float = (Framelimit: int-19)/100.0

Global ScreenGamma: float = GetINIFloat(OptionFile, "options", "screengamma")

Global GameSaved: int

Global CanSave: int = True

Global CursorIMG: int = LoadImage_Strict("GFX\cursor.png")

Global SelectedLoadingScreen.LoadingScreens, LoadingScreenAmount: int, LoadingScreenText: int
Global LoadingBack: int = LoadImage_Strict("Loadingscreens\loadingback.jpg")

Global KEY_RIGHT = GetINIInt(OptionFile, "binds", "Right key")
Global KEY_LEFT = GetINIInt(OptionFile, "binds", "Left key")
Global KEY_UP = GetINIInt(OptionFile, "binds", "Up key")
Global KEY_DOWN = GetINIInt(OptionFile, "binds", "Down key")

Global KEY_BLINK = GetINIInt(OptionFile, "binds", "Blink key")
Global KEY_SPRINT = GetINIInt(OptionFile, "binds", "Sprint key")
Global KEY_INV = GetINIInt(OptionFile, "binds", "Inventory key")
Global KEY_CROUCH = GetINIInt(OptionFile, "binds", "Crouch key")
Global KEY_SAVE = GetINIInt(OptionFile, "binds", "Save key")
Global KEY_CONSOLE = GetINIInt(OptionFile, "binds", "Console key")

Global MouseSmooth: float = GetINIFloat(OptionFile,"options", "mouse smoothing", 1.0)

Global viewport_center_x: int = GraphicWidth / 2, viewport_center_y: int = GraphicHeight / 2


Global MenuScale: float = (GraphicHeight / 1024.0)
Global CurTime: int, PrevTime: int, LoopDelay: int, FPSfactor: float, FPSfactor2: float, PrevFPSFactor: float

Global CreditsFont: int,CreditsFont2: int

Global BlinkMeterIMG: int = LoadImage_Strict("GFX\blinkmeter.jpg")

Global mouselook_x_inc: float = 0.3
Global mouselook_y_inc: float = 0.3 

Global mouse_left_limit: int = 250, mouse_right_limit: int = GraphicsWidth () - 250
Global mouse_top_limit: int = 150, mouse_bottom_limit: int = GraphicsHeight () - 150
Global mouse_x_speed_1: float, mouse_y_speed_1: float

Global MTFtimer: float, MTFrooms.Rooms[10], MTFroomState: int[10]


Global OptionFile: String = "options.ini"



Global ErrorFile: String = "error_log_"

Global FogTexture: int, Fog: int
Global GasMaskTexture: int, GasMaskOverlay: int
Global InfectTexture: int, InfectOverlay: int
Global DarkTexture: int, Dark: int
Global Collider: int, Head: int

Global FogNVTexture: int
Global NVTexture: int, NVOverlay: int

Global TeslaTexture: int

Global LightTexture: int, Light: int

Global DoorOBJ: int, DoorFrameOBJ: int

Global LeverOBJ: int, LeverBaseOBJ: int

Global DoorColl: int
Global ButtonOBJ: int, ButtonKeyOBJ: int, ButtonCodeOBJ: int, ButtonScannerOBJ: int


Global Monitor: int, MonitorTexture: int
Global CamBaseOBJ: int, CamOBJ: int

Global LiquidObj: int,MTFObj: int,GuardObj: int,ClassDObj: int
Global ApacheObj: int,ApacheRotorObj: int

Global UnableToMove: int = false
Global ShouldEntitiesFall: int = True
Global PlayerFallingPickDistance: float = 10.0

Global Save_MSG: String = ""
Global Save_MSG_Timer: float = 0.0
Global Save_MSG_Y: float = 0.0

Global MTF_CameraCheckTimer: float = 0.0
Global MTF_CameraCheckDetected: int = false



	Global SoundEmitter: int
	Global TempSounds: int[10]
	Global TempSoundCHN: int
	Global TempSoundIndex: int = 0
	
		Global CameraFogNear: float = GetINIFloat("options.ini", "options", "camera fog near")
	Global CameraFogFar: float = GetINIFloat("options.ini", "options", "camera fog far")

	Global StoredCameraFogFar: float = CameraFogFar

	Global MouseSens: float = GetINIFloat("options.ini", "options", "mouse sensitivity")

	Global EnableVRam: int = GetINIInt("options.ini", "options", "enable vram")



	Global DebugHUD: int

	Global BlurVolume: float, BlurTimer: float

	Global LightBlink: float, LightFlash: float

	Global BumpEnabled: int = GetINIInt("options.ini", "options", "bump mapping enabled")
	Global HUDenabled: int = GetINIInt("options.ini", "options", "HUD enabled")

	Global Camera: int, CameraShake: float, CurrCameraZoom: float

	Global Brightness: int = GetINIFloat("options.ini", "options", "brightness")

	Global KeyCardSFX1
	Global KeyCardSFX2
	Global ButtonSFX2
	Global ScannerSFX1
	Global ScannerSFX2

	Global OpenDoorFastSFX
	Global CautionSFX: int

	Global NuclearSirenSFX: int

	Global CameraSFX

	Global StoneDragSFX: int

	Global GunshotSFX: int
	Global Gunshot2SFX: int
	Global Gunshot3SFX: int
	Global BullethitSFX: int
		Global TeslaIdleSFX
	Global TeslaActivateSFX
	Global TeslaPowerUpSFX

	Global MagnetUpSFX: int, MagnetDownSFX
	Global FemurBreakerSFX: int
	Global EndBreathCHN: int
	Global EndBreathSFX: int
	
	Global BurstSFX
	
	Global Use914SFX: int
	Global Death914SFX: int
	
		Global Wearing1499: int = false
	Global AmbientLightRoomTex: int, AmbientLightRoomVal: int

	Global EnableUserTracks: int = GetINIInt(OptionFile, "audio", "enable user tracks")
	Global UserTrackMode: int = GetINIInt(OptionFile, "audio", "user track setting")
	Global UserTrackCheck: int = 0, UserTrackCheck2: int = 0
	Global UserTrackMusicAmount: int = 0, CurrUserTrack: int, UserTrackFlag: int = false
	
	
		Global NTF_1499PrevX: float
	Global NTF_1499PrevY: float
	Global NTF_1499PrevZ: float
	Global NTF_1499PrevRoom.Rooms
	Global NTF_1499X: float
	Global NTF_1499Y: float
	Global NTF_1499Z: float
	Global NTF_1499Sky: int
	
	
		Global InFacility: int = True

	Global PrevMusicVolume: float = MusicVolume: float
	Global PrevSFXVolume: float = SFXVolume: float
	Global DeafPlayer: int = false
	Global DeafTimer: float = 0.0

	Global IsZombie: int = false

	Global room2gw_brokendoor: int = false
	Global room2gw_x: float = 0.0
	Global room2gw_z: float = 0.0

	Global Menu_TestIMG
	Global menuroomscale: float = 8.0 / 2048.0

	Global CurrMenu_TestIMG: String = ""
	
	
		Global DTextures[MaxDTextures]

	Global NPC049OBJ, NPC0492OBJ
	Global ClerkOBJ

	Global IntercomStreamCHN: int

	Global ForestNPC,ForestNPCTex,ForestNPCData: float[3]


	Global PauseMenuIMG: int

	Global SprintIcon: int
	Global BlinkIcon: int
	Global CrouchIcon: int
	Global HandIcon: int
	Global HandIcon2: int
		Global ClosestButton: int, ClosestDoor.Doors
	Global SelectedDoor.Doors, UpdateDoorsTimer: float
	Global DoorTempID: int
	
		Global MusicVolume: float = GetINIFloat(OptionFile, "audio", "music volume")


	Global CurrMusicStream, MusicCHN
	
		Global CurrMusicVolume: float = 1.0, NowPlaying: int=2, ShouldPlay: int=11
	Global CurrMusic: int = 1
	
	
	Global LeverSFX: int, LightSFX: int
	Global ButtGhostSFX: int
