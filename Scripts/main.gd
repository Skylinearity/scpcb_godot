extends Node


#Include "StrictLoads.bb"
#Include "fullscreen_window_fix.bb"
#Include "KeyName.bb"
#Include "Blitz_Basic_Bank.bb"
#Include "Blitz_File_FileName.bb"
#Include "Blitz_File_ZipApi.bb"
#Include "Update.bb"
#
#Include "DevilParticleSystem.bb"
#Include "AAText.bb"
#Include "Achievements.bb"
#Include "Difficulty.bb"
# Include "dreamfilter.bb"

var consoleMsg: Array[ConsoleMsg]

func _ready():
	var InitErrorStr: String = ""

	if FileSize("fmod.dll") == 0:
		InitErrorStr += "fmod.dll" + char(13) + char(10)
	if FileSize("zlibwapi.dll") == 0:
		InitErrorStr += "zlibwapi.dll"+Chr(13)+Chr(10)

	if Len(InitErrorStr)>0:
		RuntimeError ("The following DLLs were not found in the game directory:"+Chr(13)+Chr(10)+Chr(13)+Chr(10)+InitErrorStr)





	var ErrorFileInd: int = 0
	while FileType(ErrorFile+Str(ErrorFileInd)+".txt") != 0:
		ErrorFileInd += 1

	ErrorFile += str(ErrorFileInd)+".txt"


	var ArrowIMG: PackedInt32Array = []
	ArrowIMG.resize(4)

	var GfxModeWidths: PackedInt32Array = []
	GfxModeWidths.resize(TotalGFXModes)
	var GfxModeHeights: PackedInt32Array = []
	GfxModeHeights.resize(TotalGFXModes)

	var TextureFloat: float = 0.8 - 0.4 * TextureDetails

	if LauncherEnabled:
		AspectRatioRatio = 1.0
		UpdateLauncher()


		if BorderlessWindowed:
			DebugLog ("Using Borderless Windowed Mode")
			Graphics3DExt (G_viewport_width, G_viewport_height, 0, 2)


			api_SetWindowLong( G_app_handle, C_GWL_STYLE, C_WS_POPUP )
			api_SetWindowPos( G_app_handle, C_HWND_TOP, G_viewport_x, G_viewport_y, G_viewport_width, G_viewport_height, C_SWP_SHOWWINDOW )

			RealGraphicWidth = G_viewport_width
			RealGraphicHeight = G_viewport_height

			AspectRatioRatio = (Float(GraphicWidth)/Float(GraphicHeight))/(Float(RealGraphicWidth)/Float(RealGraphicHeight))

			Fullscreen = false
		else:
			AspectRatioRatio = 1.0
			RealGraphicWidth = GraphicWidth
			RealGraphicHeight = GraphicHeight
			if Fullscreen:
				Graphics3DExt(GraphicWidth, GraphicHeight, (16*Bit16Mode), 1)
			else:
				Graphics3DExt(GraphicWidth, GraphicHeight, 0, 2)



	else:
		for i:int in range(1, TotalGFXModes + 1):
			var samefound: int = false
			for  n: int in range(0, TotalGFXModes):
				if GfxModeWidths[n] == GfxModeWidth[i] and GfxModeHeights(n) == GfxModeHeight(i):
					samefound = true
					break

			if samefound == false:
				if GraphicWidth == GfxModeWidth[i] and GraphicHeight == GfxModeHeight[i]:
					SelectedGFXMode = GFXModes
				GfxModeWidths[GFXModes] = GfxModeWidth[i]
				GfxModeHeights[GFXModes] = GfxModeHeight[i]
				GFXModes += 1



		GraphicWidth = GfxModeWidths(SelectedGFXMode)
		GraphicHeight = GfxModeHeights(SelectedGFXMode)


		if BorderlessWindowed:
			DebugLog ("Using Faked Fullscreen")
			Graphics3DExt (G_viewport_width, G_viewport_height, 0, 2)


			api_SetWindowLong( G_app_handle, C_GWL_STYLE, C_WS_POPUP )
			api_SetWindowPos( G_app_handle, C_HWND_TOP, G_viewport_x, G_viewport_y, G_viewport_width, G_viewport_height, C_SWP_SHOWWINDOW )

			RealGraphicWidth = G_viewport_width
			RealGraphicHeight = G_viewport_height

			AspectRatioRatio = (float(GraphicWidth)/Float(GraphicHeight))/(Float(RealGraphicWidth)/Float(RealGraphicHeight))

			Fullscreen = false
		else:
			AspectRatioRatio = 1.0
			RealGraphicWidth = GraphicWidth
			RealGraphicHeight = GraphicHeight
			if Fullscreen:
				Graphics3DExt(GraphicWidth, GraphicHeight, (16*Bit16Mode), 1)
			else:
				Graphics3DExt(GraphicWidth, GraphicHeight, 0, 2)

	SetBuffer(BackBuffer())

	var CheckFPS: int
	var ElapsedLoops: int
	var FPS: int
	var ElapsedTime: float


	const HIT_MAP: int = 1
	const HIT_PLAYER: int = 2
	const HIT_ITEM: int = 3
	const HIT_APACHE: int = 4
	const HIT_178: int = 5
	const HIT_DEAD: int = 6
	SeedRnd (MilliSecs())




	AppTitle ("SCP - Containment Breach v"+VersionNumber)

	PlayStartupVideos()






	InitLoadingScreens("Loadingscreens\\loadingscreens.ini")

	InitAAFont()


	var Font1: int = AALoadFont("GFX\\font\\cour\\Courier New.ttf", Int(19 * (GraphicHeight / 1024.0)), 0,0,0)
	var Font2: int = AALoadFont("GFX\\font\\courbd.\\Courier New.ttf", Int(58 * (GraphicHeight / 1024.0)), 0,0,0)
	var Font3: int = AALoadFont("GFX\\font\\DS-DIGI\\DS-Digital.ttf", Int(22 * (GraphicHeight / 1024.0)), 0,0,0)
	var Font4: int = AALoadFont("GFX\\font\\DS-DIGI\\DS-Digital.ttf", Int(60 * (GraphicHeight / 1024.0)), 0,0,0)
	var Font5: int = AALoadFont("GFX\\font\\Journal\\Journal.ttf", Int(58 * (GraphicHeight / 1024.0)), 0,0,0)



	var ConsoleFont: int = AALoadFont("Blitz", Int(20 * (GraphicHeight / 1024.0)), 0,0,0,1)

	AASetFont (Font2)



	DrawLoading(0, True)






	var DrawArrowIcon: PackedInt32Array = []
	DrawArrowIcon.resize(4)







	var RadioState: PackedFloat32Array = []
	RadioState.resize(10)
	var RadioState3: PackedInt32Array = []
	RadioState3.resize(10)
	var RadioState4: PackedInt32Array = []
	RadioState4.resize(9)
	var RadioCHN: PackedInt32Array = []
	RadioCHN.resize(8)

	var OldAiPics: PackedInt32Array = []
	OldAiPics.resize(5)




func CreateConsoleMsg(txt: String,r: int=-1,g: int=-1,b: int=-1,isCommand: int=False) :
	var c: ConsoleMsg = ConsoleMsg.new()
	
	consoleMsg.insert(0, c)

	c.txt = txt
	c.isCommand = isCommand

	c.r = r
	c.g = g
	c.b = b

	if (c.r<0):
		c.r = ConsoleR
	if (c.g<0):
		c.g = ConsoleG
	if (c.b<0):
		c.b = ConsoleB

func UpdateConsole():

	if !CanOpenConsole:
		ConsoleOpen = false
		return


	if ConsoleOpen:

		AASetFont (ConsoleFont)

		ConsoleR = 255
		ConsoleG = 255
		ConsoleB = 255

		var x: int = 0
		var y: int = GraphicHeight-300*MenuScale
		var width: int = GraphicWidth
		var height: int = 300*MenuScale-30*MenuScale
		var StrTemp
		var temp: int

		DrawFrame (x,y,width,height+30*MenuScale)

		var consoleHeight: int = 0
		var scrollbarHeight: int = 0
		for cm: ConsoleMsg in consoleMsg:
			consoleHeight += 15*MenuScale

		scrollbarHeight = (Float(height)/Float(consoleHeight))*height
		if scrollbarHeight>height:
			scrollbarHeight = height
		if consoleHeight<height:
			consoleHeight = height

		Color (50,50,50)
		var inBar: int = MouseOn(x+width-26*MenuScale,y,26*MenuScale,height)
		if inBar:
			Color(70,70,70)
		Rect (x+width-26*MenuScale,y,26*MenuScale,height,True)


		Color (120,120,120)
		var inBox: int = MouseOn(x+width-23*MenuScale,y+height-scrollbarHeight+(ConsoleScroll*scrollbarHeight/height),20*MenuScale,scrollbarHeight)
		if inBox:
			Color (200,200,200)
		if ConsoleScrollDragging:
			Color (255,255,255)
		Rect (x+width-23*MenuScale,y+height-scrollbarHeight+(ConsoleScroll*scrollbarHeight/height),20*MenuScale,scrollbarHeight,True)

		if !MouseDown(1):
			ConsoleScrollDragging=False
		elif ConsoleScrollDragging:
			ConsoleScroll = ConsoleScroll+((ScaledMouseY()-ConsoleMouseMem)*height/scrollbarHeight)
			ConsoleMouseMem = ScaledMouseY()


		if (not ConsoleScrollDragging):
			if MouseHit1:
				if inBox:
					ConsoleScrollDragging=True
					ConsoleMouseMem = ScaledMouseY()
				elif inBar:
					ConsoleScroll = ConsoleScroll+((ScaledMouseY()-(y+height))*consoleHeight/height+(height/2))
					ConsoleScroll = ConsoleScroll/2




		mouseScroll = MouseZSpeed()
		if mouseScroll==1:
			ConsoleScroll -=  15*MenuScale
		elif mouseScroll==-1:
			ConsoleScroll += 15*MenuScale


		var reissuePos: int
		if KeyHit(200):
			reissuePos = 0
			var count: int = 0
			if (ConsoleReissue==null):
				ConsoleReissue = consoleMsg[0]

				for ConsoleReissue: ConsoleMsg in consoleMsg:
					if ConsoleReissue == null:
						break
					if (ConsoleReissue.isCommand):
						break
					reissuePos -= 15*MenuScale
				

			else:
				for cm: ConsoleMsg in consoleMsg:
					if cm == null:
						break
					if cm == ConsoleReissue:
						break
					reissuePos -= 15*MenuScale
				count += 1
				ConsoleReissue = consoleMsg[count]
				
				reissuePos -= 15*MenuScale
				
				count = 0
				while true:
					
					if (ConsoleReissue == null):
						ConsoleReissue = consoleMsg[0]
						reissuePos = 0


					if (ConsoleReissue.isCommand):
						break

					reissuePos -= 15*MenuScale
					count += 1
					ConsoleReissue = consoleMsg[count]
					
				
			if ConsoleReissue != null:
				ConsoleInput = ConsoleReissue.txt
				ConsoleScroll = reissuePos+(height/2)



		if KeyHit(208):
			reissuePos = -consoleHeight+15*MenuScale
			if (ConsoleReissue == null):
				
				count = consoleMsg.size() - 1
				ConsoleReissue = consoleMsg[count]
				while (ConsoleReissue != null):
					if (ConsoleReissue.isCommand):
						break

					reissuePos = reissuePos + 15*MenuScale
					count -= 1
					ConsoleReissue = consoleMsg[count]
				

			else:
				count = consoleMsg.size() - 1
				cm = consoleMsg[count]
				while cm != null:
					if cm == ConsoleReissue:
						break
					reissuePos += 15*MenuScale
					count -= 1
					cm = consoleMsg[count]
				count -= 1
				ConsoleReissue = consoleMsg[count]
				reissuePos += 15*MenuScale
				
				while true:
					
					if (ConsoleReissue == null):
						count = consoleMsg.size() - 1
						ConsoleReissue = consoleMsg[count]
						reissuePos=-consoleHeight+15*MenuScale


					if (ConsoleReissue.isCommand):
						break

					reissuePos += 15*MenuScale
					count -= 1
					ConsoleReissue = consoleMsg[count]
				Wend


			if ConsoleReissue != null:
				ConsoleInput = ConsoleReissue.txt
				ConsoleScroll = reissuePos+(height/2)



		if ConsoleScroll<-consoleHeight+height: ConsoleScroll = -consoleHeight+height
		if ConsoleScroll>0: ConsoleScroll = 0

		Color (255, 255, 255)

		SelectedInputBox = 2
		var oldConsoleInput: String = ConsoleInput
		ConsoleInput = InputBox(x, y + height, width, 30*MenuScale, ConsoleInput, 2)
		if oldConsoleInput!=ConsoleInput:
			ConsoleReissue = Null

		ConsoleInput = Left(ConsoleInput, 100)

		if KeyHit(28) and ConsoleInput != "":
			ConsoleReissue = null
			ConsoleScroll = 0
			CreateConsoleMsg(ConsoleInput,255,255,0,True)
			if Instr(ConsoleInput, " ") > 0:
				StrTemp = Lower(Left(ConsoleInput, Instr(ConsoleInput, " ") - 1))
			else:
				StrTemp = Lower(ConsoleInput)


			match StrTemp.to_lower():
				"help":

					if Instr(ConsoleInput, " ")!=0:
						StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					else:
						StrTemp = ""

					ConsoleR = 0
					ConsoleG = 255
					ConsoleB = 255

					match StrTemp.to_lower():
						"1","":
							CreateConsoleMsg("LIST OF COMMANDS - PAGE 1/3")
							CreateConsoleMsg("******************************")
							CreateConsoleMsg("- asd")
							CreateConsoleMsg("- status")
							CreateConsoleMsg("- camerapick")
							CreateConsoleMsg("- ending")
							CreateConsoleMsg("- noclipspeed")
							CreateConsoleMsg("- noclip")
							CreateConsoleMsg("- injure [value]")
							CreateConsoleMsg("- infect [value]")
							CreateConsoleMsg("- heal")
							CreateConsoleMsg("- teleport [room name]")
							CreateConsoleMsg("- spawnitem [item name]")
							CreateConsoleMsg("- wireframe")
							CreateConsoleMsg("- 173speed")
							CreateConsoleMsg("- 106speed")
							CreateConsoleMsg("- 173state")
							CreateConsoleMsg("- 106state")
							CreateConsoleMsg("******************************")
							CreateConsoleMsg("Use "+char(34)+"help 2/3"+char(34)+" to find more commands.")
							CreateConsoleMsg("Use "+Chr(34)+"help [command name]"+Chr(34)+" to get more information about a command.")
							CreateConsoleMsg("******************************")
						"2":
							CreateConsoleMsg("LIST OF COMMANDS - PAGE 2/3")
							CreateConsoleMsg("******************************")
							CreateConsoleMsg("- spawn [npc type] [state]")
							CreateConsoleMsg("- reset096")
							CreateConsoleMsg("- disable173")
							CreateConsoleMsg("- enable173")
							CreateConsoleMsg("- disable106")
							CreateConsoleMsg("- enable106")
							CreateConsoleMsg("- halloween")
							CreateConsoleMsg("- sanic")
							CreateConsoleMsg("- scp-420-j")
							CreateConsoleMsg("- godmode")
							CreateConsoleMsg("- revive")
							CreateConsoleMsg("- noclip")
							CreateConsoleMsg("- showfps")
							CreateConsoleMsg("- 096state")
							CreateConsoleMsg("- debughud")
							CreateConsoleMsg("- camerafog [near] [far]")
							CreateConsoleMsg("- gamma [value]")
							CreateConsoleMsg("- infinitestamina")
							CreateConsoleMsg("******************************")
							CreateConsoleMsg("Use "+Chr(34)+"help [command name]"+Chr(34)+" to get more information about a command.")
							CreateConsoleMsg("******************************")
						"3":
							CreateConsoleMsg("- playmusic [clip + .wav/.ogg]")
							CreateConsoleMsg("- notarget")
							CreateConsoleMsg("- unlockbreaks")
						"asd":
							pass #asd
						"camerafog":
							pass
						"gamma":
							pass
						"noclip","fly":
							pass
						"godmode","god":
							pass
						"wireframe":
							pass
						"spawnitem":
							pass
						"spawn":
							pass
						"revive","undead","resurrect":
							pass
						"teleport":
							pass
						"stopsound", "stfu":
							pass
						"camerapick":
							pass
						"status":
							pass
						"weed","scp-420-j","420":
							pass
						"playmusic":
							pass

						_:
							CreateConsoleMsg("There is no help available for that command.",255,150,0)



				"asd":

					WireFrame (1)
					WireframeState=1
					GodMode = 1
					NoClip = 1
					CameraFogNear = 15
					CameraFogFar = 20

				"status":

					ConsoleR = 0
					ConsoleG = 255
					ConsoleB = 0
					CreateConsoleMsg("******************************")
					CreateConsoleMsg("Status: ")
					CreateConsoleMsg("Coordinates: ")
					CreateConsoleMsg("    - collider: "+EntityX(Collider)+", "+EntityY(Collider)+", "+EntityZ(Collider))
					CreateConsoleMsg("    - camera: "+EntityX(Camera)+", "+EntityY(Camera)+", "+EntityZ(Camera))

					CreateConsoleMsg("Rotation: ")
					CreateConsoleMsg("    - collider: "+EntityPitch(Collider)+", "+EntityYaw(Collider)+", "+EntityRoll(Collider))
					CreateConsoleMsg("    - camera: "+EntityPitch(Camera)+", "+EntityYaw(Camera)+", "+EntityRoll(Camera))

					CreateConsoleMsg("Room: "+PlayerRoom.RoomTemplate.Name)
					for ev: Events in events:
						if ev.room == PlayerRoom:
							CreateConsoleMsg("Room event: "+ev.EventName)
							CreateConsoleMsg("-    state: "+ev.EventState)
							CreateConsoleMsg("-    state2: "+ev.EventState2)
							CreateConsoleMsg("-    state3: "+ev.EventState3)
							break



					CreateConsoleMsg("Room coordinates: "+Floor(EntityX(PlayerRoom.obj) / 8.0 + 0.5)+", "+ Floor(EntityZ(PlayerRoom.obj) / 8.0 + 0.5))
					CreateConsoleMsg("Stamina: "+Stamina)
					CreateConsoleMsg("Death timer: "+KillTimer)
					CreateConsoleMsg("Blinktimer: "+BlinkTimer)
					CreateConsoleMsg("Injuries: "+Injuries)
					CreateConsoleMsg("Bloodloss: "+Bloodloss)
					CreateConsoleMsg("******************************")

				"camerapick":

					ConsoleR = 0
					ConsoleG = 255
					ConsoleB = 0
					c = CameraPick(Camera,GraphicWidth/2, GraphicHeight/2)
					if c == 0:
						CreateConsoleMsg("******************************")
						CreateConsoleMsg("No entity  picked")
						CreateConsoleMsg("******************************")
					else:
						CreateConsoleMsg("******************************")
						CreateConsoleMsg("Picked entity:")
						sf = GetSurface(c,1)
						b = GetSurfaceBrush( sf )
						t = GetBrushTexture(b,0)
						texname =  StripPath(TextureName(t))
						CreateConsoleMsg("Texture name: "+texname)
						CreateConsoleMsg("Coordinates: "+EntityX(c)+", "+EntityY(c)+", "+EntityZ(c))
						CreateConsoleMsg("******************************")


				"hidedistance":

					HideDistance = Float(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					CreateConsoleMsg("Hidedistance set to "+HideDistance)

				"ending":

					SelectedEnding = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					KillTimer = -0.1

				"noclipspeed":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					NoClipSpeed = float(StrTemp)

				"injure":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					Injuries = Float(StrTemp)

				"infect":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					Infect = Float(StrTemp)

				"heal":

					Injuries = 0
					Bloodloss = 0

				"teleport":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					match StrTemp:
						"895", "scp-895":
							StrTemp = "coffin"
						"scp-914":
							StrTemp = "914"
						"offices", "office":
							StrTemp = "room2offices"


					for r: Rooms in rooms:
						if r.RoomTemplate.Name == StrTemp:

							PositionEntity (Collider, EntityX(r.obj), EntityY(r.obj)+0.7, EntityZ(r.obj))
							ResetEntity(Collider)
							UpdateDoors()
							UpdateRooms()
							for it: Items in items:
								it.disttimer = 0

							PlayerRoom = r
							break



					if PlayerRoom.RoomTemplate.Name != StrTemp:
						CreateConsoleMsg("Room not found.",255,150,0)

				"spawnitem":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					temp = false
					for itt: Itemtemplates in itemTemplates:
						if (Lower(itt.name) == StrTemp):
							temp = true
							CreateConsoleMsg(itt.name + " spawned.")
							it.Items = CreateItem(itt.name, itt.tempname, EntityX(Collider), EntityY(Camera,True), EntityZ(Collider))
							EntityType(it.collider, HIT_ITEM)
							break
						else: if (Lower(itt.tempname) == StrTemp):
							temp = true
							CreateConsoleMsg(itt.name + " spawned.")
							it.Items = CreateItem(itt.name, itt.tempname, EntityX(Collider), EntityY(Camera,True), EntityZ(Collider))
							EntityType(it.collider, HIT_ITEM)
							break



					if temp == false:
						CreateConsoleMsg("Item not found.",255,150,0)

				"wireframe":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					match StrTemp:
						"on", "1", "true":
							WireframeState = true
						"off", "0", "false":
							WireframeState = false
						_:
							WireframeState != WireframeState


					if WireframeState:
						CreateConsoleMsg("WIREFRAME ON")
					else:
						CreateConsoleMsg("WIREFRAME OFF")


					WireFrame (WireframeState)

				"173speed":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					Curr173.Speed = Float(StrTemp)
					CreateConsoleMsg("173's speed set to " + StrTemp)

				"106speed":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					Curr106.Speed = Float(StrTemp)
					CreateConsoleMsg("106's speed set to " + StrTemp)

				"173state":

					CreateConsoleMsg("SCP-173")
					CreateConsoleMsg("Position: " + EntityX(Curr173.obj) + ", " + EntityY(Curr173.obj) + ", " + EntityZ(Curr173.obj))
					CreateConsoleMsg("Idle: " + Curr173.Idle)
					CreateConsoleMsg("State: " + Curr173.State)

				"106state":

					CreateConsoleMsg("SCP-106")
					CreateConsoleMsg("Position: " + EntityX(Curr106.obj) + ", " + EntityY(Curr106.obj) + ", " + EntityZ(Curr106.obj))
					CreateConsoleMsg("Idle: " + Curr106.Idle)
					CreateConsoleMsg("State: " + Curr106.State)

				"reset096":

					for n: NPCs in nPCs:
						if n.NPCtype == NPCtype096:
							n.State = 0
							StopStream_Strict(n.SoundChn)
							n.SoundChn=0
							if n.SoundChn2 != 0:
								StopStream_Strict(n.SoundChn2)
								n.SoundChn2=0

							break



				"disable173":

					Curr173.Idle = 3
					HideEntity (Curr173.obj)
					HideEntity (Curr173.Collider)

				"enable173":

					Curr173.Idle = false
					ShowEntity (Curr173.obj)
					ShowEntity (Curr173.Collider)

				"disable106":

					Curr106.Idle = True
					Curr106.State = 200000
					Contained106 = True

				"enable106":

					Curr106.Idle = false
					Contained106 = false
					ShowEntity (Curr106.Collider)
					ShowEntity (Curr106.obj)

				"halloween":

					HalloweenTex != HalloweenTex
					if HalloweenTex:
						var tex = LoadTexture_Strict("GFX\\npcs\\173h.pt", 1)
						EntityTexture (Curr173.obj, tex, 0, 0)
						FreeTexture (tex)
						CreateConsoleMsg("173 JACK-O-LANTERN ON")
					else:
						var tex2 = LoadTexture_Strict("GFX\\npcs\\173texture.jpg", 1)
						EntityTexture (Curr173.obj, tex2, 0, 0)
						FreeTexture (tex2)
						CreateConsoleMsg("173 JACK-O-LANTERN OFF")


				"sanic":

					SuperMan != SuperMan
					if SuperMan:
						CreateConsoleMsg("GOTTA GO FAST")
					else:
						CreateConsoleMsg("WHOA SLOW DOWN")


				"scp-420-j","420","weed":

					for i: int in range(1, 21):
						if randi(2) == 1:
							it.Items = CreateItem("Some SCP-420-J","420", EntityX(Collider,True)+Cos((360.0/20.0)*i)*randf(0.3,0.5), EntityY(Camera,True), EntityZ(Collider,True)+Sin((360.0/20.0)*i)*randf(0.3,0.5))
						else:
							it.Items = CreateItem("Joint","420s", EntityX(Collider,True)+Cos((360.0/20.0)*i)*randf(0.3,0.5), EntityY(Camera,True), EntityZ(Collider,True)+Sin((360.0/20.0)*i)*randf(0.3,0.5))

						EntityType (it.collider, HIT_ITEM)

					PlaySound_Strict (LoadTempSound("SFX\\Music\\420J.ogg"))

				"godmode", "god":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					match StrTemp:
						"on", "1", "true":
							GodMode = true
						"off", "0", "false":
							GodMode = false
						_:
							GodMode != GodMode

					if GodMode:
						CreateConsoleMsg("GODMODE ON")
					else:
						CreateConsoleMsg("GODMODE OFF")


				"revive","undead","resurrect":

					DropSpeed = -0.1
					HeadDropSpeed = 0.0
					Shake = 0
					CurrSpeed = 0

					HeartBeatVolume = 0

					CameraShake = 0
					Shake = 0
					LightFlash = 0
					BlurTimer = 0

					FallTimer = 0
					MenuOpen = false

					GodMode = 0
					NoClip = 0

					ShowEntity (Collider)

					KillTimer = 0
					KillAnim = 0

				"noclip","fly":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					match StrTemp:
						"on", "1", "true":
							NoClip = true
							Playable = true
						"off", "0", "false":
							NoClip = false
							RotateEntity (Collider, 0, EntityYaw(Collider), 0)
						_:
							NoClip != NoClip
							if !NoClip:
								RotateEntity (Collider, 0, EntityYaw(Collider), 0)
							else:
								Playable = true



					if NoClip:
						CreateConsoleMsg("NOCLIP ON")
					else:
						CreateConsoleMsg("NOCLIP OFF")


					DropSpeed = 0

				"showfps":

					ShowFPS != ShowFPS
					CreateConsoleMsg("ShowFPS: "+Str(ShowFPS))

				"096state":

					for n: NPCs in nPCs:
						if n.NPCtype == NPCtype096:
							CreateConsoleMsg("SCP-096")
							CreateConsoleMsg("Position: " + EntityX(n.obj) + ", " + EntityY(n.obj) + ", " + EntityZ(n.obj))
							CreateConsoleMsg("Idle: " + n.Idle)
							CreateConsoleMsg("State: " + n.State)
							break


					CreateConsoleMsg("SCP-096 has not spawned.")

				"debughud":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					match StrTemp:
						"on", "1", "true":
							DebugHUD = True
						"off", "0", "false":
							DebugHUD = false
						_:
							DebugHUD != DebugHUD


					if DebugHUD:
						CreateConsoleMsg("Debug Mode On")
					else:
						CreateConsoleMsg("Debug Mode Off")


				"stopsound", "stfu":

					for snd: Sound in sound:
						for i: int in range(0, 32):
							if snd.channels[i] != 0:
								StopChannel (snd.channels[i])




					for e: Events in events:
						if e.EventName == "alarm":
							for i: int in range(3):
								if e.room.NPC[i]:
									RemoveNPC(e.room.NPC[i])
							
							for i: int in range(2):
								FreeEntity (e.room.Objects[i])
								e.room.Objects[i]=0
							PositionEntity( Curr173.Collider, 0,0,0)
							ResetEntity (Curr173.Collider)
							ShowEntity (Curr173.obj)
							RemoveEvent(e)
							break


					CreateConsoleMsg("Stopped all sounds.")

				"camerafog":

					args = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					CameraFogNear = Float(Left(args, Len(args) - Instr(args, " ")))
					CameraFogFar = Float(Right(args, Len(args) - Instr(args, " ")))
					CreateConsoleMsg("Near set to: " + CameraFogNear + ", far set to: " + CameraFogFar)

				"gamma":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					ScreenGamma = Int(StrTemp)
					CreateConsoleMsg("Gamma set to " + ScreenGamma)

				"spawn":

					args = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					StrTemp = Piece(args, 1)
					StrTemp2 = Piece(args, 2)


					if (StrTemp != StrTemp2):
						Console_SpawnNPC(StrTemp, StrTemp2)
					else:
						Console_SpawnNPC(StrTemp)



				"infinitestamina","infstam":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					match StrTemp:
						"on", "1", "true":
							InfiniteStamina = True
						"off", "0", "false":
							InfiniteStamina = false
						_:
							InfiniteStamina != InfiniteStamina


					if InfiniteStamina:
						CreateConsoleMsg("INFINITE STAMINA ON")
					else:
						CreateConsoleMsg("INFINITE STAMINA OFF")


				"asd2":

					GodMode = 1
					InfiniteStamina = 1
					Curr173.Idle = 3
					Curr106.Idle = true
					Curr106.State = 200000
					Contained106 = true

				"toggle_warhead_lever":

					for e: Events in events:
						if e.EventName == "room2nuke":
							e.EventState != e.EventState
							break



				"unlockbreaks":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					match StrTemp:
						"a":
							for e: Events in events:
								if e.EventName == "gateaentrance":
									e.EventState3 = 1
									e.room.RoomDoors[1].open = true
									break


							CreateConsoleMsg("Gate A is now unlocked.")
						"b":
							for e: Events in events:
								if e.EventName == "break1":
									e.EventState3 = 1
									e.room.RoomDoors[4].open = true
									break


							CreateConsoleMsg("Gate B is now unlocked.")
						_:
							for e: Events in events:
								if e.EventName == "gateaentrance":
									e.EventState3 = 1
									e.room.RoomDoors[1].open = True
								elif e.EventName == "break1":
									e.EventState3 = 1
									e.room.RoomDoors[4].open = True


							CreateConsoleMsg("Gate A and B are now unlocked.")


					RemoteDoorOn = True

				"kill","suicide":

					KillTimer = -1
					match randi(1, 4):
						1:
							DeathMSG = "[REDACTED]"
						2:
							DeathMSG = "Subject D-9341 found dead in Sector [REDACTED]. "
							DeathMSG = DeathMSG + "The subject appears to have attained no physical damage, and there is no visible indication as to what killed him. "
							DeathMSG = DeathMSG + "Body was sent for autopsy."
						3:
							DeathMSG = "EXCP_ACCESS_VIOLATION"
						4:
							DeathMSG = "Subject D-9341 found dead in Sector [REDACTED]. "
							DeathMSG = DeathMSG + "The subject appears to have scribbled the letters "+Chr(34)+"kys"+Chr(34)+" in his own blood beside him. "
							DeathMSG = DeathMSG + "No other signs of physical trauma or struggle can be observed. Body was sent for autopsy."


				"playmusic":


					if Instr(ConsoleInput, " ")!=0:
						StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					else:
						StrTemp = ""


					if StrTemp:
						PlayCustomMusic = true
						if CustomMusic != 0:
							FreeSound_Strict (CustomMusic)
							CustomMusic = 0
						if MusicCHN:
							StopChannel (MusicCHN)
						CustomMusic = LoadSound_Strict("SFX\\Music\\Custom\\"+StrTemp)
						if CustomMusic == 0:
							PlayCustomMusic = false

					else:
						PlayCustomMusic = false
						if CustomMusic != 0:
							FreeSound_Strict (CustomMusic)
							CustomMusic = 0
						if MusicCHN != 0:
							StopChannel (MusicCHN)


				"tp":

					for n: NPCs in nPCs:
						if n.NPCtype == NPCtypeMTF:
							if n.MTFLeader == null:
								PositionEntity (Collider,EntityX(n.Collider),EntityY(n.Collider)+5,EntityZ(n.Collider))
								ResetEntity (Collider)
								break




				"tele":

					args = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					StrTemp = Piece(args,1," ")
					StrTemp2 = Piece(args,2," ")
					StrTemp3 = Piece(args,3," ")
					PositionEntity (Collider,float(StrTemp),float(StrTemp2),float(StrTemp3))
					PositionEntity (Camera,float(StrTemp),float(StrTemp2),float(StrTemp3))
					ResetEntity (Collider)
					ResetEntity (Camera)
					CreateConsoleMsg("Teleported to coordinates (X|Y|Z): "+EntityX(Collider)+"|"+EntityY(Collider)+"|"+EntityZ(Collider))

				"notarget":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					match StrTemp:
						"on", "1", "true":
							NoTarget = true
						"off", "0", "false":
							NoTarget = false
						_:
							NoTarget != NoTarget


					if !NoTarget:
						CreateConsoleMsg("NOTARGET OFF")
					else:
						CreateConsoleMsg("NOTARGET ON")


				"spawnradio":

					it.Items = CreateItem("Radio Transceiver", "fineradio", EntityX(Collider), EntityY(Camera,True), EntityZ(Collider))
					EntityType(it.collider, HIT_ITEM)
					it.state = 101

				"spawnnvg":

					it.Items = CreateItem("Night Vision Goggles", "nvgoggles", EntityX(Collider), EntityY(Camera,True), EntityZ(Collider))
					EntityType(it.collider, HIT_ITEM)
					it.state = 1000

				"spawnpumpkin","pumpkin":

					CreateConsoleMsg("What pumpkin?")

				"spawnnav":

					it.Items = CreateItem("S-NAV Navigator Ultimate", "nav", EntityX(Collider), EntityY(Camera,True), EntityZ(Collider))
					EntityType(it.collider, HIT_ITEM)
					it.state = 101

				"teleport173":

					PositionEntity (Curr173.Collider,EntityX(Collider),EntityY(Collider)+0.2,EntityZ(Collider))
					ResetEntity (Curr173.Collider)

				"seteventstate":

					args = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					StrTemp = Piece(args,1," ")
					StrTemp2 = Piece(args,2," ")
					StrTemp3 = Piece(args,3," ")
					var pl_room_found: bool = false
					if StrTemp == "" or StrTemp2 == "" or StrTemp3 == "":
						CreateConsoleMsg("Too few parameters. This command requires 3.",255,150,0)
					else:
						for e: Events in events:
							if e.room == PlayerRoom:
								if Lower(StrTemp)!="keep":
									e.EventState = Float(StrTemp)

								if Lower(StrTemp2)!="keep":
									e.EventState2 = Float(StrTemp2)

								if Lower(StrTemp3)!="keep":
									e.EventState3 = Float(StrTemp3)

								CreateConsoleMsg("Changed event states from current player room to: "+e.EventState+"|"+e.EventState2+"|"+e.EventState3)
								pl_room_found = true
								break


						if !pl_room_found:
							CreateConsoleMsg("The current room doesn't has any event applied.",255,150,0)



				"spawnparticles":

					if Instr(ConsoleInput, " ")!=0:
						StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					else:
						StrTemp = ""


					if Int(StrTemp) > -1 and Int(StrTemp) <= 1:
						SetEmitter(Collider,ParticleEffect[Int(StrTemp)])
						CreateConsoleMsg("Spawned particle emitter with ID "+Int(StrTemp)+" at player's position.")
					else:
						CreateConsoleMsg("Particle emitter with ID "+Int(StrTemp)+" not found.",255,150,0)


				"giveachievement":

					if Instr(ConsoleInput, " ")!=0:
						StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					else:
						StrTemp = ""


					if Int(StrTemp)>=0 and Int(StrTemp)<MAXACHIEVEMENTS:
						Achievements[Int(StrTemp)]=True
						CreateConsoleMsg("Achievemt "+AchievementStrings(Int(StrTemp))+" unlocked.")
					else:
						CreateConsoleMsg("Achievement with ID "+Int(StrTemp)+" doesn't exist.",255,150,0)


				"427state":

					StrTemp = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))

					I_427.Timer = Float(StrTemp)*70.0

				"teleport106":

					Curr106.State = 0
					Curr106.Idle = false

				"setblinkeffect":

					args = Lower(Right(ConsoleInput, Len(ConsoleInput) - Instr(ConsoleInput, " ")))
					BlinkEffect = Float(Left(args, Len(args) - Instr(args, " ")))
					BlinkEffectTimer = Float(Right(args, Len(args) - Instr(args, " ")))
					CreateConsoleMsg("Set BlinkEffect to: " + BlinkEffect + "and BlinkEffect timer: " + BlinkEffectTimer)

				"jorge":

					CreateConsoleMsg(Chr(74)+Chr(79)+Chr(82)+Chr(71)+Chr(69)+Chr(32)+Chr(72)+Chr(65)+Chr(83)+Chr(32)+Chr(66)+Chr(69)+Chr(69)+Chr(78)+Chr(32)+Chr(69)+Chr(88)+Chr(80)+Chr(69)+Chr(67)+Chr(84)+Chr(73)+Chr(78)+Chr(71)+Chr(32)+Chr(89)+Chr(79)+Chr(85)+Chr(46))


				_:

					CreateConsoleMsg("Command not found.",255,0,0)



			ConsoleInput = ""


		var TempY: int = y + height - 25*MenuScale - ConsoleScroll
		var count: int = 0
		for cm: ConsoleMsg in consoleMsg:
			count += 1
			if count>1000:
				Delete (cm)
			else:
				if TempY >= y and TempY < y + height - 20*MenuScale:
					if cm == ConsoleReissue:
						Color (cm.r/4,cm.g/4,cm.b/4)
						Rect (x,TempY-2*MenuScale,width-30*MenuScale,24*MenuScale,True)

					Color (cm.r,cm.g,cm.b)
					if cm.isCommand:
						AAText(x + 20*MenuScale, TempY, "> "+cm.txt)
					else:
						AAText(x + 20*MenuScale, TempY, cm.txt)


				TempY -= 15*MenuScale




		Color (255,255,255)

		if Fullscreen:
			DrawImage (CursorIMG, ScaledMouseX(),ScaledMouseY())


	AASetFont (Font1)



	ConsoleR = 0
	ConsoleG = 255
	ConsoleB = 255
	CreateConsoleMsg("Console commands: ")
	CreateConsoleMsg("  - teleport [room name]")
	CreateConsoleMsg("  - godmode [on/off]")
	CreateConsoleMsg("  - noclip [on/off]")
	CreateConsoleMsg("  - noclipspeed [x] (default = 2.0)")
	CreateConsoleMsg("  - wireframe [on/off]")
	CreateConsoleMsg("  - debughud [on/off]")
	CreateConsoleMsg("  - camerafog [near] [far]")
	CreateConsoleMsg(" ")
	CreateConsoleMsg("  - status")
	CreateConsoleMsg("  - heal")
	CreateConsoleMsg(" ")
	CreateConsoleMsg("  - spawnitem [item name]")
	CreateConsoleMsg(" ")
	CreateConsoleMsg("  - 173speed [x] (default = 35)")
	CreateConsoleMsg("  - disable173/enable173")
	CreateConsoleMsg("  - disable106/enable106")
	CreateConsoleMsg("  - 173state/106state/096state")
	CreateConsoleMsg("  - spawn [npc type]")


	

	var LightSpriteTex: PackedInt32Array = []
	LightSpriteTex.resize(10)
	






	var Music: PackedStringArray = [
		"The Dread",
		"HeavyContainment",
		"EntranceZone",
		"PD",
		"079",
		"GateB1",
		"GateB2",
		"Room3Storage",
		"Room049",
		"8601",
		"106",
		"Menu",
		"8601Cancer",
		"Intro",
		"178",
		"PDTrench",
		"205",
		"GateA",
		"1499",
		"1499Danger",
		"049Chase",
		"..\\Ending\\MenuBreath",
		"914",
		"Ending",
		"Credits",
		"SaveMeFrom"
	]
	Music.resize(40)


	MusicCHN = StreamSound_Strict("SFX\\Music\\"+Music(2)+".ogg",MusicVolume,Mode)



	DrawLoading(10, True)

	Dim OpenDoorSFX: int(3,3)
	Dim CloseDoorSFX: int(3,3)





	Dim DecaySFX: int(5)


	DrawLoading(20, True)

	Dim RustleSFX: int(3)


	Dim DripSFX: int(4)

	

	Dim RadioSFX(5,10)

	Global RadioSquelch
	Global RadioStatic
	Global RadioBuzz

	Global ElevatorBeepSFX, ElevatorMoveSFX

	Dim PickSFX: int(10)

	Global AmbientSFXCHN: int, CurrAmbientSFX: int
	Dim AmbientSFXAmount(6)

	AmbientSFXAmount(0)=8 : AmbientSFXAmount(1)=11 : AmbientSFXAmount(2)=12

	AmbientSFXAmount(3)=15 : AmbientSFXAmount(4)=5

	AmbientSFXAmount(5)=10

	Dim AmbientSFX: int(6, 15)

	Dim OldManSFX: int(8)

	Dim Scp173SFX: int(3)

	Dim HorrorSFX: int(20)


	DrawLoading(25, True)

	Dim IntroSFX: int(20)




	Dim AlarmSFX: int(5)

	Dim CommotionState: int(25)

	Global HeartBeatSFX

	Global VomitSFX: int

	Dim BreathSFX(2,5)
	Global BreathCHN: int


	Dim NeckSnapSFX(3)

	Dim DamageSFX: int(9)

	Dim MTFSFX: int(8)

	Dim CoughSFX: int(3)
	Global CoughCHN: int, VomitCHN: int

	Global MachineSFX: int
	Global ApacheSFX
	Global CurrStepSFX
	Dim StepSFX: int(5, 2, 8)

	Dim Step2SFX(6)

	DrawLoading(30, True)



	Global PlayCustomMusic: int = false, CustomMusic: int = 0

	Global Monitor2, Monitor3, MonitorTexture2, MonitorTexture3, MonitorTexture4, MonitorTextureOff
	Global MonitorTimer: float = 0.0, MonitorTimer2: float = 0.0, UpdateCheckpoint1: int, UpdateCheckpoint2: int


	Global PlayerDetected: int
	Global PrevInjuries: float,PrevBloodloss: float
	Global NoTarget: int = false

	Global NVGImages = LoadAnimImage("GFX\battery.png",64,64,0,2)
	MaskImage NVGImages,255,0,255


	Dim UserTrackName: String(256)



	Global OptionsMenu: int = 0
	Global QuitMSG: int = 0



	Global ParticleAmount: int = GetINIInt(OptionFile,"options","particle amount")

	Dim NavImages(5)
	for i = 0 To 3
		NavImages(i) = LoadImage_Strict("GFX\navigator\roomborder"+i+".png")
		MaskImage NavImages(i),255,0,255

	NavImages(4) = LoadImage_Strict("GFX\navigator\batterymeter.png")

	Global NavBG = CreateImage(GraphicWidth,GraphicHeight)

	Global LightConeModel

	Global ParticleEffect[10]

	const MaxDTextures=8


	Global StaminaMeterIMG: int

	Global KeypadHUD

	Global Panel294, Using294: int, Input294: String

	DrawLoading(35, True)



	Include "Items.bb"



	Include "Particles.bb"



class Doors:
	var obj: int
	var obj2: int
	var frameobj: int
	var buttons: int[2]
	var locked: int
	var open: int
	var angle: int
	var openstate: float
	var fastopen: int
	var dir: int
	var timer: int
	var timerstate: float
	var KeyCard: int
	var room: Rooms

	var DisableWaypoint: int

	var dist: float

	var SoundCHN: int

	var Code: String

	var ID: int

	var Level: int
	var LevelDest: int

	var AutoClose: int

	var LinkedDoor: Doors

	var IsElevatorDoor: int = false

	var MTFClose: int = True
	var NPCCalledElevator: int = false

	var DoorHitOBJ: int


	Dim BigDoorOBJ(2)
	Dim HeavyDoorObj(2)
	Dim OBJTunnel(7)

	func CreateDoor(lvl, x: float, y: float, z: float, angle: float, room.Rooms, dopen: int = false,  big: int = false, keycard: int = false, code: String="", useCollisionMesh: int = false) -> Doors:
		var d: Doors
		var parent
		var i: int
		if room != Null:
			parent = room.obj

		var d2.Doors

		d.Doors = Doors.new()
		if big=1:
			d.obj = CopyEntity(BigDoorOBJ(0))
			ScaleEntity(d.obj, 55 * RoomScale, 55 * RoomScale, 55 * RoomScale)
			d.obj2 = CopyEntity(BigDoorOBJ(1))
			ScaleEntity(d.obj2, 55 * RoomScale, 55 * RoomScale, 55 * RoomScale)

			d.frameobj = CopyEntity(DoorColl)
			ScaleEntity(d.frameobj, RoomScale, RoomScale, RoomScale)
			EntityType (d.frameobj, HIT_MAP)
			EntityAlpha (d.frameobj, 0.0)
		elif big=2:
			d.obj = CopyEntity(HeavyDoorObj(0))
			ScaleEntity(d.obj, RoomScale, RoomScale, RoomScale)
			d.obj2 = CopyEntity(HeavyDoorObj(1))
			ScaleEntity(d.obj2, RoomScale, RoomScale, RoomScale)

			d.frameobj = CopyEntity(DoorFrameOBJ)
		elif big=3:
			for d2 in doors:
				if d2 != d and d2.dir = 3:
					d.obj = CopyEntity(d2.obj)
					d.obj2 = CopyEntity(d2.obj2)
					ScaleEntity (d.obj, RoomScale, RoomScale, RoomScale)
					ScaleEntity (d.obj2, RoomScale, RoomScale, RoomScale)
					break


			if d.obj=0:
				d.obj = LoadMesh_Strict("GFX\\map\\elevatordoor.b3d")
				d.obj2 = CopyEntity(d.obj)
				ScaleEntity( d.obj, RoomScale, RoomScale, RoomScale)
				ScaleEntity (d.obj2, RoomScale, RoomScale, RoomScale)

			d.frameobj = CopyEntity(DoorFrameOBJ)
		else:
			d.obj = CopyEntity(DoorOBJ)
			ScaleEntity(d.obj, (204.0 * RoomScale) / MeshWidth(d.obj), 312.0 * RoomScale / MeshHeight(d.obj), 16.0 * RoomScale / MeshDepth(d.obj))

			d.frameobj = CopyEntity(DoorFrameOBJ)
			d.obj2 = CopyEntity(DoorOBJ)

			ScaleEntity(d.obj2, (204.0 * RoomScale) / MeshWidth(d.obj), 312.0 * RoomScale / MeshHeight(d.obj), 16.0 * RoomScale / MeshDepth(d.obj))




		PositionEntity d.frameobj, x, y, z
		ScaleEntity(d.frameobj, (8.0 / 2048.0), (8.0 / 2048.0), (8.0 / 2048.0))
		EntityPickMode d.frameobj,2
		EntityType d.obj, HIT_MAP
		EntityType d.obj2, HIT_MAP

		d.ID = DoorTempID
		DoorTempID=DoorTempID+1

		d.KeyCard = keycard
		d.Code = code

		d.Level = lvl
		d.LevelDest = 66

		for i: int = 0 To 1
			if code != "":
				d.buttons[i]= CopyEntity(ButtonCodeOBJ)
				EntityFX(d.buttons[i], 1)
			else:
				if keycard>0:
					d.buttons[i]= CopyEntity(ButtonKeyOBJ)
				elif keycard<0
					d.buttons[i]= CopyEntity(ButtonScannerOBJ)
				else:
					d.buttons[i] = CopyEntity(ButtonOBJ)



			ScaleEntity(d.buttons[i], 0.03, 0.03, 0.03)


		if big=1:
			PositionEntity d.buttons[0], x - 432.0 * RoomScale, y + 0.7, z + 192.0 * RoomScale
			PositionEntity d.buttons[1], x + 432.0 * RoomScale, y + 0.7, z - 192.0 * RoomScale
			RotateEntity d.buttons[0], 0, 90, 0
			RotateEntity d.buttons[1], 0, 270, 0
		else:
			PositionEntity d.buttons[0], x + 0.6, y + 0.7, z - 0.1
			PositionEntity d.buttons[1], x - 0.6, y + 0.7, z + 0.1
			RotateEntity d.buttons[1], 0, 180, 0

		EntityParent(d.buttons[0], d.frameobj)
		EntityParent(d.buttons[1], d.frameobj)
		EntityPickMode(d.buttons[0], 2)
		EntityPickMode(d.buttons[1], 2)

		PositionEntity d.obj, x, y, z

		RotateEntity d.obj, 0, angle, 0
		RotateEntity d.frameobj, 0, angle, 0

		if d.obj2 != 0:
			PositionEntity d.obj2, x, y, z
			if big=1:
				RotateEntity(d.obj2, 0, angle, 0)
			else:
				RotateEntity(d.obj2, 0, angle + 180, 0)

			EntityParent(d.obj2, parent)


		EntityParent(d.frameobj, parent)
		EntityParent(d.obj, parent)

		d.angle = angle
		d.open = dopen

		EntityPickMode(d.obj, 2)
		if d.obj2 != 0:
			EntityPickMode(d.obj2, 2)


		EntityPickMode d.frameobj,2

		if d.open And big = false And randi(1, 8) = 1: d.AutoClose = True
		d.dir=big
		d.room=room

		d.MTFClose = true

		if useCollisionMesh:
			for d2.Doors = Each Doors
				if d2 != d:
					if d2.DoorHitOBJ != 0:
						d.DoorHitOBJ = CopyEntity(d2\DoorHitOBJ,d.frameobj)
						EntityAlpha d.DoorHitOBJ,0.0
						EntityFX d.DoorHitOBJ,1
						EntityType d.DoorHitOBJ,HIT_MAP
						EntityColor d.DoorHitOBJ,255,0,0
						HideEntity d.DoorHitOBJ
						break



			if d.DoorHitOBJ=0:
				d.DoorHitOBJ = LoadMesh_Strict("GFX\\doorhit.b3d",d.frameobj)
				EntityAlpha (d.DoorHitOBJ,0.0)
				EntityFX (d.DoorHitOBJ,1)
				EntityType (d.DoorHitOBJ,HIT_MAP)
				EntityColor (d.DoorHitOBJ,255,0,0)
				HideEntity (d.DoorHitOBJ)



		return d

	

	func CreateButton(x: float,y: float,z: float, pitch: float,yaw: float,roll: float=0)
		var obj = CopyEntity(ButtonOBJ)

		ScaleEntity(obj, 0.03, 0.03, 0.03)

		PositionEntity obj, x,y,z
		RotateEntity obj, pitch,yaw,roll

		EntityPickMode(obj, 2)

		return obj
	

	func UpdateDoors()

		var i: int, d.Doors, x: float, z: float, dist: float
		if UpdateDoorsTimer =< 0:
			for d.Doors = Each Doors
				var xdist: float = Abs(EntityX(Collider)-EntityX(d.obj,True))
				var zdist: float = Abs(EntityZ(Collider)-EntityZ(d.obj,True))

				d.dist = xdist+zdist

				if d.dist > HideDistance*2:
					if d.obj != 0: HideEntity d.obj
					if d.frameobj != 0: HideEntity d.frameobj
					if d.obj2 != 0: HideEntity d.obj2
					if d.buttons[0] != 0: HideEntity d.buttons[0]
					if d.buttons[1] != 0: HideEntity d.buttons[1]
				else:
					if d.obj != 0: ShowEntity d.obj
					if d.frameobj != 0: ShowEntity d.frameobj
					if d.obj2 != 0: ShowEntity d.obj2
					if d.buttons[0] != 0: ShowEntity d.buttons[0]
					if d.buttons[1] != 0: ShowEntity d.buttons[1]


				if PlayerRoom\RoomTemplate.Name: String = "room2sl"
					if ValidRoom2slCamRoom(d.room)
						if d.obj != 0: ShowEntity d.obj
						if d.frameobj != 0: ShowEntity d.frameobj
						if d.obj2 != 0: ShowEntity d.obj2
						if d.buttons[0] != 0: ShowEntity d.buttons[0]
						if d.buttons[1] != 0: ShowEntity d.buttons[1]




			UpdateDoorsTimer = 30
		else:
			UpdateDoorsTimer = Max(UpdateDoorsTimer-FPSfactor,0)


		ClosestButton = 0
		ClosestDoor = Null

		for d.Doors = Each Doors
			if d.dist < HideDistance*2 Or d.IsElevatorDoor>0:

				if (d.openstate >= 180 Or d.openstate <= 0) And GrabbedEntity = 0:
					for i: int = 0 To 1
						if d.buttons[i] != 0:
							if Abs(EntityX(Collider)-EntityX(d.buttons[i],True)) < 1.0:
								if Abs(EntityZ(Collider)-EntityZ(d.buttons[i],True)) < 1.0:
									dist: float = Distance(EntityX(Collider, True), EntityZ(Collider, True), EntityX(d.buttons[i], True), EntityZ(d.buttons[i], True))
									if dist < 0.7:
										var temp: int = CreatePivot()
										PositionEntity temp, EntityX(Camera), EntityY(Camera), EntityZ(Camera)
										PointEntity temp,d.buttons[i]

										if EntityPick(temp, 0.6) = d.buttons[i]:
											if ClosestButton = 0:
												ClosestButton = d.buttons[i]
												ClosestDoor = d
											else:
												if dist < EntityDistance(Collider, ClosestButton): ClosestButton = d.buttons[i] : ClosestDoor = d



										FreeEntity (temp)









				if d.open:
					if d.openstate < 180:
						match d.dir
							0:
								d.openstate = Min(180, d.openstate + FPSfactor * 2 * (d.fastopen+1))
								MoveEntity(d.obj, Sin(d.openstate) * (d.fastopen*2+1) * FPSfactor / 80.0, 0, 0)
								if d.obj2 != 0: MoveEntity(d.obj2, Sin(d.openstate)* (d.fastopen+1) * FPSfactor / 80.0, 0, 0)
							1:
								d.openstate = Min(180, d.openstate + FPSfactor * 0.8)
								MoveEntity(d.obj, Sin(d.openstate) * FPSfactor / 180.0, 0, 0)
								if d.obj2 != 0: MoveEntity(d.obj2, -Sin(d.openstate) * FPSfactor / 180.0, 0, 0)
							2
								d.openstate = Min(180, d.openstate + FPSfactor * 2 * (d.fastopen+1))
								MoveEntity(d.obj, Sin(d.openstate) * (d.fastopen+1) * FPSfactor / 85.0, 0, 0)
								if d.obj2 != 0: MoveEntity(d.obj2, Sin(d.openstate)* (d.fastopen*2+1) * FPSfactor / 120.0, 0, 0)
							3
								d.openstate = Min(180, d.openstate + FPSfactor * 2 * (d.fastopen+1))
								MoveEntity(d.obj, Sin(d.openstate) * (d.fastopen*2+1) * FPSfactor / 162.0, 0, 0)
								if d.obj2 != 0: MoveEntity(d.obj2, Sin(d.openstate)* (d.fastopen*2+1) * FPSfactor / 162.0, 0, 0)
							4
								d.openstate = Min(180, d.openstate + FPSfactor * 1.4)
								MoveEntity(d.obj, Sin(d.openstate) * FPSfactor / 114.0, 0, 0)

					else:
						d.fastopen = 0
						ResetEntity(d.obj)
						if d.obj2 != 0: ResetEntity(d.obj2)
						if d.timerstate > 0:
							d.timerstate = Max(0, d.timerstate - FPSfactor)
							if d.timerstate + FPSfactor > 110 And d.timerstate <= 110: d.SoundCHN = PlaySound2(CautionSFX, Camera, d.obj)

							var sound: int
							if d.dir = 1: sound: int = randi(0, 1) else: sound: int = randi(0, 2)
							if d.timerstate = 0: d.open = (Not d.open) : d.SoundCHN = PlaySound2(CloseDoorSFX(d.dir,sound: int), Camera, d.obj)

						if d.AutoClose And RemoteDoorOn = True:
							if EntityDistance(Camera, d.obj) < 2.1:
								if (Not Wearing714): PlaySound_Strict HorrorSFX(7)
								d.open = false : d.SoundCHN = PlaySound2(CloseDoorSFX(Min(d.dir,1), randi(0, 2)), Camera, d.obj) : d.AutoClose = false



				else:
					if d.openstate > 0:
						match d.dir
							0
								d.openstate = Max(0, d.openstate - FPSfactor * 2 * (d.fastopen+1))
								MoveEntity(d.obj, Sin(d.openstate) * -FPSfactor * (d.fastopen+1) / 80.0, 0, 0)
								if d.obj2 != 0: MoveEntity(d.obj2, Sin(d.openstate) * (d.fastopen+1) * -FPSfactor / 80.0, 0, 0)
							1
								d.openstate = Max(0, d.openstate - FPSfactor*0.8)
								MoveEntity(d.obj, Sin(d.openstate) * -FPSfactor / 180.0, 0, 0)
								if d.obj2 != 0: MoveEntity(d.obj2, Sin(d.openstate) * FPSfactor / 180.0, 0, 0)
								if d.openstate < 15 And d.openstate+FPSfactor => 15
									if ParticleAmount=2
										for i = 0 To randi(75,99)
											var pvt: int = CreatePivot()
											PositionEntity(pvt, EntityX(d.frameobj,True)+randf(-0.2,0.2), EntityY(d.frameobj,True)+randf(0.0,1.2), EntityZ(d.frameobj,True)+randf(-0.2,0.2))
											RotateEntity(pvt, 0, randf(360), 0)

											var p.Particles = CreateParticle(EntityX(pvt), EntityY(pvt), EntityZ(pvt), 2, 0.002, 0, 300)
											p\speed = 0.005
											RotateEntity(p\pvt, randf(-20, 20), randf(360), 0)

											p\SizeChange = -0.00001
											p\size = 0.01
											ScaleSprite p\obj,p\size,p\size

											p\Achange = -0.01

											EntityOrder p\obj,-1

											FreeEntity pvt



							2
								d.openstate = Max(0, d.openstate - FPSfactor * 2 * (d.fastopen+1))
								MoveEntity(d.obj, Sin(d.openstate) * -FPSfactor * (d.fastopen+1) / 85.0, 0, 0)
								if d.obj2 != 0: MoveEntity(d.obj2, Sin(d.openstate) * (d.fastopen+1) * -FPSfactor / 120.0, 0, 0)
							3
								d.openstate = Max(0, d.openstate - FPSfactor * 2 * (d.fastopen+1))
								MoveEntity(d.obj, Sin(d.openstate) * -FPSfactor * (d.fastopen+1) / 162.0, 0, 0)
								if d.obj2 != 0: MoveEntity(d.obj2, Sin(d.openstate) * (d.fastopen+1) * -FPSfactor / 162.0, 0, 0)
							4
								d.openstate = Min(180, d.openstate - FPSfactor * 1.4)
								MoveEntity(d.obj, Sin(d.openstate) * -FPSfactor / 114.0, 0, 0)


						if d.angle = 0 Or d.angle=180:
							if Abs(EntityZ(d.frameobj, True)-EntityZ(Collider))<0.15:
								if Abs(EntityX(d.frameobj, True)-EntityX(Collider))<0.7*(d.dir*2+1):
									z: float = CurveValue(EntityZ(d.frameobj,True)+0.15*Sgn(EntityZ(Collider)-EntityZ(d.frameobj, True)), EntityZ(Collider), 5)
									PositionEntity Collider, EntityX(Collider), EntityY(Collider), z


						else:
							if Abs(EntityX(d.frameobj, True)-EntityX(Collider))<0.15:
								if Abs(EntityZ(d.frameobj, True)-EntityZ(Collider))<0.7*(d.dir*2+1):
									x: float = CurveValue(EntityX(d.frameobj,True)+0.15*Sgn(EntityX(Collider)-EntityX(d.frameobj, True)), EntityX(Collider), 5)
									PositionEntity Collider, x, EntityY(Collider), EntityZ(Collider)




						if d.DoorHitOBJ != 0:
							ShowEntity d.DoorHitOBJ

					else:
						d.fastopen = 0
						PositionEntity(d.obj, EntityX(d.frameobj, True), EntityY(d.frameobj, True), EntityZ(d.frameobj, True))
						if d.obj2 != 0: PositionEntity(d.obj2, EntityX(d.frameobj, True), EntityY(d.frameobj, True), EntityZ(d.frameobj, True))
						if d.obj2 != 0 And d.dir = 0:
							MoveEntity(d.obj, 0, 0, 8.0 * RoomScale)
							MoveEntity(d.obj2, 0, 0, 8.0 * RoomScale)

						if d.DoorHitOBJ != 0:
							HideEntity d.DoorHitOBJ





			UpdateSoundOrigin(d.SoundCHN,Camera,d.frameobj)

			if d.DoorHitOBJ!=0:
				if DebugHUD:
					EntityAlpha d.DoorHitOBJ,0.5
				else:
					EntityAlpha d.DoorHitOBJ,0.0



	

	func UseDoor(d.Doors, showmsg: int=True, playsfx: int=True)
		var temp: int = 0
		if d.KeyCard > 0:
			if SelectedItem = Null:
				if showmsg = True:
					if (Instr(Msg,"The keycard")=0 And Instr(Msg,"A keycard with")=0) Or (MsgTimer<70*3):
						Msg = "A keycard is required to operate this door."
						MsgTimer = 70 * 7


				Return
			else:
				match Selecteditem.itemtemplate.tempname
					"key1"
						temp = 1
					"key2"
						temp = 2
					"key3"
						temp = 3
					"key4"
						temp = 4
					"key5"
						temp = 5
					"key6"
						temp = 6
					_:
						temp = -1


				if temp =-1:
					if showmsg = True:
						if (Instr(Msg,"The keycard")=0 And Instr(Msg,"A keycard with")=0) Or (MsgTimer<70*3):
							Msg = "A keycard is required to operate this door."
							MsgTimer = 70 * 7


					Return
				elif temp >= d.KeyCard
					SelectedItem = Null
					if showmsg = True:
						if d.locked:
							PlaySound_Strict KeyCardSFX2
							Msg = "The keycard was inserted into the slot but nothing happened."
							MsgTimer = 70 * 7
							Return
						else:
							PlaySound_Strict KeyCardSFX1
							Msg = "The keycard was inserted into the slot."
							MsgTimer = 70 * 7


				else:
					SelectedItem = Null
					if showmsg = True:
						PlaySound_Strict KeyCardSFX2
						if d.locked:
							Msg = "The keycard was inserted into the slot but nothing happened."
						else:
							Msg = "A keycard with security clearance "+d.KeyCard+" or higher is required to operate this door."

						MsgTimer = 70 * 7

					Return


		elif d.KeyCard < 0:

			if SelectedItem != Null:
				temp = (Selecteditem.itemtemplate.tempname = "hand" And d.KeyCard=-1) Or (Selecteditem.itemtemplate.tempname = "hand2" And d.KeyCard=-2)

			SelectedItem = Null
			if temp != 0:
				PlaySound_Strict ScannerSFX1
				if (Instr(Msg,"You placed your")=0) Or (MsgTimer < 70*3):
					Msg = "You place the palm of the hand onto the scanner. The scanner reads: "+Chr(34)+"DNA verified. Access granted."+Chr(34)

				MsgTimer = 70 * 10
			else:
				if showmsg = True:
					PlaySound_Strict ScannerSFX2
					Msg = "You placed your palm onto the scanner. The scanner reads: "+Chr(34)+"DNA does not match known sample. Access denied."+Chr(34)
					MsgTimer = 70 * 10

				Return

		else:
			if d.locked:
				if showmsg = True:
					if Not (d.IsElevatorDoor>0):
						PlaySound_Strict ButtonSFX2
						if PlayerRoom\RoomTemplate.Name != "room2elevator":
							if d.open:
								Msg = "You pushed the button but nothing happened."
							else:
								Msg = "The door appears to be locked."

						else:
							Msg = "The elevator appears to be broken."

						MsgTimer = 70 * 5
					else:
						if d.IsElevatorDoor = 1:
							Msg = "You called the elevator."
							MsgTimer = 70 * 5
						elif d.IsElevatorDoor = 3:
							Msg = "The elevator is already on this floor."
							MsgTimer = 70 * 5
						elif (Msg!="You called the elevator.")
							if (Msg="You already called the elevator.") Or (MsgTimer<70*3)
								match randi(1, 10):
									1
										Msg = "Stop spamming the button."
										MsgTimer = 70 * 7
									2
										Msg = "Pressing it harder does not make the elevator come faster."
										MsgTimer = 70 * 7
									3
										Msg = "if you continue pressing this button I will generate a Memory Access Violation."
										MsgTimer = 70 * 7
									_:
										Msg = "You already called the elevator."
										MsgTimer = 70 * 7


						else:
							Msg = "You already called the elevator."
							MsgTimer = 70 * 7




				Return



		d.open = (Not d.open)
		if d.LinkedDoor != Null: d.LinkedDoor\open = (Not d.LinkedDoor\open)

		var sound = 0

		if d.dir = 1: sound=randi(0, 1) else: sound=randi(0, 2)

		if playsfx=True:
			if d.open:
				if d.LinkedDoor != Null: d.LinkedDoor\timerstate = d.LinkedDoor\timer
				d.timerstate = d.timer
				d.SoundCHN = PlaySound2 (OpenDoorSFX(d.dir, sound), Camera, d.obj)
			else:
				d.SoundCHN = PlaySound2 (CloseDoorSFX(d.dir, sound), Camera, d.obj)

			UpdateSoundOrigin(d.SoundCHN,Camera,d.obj)
		else:
			if d.open:
				if d.LinkedDoor != Null: d.LinkedDoor\timerstate = d.LinkedDoor\timer
				d.timerstate = d.timer



	

	func RemoveDoor(d.Doors)
		if d.buttons[0] != 0: EntityParent d.buttons[0], 0
		if d.buttons[1] != 0: EntityParent d.buttons[1], 0

		if d.obj != 0: FreeEntity d.obj
		if d.obj2 != 0: FreeEntity d.obj2
		if d.frameobj != 0: FreeEntity d.frameobj
		if d.buttons[0] != 0: FreeEntity d.buttons[0]
		if d.buttons[1] != 0: FreeEntity d.buttons[1]

		Delete d
	

	DrawLoading(40,True)

	Include "MapSystem.bb"

	DrawLoading(80,True)

	Include "NPCs.bb"



	Type Events
		Field EventName: String
		Field room.Rooms

		Field EventState: float, EventState2: float, EventState3: float
		Field SoundCHN: int, SoundCHN2: int
		Field Sound, Sound2
		Field SoundCHN_isStream: int, SoundCHN2_isStream: int

		Field EventStr: String

		Field img: int
	End Type

	func CreateEvent.Events(eventname: String, roomname: String, id: int, prob: float = 0.0)

		var i: int = 0, temp: int, e.Events, e2.Events, r.Rooms

		if prob = 0.0:
			for r.Rooms = Each Rooms
				if (roomname = "" Or roomname = r\RoomTemplate.Name):
					temp = false
					for e2.Events = Each Events
						if e2\room = r: temp = True : break


					i=i+1
					if i >= id And temp = false:
						e.Events = New Events
						e.EventName = eventname
						e.room = r
						return e



		else:
			for r.Rooms = Each Rooms
				if (roomname = "" Or roomname = r\RoomTemplate.Name):
					temp = false
					for e2.Events = Each Events
						if e2\room = r: temp = True : break


					if randf(0.0, 1.0) < prob And temp = false:
						e.Events = New Events
						e.EventName = eventname
						e.room = r





		return Null
	

	func InitEvents()
		var e.Events

		CreateEvent("173", "173", 0)
		CreateEvent("alarm", "start", 0)

		CreateEvent("pocketdimension", "pocketdimension", 0)


		CreateEvent("tunnel106", "tunnel", 0, 0.07 + (0.1*SelectedDifficulty.aggressiveNPCs))


		if randi(1, 3)<3:
			CreateEvent("lockroom173", "lockroom", 0)
		CreateEvent("lockroom173", "lockroom", 0, 0.3 + (0.5*SelectedDifficulty.aggressiveNPCs))

		CreateEvent("room2trick", "room2", 0, 0.15)

		CreateEvent("1048a", "room2", 0, 1.0)

		CreateEvent("room2storage", "room2storage", 0)


		CreateEvent("lockroom096", "lockroom2", 0)

		CreateEvent("endroom106", "endroom", randi(0,1))

		CreateEvent("room2poffices2", "room2poffices2", 0)

		CreateEvent("room2fan", "room2_2", 0, 1.0)

		CreateEvent("room2elevator2", "room2elevator", 0)
		CreateEvent("room2elevator", "room2elevator", randi(1,2))

		CreateEvent("room3storage", "room3storage", 0, 0)

		CreateEvent("tunnel2smoke", "tunnel2", 0, 0.2)
		CreateEvent("tunnel2", "tunnel2", randi(0,2), 0)
		CreateEvent("tunnel2", "tunnel2", 0, (0.2*SelectedDifficulty\aggressiveNPCs))


		CreateEvent("room2doors173", "room2doors", 0, 0.5 + (0.4*SelectedDifficulty\aggressiveNPCs))


		CreateEvent("room2offices2", "room2offices2", 0, 0.7)

		CreateEvent("room2closets", "room2closets", 0)

		CreateEvent("room2cafeteria", "room2cafeteria", 0)

		CreateEvent("room3pitduck", "room3pit", 0)
		CreateEvent("room3pit1048", "room3pit", 1)


		CreateEvent("room2offices3", "room2offices3", 0, 1.0)

		CreateEvent("room2servers", "room2servers", 0)

		CreateEvent("room3servers", "room3servers", 0)
		CreateEvent("room3servers", "room3servers2", 0)


		CreateEvent("room3tunnel","room3tunnel", 0, 0.08)

		CreateEvent("room4","room4", 0)

		if randi(5)<5:
			match randi(3)
				1
					CreateEvent("682roar", "tunnel", randi(0,2), 0)
				2
					CreateEvent("682roar", "room3pit", randi(0,2), 0)
				3

					CreateEvent("682roar", "room2z3", 0, 0)



		CreateEvent("testroom173", "room2testroom2", 0, 1.0)

		CreateEvent("room2tesla", "room2tesla", 0, 0.9)

		CreateEvent("room2nuke", "room2nuke", 0, 0)

		if randi(1, 5) < 5:
			CreateEvent("coffin106", "coffin", 0, 0)
		else:
			CreateEvent("coffin", "coffin", 0, 0)


		CreateEvent("checkpoint", "checkpoint1", 0, 1.0)
		CreateEvent("checkpoint", "checkpoint2", 0, 1.0)

		CreateEvent("room3door", "room3", 0, 0.1)
		CreateEvent("room3door", "room3tunnel", 0, 0.1)

		if randi(1, 2) == 1:
			CreateEvent("106victim", "room3", randi(1,2))
			CreateEvent("106sinkhole", "room3_2", randi(2,3))
		else:
			CreateEvent("106victim", "room3_2", randi(1,2))
			CreateEvent("106sinkhole", "room3", randi(2,3))

		CreateEvent("106sinkhole", "room4", randi(1,2))

		CreateEvent("room079", "room079", 0, 0)

		CreateEvent("room049", "room049", 0, 0)

		CreateEvent("room012", "room012", 0, 0)

		CreateEvent("room035", "room035", 0, 0)

		CreateEvent("008", "008", 0, 0)

		CreateEvent("room106", "room106", 0, 0)

		CreateEvent("pj", "roompj", 0, 0)

		CreateEvent("914", "914", 0, 0)

		CreateEvent("buttghost", "room2toilets", 0, 0)
		CreateEvent("toiletguard", "room2toilets", 1, 0)

		CreateEvent("room2pipes106", "room2pipes", randi(0, 3))

		CreateEvent("room2pit", "room2pit", 0, 0.4 + (0.4*SelectedDifficulty\aggressiveNPCs))

		CreateEvent("testroom", "testroom", 0)

		CreateEvent("room2tunnel", "room2tunnel", 0)

		CreateEvent("room2ccont", "room2ccont", 0)

		CreateEvent("gateaentrance", "gateaentrance", 0)
		CreateEvent("gatea", "gatea", 0)
		CreateEvent("break1", "break1", 0)

		CreateEvent("room205", "room205", 0)

		CreateEvent("room860","room860", 0)

		CreateEvent("room966","room966", 0)

		CreateEvent("room1123", "room1123", 0, 0)

		CreateEvent("room2tesla", "room2tesla_lcz", 0, 0.9)
		CreateEvent("room2tesla", "room2tesla_hcz", 0, 0.9)


		CreateEvent("room4tunnels","room4tunnels",0)
		CreateEvent("room_gw","room2gw",0,1.0)
		CreateEvent("dimension1499","dimension1499",0)
		CreateEvent("room1162","room1162",0)
		CreateEvent("room2scps2","room2scps2",0)
		CreateEvent("room_gw","room3gw",0,1.0)
		CreateEvent("room2sl","room2sl",0)
		CreateEvent("medibay","medibay",0)
		CreateEvent("room2shaft","room2shaft",0)
		CreateEvent("room1lifts","room1lifts",0)

		CreateEvent("room2gw_b","room2gw_b",randi(0,1))

		CreateEvent("096spawn","room4pit",0,0.6+(0.2*SelectedDifficulty\aggressiveNPCs))
		CreateEvent("096spawn","room3pit",0,0.6+(0.2*SelectedDifficulty\aggressiveNPCs))
		CreateEvent("096spawn","room2pipes",0,0.4+(0.2*SelectedDifficulty\aggressiveNPCs))
		CreateEvent("096spawn","room2pit",0,0.5+(0.2*SelectedDifficulty\aggressiveNPCs))
		CreateEvent("096spawn","room3tunnel",0,0.6+(0.2*SelectedDifficulty\aggressiveNPCs))
		CreateEvent("096spawn","room4tunnels",0,0.7+(0.2*SelectedDifficulty\aggressiveNPCs))
		CreateEvent("096spawn","tunnel",0,0.6+(0.2*SelectedDifficulty\aggressiveNPCs))
		CreateEvent("096spawn","tunnel2",0,0.4+(0.2*SelectedDifficulty\aggressiveNPCs))
		CreateEvent("096spawn","room3z2",0,0.7+(0.2*SelectedDifficulty\aggressiveNPCs))

		CreateEvent("room2pit","room2_4",0,0.4 + (0.4*SelectedDifficulty\aggressiveNPCs))

		CreateEvent("room2offices035","room2offices",0)

		CreateEvent("room2pit106", "room2pit", 0, 0.07 + (0.1*SelectedDifficulty\aggressiveNPCs))

		CreateEvent("room1archive", "room1archive", 0, 1.0)


	Include "UpdateEvents.bb"

	func RemoveEvent(e.Events)
		if e.Sound!=0: FreeSound_Strict e.Sound
		if e.Sound2!=0: FreeSound_Strict e.Sound2
		if e.img!=0: FreeImage e.img
		Delete e
	

	Collisions (HIT_PLAYER, HIT_MAP, 2, 2)
	Collisions (HIT_PLAYER, HIT_PLAYER, 1, 3)
	Collisions (HIT_ITEM, HIT_MAP, 2, 2)
	Collisions (HIT_APACHE, HIT_APACHE, 1, 2)
	Collisions (HIT_178, HIT_MAP, 2, 2)
	Collisions (HIT_178, HIT_178, 1, 3)
	Collisions (HIT_DEAD, HIT_MAP, 2, 2)

	func MilliSecs2():
		var retVal: int = MilliSecs()
		if retVal < 0:
			retVal += 2147483648
		return retVal

	DrawLoading(90, True)




	Dim LightSpriteTex: int(5)

	Dim DecalTextures: int(20)



	Include "menu.bb"
	MainMenuOpen = True



class MEMORYSTATUS:
	var dwLength: int
	var dwMemoryLoad: int
	var dwTotalPhys: int
	var dwAvailPhys: int
	var dwTotalPageFile: int
	var dwAvailPageFile: int
	var dwTotalVirtual: int
	var dwAvailVirtual: int


	Global m.MEMORYSTATUS = New MEMORYSTATUS

	FlushKeys()
	FlushMouse()

	DrawLoading(100, True)

	LoopDelay = MilliSecs()

	Global UpdateParticles_Time: float = 0.0

	Global CurrTrisAmount: int

	Global Input_ResetTime: float = 0

	class SCP427
		var Using: int
		var Timer: float
		var Sound[1]
		var SoundCHN[1]
	

	Global I_427.SCP427 = New SCP427

	class MapZones:
		var Transition: int[1]
		var HasCustomForest: int
		var HasCustomMT: int

	Global I_Zone.MapZones = New MapZones




	Repeat

		Cls()

		CurTime = MilliSecs2()
		ElapsedTime = (CurTime - PrevTime) / 1000.0
		PrevTime = CurTime
		PrevFPSFactor = FPSfactor
		FPSfactor = Max(Min(ElapsedTime * 70, 5.0), 0.2)
		FPSfactor2 = FPSfactor

		if MenuOpen or InvOpen or OtherOpen != Null or ConsoleOpen or SelectedDoor != Null or SelectedScreen != Null or Using294: FPSfactor = 0

		if Framelimit > 0:

			var WaitingTime: int = (1000.0 / Framelimit) - (MilliSecs2() - LoopDelay)
			Delay WaitingTime: int

			LoopDelay = MilliSecs2()



		if CheckFPS < MilliSecs2():
			FPS = ElapsedLoops
			ElapsedLoops = 0
			CheckFPS = MilliSecs2()+1000

		ElapsedLoops += 1

		if Input_ResetTime<=0.0
			DoubleClick = false
			MouseHit1 = MouseHit(1)
			if MouseHit1:
				if MilliSecs2() - LastMouseHit1 < 800:
					DoubleClick = true
				LastMouseHit1 = MilliSecs2()


			var prevmousedown1 = MouseDown1
			MouseDown1 = MouseDown(1)
			if prevmousedown1 = True and MouseDown1=False:
				MouseUp1 = true
			else:
				MouseUp1 = false

			MouseHit2 = MouseHit(2)

			if !MouseDown1 and !MouseHit1:
				GrabbedEntity = 0
		else:
			Input_ResetTime = max(Input_ResetTime-FPSfactor,0.0)


		UpdateMusic()
		if EnableSFXRelease:
			AutoReleaseSounds()

		if MainMenuOpen:
			if ShouldPlay = 21:
				EndBreathSFX = LoadSound("SFX\\Ending\\MenuBreath.ogg")
				EndBreathCHN = PlaySound(EndBreathSFX)
				ShouldPlay = 66
			elif ShouldPlay = 66
				if !ChannelPlaying(EndBreathCHN):
					FreeSound(EndBreathSFX)
					ShouldPlay = 11

			else:
				ShouldPlay = 11

			UpdateMainMenu()
		else:
			UpdateStreamSounds()

			ShouldPlay = min(PlayerZone,2)

			DrawHandIcon = false

			RestoreSanity = true
			ShouldEntitiesFall = true

			if FPSfactor > 0 and PlayerRoom.RoomTemplate.Name != "dimension1499": UpdateSecurityCams()

			if PlayerRoom.RoomTemplate.Name != "pocketdimension" And PlayerRoom\RoomTemplate.Name != "gatea" And PlayerRoom\RoomTemplate.Name != "break1" And (Not MenuOpen) And (Not ConsoleOpen) And (Not InvOpen):

				if randi(1, 1500) = 1:
					for i = 0 To 5
						if AmbientSFX(i,CurrAmbientSFX)!=0:
							if ChannelPlaying(AmbientSFXCHN)=0: FreeSound_Strict AmbientSFX(i,CurrAmbientSFX) : AmbientSFX(i,CurrAmbientSFX) = 0



					PositionEntity (SoundEmitter, EntityX(Camera) + randf(-1.0, 1.0), 0.0, EntityZ(Camera) + randf(-1.0, 1.0))

					if randi(1, 3)=1:
						PlayerZone = 3

					if PlayerRoom\RoomTemplate.Name = "173":
						PlayerZone = 4
					elif PlayerRoom\RoomTemplate.Name = "room860"
						for e.Events = Each Events
							if e.EventName = "room860"
								if e.EventState = 1.0
									PlayerZone = 5
									PositionEntity (SoundEmitter, EntityX(SoundEmitter), 30.0, EntityZ(SoundEmitter))


								break




					CurrAmbientSFX = randi(0,AmbientSFXAmount(PlayerZone)-1)

					var sound_path: String = "SFX\\Ambient\\"
					var curr_sfx_tmp: String = "\\ambient" + (CurrAmbientSFX+1)+".ogg"
					var insert: String
					
					match PlayerZone:
						0,1,2:
							insert = "Zone"+(PlayerZone+1)
						3, 4, 5:
							insert = ["General", "Pre-breach", "Forest"][PlayerZone]
					if AmbientSFX(PlayerZone,CurrAmbientSFX)==0:
						AmbientSFX(PlayerZone,CurrAmbientSFX)=LoadSound_Strict(sound_path + insert + curr_sfx_tmp)

					AmbientSFXCHN = PlaySound2(AmbientSFX(PlayerZone,CurrAmbientSFX), Camera, SoundEmitter)

				UpdateSoundOrigin(AmbientSFXCHN,Camera, SoundEmitter)

				if randi(1, 50000) == 3:
					var RN: String = PlayerRoom.RoomTemplate.Name
					if RN: String != "room860" and RN: String != "room1123" And RN: String != "173" And RN: String != "dimension1499":
						if FPSfactor > 0:
							LightBlink = randf(1.0,2.0)
						PlaySound_Strict(LoadTempSound("SFX\SCP\079\Broadcast"+randi(1,7)+".ogg"))




			UpdateCheckpoint1 = false
			UpdateCheckpoint2 = false

			if !MenuOpen and !InvOpen and !OtherOpen and !SelectedDoor and !ConsoleOpen and !Using294 and !SelectedScreen and EndingTimer => 0:
				LightVolume = CurveValue(TempLightVolume, LightVolume, 50.0)
				CameraFogRange(Camera, CameraFogNear*LightVolume,CameraFogFar*LightVolume)
				CameraFogColor(Camera, 0,0,0)
				CameraFogMode (Camera,1)
				CameraRange(Camera, 0.05, Min(CameraFogFar*LightVolume*1.5,28))
				if PlayerRoom.RoomTemplate.Name!="pocketdimension":
					CameraClsColor(Camera, 0,0,0)


				AmbientLight (Brightness, Brightness, Brightness)
				PlayerSoundVolume = CurveValue(0.0, PlayerSoundVolume, 5.0)

				CanSave: bool = true
				UpdateDeafPlayer()
				UpdateEmitters()
				MouseLook()
				if PlayerRoom.RoomTemplate.Name = "dimension1499" And QuickLoadPercent > 0 And QuickLoadPercent < 100
					ShouldEntitiesFall = false

				MovePlayer()
				InFacility = CheckForPlayerInFacility()
				if PlayerRoom.RoomTemplate.Name = "dimension1499"
					if QuickLoadPercent = -1 Or QuickLoadPercent = 100
						UpdateDimension1499()

					UpdateLeave1499()
				elif PlayerRoom.RoomTemplate.Name = "gatea" Or (PlayerRoom\RoomTemplate.Name="break1" And EntityY(Collider)>1040.0*RoomScale)
					UpdateDoors()
					if QuickLoadPercent == -1 or QuickLoadPercent == 100:
						UpdateEndings()

					UpdateScreens()
					UpdateRoomLights(Camera)
				else:
					UpdateDoors()
					if QuickLoadPercent == -1 or QuickLoadPercent = 100
						UpdateEvents()

					UpdateScreens()
					TimeCheckpointMonitors()
					Update294()
					UpdateRoomLights(Camera)

				UpdateDecals()
				UpdateMTF()
				UpdateNPCs()
				UpdateItems()
				UpdateParticles()
				Use427()
				UpdateMonitorSaving()

				UpdateParticles_Time: float = min(1, UpdateParticles_Time + FPSfactor)
				if UpdateParticles_Time == 1:
					UpdateDevilEmitters()
					UpdateParticles_Devil()
					UpdateParticles_Time=0



			if InfiniteStamina:
				Stamina = min(100, Stamina + (100.0-Stamina)*0.01*FPSfactor)

			if FPSfactor=0
				UpdateWorld(0)
			else:
				UpdateWorld()
				ManipulateNPCBones()

			RenderWorld2()

			BlurVolume = Min(CurveValue(0.0, BlurVolume, 20.0),0.95)
			if BlurTimer > 0.0:
				BlurVolume = Max(Min(0.95, BlurTimer / 1000.0), BlurVolume)
				BlurTimer = Max(BlurTimer - FPSfactor, 0.0)


			UpdateBlur(BlurVolume)



			var darkA: float = 0.0
			if !MenuOpen :
				if Sanity < 0:
					if RestoreSanity:
						Sanity = min(Sanity + FPSfactor, 0.0)
					if Sanity < (-200):
						darkA = max(min((-Sanity - 200) / 700.0, 0.6), darkA)
						if KillTimer => 0:
							HeartBeatVolume = min(abs(Sanity+200)/500.0,1.0)
							HeartBeatRate = max(70 + abs(Sanity+200)/6.0,HeartBeatRate)




				if EyeStuck > 0:
					BlinkTimer = BLINKFREQ
					EyeStuck = max(EyeStuck-FPSfactor,0)

					if EyeStuck < 9000:
						BlurTimer = max(BlurTimer, (9000-EyeStuck)*0.5)
					if EyeStuck < 6000:
						darkA = min(max(darkA, (6000-EyeStuck)/5000.0),1.0)
					if EyeStuck < 9000 and EyeStuck+FPSfactor =>9000:
						Msg = "The eyedrops are causing your eyes to tear up."
						MsgTimer = 70*6



				if BlinkTimer < 0:
					if BlinkTimer > - 5:
						darkA = max(darkA, sin(abs(BlinkTimer * 18.0)))
					elif BlinkTimer > - 15
						darkA = 1.0
					else:
						darkA = max(darkA, abs(sin(BlinkTimer * 18.0)))


					if BlinkTimer <= - 20:

						match SelectedDifficulty.otherFactors
							EASY:
								BLINKFREQ = randf(490,700)
							NORMAL:
								BLINKFREQ = randf(455,665)
							HARD:
								BLINKFREQ = randf(420,630)

						BlinkTimer = BLINKFREQ


					BlinkTimer -= FPSfactor
				else:
					BlinkTimer -= FPSfactor * 0.6 * BlinkEffect
					if EyeIrritation > 0:
						BlinkTimer -= min(EyeIrritation / 100.0 + 1.0, 4.0) * FPSfactor

					darkA = max(darkA, 0.0)


				EyeIrritation = max(0, EyeIrritation - FPSfactor)

				if BlinkEffectTimer > 0:
					BlinkEffectTimer = BlinkEffectTimer - (FPSfactor/70)
				else:
					if BlinkEffect != 1.0: BlinkEffect = 1.0


				LightBlink = max(LightBlink - (FPSfactor / 35.0), 0)
				if LightBlink > 0:
					darkA = min(max(darkA, LightBlink * randf(0.3, 0.8)), 1.0)

				if Using294: darkA=1.0

				if (Not WearingNightVision): darkA = Max((1.0-SecondaryLightOn)*0.9, darkA)

				if KillTimer < 0:
					InvOpen = false
					SelectedItem = Null
					SelectedScreen = Null
					SelectedMonitor = Null
					BlurTimer = Abs(KillTimer*5)
					KillTimer=KillTimer-(FPSfactor*0.8)
					if KillTimer < - 360:
						MenuOpen = True
						if SelectedEnding != "": EndingTimer = Min(KillTimer,-0.1)

					darkA = Max(darkA, Min(Abs(KillTimer / 400.0), 1.0))


				if FallTimer < 0:
					if SelectedItem != Null:
						if Instr(Selecteditem.itemtemplate.tempname,"hazmatsuit") Or Instr(Selecteditem.itemtemplate.tempname,"vest"):
							if WearingHazmat=0 And WearingVest=0:
								DropItem(SelectedItem)



					InvOpen = false
					SelectedItem = Null
					SelectedScreen = Null
					SelectedMonitor = Null
					BlurTimer = Abs(FallTimer*10)
					FallTimer = FallTimer-FPSfactor
					darkA = Max(darkA, Min(Abs(FallTimer / 400.0), 1.0))


				if SelectedItem != Null:
					if Selecteditem.itemtemplate.tempname = "navigator" Or Selecteditem.itemtemplate.tempname = "nav": darkA = Max(darkA, 0.5)

				if SelectedScreen != Null: darkA = Max(darkA, 0.5)

				EntityAlpha(Dark, darkA)


			if LightFlash > 0:
				ShowEntity Light
				EntityAlpha(Light, Max(Min(LightFlash + randf(-0.2, 0.2), 1.0), 0.0))
				LightFlash = Max(LightFlash - (FPSfactor / 70.0), 0)
			else:
				HideEntity Light



			EntityColor Light,255,255,255



			if KeyHit(KEY_INV) And VomitTimer >= 0:
				if (Not UnableToMove) And (Not IsZombie) And (Not Using294):
					var W: String = ""
					var V: float = 0
					if SelectedItem!=Null
						W: String = Selecteditem.itemtemplate.tempname
						V: float = Selecteditem.state

					if (W!="vest" And W!="finevest" And W!="hazmatsuit" And W!="hazmatsuit2" And W!="hazmatsuit3") Or V=0 Or V=100
						if InvOpen:
							ResumeSounds()
							MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0
						else:
							PauseSounds()

						InvOpen = Not InvOpen
						if OtherOpen!=Null: OtherOpen=Null
						SelectedItem = Null




			if KeyHit(KEY_SAVE):
				if SelectedDifficulty\saveType = SAVEANYWHERE:
					RN: String = PlayerRoom\RoomTemplate.Name: String
					if RN: String = "173" Or (RN: String = "break1" And EntityY(Collider)>1040.0*RoomScale) Or RN: String = "gatea"
						Msg = "You cannot save in this location."
						MsgTimer = 70 * 4

					elif (Not CanSave) Or QuickLoadPercent > -1
						Msg = "You cannot save at this moment."
						MsgTimer = 70 * 4

						if QuickLoadPercent > -1
							Msg = Msg + " (game is loading)"


					else:
						SaveGame(SavePath + CurrSave + "\\")

				elif SelectedDifficulty\saveType = SAVEONSCREENS
					if SelectedScreen=Null And SelectedMonitor=Null:
						Msg = "Saving is only permitted on clickable monitors scattered throughout the facility."
						MsgTimer = 70 * 4

					else:
						RN: String = PlayerRoom\RoomTemplate.Name: String
						if RN: String = "173" Or (RN: String = "break1" And EntityY(Collider)>1040.0*RoomScale) Or RN: String = "gatea"
							Msg = "You cannot save in this location."
							MsgTimer = 70 * 4

						elif (Not CanSave) Or QuickLoadPercent > -1
							Msg = "You cannot save at this moment."
							MsgTimer = 70 * 4

							if QuickLoadPercent > -1
								Msg = Msg + " (game is loading)"


						else:
							if SelectedScreen!=Null
								GameSaved = false
								Playable = True
								DropSpeed = 0

							SaveGame(SavePath + CurrSave + "\\")


				else:
					Msg = "Quick saving is disabled."
					MsgTimer = 70 * 4


			else: if SelectedDifficulty\saveType = SAVEONSCREENS And (SelectedScreen!=Null Or SelectedMonitor!=Null)
				if (Msg!="Game progress saved." And Msg!="You cannot save in this location."And Msg!="You cannot save at this moment.") Or MsgTimer<=0:
					Msg = "Press "+KeyName(KEY_SAVE)+" to save."
					MsgTimer = 70*4



				if MouseHit2: SelectedMonitor = Null


			if KeyHit(KEY_CONSOLE):
				if CanOpenConsole
					if ConsoleOpen:
						UsedConsole = True
						ResumeSounds()
						MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0
					else:
						PauseSounds()

					ConsoleOpen = (Not ConsoleOpen)
					FlushKeys()



			DrawGUI()

			if EndingTimer < 0:
				if SelectedEnding != "": DrawEnding()
			else:
				DrawMenu()


			UpdateConsole()

			if PlayerRoom != Null:
				if PlayerRoom\RoomTemplate.Name = "173":
					for e.Events = Each Events
						if e.EventName = "173":
							if e.EventState3 => 40 And e.EventState3 < 50:
								if InvOpen:
									Msg = "Double click on the document to view it."
									MsgTimer=70*7
									e.EventState3 = 50







			if MsgTimer > 0:
				var temp: int = false
				if (Not InvOpen: int)
					if SelectedItem != Null
						if Selecteditem.itemtemplate.tempname = "paper" Or Selecteditem.itemtemplate.tempname = "oldpaper"
							temp: int = True




				if (Not temp: int)
					Color 0,0,0
					AAText((GraphicWidth / 2)+1, (GraphicHeight / 2) + 201, Msg, True, false, Min(MsgTimer / 2, 255)/255.0)
					Color 255,255,255
					if Left(Msg,14)="Blitz3D Error!":
						Color 255,0,0

					AAText((GraphicWidth / 2), (GraphicHeight / 2) + 200, Msg, True, false, Min(MsgTimer / 2, 255)/255.0)
				else:
					Color 0,0,0
					AAText((GraphicWidth / 2)+1, (GraphicHeight * 0.94) + 1, Msg, True, false, Min(MsgTimer / 2, 255)/255.0)
					Color 255,255,255
					if Left(Msg,14)="Blitz3D Error!":
						Color 255,0,0

					AAText((GraphicWidth / 2), (GraphicHeight * 0.94), Msg, True, false, Min(MsgTimer / 2, 255)/255.0)

				MsgTimer=MsgTimer-FPSfactor2


			Color 255, 255, 255
			if ShowFPS: AASetFont ConsoleFont : AAText 20, 20, "FPS: " + FPS : AASetFont Font1

			DrawQuickLoading()

			UpdateAchievementMsg()



		if BorderlessWindowed:
			if (RealGraphicWidth!=GraphicWidth) Or (RealGraphicHeight!=GraphicHeight):
				SetBuffer TextureBuffer(fresize_texture)
				ClsColor 0,0,0 : Cls
				CopyRect 0,0,GraphicWidth,GraphicHeight,1024-GraphicWidth/2,1024-GraphicHeight/2,BackBuffer(),TextureBuffer(fresize_texture)
				SetBuffer BackBuffer()
				ClsColor 0,0,0 : Cls
				ScaleRender(0,0,2050.0 / Float(GraphicWidth) * AspectRatioRatio, 2050.0 / Float(GraphicWidth) * AspectRatioRatio)





		if ScreenGamma>1.0:
			CopyRect 0,0,RealGraphicWidth,RealGraphicHeight,1024-RealGraphicWidth/2,1024-RealGraphicHeight/2,BackBuffer(),TextureBuffer(fresize_texture)
			EntityBlend fresize_image,1
			ClsColor 0,0,0 : Cls
			ScaleRender(-1.0/Float(RealGraphicWidth),1.0/Float(RealGraphicWidth),2048.0 / Float(RealGraphicWidth),2048.0 / Float(RealGraphicWidth))
			EntityFX fresize_image,1+32
			EntityBlend fresize_image,3
			EntityAlpha fresize_image,ScreenGamma-1.0
			ScaleRender(-1.0/Float(RealGraphicWidth),1.0/Float(RealGraphicWidth),2048.0 / Float(RealGraphicWidth),2048.0 / Float(RealGraphicWidth))
		elif ScreenGamma<1.0:
			CopyRect 0,0,RealGraphicWidth,RealGraphicHeight,1024-RealGraphicWidth/2,1024-RealGraphicHeight/2,BackBuffer(),TextureBuffer(fresize_texture)
			EntityBlend fresize_image,1
			ClsColor 0,0,0 : Cls
			ScaleRender(-1.0/Float(RealGraphicWidth),1.0/Float(RealGraphicWidth),2048.0 / Float(RealGraphicWidth),2048.0 / Float(RealGraphicWidth))
			EntityFX fresize_image,1+32
			EntityBlend fresize_image,2
			EntityAlpha fresize_image,1.0
			SetBuffer TextureBuffer(fresize_texture2)
			ClsColor 255*ScreenGamma,255*ScreenGamma,255*ScreenGamma
			Cls
			SetBuffer BackBuffer()
			ScaleRender(-1.0/Float(RealGraphicWidth),1.0/Float(RealGraphicWidth),2048.0 / Float(RealGraphicWidth),2048.0 / Float(RealGraphicWidth))
			SetBuffer(TextureBuffer(fresize_texture2))
			ClsColor 0,0,0
			Cls
			SetBuffer(BackBuffer())

		EntityFX fresize_image,1
		EntityBlend fresize_image,1
		EntityAlpha fresize_image,1.0

		CatchErrors("Main loop / uncaught")

		if Vsync = 0:
			Flip 0
		else:
			Flip 1

	Forever



	func QuickLoadEvents()
		CatchErrors("Uncaught (QuickLoadEvents)")

		if QuickLoad_CurrEvent = Null:
			QuickLoadPercent = -1
			Return


		var e.Events = QuickLoad_CurrEvent

		var r: Rooms
		var sc: SecurityCams
		var sc2: SecurityCams
		var scale: float
		var pvt: int
		var n: NPCs
		var tex: int
		var i: int
		var x: float
		var z: float



		match e.EventName:
			"room2sl":

				if e.EventState = 0 And e.EventStr != ""
					if e.EventStr != "" And Left(e.EventStr,4) != "load"
						QuickLoadPercent = QuickLoadPercent + 5
						if Int(e.EventStr) > 9
							e.EventStr = "load2"
						else:
							e.EventStr = Int(e.EventStr) + 1

					elif e.EventStr = "load2"

						var skip = false
						if e.room\NPC[0]=Null:
							for n.NPCs = Each NPCs
								if n\NPCtype = NPCtype049

									skip = True
									break



							if (Not skip)
								e.room\NPC[0] = CreateNPC(NPCtype049,EntityX(e.room\Objects[7],True),EntityY(e.room\Objects[7],True)+5,EntityZ(e.room\Objects[7],True))
								e.room\NPC[0]\HideFromNVG = True
								PositionEntity e.room\NPC[0]\Collider,EntityX(e.room\Objects[7],True),EntityY(e.room\Objects[7],True)+5,EntityZ(e.room\Objects[7],True)
								ResetEntity e.room\NPC[0]\Collider
								RotateEntity e.room\NPC[0]\Collider,0,e.room\angle+180,0
								e.room\NPC[0]\State = 0
								e.room\NPC[0]\PrevState = 2

								DebugLog(EntityX(e.room\Objects[7],True)+", "+EntityY(e.room\Objects[7],True)+", "+EntityZ(e.room\Objects[7],True))
							else:
								DebugLog "Skipped 049 spawning in room2sl"


						QuickLoadPercent = 80
						e.EventStr = "load3"
					elif e.EventStr = "load3"


						e.EventState = 1
						if e.EventState2 = 0: e.EventState2 = -(70*5)

						QuickLoadPercent = 100



			"room2closets"

				if e.EventState = 0
					if e.EventStr = "load0"
						QuickLoadPercent = 10
						if e.room\NPC[0]=Null:
							e.room\NPC[0] = CreateNPC(NPCtypeD, EntityX(e.room\Objects[0],True),EntityY(e.room\Objects[0],True),EntityZ(e.room\Objects[0],True))


						ChangeNPCTextureID(e.room\NPC[0],4)
						e.EventStr = "load1"
					elif e.EventStr = "load1"
						QuickLoadPercent = 20
						e.room\NPC[0]\Sound=LoadSound_Strict("SFX\Room\Storeroom\Escape1.ogg")
						e.EventStr = "load2"
					elif e.EventStr = "load2"
						QuickLoadPercent = 35
						e.room\NPC[0]\SoundChn = PlaySound2(e.room\NPC[0]\Sound, Camera, e.room\NPC[0]\Collider, 12)
						e.EventStr = "load3"
					elif e.EventStr = "load3"
						QuickLoadPercent = 55
						if e.room\NPC[1]=Null:
							e.room\NPC[1] = CreateNPC(NPCtypeD, EntityX(e.room\Objects[1],True),EntityY(e.room\Objects[1],True),EntityZ(e.room\Objects[1],True))


						ChangeNPCTextureID(e.room\NPC[1],2)
						e.EventStr = "load4"
					elif e.EventStr = "load4"
						QuickLoadPercent = 80
						e.room\NPC[1]\Sound=LoadSound_Strict("SFX\Room\Storeroom\Escape2.ogg")
						e.EventStr = "load5"
					elif e.EventStr = "load5"
						QuickLoadPercent = 100
						PointEntity e.room\NPC[0]\Collider, e.room\NPC[1]\Collider
						PointEntity e.room\NPC[1]\Collider, e.room\NPC[0]\Collider

						e.EventState=1



			"room3storage"

				if e.room\NPC[0]=Null:
					e.room\NPC[0]=CreateNPC(NPCtype939, 0,0,0)
					QuickLoadPercent = 20
				elif e.room\NPC[1]=Null:
					e.room\NPC[1]=CreateNPC(NPCtype939, 0,0,0)
					QuickLoadPercent = 50
				elif e.room\NPC[2]=Null:
					e.room\NPC[2]=CreateNPC(NPCtype939, 0,0,0)
					QuickLoadPercent = 100
				else:
					if QuickLoadPercent > -1: QuickLoadPercent = 100


			"room049"

				if e.EventState = 0:
					if e.EventStr = "load0"
						n.NPCs = CreateNPC(NPCtypeZombie, EntityX(e.room\Objects[4],True),EntityY(e.room\Objects[4],True),EntityZ(e.room\Objects[4],True))
						PointEntity n\Collider, e.room\obj
						TurnEntity n\Collider, 0, 190, 0
						QuickLoadPercent = 20
						e.EventStr = "load1"
					elif e.EventStr = "load1"
						n.NPCs = CreateNPC(NPCtypeZombie, EntityX(e.room\Objects[5],True),EntityY(e.room\Objects[5],True),EntityZ(e.room\Objects[5],True))
						PointEntity n\Collider, e.room\obj
						TurnEntity n\Collider, 0, 20, 0
						QuickLoadPercent = 60
						e.EventStr = "load2"
					elif e.EventStr = "load2"
						for n.NPCs = Each NPCs
							if n\NPCtype = NPCtype049
								e.room\NPC[0]=n
								e.room\NPC[0]\State = 2
								e.room\NPC[0]\Idle = 1
								e.room\NPC[0]\HideFromNVG = True
								PositionEntity e.room\NPC[0]\Collider,EntityX(e.room\Objects[4],True),EntityY(e.room\Objects[4],True)+3,EntityZ(e.room\Objects[4],True)
								ResetEntity e.room\NPC[0]\Collider
								break


						if e.room\NPC[0]=Null
							n.NPCs = CreateNPC(NPCtype049, EntityX(e.room\Objects[4],True), EntityY(e.room\Objects[4],True)+3, EntityZ(e.room\Objects[4],True))
							PointEntity n\Collider, e.room\obj
							n\State = 2
							n\Idle = 1
							n\HideFromNVG = True
							e.room\NPC[0]=n

						QuickLoadPercent = 100
						e.EventState=1



			"room205"

				if e.EventState=0 Or e.room\Objects[0]=0:
					if e.EventStr = "load0"
						e.room\Objects[3] = LoadAnimMesh_Strict("GFX\npcs\205_demon1.b3d")
						QuickLoadPercent = 10
						e.EventStr = "load1"
					elif e.EventStr = "load1"
						e.room\Objects[4] = LoadAnimMesh_Strict("GFX\npcs\205_demon2.b3d")
						QuickLoadPercent = 20
						e.EventStr = "load2"
					elif e.EventStr = "load2"
						e.room\Objects[5] = LoadAnimMesh_Strict("GFX\npcs\205_demon3.b3d")
						QuickLoadPercent = 30
						e.EventStr = "load3"
					elif e.EventStr = "load3"
						e.room\Objects[6] = LoadAnimMesh_Strict("GFX\npcs\205_woman.b3d")
						QuickLoadPercent = 40
						e.EventStr = "load4"
					elif e.EventStr = "load4"
						QuickLoadPercent = 50
						e.EventStr = "load5"
					elif e.EventStr = "load5"
						for i = 3 To 6
							PositionEntity e.room\Objects[i], EntityX(e.room\Objects[0],True), EntityY(e.room\Objects[0],True), EntityZ(e.room\Objects[0],True), True
							RotateEntity e.room\Objects[i], -90, EntityYaw(e.room\Objects[0],True), 0, True
							ScaleEntity(e.room\Objects[i], 0.05, 0.05, 0.05, True)

						QuickLoadPercent = 70
						e.EventStr = "load6"
					elif e.EventStr = "load6"


						HideEntity(e.room\Objects[3])
						HideEntity(e.room\Objects[4])
						HideEntity(e.room\Objects[5])
						QuickLoadPercent = 100
						e.EventStr = "loaddone"




			"room860"

				if e.EventStr = "load0"
					QuickLoadPercent = 15
					ForestNPC = CreateSprite()

					ScaleSprite ForestNPC,0.75*(140.0/410.0),0.75
					SpriteViewMode ForestNPC,4
					EntityFX ForestNPC,1+8
					ForestNPCTex = LoadAnimTexture("GFX\npcs\AgentIJ.AIJ",1+2,140,410,0,4)
					ForestNPCData[0] = 0
					EntityTexture ForestNPC,ForestNPCTex,ForestNPCData[0]
					ForestNPCData[1]=0
					ForestNPCData[2]=0
					HideEntity ForestNPC
					e.EventStr = "load1"
				elif e.EventStr = "load1"
					QuickLoadPercent = 40
					e.EventStr = "load2"
				elif e.EventStr = "load2"
					QuickLoadPercent = 100
					if e.room\NPC[0]=Null: e.room\NPC[0]=CreateNPC(NPCtype860, 0,0,0)
					e.EventStr = "loaddone"


			"room966"

				if e.EventState = 1
					e.EventState2 = e.EventState2+FPSfactor
					if e.EventState2>30:
						if e.EventStr = ""
							CreateNPC(NPCtype966, EntityX(e.room\Objects[0],True), EntityY(e.room\Objects[0],True), EntityZ(e.room\Objects[0],True))
							QuickLoadPercent = 50
							e.EventStr = "load0"
						elif e.EventStr = "load0"
							CreateNPC(NPCtype966, EntityX(e.room\Objects[2],True), EntityY(e.room\Objects[2],True), EntityZ(e.room\Objects[2],True))
							QuickLoadPercent = 100
							e.EventState=2

					else:
						QuickLoadPercent = Int(e.EventState2)



			"dimension1499"

				if e.EventState = 0.0
					if e.EventStr = "load0"
						QuickLoadPercent = 10
						e.room\Objects[0] = LoadMesh_Strict("GFX\map\dimension1499\1499plane.b3d")

						HideEntity e.room\Objects[0]
						e.EventStr = "load1"
					elif e.EventStr = "load1"
						QuickLoadPercent = 30
						NTF_1499Sky = sky_CreateSky("GFX\map\sky\1499sky")
						e.EventStr = 1
					else:
						if Int(e.EventStr)<16
							QuickLoadPercent = QuickLoadPercent + 2
							e.room\Objects[Int(e.EventStr)] = LoadMesh_Strict("GFX\map\dimension1499\1499object"+(Int(e.EventStr))+".b3d")
							HideEntity e.room\Objects[Int(e.EventStr)]
							e.EventStr = Int(e.EventStr)+1
						elif Int(e.EventStr)=16
							QuickLoadPercent = 90
							CreateChunkParts(e.room)
							e.EventStr = 17
						elif Int(e.EventStr) = 17
							QuickLoadPercent = 100
							x: float = EntityX(e.room\obj)
							z: float = EntityZ(e.room\obj)
							var ch.Chunk
							for i = -2 To 0 Step 2
								ch = CreateChunk(-1,x: float*(i*2.5),EntityY(e.room\obj),z: float,True)

							for i = -2 To 0 Step 2
								ch = CreateChunk(-1,x: float*(i*2.5),EntityY(e.room\obj),z: float-40,True)

							e.EventState = 2.0
							e.EventStr = 18






		CatchErrors("QuickLoadEvents "+e.EventName)

	

	func Kill()
		if GodMode: Return

		if BreathCHN != 0:
			if ChannelPlaying(BreathCHN): StopChannel(BreathCHN)


		if KillTimer >= 0:
			KillAnim = randi(0,1)
			PlaySound_Strict(DamageSFX(0))
			if SelectedDifficulty\permaDeath:
				DeleteFile(CurrentDir() + SavePath + CurrSave+"\save.txt")
				DeleteDir(SavePath + CurrSave)
				LoadSaveGames()


			KillTimer = Min(-1, KillTimer)
			ShowEntity Head
			PositionEntity(Head, EntityX(Camera, True), EntityY(Camera, True), EntityZ(Camera, True), True)
			ResetEntity (Head)
			RotateEntity(Head, 0, EntityYaw(Camera), 0)

	

	func DrawEnding()

		ShowPointer()

		FPSfactor = 0

		if EndingTimer>-2000
			EndingTimer=Max(EndingTimer-FPSfactor2,-1111)
		else:
			EndingTimer=EndingTimer-FPSfactor2


		GiveAchievement(Achv055)
		if (Not UsedConsole): GiveAchievement(AchvConsole)
		if SelectedDifficulty\name = "Keter": GiveAchievement(AchvKeter)
		var x,y,width,height, temp
		var itt.ItemTemplates, r.Rooms

		match Lower(SelectedEnding)
			"b2", "a1"
				ClsColor Max(255+(EndingTimer)*2.8,0), Max(255+(EndingTimer)*2.8,0), Max(255+(EndingTimer)*2.8,0)
			_:
				ClsColor 0,0,0


		ShouldPlay = 66

		Cls

		if EndingTimer<-200:

			if BreathCHN != 0:
				if ChannelPlaying(BreathCHN): StopChannel BreathCHN : Stamina = 100




			if EndingScreen = 0:
				EndingScreen = LoadImage_Strict("GFX\endingscreen.pt")

				ShouldPlay = 23
				CurrMusicVolume = MusicVolume

				CurrMusicVolume = MusicVolume
				StopStream_Strict(MusicCHN)
				MusicCHN = StreamSound_Strict("SFX\\Music\\"+Music(23)+".ogg",CurrMusicVolume,0)
				NowPlaying = ShouldPlay

				PlaySound_Strict LightSFX


			if EndingTimer > -700:


				if randi(1,150)<Min((Abs(EndingTimer)-200),155):
					DrawImage EndingScreen, GraphicWidth/2-400, GraphicHeight/2-400
				else:
					Color 0,0,0
					Rect 100,100,GraphicWidth-200,GraphicHeight-200
					Color 255,255,255


				if EndingTimer+FPSfactor2 > -450 And EndingTimer <= -450:
					match Lower(SelectedEnding)
						"a1", "a2"
							PlaySound_Strict LoadTempSound("SFX\Ending\GateA\Ending"+SelectedEnding+".ogg")
						"b1", "b2", "b3"
							PlaySound_Strict LoadTempSound("SFX\Ending\GateB\Ending"+SelectedEnding+".ogg")



			else:

				DrawImage EndingScreen, GraphicWidth/2-400, GraphicHeight/2-400

				if EndingTimer < -1000 And EndingTimer > -2000

					width = ImageWidth(PauseMenuIMG)
					height = ImageHeight(PauseMenuIMG)
					x = GraphicWidth / 2 - width / 2
					y = GraphicHeight / 2 - height / 2

					DrawImage PauseMenuIMG, x, y

					Color(255, 255, 255)
					AASetFont Font2
					AAText(x + width / 2 + 40*MenuScale, y + 20*MenuScale, "THE END", True)
					AASetFont Font1

					if AchievementsMenu=0:
						x = x+132*MenuScale
						y = y+122*MenuScale

						var roomamount = 0, roomsfound = 0
						for r.Rooms = Each Rooms
							roomamount = roomamount + 1
							roomsfound = roomsfound + r\found


						var docamount=0, docsfound=0
						for itt.ItemTemplates = Each ItemTemplates
							if itt\tempname = "paper":
								docamount=docamount+1
								docsfound=docsfound+itt\found



						var scpsEncountered=1
						for i = 0 To 24
							scpsEncountered = scpsEncountered+Achievements(i)


						var achievementsUnlocked =0
						for i = 0 To MAXACHIEVEMENTS-1
							achievementsUnlocked = achievementsUnlocked + Achievements(i)


						AAText x, y, "SCPs encountered: " +scpsEncountered
						AAText x, y+20*MenuScale, "Achievements unlocked: " + achievementsUnlocked+"/"+(MAXACHIEVEMENTS)
						AAText x, y+40*MenuScale, "Rooms found: " + roomsfound+"/"+roomamount
						AAText x, y+60*MenuScale, "Documents discovered: " +docsfound+"/"+docamount
						AAText x, y+80*MenuScale, "Items refined in SCP-914: " +RefinedItems

						x = GraphicWidth / 2 - width / 2
						y = GraphicHeight / 2 - height / 2
						x = x+width/2
						y = y+height-100*MenuScale

						if DrawButton(x-145*MenuScale,y-200*MenuScale,390*MenuScale,60*MenuScale,"ACHIEVEMENTS", True):
							AchievementsMenu = 1



						if DrawButton(x-145*MenuScale,y-100*MenuScale,390*MenuScale,60*MenuScale,"MAIN MENU", True)
							ShouldPlay = 24
							NowPlaying = ShouldPlay
							for i=0 To 9
								if TempSounds[i]!=0: FreeSound_Strict TempSounds[i] : TempSounds[i]=0

							StopStream_Strict(MusicCHN)
							MusicCHN = StreamSound_Strict("SFX\\Music\\"+Music(NowPlaying)+".ogg",0.0,Mode)
							SetStreamVolume_Strict(MusicCHN,1.0*MusicVolume)
							FlushKeys()
							EndingTimer=-2000
							InitCredits()

					else:
						ShouldPlay = 23
						DrawMenu()


				elif EndingTimer<=-2000
					ShouldPlay = 24
					DrawCredits()






		if Fullscreen: DrawImage CursorIMG, ScaledMouseX(),ScaledMouseY()

		AASetFont Font1
	

	Type CreditsLine
		Field txt: String
		Field id: int
		Field stay: int
	End Type

	Global CreditsTimer: float = 0.0
	Global CreditsScreen: int

	func InitCredits()
		var cl.CreditsLine
		var file: int = OpenFile("Credits.txt")
		var l: String

		CreditsFont: int = LoadFont_Strict("GFX\font\cour\Courier New.ttf", Int(21 * (GraphicHeight / 1024.0)), 0,0,0)
		CreditsFont2: int = LoadFont_Strict("GFX\font\courbd.Courier New.ttf", Int(35 * (GraphicHeight / 1024.0)), 0,0,0)

		if CreditsScreen = 0
			CreditsScreen = LoadImage_Strict("GFX\creditsscreen.pt")


		Repeat
			l = ReadLine(file)
			cl = New CreditsLine
			cl\txt = l
		Until Eof(file)

		Delete First CreditsLine
		CreditsTimer = 0

	

	func DrawCredits()
		var credits_Y: float = (EndingTimer+2000)/2+(GraphicHeight+10)
		var cl.CreditsLine
		var id: int
		var endlinesamount: int
		var LastCreditLine.CreditsLine

		Cls

		if randi(1,300)>1
			DrawImage CreditsScreen, GraphicWidth/2-400, GraphicHeight/2-400


		id = 0
		endlinesamount = 0
		LastCreditLine = Null
		Color 255,255,255
		for cl = Each CreditsLine
			cl\id = id
			if Left(cl\txt,1)="*"
				SetFont CreditsFont2
				if cl\stay=False
					Text GraphicWidth/2,credits_Y+(24*cl\id*MenuScale),Right(cl\txt,Len(cl\txt)-1),True

			elif Left(cl\txt,1)="/"
				LastCreditLine = Before(cl)
			else:
				SetFont CreditsFont
				if cl\stay=False
					Text GraphicWidth/2,credits_Y+(24*cl\id*MenuScale),cl\txt,True


			if LastCreditLine!=Null
				if cl\id>LastCreditLine.id
					cl\stay = True


			if cl\stay
				endlinesamount=endlinesamount+1

			id=id+1

		if (credits_Y+(24*LastCreditLine.id*MenuScale))<-StringHeight(LastCreditLine.txt)
			CreditsTimer=CreditsTimer+(0.5*FPSfactor2)
			if CreditsTimer>=0.0 And CreditsTimer<255.0
				Color Max(Min(CreditsTimer,255),0),Max(Min(CreditsTimer,255),0),Max(Min(CreditsTimer,255),0)
			elif CreditsTimer>=255.0
				Color 255,255,255
				if CreditsTimer>500.0
					CreditsTimer=-255.0

			else:
				Color Max(Min(-CreditsTimer,255),0),Max(Min(-CreditsTimer,255),0),Max(Min(-CreditsTimer,255),0)
				if CreditsTimer>=-1.0
					CreditsTimer=-1.0


			DebugLog CreditsTimer

		if CreditsTimer!=0.0
			for cl = Each CreditsLine
				if cl\stay
					SetFont CreditsFont
					if Left(cl\txt,1)="/"
						Text GraphicWidth/2,(GraphicHeight/2)+(endlinesamount/2)+(24*cl\id*MenuScale),Right(cl\txt,Len(cl\txt)-1),True
					else:
						Text GraphicWidth/2,(GraphicHeight/2)+(24*(cl\id-LastCreditLine.id)*MenuScale)-((endlinesamount/2)*24*MenuScale),cl\txt,True





		if GetKey(): CreditsTimer=-1

		if CreditsTimer=-1
			FreeFont CreditsFont
			FreeFont CreditsFont2
			FreeImage CreditsScreen
			CreditsScreen = 0
			FreeImage EndingScreen
			EndingScreen = 0
			Delete Each CreditsLine
			NullGame(False)
			StopStream_Strict(MusicCHN)
			ShouldPlay = 21
			MenuOpen = false
			MainMenuOpen = True
			MainMenuTab = 0
			CurrSave = ""
			FlushKeys()


	


	func MovePlayer()
		CatchErrors("Uncaught (MovePlayer)")
		var Sprint: float = 1.0, Speed: float = 0.018, i: int, angle: float

		if SuperMan:
			Speed = Speed * 3

			SuperManTimer=SuperManTimer+FPSfactor

			CameraShake = Sin(SuperManTimer / 5.0) * (SuperManTimer / 1500.0)

			if SuperManTimer > 70 * 50:
				DeathMSG = "A Class D jumpsuit found in [DATA REDACTED]. Upon further examination, the jumpsuit was found to be filled with 12.5 kilograms of blue ash-like substance. "
				DeathMSG = DeathMSG + "Chemical analysis of the substance remains non-conclusive. Most likely related to SCP-914."
				Kill()
				ShowEntity Fog
			else:
				BlurTimer = 500
				HideEntity Fog



		if DeathTimer > 0:
			DeathTimer=DeathTimer-FPSfactor
			if DeathTimer < 1: DeathTimer = -1.0
		elif DeathTimer < 0
			Kill()


		if CurrSpeed > 0:
			Stamina = Min(Stamina + 0.15 * FPSfactor/1.25, 100.0)
		else:
			Stamina = Min(Stamina + 0.15 * FPSfactor*1.25, 100.0)


		if StaminaEffectTimer > 0:
			StaminaEffectTimer = StaminaEffectTimer - (FPSfactor/70)
		else:
			if StaminaEffect != 1.0: StaminaEffect = 1.0


		var temp: float

		if PlayerRoom\RoomTemplate.Name!="pocketdimension":
			if KeyDown(KEY_SPRINT):
				if Stamina < 5:
					temp = 0
					if WearingGasMask>0 Or Wearing1499>0: temp=1
					if ChannelPlaying(BreathCHN)=False: BreathCHN = PlaySound_Strict(BreathSFX((temp), 0))
				elif Stamina < 50
					if BreathCHN=0:
						temp = 0
						if WearingGasMask>0 Or Wearing1499>0: temp=1
						BreathCHN = PlaySound_Strict(BreathSFX((temp), randi(1,3)))
						ChannelVolume BreathCHN, Min((70.0-Stamina)/70.0,1.0)*SFXVolume
					else:
						if ChannelPlaying(BreathCHN)=False:
							temp = 0
							if WearingGasMask>0 Or Wearing1499>0: temp=1
							BreathCHN = PlaySound_Strict(BreathSFX((temp), randi(1,3)))
							ChannelVolume BreathCHN, Min((70.0-Stamina)/70.0,1.0)*SFXVolume






		for i = 0 To MaxItemAmount-1
			if Inventory(i)!=Null:
				if Inventory(i)\itemtemplate.tempname = "finevest": Stamina = Min(Stamina, 60)



		if Wearing714:
			Stamina = Min(Stamina, 10)
			Sanity = Max(-850, Sanity)


		if IsZombie: Crouch = false

		if Abs(CrouchState-Crouch)<0.001:
			CrouchState = Crouch
		else:
			CrouchState = CurveValue(Crouch, CrouchState, 10.0)


		if (Not NoClip):
			if ((KeyDown(KEY_DOWN) Or KeyDown(KEY_UP)) Or (KeyDown(KEY_RIGHT) Or KeyDown(KEY_LEFT)) And Playable) Or ForceMove>0:

				if Crouch = 0 And (KeyDown(KEY_SPRINT)) And Stamina > 0.0 And (Not IsZombie):
					Sprint = 2.5
					Stamina = Stamina - FPSfactor * 0.4 * StaminaEffect
					if Stamina <= 0: Stamina = -20.0


				if PlayerRoom\RoomTemplate.Name = "pocketdimension":
					if EntityY(Collider)<2000*RoomScale Or EntityY(Collider)>2608*RoomScale:
						Stamina = 0
						Speed = 0.015
						Sprint = 1.0



				if ForceMove>0: Speed=Speed*ForceMove

				if SelectedItem!=Null:
					if Selecteditem.itemtemplate.tempname = "firstaid" Or Selecteditem.itemtemplate.tempname = "finefirstaid" Or Selecteditem.itemtemplate.tempname = "firstaid2":
						Sprint = 0



				temp: float = (Shake Mod 360)
				var tempchn: int
				if (Not UnableToMove: int): Shake: float = (Shake + FPSfactor * Min(Sprint, 1.5) * 7) Mod 720
				if temp < 180 And (Shake Mod 360) >= 180 And KillTimer>=0:
					if CurrStepSFX=0:
						temp = GetStepSound(Collider)

						if Sprint = 1.0:
							PlayerSoundVolume = Max(4.0,PlayerSoundVolume)
							tempchn: int = PlaySound_Strict(StepSFX(temp, 0, randi(0, 7)))
							ChannelVolume tempchn, (1.0-(Crouch*0.6))*SFXVolume: float
						else:
							PlayerSoundVolume = Max(2.5-(Crouch*0.6),PlayerSoundVolume)
							tempchn: int = PlaySound_Strict(StepSFX(temp, 1, randi(0, 7)))
							ChannelVolume tempchn, (1.0-(Crouch*0.6))*SFXVolume: float

					elif CurrStepSFX=1
						tempchn: int = PlaySound_Strict(Step2SFX(randi(0, 2)))
						ChannelVolume tempchn, (1.0-(Crouch*0.4))*SFXVolume: float
					elif CurrStepSFX=2
						tempchn: int = PlaySound_Strict(Step2SFX(randi(3,5)))
						ChannelVolume tempchn, (1.0-(Crouch*0.4))*SFXVolume: float
					elif CurrStepSFX=3
						if Sprint = 1.0:
							PlayerSoundVolume = Max(4.0,PlayerSoundVolume)
							tempchn: int = PlaySound_Strict(StepSFX(0, 0, randi(0, 7)))
							ChannelVolume tempchn, (1.0-(Crouch*0.6))*SFXVolume: float
						else:
							PlayerSoundVolume = Max(2.5-(Crouch*0.6),PlayerSoundVolume)
							tempchn: int = PlaySound_Strict(StepSFX(0, 1, randi(0, 7)))
							ChannelVolume tempchn, (1.0-(Crouch*0.6))*SFXVolume: float





		else::
			if (KeyDown(KEY_SPRINT)):
				Sprint = 2.5
			elif KeyDown(KEY_CROUCH)
				Sprint = 0.5



		if KeyHit(KEY_CROUCH) And Playable: Crouch = (Not Crouch)

		var temp2: float = (Speed * Sprint) / (1.0+CrouchState)

		if NoClip:
			Shake = 0
			CurrSpeed = 0
			CrouchState = 0
			Crouch = 0

			RotateEntity Collider, WrapAngle(EntityPitch(Camera)), WrapAngle(EntityYaw(Camera)), 0

			temp2 = temp2 * NoClipSpeed

			if KeyDown(KEY_DOWN): MoveEntity Collider, 0, 0, -temp2*FPSfactor
			if KeyDown(KEY_UP): MoveEntity Collider, 0, 0, temp2*FPSfactor

			if KeyDown(KEY_LEFT): MoveEntity Collider, -temp2*FPSfactor, 0, 0
			if KeyDown(KEY_RIGHT): MoveEntity Collider, temp2*FPSfactor, 0, 0

			ResetEntity Collider
		else:
			temp2: float = temp2 / Max((Injuries+3.0)/3.0,1.0)
			if Injuries > 0.5:
				temp2 = temp2*Min((Sin(Shake/2)+1.2),1.0)


			temp = false
			if (Not IsZombie: int)
				if KeyDown(KEY_DOWN) And Playable:
					temp = True
					angle = 180
					if KeyDown(KEY_LEFT): angle = 135
					if KeyDown(KEY_RIGHT): angle = -135
				elif (KeyDown(KEY_UP) And Playable):
					temp = True
					angle = 0
					if KeyDown(KEY_LEFT): angle = 45
					if KeyDown(KEY_RIGHT): angle = -45
				elif ForceMove>0:
					temp=True
					angle = ForceAngle
				else: if Playable:
					if KeyDown(KEY_LEFT): angle = 90 : temp = True
					if KeyDown(KEY_RIGHT): angle = -90 : temp = True

			else:
				temp=True
				angle = ForceAngle


			angle = WrapAngle(EntityYaw(Collider,True)+angle+90.0)

			if temp:
				CurrSpeed = CurveValue(temp2, CurrSpeed, 20.0)
			else:
				CurrSpeed = Max(CurveValue(0.0, CurrSpeed-0.1, 1.0),0.0)


			if (Not UnableToMove: int): TranslateEntity Collider, Cos(angle)*CurrSpeed * FPSfactor, 0, Sin(angle)*CurrSpeed * FPSfactor, True

			var CollidedFloor: int = false
			for i = 1 To CountCollisions(Collider)
				if CollisionY(Collider, i) < EntityY(Collider) - 0.25: CollidedFloor = True


			if CollidedFloor = True:
				if DropSpeed: float < - 0.07:
					if CurrStepSFX=0:
						PlaySound_Strict(StepSFX(GetStepSound(Collider), 0, randi(0, 7)))
					elif CurrStepSFX=1
						PlaySound_Strict(Step2SFX(randi(0, 2)))
					elif CurrStepSFX=2
						PlaySound_Strict(Step2SFX(randi(3, 5)))
					elif CurrStepSFX=3
						PlaySound_Strict(StepSFX(0, 0, randi(0, 7)))

					PlayerSoundVolume = Max(3.0,PlayerSoundVolume)

				DropSpeed: float = 0
			else:

				if PlayerFallingPickDistance: float!=0.0
					var pick = LinePick(EntityX(Collider),EntityY(Collider),EntityZ(Collider),0,-PlayerFallingPickDistance,0)
					if pick
						DropSpeed: float = Min(Max(DropSpeed - 0.006 * FPSfactor, -2.0), 0.0)
					else:
						DropSpeed: float = 0

				else:
					DropSpeed: float = Min(Max(DropSpeed - 0.006 * FPSfactor, -2.0), 0.0)


			PlayerFallingPickDistance: float = 10.0

			if (Not UnableToMove: int) And ShouldEntitiesFall: TranslateEntity Collider, 0, DropSpeed * FPSfactor, 0


		ForceMove = false

		if Injuries > 1.0:
			temp2 = Bloodloss
			BlurTimer = Max(Max(Sin(MilliSecs2()/100.0)*Bloodloss*30.0,Bloodloss*2*(2.0-CrouchState)),BlurTimer)
			if (Not I_427\Using And I_427\Timer < 70*360):
				Bloodloss = Min(Bloodloss + (Min(Injuries,3.5)/300.0)*FPSfactor,100)


			if temp2 <= 60 And Bloodloss > 60:
				Msg = "You are feeling faint from the amount of blood you have lost."
				MsgTimer = 70*4



		UpdateInfect()

		if Bloodloss > 0:
			if randf(200)<Min(Injuries,4.0):
				pvt = CreatePivot()
				PositionEntity pvt, EntityX(Collider)+randf(-0.05,0.05),EntityY(Collider)-0.05,EntityZ(Collider)+randf(-0.05,0.05)
				TurnEntity pvt, 90, 0, 0
				EntityPick(pvt,0.3)
				de.decals = CreateDecal(randi(15,16), PickedX(), PickedY()+0.005, PickedZ(), 90, randi(360), 0)
				de.size = randf(0.03,0.08)*Min(Injuries,3.0) : EntityAlpha(de.obj, 1.0) : ScaleSprite de.obj, de.size, de.size
				tempchn: int = PlaySound_Strict (DripSFX(randi(0,2)))
				ChannelVolume tempchn, randf(0.0,0.8)*SFXVolume
				ChannelPitch tempchn, randi(20000,30000)

				FreeEntity pvt


			CurrCameraZoom = Max(CurrCameraZoom, (Sin(Float(MilliSecs2())/20.0)+1.0)*Bloodloss*0.2)

			if Bloodloss > 60: Crouch = True
			if Bloodloss => 100:
				Kill()
				HeartBeatVolume = 0.0
			elif Bloodloss > 80.0
				HeartBeatRate = Max(150-(Bloodloss-80)*5,HeartBeatRate)
				HeartBeatVolume = Max(HeartBeatVolume, 0.75+(Bloodloss-80.0)*0.0125)
			elif Bloodloss > 35.0
				HeartBeatRate = Max(70+Bloodloss,HeartBeatRate)
				HeartBeatVolume = Max(HeartBeatVolume, (Bloodloss-35.0)/60.0)



		if HealTimer > 0:
			DebugLog HealTimer
			HealTimer = HealTimer - (FPSfactor / 70)
			Bloodloss = Min(Bloodloss + (2 / 400.0) * FPSfactor, 100)
			Injuries = Max(Injuries - (FPSfactor / 70) / 30, 0.0)


		if Playable:
			if KeyHit(KEY_BLINK): BlinkTimer = 0
			if KeyDown(KEY_BLINK) And BlinkTimer < - 10: BlinkTimer = -10



		if HeartBeatVolume > 0:
			if HeartBeatTimer <= 0:
				tempchn = PlaySound_Strict (HeartBeatSFX)
				ChannelVolume tempchn, HeartBeatVolume*SFXVolume: float

				HeartBeatTimer = 70.0*(60.0/Max(HeartBeatRate,1.0))
			else:
				HeartBeatTimer = HeartBeatTimer - FPSfactor


			HeartBeatVolume = Max(HeartBeatVolume - FPSfactor*0.05, 0)


		CatchErrors("MovePlayer")
	

	func MouseLook()
		var i: int

		CameraShake = Max(CameraShake - (FPSfactor / 10), 0)


		CameraZoom(Camera, Min(1.0+(CurrCameraZoom/400.0),1.1))
		CurrCameraZoom = Max(CurrCameraZoom - FPSfactor, 0)

		if KillTimer >= 0 And FallTimer >=0:

			HeadDropSpeed = 0

			var Zero: float = 0.0
			var Nan1: float = 0.0 / Zero
			if Int(EntityX(Collider))=Int(Nan1):

				PositionEntity Collider, EntityX(Camera, True), EntityY(Camera, True) - 0.5, EntityZ(Camera, True), True
				Msg = "EntityX(Collider) = NaN, RESETTING COORDINATES    -    New coordinates: "+EntityX(Collider)
				MsgTimer = 300



			var up: float = (Sin(Shake) / (20.0+CrouchState*20.0))*0.6;, side: float = Cos(Shake / 2.0) / 35.0
			var roll: float = Max(Min(Sin(Shake/2)*2.5*Min(Injuries+0.25,3.0),8.0),-8.0)


			PositionEntity Camera, EntityX(Collider), EntityY(Collider), EntityZ(Collider)
			RotateEntity Camera, 0, EntityYaw(Collider), roll*0.5

			MoveEntity Camera, side, up + 0.6 + CrouchState * -0.3, 0


			mouse_x_speed_1: float = CurveValue(MouseXSpeed() * (MouseSens + 0.6) , mouse_x_speed_1, (6.0 / (MouseSens + 1.0))*MouseSmooth)
			if Int(mouse_x_speed_1) = Int(Nan1): mouse_x_speed_1 = 0
			if PrevFPSFactor>0:
				if Abs(FPSfactor/PrevFPSFactor-1.0)>1.0:

					mouse_x_speed_1 = 0.0
					mouse_y_speed_1 = 0.0


			if InvertMouse:
				mouse_y_speed_1: float = CurveValue(-MouseYSpeed() * (MouseSens + 0.6), mouse_y_speed_1, (6.0/(MouseSens+1.0))*MouseSmooth)
			else:
				mouse_y_speed_1: float = CurveValue(MouseYSpeed () * (MouseSens + 0.6), mouse_y_speed_1, (6.0/(MouseSens+1.0))*MouseSmooth)

			if Int(mouse_y_speed_1) = Int(Nan1): mouse_y_speed_1 = 0

			var the_yaw: float = ((mouse_x_speed_1: float)) * mouselook_x_inc: float / (1.0+WearingVest)
			var the_pitch: float = ((mouse_y_speed_1: float)) * mouselook_y_inc: float / (1.0+WearingVest)

			TurnEntity Collider, 0.0, -the_yaw: float, 0.0
			user_camera_pitch: float = user_camera_pitch: float + the_pitch: float

			if user_camera_pitch: float > 70.0: user_camera_pitch: float = 70.0
			if user_camera_pitch: float < - 70.0: user_camera_pitch: float = -70.0

			RotateEntity Camera, WrapAngle(user_camera_pitch + randf(-CameraShake, CameraShake)), WrapAngle(EntityYaw(Collider) + randf(-CameraShake, CameraShake)), roll ; Pitch the user;s camera up And down.

			if PlayerRoom\RoomTemplate.Name = "pocketdimension":
				if EntityY(Collider)<2000*RoomScale Or EntityY(Collider)>2608*RoomScale:
					RotateEntity Camera, WrapAngle(EntityPitch(Camera)),WrapAngle(EntityYaw(Camera)), roll+WrapAngle(Sin(MilliSecs2()/150.0)*30.0) ; Pitch the user;s camera up And down.



		else:
			HideEntity Collider
			PositionEntity Camera, EntityX(Head), EntityY(Head), EntityZ(Head)

			var CollidedFloor: int = false
			for i = 1 To CountCollisions(Head)
				if CollisionY(Head, i) < EntityY(Head) - 0.01: CollidedFloor = True


			if CollidedFloor = True:
				HeadDropSpeed: float = 0
			else:

				if KillAnim = 0:
					MoveEntity Head, 0, 0, HeadDropSpeed
					RotateEntity(Head, CurveAngle(-90.0, EntityPitch(Head), 20.0), EntityYaw(Head), EntityRoll(Head))
					RotateEntity(Camera, CurveAngle(EntityPitch(Head) - 40.0, EntityPitch(Camera), 40.0), EntityYaw(Camera), EntityRoll(Camera))
				else:
					MoveEntity Head, 0, 0, -HeadDropSpeed
					RotateEntity(Head, CurveAngle(90.0, EntityPitch(Head), 20.0), EntityYaw(Head), EntityRoll(Head))
					RotateEntity(Camera, CurveAngle(EntityPitch(Head) + 40.0, EntityPitch(Camera), 40.0), EntityYaw(Camera), EntityRoll(Camera))


				HeadDropSpeed: float = HeadDropSpeed - 0.002 * FPSfactor


			if InvertMouse:
				TurnEntity (Camera, -MouseYSpeed() * 0.05 * FPSfactor, -MouseXSpeed() * 0.15 * FPSfactor, 0)
			else:
				TurnEntity (Camera, MouseYSpeed() * 0.05 * FPSfactor, -MouseXSpeed() * 0.15 * FPSfactor, 0)




		;pölyhiukkasia
		if ParticleAmount=2
			if randi(35) = 1:
				var pvt: int = CreatePivot()
				PositionEntity(pvt, EntityX(Camera, True), EntityY(Camera, True), EntityZ(Camera, True))
				RotateEntity(pvt, 0, randf(360), 0)
				if randi(2) = 1:
					MoveEntity(pvt, 0, randf(-0.5, 0.5), randf(0.5, 1.0))
				else:
					MoveEntity(pvt, 0, randf(-0.5, 0.5), randf(0.5, 1.0))


				var p.Particles = CreateParticle(EntityX(pvt), EntityY(pvt), EntityZ(pvt), 2, 0.002, 0, 300)
				p\speed = 0.001
				RotateEntity(p\pvt, randf(-20, 20), randf(360), 0)

				p\SizeChange = -0.00001

				FreeEntity pvt



		; -- Limit the mouse;s movement. Using this method produces smoother mouselook movement than centering the mouse Each loop.
		if (MouseX() > mouse_right_limit) Or (MouseX() < mouse_left_limit) Or (MouseY() > mouse_bottom_limit) Or (MouseY() < mouse_top_limit)
			MoveMouse viewport_center_x, viewport_center_y


		if WearingGasMask Or WearingHazmat Or Wearing1499:
			if Wearing714 = false:
				if WearingGasMask = 2 Or Wearing1499 = 2 Or WearingHazmat = 2:
					Stamina = Min(100, Stamina + (100.0-Stamina)*0.01*FPSfactor)


			if WearingHazmat = 1:
				Stamina = Min(60, Stamina)


			ShowEntity(GasMaskOverlay)
		else:
			HideEntity(GasMaskOverlay)


		if (Not WearingNightVision=0):
			ShowEntity(NVOverlay)
			if WearingNightVision=2:
				EntityColor(NVOverlay, 0,100,255)
				AmbientLightRooms(15)
			elif WearingNightVision=3:
				EntityColor(NVOverlay, 255,0,0)
				AmbientLightRooms(15)
			else:
				EntityColor(NVOverlay, 0,255,0)
				AmbientLightRooms(15)

			EntityTexture(Fog, FogNVTexture)
		else:
			AmbientLightRooms(0)
			HideEntity(NVOverlay)
			EntityTexture(Fog, FogTexture)


		for i = 0 To 5
			if SCP1025state[i]>0:
				match i
					0 ;common cold
						if FPSfactor>0:
							if randi(1000)=1:
								if CoughCHN = 0:
									CoughCHN = PlaySound_Strict(CoughSFX(randi(0, 2)))
								else:
									if Not ChannelPlaying(CoughCHN): CoughCHN = PlaySound_Strict(CoughSFX(randi(0, 2)))



						Stamina = Stamina - FPSfactor * 0.3
					1 ;chicken pox
						if randi(9000)=1 And Msg="":
							Msg="Your skin is feeling itchy."
							MsgTimer =70*4

					2 ;cancer of the lungs
						if FPSfactor>0:
							if randi(800)=1:
								if CoughCHN = 0:
									CoughCHN = PlaySound_Strict(CoughSFX(randi(0, 2)))
								else:
									if Not ChannelPlaying(CoughCHN): CoughCHN = PlaySound_Strict(CoughSFX(randi(0, 2)))



						Stamina = Stamina - FPSfactor * 0.1
					3 ;appendicitis
						;0.035/sec = 2.1/min
						if (Not I_427\Using And I_427\Timer < 70*360):
							SCP1025state[i]=SCP1025state[i]+FPSfactor*0.0005

						if SCP1025state[i]>20.0:
							if SCP1025state[i]-FPSfactor<=20.0: Msg="The pain in your stomach is becoming unbearable."
							Stamina = Stamina - FPSfactor * 0.3
						elif SCP1025state[i]>10.0
							if SCP1025state[i]-FPSfactor<=10.0: Msg="Your stomach is aching."

					4 ;asthma
						if Stamina < 35:
							if randi(Int(140+Stamina*8))=1:
								if CoughCHN = 0:
									CoughCHN = PlaySound_Strict(CoughSFX(randi(0, 2)))
								else:
									if Not ChannelPlaying(CoughCHN): CoughCHN = PlaySound_Strict(CoughSFX(randi(0, 2)))


							CurrSpeed = CurveValue(0, CurrSpeed, 10+Stamina*15)

					5;cardiac arrest
						if (Not I_427\Using And I_427\Timer < 70*360):
							SCP1025state[i]=SCP1025state[i]+FPSfactor*0.35

						;35/sec
						if SCP1025state[i]>110:
							HeartBeatRate=0
							BlurTimer = Max(BlurTimer, 500)
							if SCP1025state[i]>140:
								DeathMSG = Chr(34)+"He died of a cardiac arrest after reading SCP-1025, that's for sure. Is there such a thing as psychosomatic cardiac arrest, or does SCP-1025 have some "
								DeathMSG = DeathMSG + "anomalous properties we are not yet aware of?"+Chr(34)
								Kill()

						else:
							HeartBeatRate=Max(HeartBeatRate, 70+SCP1025state[i])
							HeartBeatVolume = 1.0






	

	;--------------------------------------- GUI, menu etc ------------------------------------------------

	func DrawGUI()
		CatchErrors("Uncaught (DrawGUI)")

		var temp: int, x: int, y: int, z: int, i: int, yawvalue: float, pitchvalue: float
		var x2: float,y2: float,z2: float
		var n: int, xtemp, ytemp, strtemp: String

		var e.Events, it.Items

		if MenuOpen Or ConsoleOpen Or SelectedDoor != Null Or InvOpen Or OtherOpen!=Null Or EndingTimer < 0:
			ShowPointer()
		else:
			HidePointer()


		if PlayerRoom\RoomTemplate.Name = "pocketdimension":
			for e.Events = Each Events
				if e.room = PlayerRoom:
					if Float(e.EventStr)<1000.0:
						if e.EventState > 600:
							if BlinkTimer < -3 And BlinkTimer > -10:
								if e.img = 0:
									if BlinkTimer > -5 And randi(30)=1:
										PlaySound_Strict DripSFX(0)
										if e.img = 0: e.img = LoadImage_Strict("GFX\npcs\106face.jpg")

								else:
									DrawImage e.img, GraphicWidth/2-randi(390,310), GraphicHeight/2-randi(290,310)

							else:
								if e.img != 0: FreeImage e.img : e.img = 0


							break

					else:
						if BlinkTimer < -3 And BlinkTimer > -10:
							if e.img = 0:
								if BlinkTimer > -5:
									if e.img = 0:
										e.img = LoadImage_Strict("GFX\kneelmortal.pd")
										if (ChannelPlaying(e.SoundCHN)):
											StopChannel(e.SoundCHN)

										e.SoundCHN = PlaySound_Strict(e.Sound)


							else:
								DrawImage e.img, GraphicWidth/2-randi(390,310), GraphicHeight/2-randi(290,310)

						else:
							if e.img != 0: FreeImage e.img : e.img = 0
							if BlinkTimer < -3:
								if (Not ChannelPlaying(e.SoundCHN)):
									e.SoundCHN = PlaySound_Strict(e.Sound)

							else:
								if (ChannelPlaying(e.SoundCHN)):
									StopChannel(e.SoundCHN)




						break






		if ClosestButton != 0 And SelectedDoor = Null And InvOpen = false And MenuOpen = false And OtherOpen = Null:
			temp: int = CreatePivot()
			PositionEntity temp, EntityX(Camera), EntityY(Camera), EntityZ(Camera)
			PointEntity temp, ClosestButton
			yawvalue: float = WrapAngle(EntityYaw(Camera) - EntityYaw(temp))
			if yawvalue > 90 And yawvalue <= 180: yawvalue = 90
			if yawvalue > 180 And yawvalue < 270: yawvalue = 270
			pitchvalue: float = WrapAngle(EntityPitch(Camera) - EntityPitch(temp))
			if pitchvalue > 90 And pitchvalue <= 180: pitchvalue = 90
			if pitchvalue > 180 And pitchvalue < 270: pitchvalue = 270

			FreeEntity (temp)

			DrawImage(HandIcon, GraphicWidth / 2 + Sin(yawvalue) * (GraphicWidth / 3) - 32, GraphicHeight / 2 - Sin(pitchvalue) * (GraphicHeight / 3) - 32)

			if MouseUp1:
				MouseUp1 = false
				if ClosestDoor != Null:
					if ClosestDoor\Code != "":
						SelectedDoor = ClosestDoor
					elif Playable:
						PlaySound2(ButtonSFX, Camera, ClosestButton)
						UseDoor(ClosestDoor,True)





		if ClosestItem != Null:
			yawvalue: float = -DeltaYaw(Camera, Closestitem.collider)
			if yawvalue > 90 And yawvalue <= 180: yawvalue = 90
			if yawvalue > 180 And yawvalue < 270: yawvalue = 270
			pitchvalue: float = -DeltaPitch(Camera, Closestitem.collider)
			if pitchvalue > 90 And pitchvalue <= 180: pitchvalue = 90
			if pitchvalue > 180 And pitchvalue < 270: pitchvalue = 270

			DrawImage(HandIcon2, GraphicWidth / 2 + Sin(yawvalue) * (GraphicWidth / 3) - 32, GraphicHeight / 2 - Sin(pitchvalue) * (GraphicHeight / 3) - 32)


		if DrawHandIcon: DrawImage(HandIcon, GraphicWidth / 2 - 32, GraphicHeight / 2 - 32)
		for i = 0 To 3
			if DrawArrowIcon(i):
				x = GraphicWidth / 2 - 32
				y = GraphicHeight / 2 - 32
				match i
					0
						y = y - 64 - 5
					1
						x = x + 64 + 5
					2
						y = y + 64 + 5
					3
						x = x - 5 - 64

				DrawImage(HandIcon, x, y)
				Color 0, 0, 0
				Rect(x + 4, y + 4, 64 - 8, 64 - 8)
				DrawImage(ArrowIMG(i), x + 21, y + 21)
				DrawArrowIcon(i) = false



		if Using294: Use294()

		if HUDenabled:

			var width: int = 204, height: int = 20
			x: int = 80
			y: int = GraphicHeight - 95

			Color 255, 255, 255
			Rect (x, y, width, height, false)
			for i = 1 To Int(((width - 2) * (BlinkTimer / (BLINKFREQ))) / 10)
				DrawImage(BlinkMeterIMG, x + 3 + 10 * (i - 1), y + 3)

			Color 0, 0, 0
			Rect(x - 50, y, 30, 30)

			if EyeIrritation > 0:
				Color 200, 0, 0
				Rect(x - 50 - 3, y - 3, 30 + 6, 30 + 6)


			Color 255, 255, 255
			Rect(x - 50 - 1, y - 1, 30 + 2, 30 + 2, false)

			DrawImage BlinkIcon, x - 50, y

			y = GraphicHeight - 55
			Color 255, 255, 255
			Rect (x, y, width, height, false)
			for i = 1 To Int(((width - 2) * (Stamina / 100.0)) / 10)
				DrawImage(StaminaMeterIMG, x + 3 + 10 * (i - 1), y + 3)


			Color 0, 0, 0
			Rect(x - 50, y, 30, 30)

			Color 255, 255, 255
			Rect(x - 50 - 1, y - 1, 30 + 2, 30 + 2, false)
			if Crouch:
				DrawImage CrouchIcon, x - 50, y
			else:
				DrawImage SprintIcon, x - 50, y


			if DebugHUD:
				Color 255, 255, 255
				AASetFont ConsoleFont

				;Text x + 250, 50, "Zone: " + (EntityZ(Collider)/8.0)
				AAText x - 50, 50, "Player Position: (" + f2s(EntityX(Collider), 3) + ", " + f2s(EntityY(Collider), 3) + ", " + f2s(EntityZ(Collider), 3) + ")"
				AAText x - 50, 70, "Camera Position: (" + f2s(EntityX(Camera), 3)+ ", " + f2s(EntityY(Camera), 3) +", " + f2s(EntityZ(Camera), 3) + ")"
				AAText x - 50, 100, "Player Rotation: (" + f2s(EntityPitch(Collider), 3) + ", " + f2s(EntityYaw(Collider), 3) + ", " + f2s(EntityRoll(Collider), 3) + ")"
				AAText x - 50, 120, "Camera Rotation: (" + f2s(EntityPitch(Camera), 3)+ ", " + f2s(EntityYaw(Camera), 3) +", " + f2s(EntityRoll(Camera), 3) + ")"
				AAText x - 50, 150, "Room: " + PlayerRoom\RoomTemplate.Name
				for ev.Events = Each Events
					if ev\room = PlayerRoom:
						AAText x - 50, 170, "Room event: " + ev\EventName
						AAText x - 50, 190, "state: " + ev\EventState
						AAText x - 50, 210, "state2: " + ev\EventState2
						AAText x - 50, 230, "state3: " + ev\EventState3
						AAText x - 50, 250, "str: "+ ev\EventStr
						break


				AAText x - 50, 280, "Room coordinates: (" + Floor(EntityX(PlayerRoom\obj) / 8.0 + 0.5) + ", " + Floor(EntityZ(PlayerRoom\obj) / 8.0 + 0.5) + ", angle: "+PlayerRoom\angle + ")"
				AAText x - 50, 300, "Stamina: " + f2s(Stamina, 3)
				AAText x - 50, 320, "Death timer: " + f2s(KillTimer, 3)
				AAText x - 50, 340, "Blink timer: " + f2s(BlinkTimer, 3)
				AAText x - 50, 360, "Injuries: " + Injuries
				AAText x - 50, 380, "Bloodloss: " + Bloodloss
				if Curr173 != Null
					AAText x - 50, 410, "SCP - 173 Position (collider): (" + f2s(EntityX(Curr173\Collider), 3) + ", " + f2s(EntityY(Curr173\Collider), 3) + ", " + f2s(EntityZ(Curr173\Collider), 3) + ")"
					AAText x - 50, 430, "SCP - 173 Position (obj): (" + f2s(EntityX(Curr173\obj), 3) + ", " + f2s(EntityY(Curr173\obj), 3) + ", " + f2s(EntityZ(Curr173\obj), 3) + ")"
					;Text x - 50, 410, "SCP - 173 Idle: " + Curr173\Idle
					AAText x - 50, 450, "SCP - 173 State: " + Curr173\State

				if Curr106 != Null
					AAText x - 50, 470, "SCP - 106 Position: (" + f2s(EntityX(Curr106\obj), 3) + ", " + f2s(EntityY(Curr106\obj), 3) + ", " + f2s(EntityZ(Curr106\obj), 3) + ")"
					AAText x - 50, 490, "SCP - 106 Idle: " + Curr106\Idle
					AAText x - 50, 510, "SCP - 106 State: " + Curr106\State

				offset: int = 0
				for npc.NPCs = Each NPCs
					if npc\NPCtype = NPCtype096:
						AAText x - 50, 530, "SCP - 096 Position: (" + f2s(EntityX(npc\obj), 3) + ", " + f2s(EntityY(npc\obj), 3) + ", " + f2s(EntityZ(npc\obj), 3) + ")"
						AAText x - 50, 550, "SCP - 096 Idle: " + npc\Idle
						AAText x - 50, 570, "SCP - 096 State: " + npc\State
						AAText x - 50, 590, "SCP - 096 Speed: " + f2s(npc\currspeed, 5)

					if npc\NPCtype = NPCtypeMTF:
						AAText x - 50, 620 + 60 * offset, "MTF " + offset + " Position: (" + f2s(EntityX(npc\obj), 3) + ", " + f2s(EntityY(npc\obj), 3) + ", " + f2s(EntityZ(npc\obj), 3) + ")"
						AAText x - 50, 640 + 60 * offset, "MTF " + offset + " State: " + npc\State
						AAText x - 50, 660 + 60 * offset, "MTF " + offset + " LastSeen: " + npc\lastseen
						offset = offset + 1


				if PlayerRoom\RoomTemplate.Name: String = "dimension1499"
					AAText x + 350, 50, "Current Chunk X/Z: ("+(Int((EntityX(Collider)+20)/40))+", "+(Int((EntityZ(Collider)+20)/40))+")"
					var CH_Amount: int = 0
					for ch.Chunk = Each Chunk
						CH_Amount = CH_Amount + 1

					AAText x + 350, 70, "Current Chunk Amount: "+CH_Amount
				else:
					AAText x + 350, 50, "Current Room Position: ("+PlayerRoom\x+", "+PlayerRoom\y+", "+PlayerRoom\z+")"

				GlobalMemoryStatus m.MEMORYSTATUS
				AAText x + 350, 90, (m\dwAvailPhys: int/1024/1024)+" MB/"+(m\dwTotalPhys: int/1024/1024)+" MB ("+(m\dwAvailPhys: int/1024)+" KB/"+(m\dwTotalPhys: int/1024)+" KB)"
				AAText x + 350, 110, "Triangles rendered: "+CurrTrisAmount
				AAText x + 350, 130, "Active textures: "+ActiveTextures()
				AAText x + 350, 150, "SCP-427 state (secs): "+Int(I_427\Timer/70.0)
				AAText x + 350, 170, "SCP-008 infection: "+Infect
				for i = 0 To 5
					AAText x + 350, 190+(20*i), "SCP-1025 State "+i+": "+SCP1025state[i]

				if SelectedMonitor != Null:
					AAText x + 350, 310, "Current monitor: "+SelectedMonitor\ScrObj
				else:
					AAText x + 350, 310, "Current monitor: NULL"


				AASetFont Font1




		if SelectedScreen != Null:
			DrawImage SelectedScreen\img, GraphicWidth/2-ImageWidth(SelectedScreen\img)/2,GraphicHeight/2-ImageHeight(SelectedScreen\img)/2

			if MouseUp1 Or MouseHit2:
				FreeImage SelectedScreen\img : SelectedScreen\img = 0
				SelectedScreen = Null
				MouseUp1 = false



		var PrevInvOpen: int = InvOpen, MouseSlot: int = 66

		var shouldDrawHUD: int=True
		if SelectedDoor != Null:
			SelectedItem = Null

			if shouldDrawHUD:
				pvt = CreatePivot()
				PositionEntity pvt, EntityX(ClosestButton,True),EntityY(ClosestButton,True),EntityZ(ClosestButton,True)
				RotateEntity pvt, 0, EntityYaw(ClosestButton,True)-180,0
				MoveEntity pvt, 0,0,0.22
				PositionEntity Camera, EntityX(pvt),EntityY(pvt),EntityZ(pvt)
				PointEntity Camera, ClosestButton
				FreeEntity pvt

				CameraProject(Camera, EntityX(ClosestButton,True),EntityY(ClosestButton,True)+MeshHeight(ButtonOBJ)*0.015,EntityZ(ClosestButton,True))
				projY: float = ProjectedY()
				CameraProject(Camera, EntityX(ClosestButton,True),EntityY(ClosestButton,True)-MeshHeight(ButtonOBJ)*0.015,EntityZ(ClosestButton,True))
				scale: float = (ProjectedY()-projy)/462.0

				x = GraphicWidth/2-ImageWidth(KeypadHUD)*scale/2
				y = GraphicHeight/2-ImageHeight(KeypadHUD)*scale/2

				AASetFont Font3
				if KeypadMSG != "":
					KeypadTimer = KeypadTimer-FPSfactor2

					if (KeypadTimer Mod 70) < 35: AAText GraphicWidth/2, y+124*scale, KeypadMSG, True,True
					if KeypadTimer =<0:
						KeypadMSG = ""
						SelectedDoor = Null
						MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0

				else:
					AAText GraphicWidth/2, y+70*scale, "ACCESS CODE: ",True,True
					AASetFont Font4
					AAText GraphicWidth/2, y+124*scale, KeypadInput,True,True


				x = x+44*scale
				y = y+249*scale

				for n = 0 To 3
					for i = 0 To 2
						xtemp = x+Int(58.5*scale*n)
						ytemp = y+(67*scale)*i

						temp = false
						if MouseOn(xtemp,ytemp, 54*scale,65*scale) And KeypadMSG = "":
							if MouseUp1:
								PlaySound_Strict ButtonSFX

								match (n+1)+(i*4)
									1,2,3
										KeypadInput=KeypadInput + ((n+1)+(i*4))
									4
										KeypadInput=KeypadInput + "0"
									5,6,7
										KeypadInput=KeypadInput + ((n+1)+(i*4)-1)
									8 ;enter
										if KeypadInput = SelectedDoor\Code:
											PlaySound_Strict ScannerSFX1

											if SelectedDoor\Code = Str(AccessCode):
												GiveAchievement(AchvMaynard)
											elif SelectedDoor\Code = "7816"
												GiveAchievement(AchvHarp)


											SelectedDoor\locked = 0
											UseDoor(SelectedDoor,True)
											SelectedDoor = Null
											MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0
										else:
											PlaySound_Strict ScannerSFX2
											KeypadMSG = "ACCESS DENIED"
											KeypadTimer = 210
											KeypadInput = ""

									9,10,11
										KeypadInput=KeypadInput + ((n+1)+(i*4)-2)
									12
										KeypadInput = ""


								if Len(KeypadInput)> 4: KeypadInput = Left(KeypadInput,4)


						else:
							temp = false





				if Fullscreen: DrawImage CursorIMG, ScaledMouseX(),ScaledMouseY()

				if MouseHit2:
					SelectedDoor = Null
					MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0

			else:
				SelectedDoor = Null

		else:
			KeypadInput = ""
			KeypadTimer = 0
			KeypadMSG = ""


		if KeyHit(1) And EndingTimer=0 And (Not Using294):
			if MenuOpen Or InvOpen:
				ResumeSounds()
				if OptionsMenu != 0: SaveOptionsINI()
				MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0
			else:
				PauseSounds()

			MenuOpen = (Not MenuOpen)

			AchievementsMenu = 0
			OptionsMenu = 0
			QuitMSG = 0

			SelectedDoor = Null
			SelectedScreen = Null
			SelectedMonitor = Null
			if SelectedItem != Null:
				if Instr(Selecteditem.itemtemplate.tempname,"vest") Or Instr(Selecteditem.itemtemplate.tempname,"hazmatsuit"):
					if (Not WearingVest) And (Not WearingHazmat):
						DropItem(SelectedItem)

					SelectedItem = Null




		var spacing: int
		var PrevOtherOpen.Items

		var OtherSize: int,OtherAmount: int

		var isEmpty: int

		var isMouseOn: int

		var closedInv: int

		if OtherOpen!=Null:

			if (PlayerRoom\RoomTemplate.Name = "gatea"):
				HideEntity Fog
				CameraFogRange Camera, 5,30
				CameraFogColor (Camera,200,200,200)
				CameraClsColor (Camera,200,200,200)
				CameraRange(Camera, 0.05, 30)
			else: if (PlayerRoom\RoomTemplate.Name = "break1") And (EntityY(Collider)>1040.0*RoomScale)
				HideEntity Fog
				CameraFogRange Camera, 5,45
				CameraFogColor (Camera,200,200,200)
				CameraClsColor (Camera,200,200,200)
				CameraRange(Camera, 0.05, 60)


			PrevOtherOpen = OtherOpen
			OtherSize=OtherOpen\invSlots;Int(OtherOpen\state2)

			for i: int=0 To OtherSize-1
				if OtherOpen\SecondInv[i] != Null:
					OtherAmount = OtherAmount+1



			;if OtherAmount > 0:
			;	OtherOpen\state = 1.0
			;else:
			;	OtherOpen\state = 0.0
			;
			InvOpen = false
			SelectedDoor = Null
			var tempX: int = 0

			width = 70
			height = 70
			spacing: int = 35

			x = GraphicWidth / 2 - (width * MaxItemAmount /2 + spacing * (MaxItemAmount / 2 - 1)) / 2
			y = GraphicHeight / 2 - (height * OtherSize /5 + spacing * (OtherSize / 5 - 1)) / 2;height

			ItemAmount = 0
			for  n: int = 0 To OtherSize - 1
				isMouseOn: int = false
				if ScaledMouseX() > x And ScaledMouseX() < x + width:
					if ScaledMouseY() > y And ScaledMouseY() < y + height:
						isMouseOn = True



				if isMouseOn:
					MouseSlot = n
					Color 255, 0, 0
					Rect(x - 1, y - 1, width + 2, height + 2)


				DrawFrame(x, y, width, height, (x Mod 64), (x Mod 64))

				if OtherOpen = Null: break

				if OtherOpen\SecondInv[n] != Null:
					if (SelectedItem != OtherOpen\SecondInv[n] Or isMouseOn): DrawImage(OtherOpen\SecondInv[n]\invimg, x + width / 2 - 32, y + height / 2 - 32)

				DebugLog "otheropen: "+(OtherOpen!=Null)
				if OtherOpen\SecondInv[n] != Null And SelectedItem != OtherOpen\SecondInv[n]:
				;drawimage(OtherOpen\SecondInv[n].InvIMG, x + width / 2 - 32, y + height / 2 - 32)
					if isMouseOn:
						Color 255, 255, 255
						AAText(x + width / 2, y + height + spacing - 15, OtherOpen\SecondInv[n]\itemtemplate.name, True)
						if SelectedItem = Null:
							if MouseHit1:
								SelectedItem = OtherOpen\SecondInv[n]
								MouseHit1 = false

								if DoubleClick:
									if OtherOpen\SecondInv[n]\itemtemplate.sound != 66: PlaySound_Strict(PickSFX(OtherOpen\SecondInv[n]\itemtemplate.sound))
									OtherOpen = Null
									closedInv=True
									InvOpen = false
									DoubleClick = false



						else:




					ItemAmount=ItemAmount+1
				else:
					if isMouseOn And MouseHit1:
						for z: int = 0 To OtherSize - 1
							if OtherOpen\SecondInv[z] = SelectedItem: OtherOpen\SecondInv[z] = Null

						OtherOpen\SecondInv[n] = SelectedItem




				x=x+width + spacing
				tempX=tempX + 1
				if tempX = 5:
					tempX=0
					y = y + height*2
					x = GraphicWidth / 2 - (width * MaxItemAmount /2 + spacing * (MaxItemAmount / 2 - 1)) / 2



			if SelectedItem != Null:
				if MouseDown1:
					if MouseSlot = 66:
						DrawImage(Selecteditem.invimg, ScaledMouseX() - ImageWidth(Selecteditem.itemtemplate.invimg) / 2, ScaledMouseY() - ImageHeight(Selecteditem.itemtemplate.invimg) / 2)
					elif SelectedItem != PrevOtherOpen\SecondInv[MouseSlot]
						DrawImage(Selecteditem.invimg, ScaledMouseX() - ImageWidth(Selecteditem.itemtemplate.invimg) / 2, ScaledMouseY() - ImageHeight(Selecteditem.itemtemplate.invimg) / 2)

				else:
					if MouseSlot = 66:
						if Selecteditem.itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))

						ShowEntity(Selecteditem.collider)
						PositionEntity(Selecteditem.collider, EntityX(Camera), EntityY(Camera), EntityZ(Camera))
						RotateEntity(Selecteditem.collider, EntityPitch(Camera), EntityYaw(Camera), 0)
						MoveEntity(Selecteditem.collider, 0, -0.1, 0.1)
						RotateEntity(Selecteditem.collider, 0, randi(360), 0)
						ResetEntity (Selecteditem.collider)


						Selecteditem.DropSpeed = 0.0

						Selecteditem.Picked = false
						for z: int = 0 To OtherSize - 1
							if OtherOpen\SecondInv[z] = SelectedItem: OtherOpen\SecondInv[z] = Null


						isEmpty=True
						if OtherOpen\itemtemplate.tempname = "wallet":
							if (Not isEmpty):
								for z: int = 0 To OtherSize - 1
									if OtherOpen\SecondInv[z]!=Null
										var name: String=OtherOpen\SecondInv[z]\itemtemplate.tempname
										if name: String!="25ct" And name: String!="coin" And name: String!="key" And name: String!="scp860" And name: String!="scp714":
											isEmpty=False
											break




						else:
							for z: int = 0 To OtherSize - 1
								if OtherOpen\SecondInv[z]!=Null
									isEmpty = false
									break




						if isEmpty:
							match OtherOpen\itemtemplate.tempname
								"clipboard"
									OtherOpen\invimg = OtherOpen\itemtemplate.invimg2
									SetAnimTime OtherOpen\model,17.0
								"wallet"
									SetAnimTime OtherOpen\model,0.0



						SelectedItem = Null
						OtherOpen = Null
						closedInv=True

						MoveMouse viewport_center_x, viewport_center_y
					else:

						if PrevOtherOpen\SecondInv[MouseSlot] = Null:
							for z: int = 0 To OtherSize - 1
								if PrevOtherOpen\SecondInv[z] = SelectedItem: PrevOtherOpen\SecondInv[z] = Null

							PrevOtherOpen\SecondInv[MouseSlot] = SelectedItem
							SelectedItem = Null
						elif PrevOtherOpen\SecondInv[MouseSlot] != SelectedItem
							match Selecteditem.itemtemplate.tempname
								_:
									Msg = "You cannot combine these two items."
									MsgTimer = 70 * 5




					SelectedItem = Null



			if Fullscreen: DrawImage CursorIMG,ScaledMouseX(),ScaledMouseY()
			if (closedInv) And (Not InvOpen):
				ResumeSounds()
				OtherOpen=Null
				MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0



		else: if InvOpen:

			if (PlayerRoom\RoomTemplate.Name = "gatea"):
				HideEntity Fog
				CameraFogRange Camera, 5,30
				CameraFogColor (Camera,200,200,200)
				CameraClsColor (Camera,200,200,200)
				CameraRange(Camera, 0.05, 30)
			elif (PlayerRoom\RoomTemplate.Name = "break1") And (EntityY(Collider)>1040.0*RoomScale)
				HideEntity Fog
				CameraFogRange Camera, 5,45
				CameraFogColor (Camera,200,200,200)
				CameraClsColor (Camera,200,200,200)
				CameraRange(Camera, 0.05, 60)


			SelectedDoor = Null

			width: int = 70
			height: int = 70
			spacing: int = 35

			x = GraphicWidth / 2 - (width * MaxItemAmount /2 + spacing * (MaxItemAmount / 2 - 1)) / 2
			y = GraphicHeight / 2 - height

			ItemAmount = 0
			for  n: int = 0 To MaxItemAmount - 1
				isMouseOn: int = false
				if ScaledMouseX() > x And ScaledMouseX() < x + width:
					if ScaledMouseY() > y And ScaledMouseY() < y + height:
						isMouseOn = True



				if Inventory(n) != Null:
					Color 200, 200, 200
					match Inventory(n)\itemtemplate.tempname
						"gasmask"
							if WearingGasMask=1: Rect(x - 3, y - 3, width + 6, height + 6)
						"supergasmask"
							if WearingGasMask=2: Rect(x - 3, y - 3, width + 6, height + 6)
						"gasmask3"
							if WearingGasMask=3: Rect(x - 3, y - 3, width + 6, height + 6)
						"hazmatsuit"
							if WearingHazmat=1: Rect(x - 3, y - 3, width + 6, height + 6)
						"hazmatsuit2"
							if WearingHazmat=2: Rect(x - 3, y - 3, width + 6, height + 6)
						"hazmatsuit3"
							if WearingHazmat=3: Rect(x - 3, y - 3, width + 6, height + 6)
						"vest"
							if WearingVest=1: Rect(x - 3, y - 3, width + 6, height + 6)
						"finevest"
							if WearingVest=2: Rect(x - 3, y - 3, width + 6, height + 6)
						"scp714"
							if Wearing714=1: Rect(x - 3, y - 3, width + 6, height + 6)
							;BoH items
						;"ring"
						;	if Wearing714=2: Rect(x - 3, y - 3, width + 6, height + 6)
						;"scp178"
						;	if Wearing178=1: Rect(x - 3, y - 3, width + 6, height + 6)
						;"glasses"
						;	if Wearing178=2: Rect(x - 3, y - 3, width + 6, height + 6)
						"nvgoggles"
							if WearingNightVision=1: Rect(x - 3, y - 3, width + 6, height + 6)
						"supernv"
							if WearingNightVision=2: Rect(x - 3, y - 3, width + 6, height + 6)
						"scp1499"
							if Wearing1499=1: Rect(x - 3, y - 3, width + 6, height + 6)
						"super1499"
							if Wearing1499=2: Rect(x - 3, y - 3, width + 6, height + 6)
						"finenvgoggles"
							if WearingNightVision=3: Rect(x - 3, y - 3, width + 6, height + 6)
						"scp427"
							if I_427\Using=1: Rect(x - 3, y - 3, width + 6, height + 6)



				if isMouseOn:
					MouseSlot = n
					Color 255, 0, 0
					Rect(x - 1, y - 1, width + 2, height + 2)


				Color 255, 255, 255
				DrawFrame(x, y, width, height, (x Mod 64), (x Mod 64))

				if Inventory(n) != Null:
					if (SelectedItem != Inventory(n) Or isMouseOn):
						DrawImage(Inventory(n)\invimg, x + width / 2 - 32, y + height / 2 - 32)



				if Inventory(n) != Null And SelectedItem != Inventory(n):
					;drawimage(Inventory(n).InvIMG, x + width / 2 - 32, y + height / 2 - 32)
					if isMouseOn:
						if SelectedItem = Null:
							if MouseHit1:
								SelectedItem = Inventory(n)
								MouseHit1 = false

								if DoubleClick:
									if WearingHazmat > 0 And Instr(Selecteditem.itemtemplate.tempname,"hazmatsuit")=0:
										Msg = "You cannot use any items while wearing a hazmat suit."
										MsgTimer = 70*5
										SelectedItem = Null
										Return

									if Inventory(n)\itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Inventory(n)\itemtemplate.sound))
									InvOpen = false
									DoubleClick = false




							AASetFont Font1
							Color 0,0,0
							AAText(x + width / 2 + 1, y + height + spacing - 15 + 1, Inventory(n)\name, True)
							Color 255, 255, 255
							AAText(x + width / 2, y + height + spacing - 15, Inventory(n)\name, True)




					ItemAmount=ItemAmount+1
				else:
					if isMouseOn And MouseHit1:
						for z: int = 0 To MaxItemAmount - 1
							if Inventory(z) = SelectedItem: Inventory(z) = Null

						Inventory(n) = SelectedItem




				x=x+width + spacing
				if n = 4:
					y = y + height*2
					x = GraphicWidth / 2 - (width * MaxItemAmount /2 + spacing * (MaxItemAmount / 2 - 1)) / 2



			if SelectedItem != Null:
				if MouseDown1:
					if MouseSlot = 66:
						DrawImage(Selecteditem.invimg, ScaledMouseX() - ImageWidth(Selecteditem.itemtemplate.invimg) / 2, ScaledMouseY() - ImageHeight(Selecteditem.itemtemplate.invimg) / 2)
					elif SelectedItem != Inventory(MouseSlot)
						DrawImage(Selecteditem.invimg, ScaledMouseX() - ImageWidth(Selecteditem.itemtemplate.invimg) / 2, ScaledMouseY() - ImageHeight(Selecteditem.itemtemplate.invimg) / 2)

				else:
					if MouseSlot = 66:
						match Selecteditem.itemtemplate.tempname
							"vest","finevest","hazmatsuit","hazmatsuit2","hazmatsuit3"
								Msg = "Double click on this item to take it off."
								MsgTimer = 70*5
							"scp1499","super1499"
								if Wearing1499>0:
									Msg = "Double click on this item to take it off."
									MsgTimer = 70*5
								else:
									DropItem(SelectedItem)
									SelectedItem = Null
									InvOpen = false

							_:
								DropItem(SelectedItem)
								SelectedItem = Null
								InvOpen = false


						MoveMouse viewport_center_x, viewport_center_y
					else:
						if Inventory(MouseSlot) = Null:
							for z: int = 0 To MaxItemAmount - 1
								if Inventory(z) = SelectedItem: Inventory(z) = Null

							Inventory(MouseSlot) = SelectedItem
							SelectedItem = Null
						elif Inventory(MouseSlot) != SelectedItem
							match Selecteditem.itemtemplate.tempname
								"paper","key1","key2","key3","key4","key5","key6","misc","oldpaper","badge","ticket","25ct","coin","key","scp860"

									if Inventory(MouseSlot)\itemtemplate.tempname = "clipboard":
										;Add an item to clipboard
										var added.Items = Null
										var b: String = Selecteditem.itemtemplate.tempname
										var b2: String = Selecteditem.itemtemplate.name
										if (b!="misc" And b!="25ct" And b!="coin" And b!="key" And b!="scp860" And b!="scp714") Or (b2="Playing Card" Or b2="Mastercard"):
											for c: int = 0 To Inventory(MouseSlot)\invSlots-1
												if (Inventory(MouseSlot)\SecondInv[c] = Null)
													if SelectedItem != Null:
														Inventory(MouseSlot)\SecondInv[c] = SelectedItem
														Inventory(MouseSlot)\state = 1.0
														SetAnimTime Inventory(MouseSlot)\model,0.0
														Inventory(MouseSlot)\invimg = Inventory(MouseSlot)\itemtemplate.invimg

														for ri: int = 0 To MaxItemAmount - 1
															if Inventory(ri) = SelectedItem:
																Inventory(ri) = Null
																PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))


														added = SelectedItem
														SelectedItem = Null : break



											if SelectedItem != Null:
												Msg = "The paperclip is not strong enough to hold any more items."
											else:
												if added.itemtemplate.tempname = "paper" Or added.itemtemplate.tempname = "oldpaper":
													Msg = "This document was added to the clipboard."
												elif added.itemtemplate.tempname = "badge"
													Msg = added.itemtemplate.name + " was added to the clipboard."
												else:
													Msg = "The " + added.itemtemplate.name + " was added to the clipboard."



											MsgTimer = 70 * 5
										else:
											Msg = "You cannot combine these two items."
											MsgTimer = 70 * 5

									elif Inventory(MouseSlot)\itemtemplate.tempname = "wallet":
										;Add an item to clipboard
										added.Items = Null
										b: String = Selecteditem.itemtemplate.tempname
										b2: String = Selecteditem.itemtemplate.name
										if (b!="misc" And b!="paper" And b!="oldpaper") Or (b2="Playing Card" Or b2="Mastercard"):
											for c: int = 0 To Inventory(MouseSlot)\invSlots-1
												if (Inventory(MouseSlot)\SecondInv[c] = Null)
													if SelectedItem != Null:
														Inventory(MouseSlot)\SecondInv[c] = SelectedItem
														Inventory(MouseSlot)\state = 1.0
														if b!="25ct" And b!="coin" And b!="key" And b!="scp860"
															SetAnimTime Inventory(MouseSlot)\model,3.0

														Inventory(MouseSlot)\invimg = Inventory(MouseSlot)\itemtemplate.invimg

														for ri: int = 0 To MaxItemAmount - 1
															if Inventory(ri) = SelectedItem:
																Inventory(ri) = Null
																PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))


														added = SelectedItem
														SelectedItem = Null : break



											if SelectedItem != Null:
												Msg = "The wallet is full."
											else:
												Msg = "You put "+added.itemtemplate.name+" into the wallet."


											MsgTimer = 70 * 5
										else:
											Msg = "You cannot combine these two items."
											MsgTimer = 70 * 5

									else:
										Msg = "You cannot combine these two items."
										MsgTimer = 70 * 5

									SelectedItem = Null


								"battery", "bat"

									match Inventory(MouseSlot)\itemtemplate.name
										"S-NAV Navigator", "S-NAV 300 Navigator", "S-NAV 310 Navigator"
											if Selecteditem.itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))
											RemoveItem (SelectedItem)
											SelectedItem = Null
											Inventory(MouseSlot)\state = 100.0
											Msg = "You replaced the navigator's battery."
											MsgTimer = 70 * 5
										"S-NAV Navigator Ultimate"
											Msg = "There seems to be no place for batteries in this navigator."
											MsgTimer = 70 * 5
										"Radio Transceiver"
											match Inventory(MouseSlot)\itemtemplate.tempname
												"fineradio", "veryfineradio"
													Msg = "There seems to be no place for batteries in this radio."
													MsgTimer = 70 * 5
												"18vradio"
													Msg = "The battery does not fit inside this radio."
													MsgTimer = 70 * 5
												"radio"
													if Selecteditem.itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))
													RemoveItem (SelectedItem)
													SelectedItem = Null
													Inventory(MouseSlot)\state = 100.0
													Msg = "You replaced the radio's battery."
													MsgTimer = 70 * 5

										"Night Vision Goggles"
											var nvname: String = Inventory(MouseSlot)\itemtemplate.tempname
											if nvname: String="nvgoggles" Or nvname: String="supernv":
												if Selecteditem.itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))
												RemoveItem (SelectedItem)
												SelectedItem = Null
												Inventory(MouseSlot)\state = 1000.0
												Msg = "You replaced the goggles' battery."
												MsgTimer = 70 * 5
											else:
												Msg = "There seems to be no place for batteries in these night vision goggles."
												MsgTimer = 70 * 5

										_:
											Msg = "You cannot combine these two items."
											MsgTimer = 70 * 5


								"18vbat"

									match Inventory(MouseSlot)\itemtemplate.name
										"S-NAV Navigator", "S-NAV 300 Navigator", "S-NAV 310 Navigator"
											Msg = "The battery does not fit inside this navigator."
											MsgTimer = 70 * 5
										"S-NAV Navigator Ultimate"
											Msg = "There seems to be no place for batteries in this navigator."
											MsgTimer = 70 * 5
										"Radio Transceiver"
											match Inventory(MouseSlot)\itemtemplate.tempname
												"fineradio", "veryfineradio"
													Msg = "There seems to be no place for batteries in this radio."
													MsgTimer = 70 * 5
												"18vradio"
													if Selecteditem.itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))
													RemoveItem (SelectedItem)
													SelectedItem = Null
													Inventory(MouseSlot)\state = 100.0
													Msg = "You replaced the radio's battery."
													MsgTimer = 70 * 5

										_:
											Msg = "You cannot combine these two items."
											MsgTimer = 70 * 5


								_:

									Msg = "You cannot combine these two items."
									MsgTimer = 70 * 5





					SelectedItem = Null



			if Fullscreen: DrawImage CursorIMG, ScaledMouseX(),ScaledMouseY()

			if InvOpen = false:
				ResumeSounds()
				MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0

		else: ;invopen = false

			if SelectedItem != Null:
				match Selecteditem.itemtemplate.tempname
					"nvgoggles"

						if Wearing1499 = 0 And WearingHazmat=0:
							if WearingNightVision = 1:
								Msg = "You removed the goggles."
								CameraFogFar = StoredCameraFogFar
							else:
								Msg = "You put on the goggles."
								WearingGasMask = 0
								WearingNightVision = 0
								StoredCameraFogFar = CameraFogFar
								CameraFogFar = 30


							WearingNightVision = (Not WearingNightVision)
						elif Wearing1499 > 0:
							Msg = "You need to take off SCP-1499 in order to put on the goggles."
						else:
							Msg = "You need to take off the hazmat suit in order to put on the goggles."

						SelectedItem = Null
						MsgTimer = 70 * 5

					"supernv"

						if Wearing1499 = 0 And WearingHazmat=0:
							if WearingNightVision = 2:
								Msg = "You removed the goggles."
								CameraFogFar = StoredCameraFogFar
							else:
								Msg = "You put on the goggles."
								WearingGasMask = 0
								WearingNightVision = 0
								StoredCameraFogFar = CameraFogFar
								CameraFogFar = 30


							WearingNightVision = (Not WearingNightVision) * 2
						elif Wearing1499 > 0:
							Msg = "You need to take off SCP-1499 in order to put on the goggles."
						else:
							Msg = "You need to take off the hazmat suit in order to put on the goggles."

						SelectedItem = Null
						MsgTimer = 70 * 5

					"finenvgoggles"

						if Wearing1499 = 0 And WearingHazmat = 0:
							if WearingNightVision = 3:
								Msg = "You removed the goggles."
								CameraFogFar = StoredCameraFogFar
							else:
								Msg = "You put on the goggles."
								WearingGasMask = 0
								WearingNightVision = 0
								StoredCameraFogFar = CameraFogFar
								CameraFogFar = 30


							WearingNightVision = (Not WearingNightVision) * 3
						elif Wearing1499 > 0:
							Msg = "You need to take off SCP-1499 in order to put on the goggles."
						else:
							Msg = "You need to take off the hazmat suit in order to put on the goggles."

						SelectedItem = Null
						MsgTimer = 70 * 5

					"ring"

						if Wearing714=2:
							Msg = "You removed the ring."
							Wearing714 = false
						else:
							;Achievements(Achv714)=True
							Msg = "You put on the ring."
							Wearing714 = 2

						MsgTimer = 70 * 5
						SelectedItem = Null

					"1123"

						if Not (Wearing714 = 1):
							if PlayerRoom\RoomTemplate.Name != "room1123":
								ShowEntity Light
								LightFlash = 7
								PlaySound_Strict(LoadTempSound("SFX\SCP\1123\Touch.ogg"))
								DeathMSG = "Subject D-9341 was shot dead after attempting to attack a member of Nine-Tailed Fox. Surveillance tapes show that the subject had been "
								DeathMSG = DeathMSG + "wandering around the site approximately 9 minutes prior, shouting the phrase " + Chr(34) + "get rid of the four pests" + Chr(34)
								DeathMSG = DeathMSG + " in chinese. SCP-1123 was found in [REDACTED] nearby, suggesting the subject had come into physical contact with it. How "
								DeathMSG = DeathMSG + "exactly SCP-1123 was removed from its containment chamber is still unknown."
								Kill()
								Return

							for e.Events = Each Events
								if e.EventName = "room1123":
									if e.EventState = 0:
										ShowEntity Light
										LightFlash = 3
										PlaySound_Strict(LoadTempSound("SFX\SCP\1123\Touch.ogg"))

									e.EventState = Max(1, e.EventState)
									break




					"battery"

						;InvOpen = True

					"key1", "key2", "key3", "key4", "key5", "key6", "keyomni", "scp860", "hand", "hand2", "25ct"

						DrawImage(Selecteditem.itemtemplate.invimg, GraphicWidth / 2 - ImageWidth(Selecteditem.itemtemplate.invimg) / 2, GraphicHeight / 2 - ImageHeight(Selecteditem.itemtemplate.invimg) / 2)

					"scp513"

						PlaySound_Strict LoadTempSound("SFX\SCP\513\Bell1.ogg")

						if Curr5131 = Null
							Curr5131 = CreateNPC(NPCtype5131, 0,0,0)

						SelectedItem = Null

					"scp500"

						if CanUseItem(False, false, True)
							GiveAchievement(Achv500)

							if Infect > 0:
								Msg = "You swallowed the pill. Your nausea is fading."
							else:
								Msg = "You swallowed the pill."

							MsgTimer = 70*7

							DeathTimer = 0
							Infect = 0
							Stamina = 100
							for i = 0 To 5
								SCP1025state[i]=0

							if StaminaEffect > 1.0:
								StaminaEffect = 1.0
								StaminaEffectTimer = 0.0


							RemoveItem(SelectedItem)
							SelectedItem = Null


					"veryfinefirstaid"

						if CanUseItem(False, false, True)
							match randi(5)
								1
									Injuries = 3.5
									Msg = "You started bleeding heavily."
									MsgTimer = 70*7
								2
									Injuries = 0
									Bloodloss = 0
									Msg = "Your wounds are healing up rapidly."
									MsgTimer = 70*7
								3
									Injuries = Max(0, Injuries - randf(0.5,3.5))
									Bloodloss = Max(0, Bloodloss - randf(10,100))
									Msg = "You feel much better."
									MsgTimer = 70*7
								4
									BlurTimer = 10000
									Bloodloss = 0
									Msg = "You feel nauseated."
									MsgTimer = 70*7
								5
									BlinkTimer = -10
									var roomname: String = PlayerRoom\RoomTemplate.Name
									if roomname = "dimension1499" Or roomname = "gatea" Or (roomname="break1" And EntityY(Collider)>1040.0*RoomScale)
										Injuries = 2.5
										Msg = "You started bleeding heavily."
										MsgTimer = 70*7
									else:
										for r.Rooms = Each Rooms
											if r\RoomTemplate.Name = "pocketdimension":
												PositionEntity(Collider, EntityX(r\obj),0.8,EntityZ(r\obj))
												ResetEntity Collider
												UpdateDoors()
												UpdateRooms()
												PlaySound_Strict(Use914SFX)
												DropSpeed = 0
												Curr106\State = -2500
												break


										Msg = "for some inexplicable reason, you find yourself inside the pocket dimension."
										MsgTimer = 70*8



							RemoveItem(SelectedItem)


					"firstaid", "finefirstaid", "firstaid2"

						if Bloodloss = 0 And Injuries = 0:
							Msg = "You do not need to use a first aid kit right now."
							MsgTimer = 70*5
							SelectedItem = Null
						else:
							if CanUseItem(False, True, True)
								CurrSpeed = CurveValue(0, CurrSpeed, 5.0)
								Crouch = True

								DrawImage(Selecteditem.itemtemplate.invimg, GraphicWidth / 2 - ImageWidth(Selecteditem.itemtemplate.invimg) / 2, GraphicHeight / 2 - ImageHeight(Selecteditem.itemtemplate.invimg) / 2)

								width: int = 300
								height: int = 20
								x: int = GraphicWidth / 2 - width / 2
								y: int = GraphicHeight / 2 + 80
								Rect(x, y, width+4, height, false)
								for  i: int = 1 To Int((width - 2) * (Selecteditem.state / 100.0) / 10)
									DrawImage(BlinkMeterIMG, x + 3 + 10 * (i - 1), y + 3)


								Selecteditem.state = Min(Selecteditem.state+(FPSfactor/5.0),100)

								if Selecteditem.state = 100:
									if Selecteditem.itemtemplate.tempname = "finefirstaid":
										Bloodloss = 0
										Injuries = Max(0, Injuries - 2.0)
										if Injuries = 0:
											Msg = "You bandaged the wounds and took a painkiller. You feel fine."
										elif Injuries > 1.0
											Msg = "You bandaged the wounds and took a painkiller, but you were not able to stop the bleeding."
										else:
											Msg = "You bandaged the wounds and took a painkiller, but you still feel sore."

										MsgTimer = 70*5
										RemoveItem(SelectedItem)
									else:
										Bloodloss = Max(0, Bloodloss - randi(10,20))
										if Injuries => 2.5:
											Msg = "The wounds were way too severe to staunch the bleeding completely."
											Injuries = Max(2.5, Injuries-randf(0.3,0.7))
										elif Injuries > 1.0
											Injuries = Max(0.5, Injuries-randf(0.5,1.0))
											if Injuries > 1.0:
												Msg = "You bandaged the wounds but were unable to staunch the bleeding completely."
											else:
												Msg = "You managed to stop the bleeding."

										else:
											if Injuries > 0.5:
												Injuries = 0.5
												Msg = "You took a painkiller, easing the pain slightly."
											else:
												Injuries = 0.5
												Msg = "You took a painkiller, but it still hurts to walk."



										if Selecteditem.itemtemplate.tempname = "firstaid2":
											match randi(6)
												1
													SuperMan = True
													Msg = "You have becomed overwhelmedwithadrenalineholyshitWOOOOOO~!"
												2
													InvertMouse = (Not InvertMouse)
													Msg = "You suddenly find it very difficult to turn your head."
												3
													BlurTimer = 5000
													Msg = "You feel nauseated."
												4
													BlinkEffect = 0.6
													BlinkEffectTimer = randi(20,30)
												5
													Bloodloss = 0
													Injuries = 0
													Msg = "You bandaged the wounds. The bleeding stopped completely and you feel fine."
												6
													Msg = "You bandaged the wounds and blood started pouring heavily through the bandages."
													Injuries = 3.5



										MsgTimer = 70*5
										RemoveItem(SelectedItem)





					"eyedrops"

						if CanUseItem(False,False,False)
							if (Not (Wearing714=1)): ;wtf is this
								BlinkEffect = 0.6
								BlinkEffectTimer = randi(20,30)
								BlurTimer = 200

							RemoveItem(SelectedItem)


					"fineeyedrops"

						if CanUseItem(False,False,False)
							if (Not (Wearing714=1)):
								BlinkEffect = 0.4
								BlinkEffectTimer = randi(30,40)
								Bloodloss = Max(Bloodloss-1.0, 0)
								BlurTimer = 200

							RemoveItem(SelectedItem)


					"supereyedrops"

						if CanUseItem(False,False,False)
							if (Not (Wearing714 = 1)):
								BlinkEffect = 0.0
								BlinkEffectTimer = 60
								EyeStuck = 10000

							BlurTimer = 1000
							RemoveItem(SelectedItem)


					"paper", "ticket"

						if Selecteditem.itemtemplate.img = 0:
							match Selecteditem.itemtemplate.name
								"Burnt Note"
									Selecteditem.itemtemplate.img = LoadImage_Strict("GFX\items\bn.it")
									SetBuffer ImageBuffer(Selecteditem.itemtemplate.img)
									Color 0,0,0
									AAText 277, 469, AccessCode, True, True
									Color 255,255,255
									SetBuffer BackBuffer()
								"Document SCP-372"
									Selecteditem.itemtemplate.img = LoadImage_Strict(Selecteditem.itemtemplate.imgpath)
									Selecteditem.itemtemplate.img = ResizeImage2(Selecteditem.itemtemplate.img, ImageWidth(Selecteditem.itemtemplate.img) * MenuScale, ImageHeight(Selecteditem.itemtemplate.img) * MenuScale)

									SetBuffer ImageBuffer(Selecteditem.itemtemplate.img)
									Color 37,45,137
									AASetFont Font5
									temp = ((Int(AccessCode)*3) Mod 10000)
									if temp < 1000: temp = temp+1000
									AAText 383*MenuScale, 734*MenuScale, temp, True, True
									Color 255,255,255
									SetBuffer BackBuffer()
								"Movie Ticket"

									Selecteditem.itemtemplate.img=LoadImage_Strict(Selecteditem.itemtemplate.imgpath)

									if (Selecteditem.state = 0):
										Msg = Chr(34)+"Hey, I remember this movie!"+Chr(34)
										MsgTimer = 70*10
										PlaySound_Strict LoadTempSound("SFX\SCP\1162\NostalgiaCancer"+randi(1,5)+".ogg")
										Selecteditem.state = 1

								_:
									Selecteditem.itemtemplate.img=LoadImage_Strict(Selecteditem.itemtemplate.imgpath)
									Selecteditem.itemtemplate.img = ResizeImage2(Selecteditem.itemtemplate.img, ImageWidth(Selecteditem.itemtemplate.img) * MenuScale, ImageHeight(Selecteditem.itemtemplate.img) * MenuScale)


							MaskImage(Selecteditem.itemtemplate.img, 255, 0, 255)


						DrawImage(Selecteditem.itemtemplate.img, GraphicWidth / 2 - ImageWidth(Selecteditem.itemtemplate.img) / 2, GraphicHeight / 2 - ImageHeight(Selecteditem.itemtemplate.img) / 2)

					"scp1025"

						GiveAchievement(Achv1025)
						if Selecteditem.itemtemplate.img=0:
							Selecteditem.state = randi(0,5)
							Selecteditem.itemtemplate.img=LoadImage_Strict("GFX\items\1025\1025_"+Int(Selecteditem.state)+".jpg")
							Selecteditem.itemtemplate.img = ResizeImage2(Selecteditem.itemtemplate.img, ImageWidth(Selecteditem.itemtemplate.img) * MenuScale, ImageHeight(Selecteditem.itemtemplate.img) * MenuScale)

							MaskImage(Selecteditem.itemtemplate.img, 255, 0, 255)


						if (Not Wearing714): SCP1025state[Selecteditem.state]=Max(1,SCP1025state[Selecteditem.state])

						DrawImage(Selecteditem.itemtemplate.img, GraphicWidth / 2 - ImageWidth(Selecteditem.itemtemplate.img) / 2, GraphicHeight / 2 - ImageHeight(Selecteditem.itemtemplate.img) / 2)

					"cup"

						if CanUseItem(False,False,True)
							Selecteditem.name = Trim(Lower(Selecteditem.name))
							if Left(Selecteditem.name, Min(6,Len(Selecteditem.name))) = "cup of":
								Selecteditem.name = Right(Selecteditem.name, Len(Selecteditem.name)-7)
							elif Left(Selecteditem.name, Min(8,Len(Selecteditem.name))) = "a cup of"
								Selecteditem.name = Right(Selecteditem.name, Len(Selecteditem.name)-9)


							;the state of refined items is more than 1.0 (fine setting increases it by 1, very fine doubles it)
							x2 = (Selecteditem.state+1.0)

							var iniStr: String = "DATA\SCP-294.ini"

							var loc: int = GetINISectionLocation(iniStr, Selecteditem.name)

							;Stop

							strtemp = GetINIString2(iniStr, loc, "message")
							if strtemp != "": Msg = strtemp : MsgTimer = 70*6

							if GetINIInt2(iniStr, loc, "lethal") Or GetINIInt2(iniStr, loc, "deathtimer"):
								DeathMSG = GetINIString2(iniStr, loc, "deathmessage")
								if GetINIInt2(iniStr, loc, "lethal"): Kill()

							BlurTimer = GetINIInt2(iniStr, loc, "blur")*70;*temp
							if VomitTimer = 0: VomitTimer = GetINIInt2(iniStr, loc, "vomit")
							CameraShakeTimer = GetINIString2(iniStr, loc, "camerashake")
							Injuries = Max(Injuries + GetINIInt2(iniStr, loc, "damage"),0);*temp
							Bloodloss = Max(Bloodloss + GetINIInt2(iniStr, loc, "blood loss"),0);*temp
							strtemp =  GetINIString2(iniStr, loc, "sound")
							if strtemp!="":
								PlaySound_Strict LoadTempSound(strtemp)

							if GetINIInt2(iniStr, loc, "stomachache"): SCP1025state[3]=1

							DeathTimer=GetINIInt2(iniStr, loc, "deathtimer")*70

							BlinkEffect = Float(GetINIString2(iniStr, loc, "blink effect", 1.0))*x2
							BlinkEffectTimer = Float(GetINIString2(iniStr, loc, "blink effect timer", 1.0))*x2

							StaminaEffect = Float(GetINIString2(iniStr, loc, "stamina effect", 1.0))*x2
							StaminaEffectTimer = Float(GetINIString2(iniStr, loc, "stamina effect timer", 1.0))*x2

							strtemp = GetINIString2(iniStr, loc, "refusemessage")
							if strtemp != "":
								Msg = strtemp
								MsgTimer = 70*6
							else:
								it.Items = CreateItem("Empty Cup", "emptycup", 0,0,0)
								it\Picked = True
								for i = 0 To MaxItemAmount-1
									if Inventory(i)=SelectedItem: Inventory(i) = it : break

								EntityType (it\collider, HIT_ITEM)

								RemoveItem(SelectedItem)


							SelectedItem = Null


					"syringe"

						if CanUseItem(False,True,True)
							HealTimer = 30
							StaminaEffect = 0.5
							StaminaEffectTimer = 20

							Msg = "You injected yourself with the syringe and feel a slight adrenaline rush."
							MsgTimer = 70 * 8

							RemoveItem(SelectedItem)


					"finesyringe"

						if CanUseItem(False,True,True)
							HealTimer = randf(20, 40)
							StaminaEffect = randf(0.5, 0.8)
							StaminaEffectTimer = randf(20, 30)

							Msg = "You injected yourself with the syringe and feel an adrenaline rush."
							MsgTimer = 70 * 8

							RemoveItem(SelectedItem)


					"veryfinesyringe"

						if CanUseItem(False,True,True)
							match randi(3)
								1
									HealTimer = randf(40, 60)
									StaminaEffect = 0.1
									StaminaEffectTimer = 30
									Msg = "You injected yourself with the syringe and feel a huge adrenaline rush."
								2
									SuperMan = True
									Msg = "You injected yourself with the syringe and feel a humongous adrenaline rush."
								3
									VomitTimer = 30
									Msg = "You injected yourself with the syringe and feel a pain in your stomach."


							MsgTimer = 70 * 8
							RemoveItem(SelectedItem)


					"radio","18vradio","fineradio","veryfineradio"

						if Selecteditem.state <= 100: Selecteditem.state = Max(0, Selecteditem.state - FPSfactor * 0.004)

						if Selecteditem.itemtemplate.img=0:
							Selecteditem.itemtemplate.img=LoadImage_Strict(Selecteditem.itemtemplate.imgpath)
							MaskImage(Selecteditem.itemtemplate.img, 255, 0, 255)


						;radiostate(5) = has the "use the number keys" -message been shown yet (true/false)
						;radiostate(6) = a timer for the "code channel"
						;RadioState(7) = another timer for the "code channel"

						if RadioState(5) = 0:
							Msg = "Use the numbered keys 1 through 5 to cycle between various channels."
							MsgTimer = 70 * 5
							RadioState(5) = 1
							RadioState(0) = -1


						strtemp: String = ""

						x = GraphicWidth - ImageWidth(Selecteditem.itemtemplate.img) ;+ 120
						y = GraphicHeight - ImageHeight(Selecteditem.itemtemplate.img) ;- 30

						DrawImage(Selecteditem.itemtemplate.img, x, y)

						if Selecteditem.state > 0:
							if PlayerRoom\RoomTemplate.Name = "pocketdimension" Or CoffinDistance < 4.0:
								ResumeChannel(RadioCHN(5))
								if ChannelPlaying(RadioCHN(5)) = false: RadioCHN(5) = PlaySound_Strict(RadioStatic)
							else:
								match Int(Selecteditem.state2)
									0 ;randomkanava
										ResumeChannel(RadioCHN(0))
										strtemp = "        USER TRACK PLAYER - "
										if (Not EnableUserTracks)
											if ChannelPlaying(RadioCHN(0)) = false: RadioCHN(0) = PlaySound_Strict(RadioStatic)
											strtemp = strtemp + "NOT ENABLED     "
										elif UserTrackMusicAmount<1
											if ChannelPlaying(RadioCHN(0)) = false: RadioCHN(0) = PlaySound_Strict(RadioStatic)
											strtemp = strtemp + "NO TRACKS FOUND     "
										else:
											if (Not ChannelPlaying(RadioCHN(0)))
												if (Not UserTrackFlag: int)
													if UserTrackMode
														if RadioState(0)<(UserTrackMusicAmount-1)
															RadioState(0) = RadioState(0) + 1
														else:
															RadioState(0) = 0

														UserTrackFlag = True
													else:
														RadioState(0) = randi(0,UserTrackMusicAmount-1)


												if CurrUserTrack: int!=0: FreeSound_Strict(CurrUserTrack: int) : CurrUserTrack: int = 0
												CurrUserTrack: int = LoadSound_Strict("SFX\\Radio\\UserTracks\\"+UserTrackName: String(RadioState(0)))
												RadioCHN(0) = PlaySound_Strict(CurrUserTrack: int)
												DebugLog "CurrTrack: "+RadioState(0)
												DebugLog UserTrackName: String(RadioState(0))
											else:
												strtemp = strtemp + Upper(UserTrackName: String(RadioState(0))) + "          "
												UserTrackFlag = false


											if KeyHit(2):
												PlaySound_Strict RadioSquelch
												if (Not UserTrackFlag: int)
													if UserTrackMode
														if RadioState(0)<(UserTrackMusicAmount-1)
															RadioState(0) = RadioState(0) + 1
														else:
															RadioState(0) = 0

														UserTrackFlag = True
													else:
														RadioState(0) = randi(0,UserTrackMusicAmount-1)


												if CurrUserTrack: int!=0: FreeSound_Strict(CurrUserTrack: int) : CurrUserTrack: int = 0
												CurrUserTrack: int = LoadSound_Strict("SFX\\Radio\\UserTracks\\"+UserTrackName: String(RadioState(0)))
												RadioCHN(0) = PlaySound_Strict(CurrUserTrack: int)
												DebugLog "CurrTrack: "+RadioState(0)
												DebugLog UserTrackName: String(RadioState(0))


									1 ;hälytyskanava
										DebugLog RadioState(1)

										ResumeChannel(RadioCHN(1))
										strtemp = "        WARNING - CONTAINMENT BREACH          "
										if ChannelPlaying(RadioCHN(1)) = false:

											if RadioState(1) => 5:
												RadioCHN(1) = PlaySound_Strict(RadioSFX(1,1))
												RadioState(1) = 0
											else:
												RadioState(1)=RadioState(1)+1
												RadioCHN(1) = PlaySound_Strict(RadioSFX(1,0))




									2 ;scp-radio
										ResumeChannel(RadioCHN(2))
										strtemp = "        SCP Foundation On-Site Radio          "
										if ChannelPlaying(RadioCHN(2)) = false:
											RadioState(2)=RadioState(2)+1
											if RadioState(2) = 17: RadioState(2) = 1
											if Floor(RadioState(2)/2)=Ceil(RadioState(2)/2): ;parillinen, soitetaan normiviesti
												RadioCHN(2) = PlaySound_Strict(RadioSFX(2,Int(RadioState(2)/2)))
											else: ;pariton, soitetaan musiikkia
												RadioCHN(2) = PlaySound_Strict(RadioSFX(2,0))


									3
										ResumeChannel(RadioCHN(3))
										strtemp = "             EMERGENCY CHANNEL - RESERVED for COMMUNICATION IN THE EVENT OF A CONTAINMENT BREACH         "
										if ChannelPlaying(RadioCHN(3)) = false: RadioCHN(3) = PlaySound_Strict(RadioStatic)

										if MTFtimer > 0:
											RadioState(3)=RadioState(3)+Max(randi(-10,1),0)
											match RadioState(3)
												40
													if Not RadioState3(0):
														RadioCHN(3) = PlaySound_Strict(LoadTempSound("SFX\Character\MTF\Random1.ogg"))
														RadioState(3) = RadioState(3)+1
														RadioState3(0) = True

												400
													if Not RadioState3(1):
														RadioCHN(3) = PlaySound_Strict(LoadTempSound("SFX\Character\MTF\Random2.ogg"))
														RadioState(3) = RadioState(3)+1
														RadioState3(1) = True

												800
													if Not RadioState3(2):
														RadioCHN(3) = PlaySound_Strict(LoadTempSound("SFX\Character\MTF\Random3.ogg"))
														RadioState(3) = RadioState(3)+1
														RadioState3(2) = True

												1200
													if Not RadioState3(3):
														RadioCHN(3) = PlaySound_Strict(LoadTempSound("SFX\Character\MTF\Random4.ogg"))
														RadioState(3) = RadioState(3)+1
														RadioState3(3) = True

												1600
													if Not RadioState3(4):
														RadioCHN(3) = PlaySound_Strict(LoadTempSound("SFX\Character\MTF\Random5.ogg"))
														RadioState(3) = RadioState(3)+1
														RadioState3(4) = True

												2000
													if Not RadioState3(5):
														RadioCHN(3) = PlaySound_Strict(LoadTempSound("SFX\Character\MTF\Random6.ogg"))
														RadioState(3) = RadioState(3)+1
														RadioState3(5) = True

												2400
													if Not RadioState3(6):
														RadioCHN(3) = PlaySound_Strict(LoadTempSound("SFX\Character\MTF\Random7.ogg"))
														RadioState(3) = RadioState(3)+1
														RadioState3(6) = True



									4
										ResumeChannel(RadioCHN(6)) ;taustalle kohinaa
										if ChannelPlaying(RadioCHN(6)) = false: RadioCHN(6) = PlaySound_Strict(RadioStatic)

										ResumeChannel(RadioCHN(4))
										if ChannelPlaying(RadioCHN(4)) = false:
											if RemoteDoorOn = false And RadioState(8) = false:
												RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\radio\Chatter3.ogg"))
												RadioState(8) = True
											else:
												RadioState(4)=RadioState(4)+Max(randi(-10,1),0)

												match RadioState(4)
													10
														if (Not Contained106)
															if Not RadioState4(0):
																RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\radio\OhGod.ogg"))
																RadioState(4) = RadioState(4)+1
																RadioState4(0) = True


													100
														if Not RadioState4(1):
															RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\radio\Chatter2.ogg"))
															RadioState(4) = RadioState(4)+1
															RadioState4(1) = True

													158
														if MTFtimer = 0 And (Not RadioState4(2)):
															RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\radio\franklin1.ogg"))
															RadioState(4) = RadioState(4)+1
															RadioState(2) = True

													200
														if Not RadioState4(3):
															RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\radio\Chatter4.ogg"))
															RadioState(4) = RadioState(4)+1
															RadioState4(3) = True

													260
														if Not RadioState4(4):
															RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\SCP\035\RadioHelp1.ogg"))
															RadioState(4) = RadioState(4)+1
															RadioState4(4) = True

													300
														if Not RadioState4(5):
															RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\radio\Chatter1.ogg"))
															RadioState(4) = RadioState(4)+1
															RadioState4(5) = True

													350
														if Not RadioState4(6):
															RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\radio\franklin2.ogg"))
															RadioState(4) = RadioState(4)+1
															RadioState4(6) = True

													400
														if Not RadioState4(7):
															RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\SCP\035\RadioHelp2.ogg"))
															RadioState(4) = RadioState(4)+1
															RadioState4(7) = True

													450
														if Not RadioState4(8):
															RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\radio\franklin3.ogg"))
															RadioState(4) = RadioState(4)+1
															RadioState4(8) = True

													600
														if Not RadioState4(9):
															RadioCHN(4) = PlaySound_Strict(LoadTempSound("SFX\radio\franklin4.ogg"))
															RadioState(4) = RadioState(4)+1
															RadioState4(9) = True






									5
										ResumeChannel(RadioCHN(5))
										if ChannelPlaying(RadioCHN(5)) = false: RadioCHN(5) = PlaySound_Strict(RadioStatic)


								x=x+66
								y=y+419

								Color (30,30,30)

								if Selecteditem.state <= 100:
									;Text (x - 60, y - 20, "BATTERY")
									for i = 0 To 4
										Rect(x, y+8*i, 43 - i * 6, 4, Ceil(Selecteditem.state / 20.0) > 4 - i )



								AASetFont Font3
								AAText(x+60, y, "CHN")

								if Selecteditem.itemtemplate.tempname = "veryfineradio": ;"KOODIKANAVA"
									ResumeChannel(RadioCHN(0))
									if ChannelPlaying(RadioCHN(0)) = false: RadioCHN(0) = PlaySound_Strict(RadioStatic)

									;radiostate(7)=kuinka mones piippaus menossa
									;radiostate(8)=kuinka mones access coden numero menossa
									RadioState(6)=RadioState(6) + FPSfactor
									temp = Mid(Str(AccessCode),RadioState(8)+1,1)
									if RadioState(6)-FPSfactor =< RadioState(7)*50 And RadioState(6)>RadioState(7)*50:
										PlaySound_Strict(RadioBuzz)
										RadioState(7)=RadioState(7)+1
										if RadioState(7)=>temp:
											RadioState(7)=0
											RadioState(6)=-100
											RadioState(8)=RadioState(8)+1
											if RadioState(8)=4: RadioState(8)=0 : RadioState(6)=-200



									strtemp = ""
									for i = 0 To randi(5, 30)
										strtemp = strtemp + Chr(randi(1,100))


									AASetFont Font4
									AAText(x+97, y+16, randi(0,9),True,True)

								else:
									for i = 2 To 6
										if KeyHit(i):
											if Selecteditem.state2 != i-2: ;pausetetaan nykyinen radiokanava
												PlaySound_Strict RadioSquelch
												if RadioCHN(Int(Selecteditem.state2)) != 0: PauseChannel(RadioCHN(Int(Selecteditem.state2)))

											Selecteditem.state2 = i-2
											;jos nykyistä kanavaa ollaan soitettu, laitetaan jatketaan toistoa samasta kohdasta
											if RadioCHN(Selecteditem.state2)!=0: ResumeChannel(RadioCHN(Selecteditem.state2))



									AASetFont Font4
									AAText(x+97, y+16, Int(Selecteditem.state2+1),True,True)


								AASetFont Font3
								if strtemp != "":
									strtemp = Right(Left(strtemp, (Int(MilliSecs2()/300) Mod Len(strtemp))),10)
									AAText(x+32, y+33, strtemp)


								AASetFont Font1





					"cigarette"

						if CanUseItem(False,False,True)
							if Selecteditem.state = 0:
								match randi(6)
									1
										Msg = Chr(34)+"I don't have anything to light it with. Umm, what about that... Nevermind."+Chr(34)
									2
										Msg = "You are unable to get lit."
									3
										Msg = Chr(34)+"I quit that a long time ago."+Chr(34)
										RemoveItem(SelectedItem)
									4
										Msg = Chr(34)+"Even if I wanted one, I have nothing to light it with."+Chr(34)
									5
										Msg = Chr(34)+"Could really go for one now... Wish I had a lighter."+Chr(34)
									6
										Msg = Chr(34)+"Don't plan on starting, even at a time like this."+Chr(34)
										RemoveItem(SelectedItem)

								Selecteditem.state = 1
							else:
								Msg = "You are unable to get lit."


							MsgTimer = 70 * 5


					"420"

						if CanUseItem(False,False,True)
							if Wearing714=1:
								Msg = Chr(34) + "DUDE WTF THIS SHIT DOESN'T EVEN WORK" + Chr(34)
							else:
								Msg = Chr(34) + "MAN DATS SUM GOOD ASS SHIT" + Chr(34)
								Injuries = Max(Injuries-0.5, 0)
								BlurTimer = 500
								GiveAchievement(Achv420)
								PlaySound_Strict LoadTempSound("SFX\Music\420J.ogg")

							MsgTimer = 70 * 5
							RemoveItem(SelectedItem)


					"420s"

						if CanUseItem(False,False,True)
							if Wearing714=1:
								Msg = Chr(34) + "DUDE WTF THIS SHIT DOESN'T EVEN WORK" + Chr(34)
							else:
								DeathMSG = "Subject D-9341 found in a comatose state in [DATA REDACTED]. The subject was holding what appears to be a cigarette while smiling widely. "
								DeathMSG = DeathMSG+"Chemical analysis of the cigarette has been inconclusive, although it seems to contain a high concentration of an unidentified chemical "
								DeathMSG = DeathMSG+"whose molecular structure is remarkably similar to that of tetrahydrocannabinol."
								Msg = Chr(34) + "UH WHERE... WHAT WAS I DOING AGAIN... MAN I NEED TO TAKE A NAP..." + Chr(34)
								KillTimer = -1

							MsgTimer = 70 * 6
							RemoveItem(SelectedItem)


					"scp714"

						if Wearing714=1:
							Msg = "You removed the ring."
							Wearing714 = false
						else:
							GiveAchievement(Achv714)
							Msg = "You put on the ring."
							Wearing714 = True

						MsgTimer = 70 * 5
						SelectedItem = Null

					"hazmatsuit", "hazmatsuit2", "hazmatsuit3"

						if WearingVest = 0:
							CurrSpeed = CurveValue(0, CurrSpeed, 5.0)

							DrawImage(Selecteditem.itemtemplate.invimg, GraphicWidth / 2 - ImageWidth(Selecteditem.itemtemplate.invimg) / 2, GraphicHeight / 2 - ImageHeight(Selecteditem.itemtemplate.invimg) / 2)

							width: int = 300
							height: int = 20
							x: int = GraphicWidth / 2 - width / 2
							y: int = GraphicHeight / 2 + 80
							Rect(x, y, width+4, height, false)
							for  i: int = 1 To Int((width - 2) * (Selecteditem.state / 100.0) / 10)
								DrawImage(BlinkMeterIMG, x + 3 + 10 * (i - 1), y + 3)


							Selecteditem.state = Min(Selecteditem.state+(FPSfactor/4.0),100)

							if Selecteditem.state=100:
								if WearingHazmat>0:
									Msg = "You removed the hazmat suit."
									WearingHazmat = false
									DropItem(SelectedItem)
								else:
									if Selecteditem.itemtemplate.tempname="hazmatsuit":
										;Msg = "Hazmat1."
										WearingHazmat = 1
									elif Selecteditem.itemtemplate.tempname="hazmatsuit2":
										;Msg = "Hazmat2."
										WearingHazmat = 2
									else:
										;Msg = "Hazmat3."
										WearingHazmat = 3

									if Selecteditem.itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))
									Msg = "You put on the hazmat suit."
									if WearingNightVision: CameraFogFar = StoredCameraFogFar
									WearingGasMask = 0
									WearingNightVision = 0

								Selecteditem.state=0
								MsgTimer = 70 * 5
								SelectedItem = Null



					"vest","finevest"

						CurrSpeed = CurveValue(0, CurrSpeed, 5.0)

						DrawImage(Selecteditem.itemtemplate.invimg, GraphicWidth / 2 - ImageWidth(Selecteditem.itemtemplate.invimg) / 2, GraphicHeight / 2 - ImageHeight(Selecteditem.itemtemplate.invimg) / 2)

						width: int = 300
						height: int = 20
						x: int = GraphicWidth / 2 - width / 2
						y: int = GraphicHeight / 2 + 80
						Rect(x, y, width+4, height, false)
						for  i: int = 1 To Int((width - 2) * (Selecteditem.state / 100.0) / 10)
							DrawImage(BlinkMeterIMG, x + 3 + 10 * (i - 1), y + 3)


						Selecteditem.state = Min(Selecteditem.state+(FPSfactor/(2.0+(0.5*(Selecteditem.itemtemplate.tempname="finevest")))),100)

						if Selecteditem.state=100:
							if WearingVest>0:
								Msg = "You removed the vest."
								WearingVest = false
								DropItem(SelectedItem)
							else:
								if Selecteditem.itemtemplate.tempname="vest":
									Msg = "You put on the vest and feel slightly encumbered."
									WearingVest = 1
								else:
									Msg = "You put on the vest and feel heavily encumbered."
									WearingVest = 2

								if Selecteditem.itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))

							Selecteditem.state=0
							MsgTimer = 70 * 5
							SelectedItem = Null


					"gasmask", "supergasmask", "gasmask3"

						if Wearing1499 = 0 And WearingHazmat = 0:
							if WearingGasMask:
								Msg = "You removed the gas mask."
							else:
								if Selecteditem.itemtemplate.tempname = "supergasmask"
									Msg = "You put on the gas mask and you can breathe easier."
								else:
									Msg = "You put on the gas mask."

								if WearingNightVision: CameraFogFar = StoredCameraFogFar
								WearingNightVision = 0
								WearingGasMask = 0

							if Selecteditem.itemtemplate.tempname="gasmask3":
								if WearingGasMask = 0: WearingGasMask = 3 else: WearingGasMask=0
							elif Selecteditem.itemtemplate.tempname="supergasmask"
								if WearingGasMask = 0: WearingGasMask = 2 else: WearingGasMask=0
							else:
								WearingGasMask = (Not WearingGasMask)

						elif Wearing1499 > 0:
							Msg = "You need to take off SCP-1499 in order to put on the gas mask."
						else:
							Msg = "You need to take off the hazmat suit in order to put on the gas mask."

						SelectedItem = Null
						MsgTimer = 70 * 5

					"navigator", "nav"


						if Selecteditem.itemtemplate.img=0:
							Selecteditem.itemtemplate.img=LoadImage_Strict(Selecteditem.itemtemplate.imgpath)
							MaskImage(Selecteditem.itemtemplate.img, 255, 0, 255)


						if Selecteditem.state <= 100: Selecteditem.state = Max(0, Selecteditem.state - FPSfactor * 0.005)

						x = GraphicWidth - ImageWidth(Selecteditem.itemtemplate.img)*0.5+20
						y = GraphicHeight - ImageHeight(Selecteditem.itemtemplate.img)*0.4-85
						width = 287
						height = 256

						var PlayerX,PlayerZ

						DrawImage(Selecteditem.itemtemplate.img, x - ImageWidth(Selecteditem.itemtemplate.img) / 2, y - ImageHeight(Selecteditem.itemtemplate.img) / 2 + 85)

						AASetFont Font3

						var NavWorks: int = True
						if PlayerRoom\RoomTemplate.Name: String = "pocketdimension" Or PlayerRoom\RoomTemplate.Name: String = "dimension1499":
							NavWorks: int = false
						elif PlayerRoom\RoomTemplate.Name: String = "room860":
							for e.Events = Each Events
								if e.EventName = "room860":
									if e.EventState = 1.0:
										NavWorks: int = false

									break




						if (Not NavWorks):
							if (MilliSecs2() Mod 1000) > 300:
								Color(200, 0, 0)
								AAText(x, y + height / 2 - 80, "ERROR 06", True)
								AAText(x, y + height / 2 - 60, "LOCATION UNKNOWN", True)

						else:

							if Selecteditem.state > 0 And (randf(CoffinDistance + 15.0) > 1.0 Or PlayerRoom\RoomTemplate.Name != "coffin"):

								PlayerX: int = Floor((EntityX(PlayerRoom\obj)+8) / 8.0 + 0.5)
								PlayerZ: int = Floor((EntityZ(PlayerRoom\obj)+8) / 8.0 + 0.5)

								SetBuffer ImageBuffer(NavBG)
								var xx = x-ImageWidth(Selecteditem.itemtemplate.img)/2
								var yy = y-ImageHeight(Selecteditem.itemtemplate.img)/2+85
								DrawImage(Selecteditem.itemtemplate.img, xx, yy)

								x = x - 12 + (((EntityX(Collider)-4.0)+8.0) Mod 8.0)*3
								y = y + 12 - (((EntityZ(Collider)-4.0)+8.0) Mod 8.0)*3
								for x2 = Max(0, PlayerX - 6) To Min(MapWidth, PlayerX + 6)
									for z2 = Max(0, PlayerZ - 6) To Min(MapHeight, PlayerZ + 6)

										if CoffinDistance > 16.0 Or randf(16.0)<CoffinDistance:
											if MapTemp(x2, z2)>0 And (MapFound(x2, z2) > 0 Or Selecteditem.itemtemplate.name = "S-NAV 310 Navigator" Or Selecteditem.itemtemplate.name = "S-NAV Navigator Ultimate"):
												var drawx: int = x + (PlayerX - 1 - x2) * 24 , drawy: int = y - (PlayerZ - 1 - z2) * 24

												if x2+1<=MapWidth:
													if MapTemp(x2+1,z2)=False
														DrawImage NavImages(3),drawx-12,drawy-12

												else:
													DrawImage NavImages(3),drawx-12,drawy-12

												if x2-1>=0:
													if MapTemp(x2-1,z2)=False
														DrawImage NavImages(1),drawx-12,drawy-12

												else:
													DrawImage NavImages(1),drawx-12,drawy-12

												if z2-1>=0:
													if MapTemp(x2,z2-1)=False
														DrawImage NavImages(0),drawx-12,drawy-12

												else:
													DrawImage NavImages(0),drawx-12,drawy-12

												if z2+1<=MapHeight:
													if MapTemp(x2,z2+1)=False
														DrawImage NavImages(2),drawx-12,drawy-12

												else:
													DrawImage NavImages(2),drawx-12,drawy-12







								SetBuffer BackBuffer()
								DrawImageRect NavBG,xx+80,yy+70,xx+80,yy+70,270,230
								Color 30,30,30
								if Selecteditem.itemtemplate.name = "S-NAV Navigator": Color(100, 0, 0)
								Rect xx+80,yy+70,270,230,False

								x = GraphicWidth - ImageWidth(Selecteditem.itemtemplate.img)*0.5+20
								y = GraphicHeight - ImageHeight(Selecteditem.itemtemplate.img)*0.4-85

								if Selecteditem.itemtemplate.name = "S-NAV Navigator":
									Color(100, 0, 0)
								else:
									Color (30,30,30)

								if (MilliSecs2() Mod 1000) > 300:
									if Selecteditem.itemtemplate.name != "S-NAV 310 Navigator" And Selecteditem.itemtemplate.name != "S-NAV Navigator Ultimate":
										AAText(x - width/2 + 10, y - height/2 + 10, "MAP DATABASE OFFLINE")


									yawvalue = EntityYaw(Collider)-90
									x1 = x+Cos(yawvalue)*6 : y1 = y-Sin(yawvalue)*6
									x2 = x+Cos(yawvalue-140)*5 : y2 = y-Sin(yawvalue-140)*5
									x3 = x+Cos(yawvalue+140)*5 : y3 = y-Sin(yawvalue+140)*5

									Line x1,y1,x2,y2
									Line x1,y1,x3,y3
									Line x2,y2,x3,y3


								var SCPs_found: int = 0
								if Selecteditem.itemtemplate.name = "S-NAV Navigator Ultimate" And (MilliSecs2() Mod 600) < 400:
									if Curr173!=Null:
										var dist: float = EntityDistance(Camera, Curr173\obj)
										dist = Ceil(dist / 8.0) * 8.0
										if dist < 8.0 * 4:
											Color 100, 0, 0
											Oval(x - dist * 3, y - 7 - dist * 3, dist * 3 * 2, dist * 3 * 2, false)
											AAText(x - width / 2 + 10, y - height / 2 + 30, "SCP-173")
											SCPs_found: int = SCPs_found: int + 1


									if Curr106!=Null:
										dist: float = EntityDistance(Camera, Curr106\obj)
										if dist < 8.0 * 4:
											Color 100, 0, 0
											Oval(x - dist * 1.5, y - 7 - dist * 1.5, dist * 3, dist * 3, false)
											AAText(x - width / 2 + 10, y - height / 2 + 30 + (20*SCPs_found), "SCP-106")
											SCPs_found: int = SCPs_found: int + 1


									if Curr096!=Null:
										dist: float = EntityDistance(Camera, Curr096\obj)
										if dist < 8.0 * 4:
											Color 100, 0, 0
											Oval(x - dist * 1.5, y - 7 - dist * 1.5, dist * 3, dist * 3, false)
											AAText(x - width / 2 + 10, y - height / 2 + 30 + (20*SCPs_found), "SCP-096")
											SCPs_found: int = SCPs_found: int + 1


									for np.NPCs = Each NPCs
										if np\NPCtype = NPCtype049
											dist: float = EntityDistance(Camera, np\obj)
											if dist < 8.0 * 4:
												if (Not np\HideFromNVG):
													Color 100, 0, 0
													Oval(x - dist * 1.5, y - 7 - dist * 1.5, dist * 3, dist * 3, false)
													AAText(x - width / 2 + 10, y - height / 2 + 30 + (20*SCPs_found), "SCP-049")
													SCPs_found: int = SCPs_found: int + 1


											break


									if PlayerRoom\RoomTemplate.Name = "coffin":
										if CoffinDistance < 8.0:
											dist = randf(4.0, 8.0)
											Color 100, 0, 0
											Oval(x - dist * 1.5, y - 7 - dist * 1.5, dist * 3, dist * 3, false)
											AAText(x - width / 2 + 10, y - height / 2 + 30 + (20*SCPs_found), "SCP-895")




								Color (30,30,30)
								if Selecteditem.itemtemplate.name = "S-NAV Navigator": Color(100, 0, 0)
								if Selecteditem.state <= 100:
									;AAText (x - width/2 + 10, y - height/2 + 10, "BATTERY")
									;xtemp = x - width/2 + 10
									;ytemp = y - height/2 + 30
									;Line xtemp, ytemp, xtemp+20, ytemp
									;Line xtemp, ytemp+100, xtemp+20, ytemp+100
									;Line xtemp, ytemp, xtemp, ytemp+100
									;Line xtemp+20, ytemp, xtemp+20, ytemp+100
									;
									;AASetFont Font4
									;for i = 1 To Ceil(Selecteditem.state / 10.0)
									;	AAText (xtemp+11, ytemp+i*10-26, "-", True)
									;	;Rect(x - width/2, y+i*15, 40 - i * 6, 5, Ceil(Selecteditem.state / 20.0) > 4 - i)
									;
									;AASetFont Font3

									xtemp = x - width/2 + 196
									ytemp = y - height/2 + 10
									Rect xtemp,ytemp,80,20,False

									for i = 1 To Ceil(Selecteditem.state / 10.0)
										DrawImage NavImages(4),xtemp+i*8-6,ytemp+4


									AASetFont Font3





					;new Items in SCP:CB 1.3
					"scp1499","super1499"

						if WearingHazmat>0
							Msg = "You are not able to wear SCP-1499 and a hazmat suit at the same time."
							MsgTimer = 70 * 5
							SelectedItem=Null
							Return


						CurrSpeed = CurveValue(0, CurrSpeed, 5.0)

						DrawImage(Selecteditem.itemtemplate.invimg, GraphicWidth / 2 - ImageWidth(Selecteditem.itemtemplate.invimg) / 2, GraphicHeight / 2 - ImageHeight(Selecteditem.itemtemplate.invimg) / 2)

						width: int = 300
						height: int = 20
						x: int = GraphicWidth / 2 - width / 2
						y: int = GraphicHeight / 2 + 80
						Rect(x, y, width+4, height, false)
						for  i: int = 1 To Int((width - 2) * (Selecteditem.state / 100.0) / 10)
							DrawImage(BlinkMeterIMG, x + 3 + 10 * (i - 1), y + 3)


						Selecteditem.state = Min(Selecteditem.state+(FPSfactor),100)

						if Selecteditem.state=100:
							if Wearing1499>0:
								;Msg = "1499remove."
								Wearing1499 = false
								;DropItem(SelectedItem)
								if Selecteditem.itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))
							else:
								if Selecteditem.itemtemplate.tempname="scp1499":
									;Msg = "scp1499."
									Wearing1499 = 1
								else:
									;Msg = "super1499."
									Wearing1499 = 2

								if Selecteditem.itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))
								GiveAchievement(Achv1499)
								if WearingNightVision: CameraFogFar = StoredCameraFogFar
								WearingGasMask = 0
								WearingNightVision = 0
								for r.Rooms = Each Rooms
									if r\RoomTemplate.Name = "dimension1499":
										BlinkTimer = -1
										NTF_1499PrevRoom = PlayerRoom
										NTF_1499PrevX: float = EntityX(Collider)
										NTF_1499PrevY: float = EntityY(Collider)
										NTF_1499PrevZ: float = EntityZ(Collider)

										if NTF_1499X: float = 0.0 And NTF_1499Y: float = 0.0 And NTF_1499Z: float = 0.0:
											PositionEntity (Collider, r\x+6086.0*RoomScale, r\y+304.0*RoomScale, r\z+2292.5*RoomScale)
											RotateEntity Collider,0,90,0,True
										else:
											PositionEntity (Collider, NTF_1499X: float, NTF_1499Y: float+0.05, NTF_1499Z: float)

										ResetEntity(Collider)
										UpdateDoors()
										UpdateRooms()
										for it.Items = Each Items
											it\disttimer = 0

										PlayerRoom = r
										PlaySound_Strict (LoadTempSound("SFX\SCP\1499\Enter.ogg"))
										NTF_1499X: float = 0.0
										NTF_1499Y: float = 0.0
										NTF_1499Z: float = 0.0
										if Curr096!=Null:
											if Curr096\SoundChn!=0:
												SetStreamVolume_Strict(Curr096\SoundChn,0.0)


										for e.Events = Each Events
											if e.EventName = "dimension1499":
												if EntityDistance(e.room\obj,Collider)>8300.0*RoomScale:
													if e.EventState2 < 5:
														e.EventState2 = e.EventState2 + 1


												break


										break



							Selecteditem.state=0
							;MsgTimer = 70 * 5
							SelectedItem = Null


					"badge"

						if Selecteditem.itemtemplate.img=0:
							Selecteditem.itemtemplate.img=LoadImage_Strict(Selecteditem.itemtemplate.imgpath)
							;Selecteditem.itemtemplate.img = ResizeImage2(Selecteditem.itemtemplate.img, ImageWidth(Selecteditem.itemtemplate.img) * MenuScale, ImageHeight(Selecteditem.itemtemplate.img) * MenuScale)

							MaskImage(Selecteditem.itemtemplate.img, 255, 0, 255)


						DrawImage(Selecteditem.itemtemplate.img, GraphicWidth / 2 - ImageWidth(Selecteditem.itemtemplate.img) / 2, GraphicHeight / 2 - ImageHeight(Selecteditem.itemtemplate.img) / 2)

						if Selecteditem.state = 0:
							PlaySound_Strict LoadTempSound("SFX\SCP\1162\NostalgiaCancer"+randi(6,10)+".ogg")
							match Selecteditem.itemtemplate.name
								"Old Badge"
									Msg = Chr(34)+"Huh? This guy looks just like me!"+Chr(34)
									MsgTimer = 70*10


							Selecteditem.state = 1


					"key"

						if Selecteditem.state = 0:
							PlaySound_Strict LoadTempSound("SFX\SCP\1162\NostalgiaCancer"+randi(6,10)+".ogg")

							Msg = Chr(34)+"Isn't this the key to that old shack? The one where I... No, it can't be."+Chr(34)
							MsgTimer = 70*10


						Selecteditem.state = 1
						SelectedItem = Null

					"oldpaper"

						if Selecteditem.itemtemplate.img = 0:
							Selecteditem.itemtemplate.img = LoadImage_Strict(Selecteditem.itemtemplate.imgpath)
							Selecteditem.itemtemplate.img = ResizeImage2(Selecteditem.itemtemplate.img, ImageWidth(Selecteditem.itemtemplate.img) * MenuScale, ImageHeight(Selecteditem.itemtemplate.img) * MenuScale)

							MaskImage(Selecteditem.itemtemplate.img, 255, 0, 255)


						DrawImage(Selecteditem.itemtemplate.img, GraphicWidth / 2 - ImageWidth(Selecteditem.itemtemplate.img) / 2, GraphicHeight / 2 - ImageHeight(Selecteditem.itemtemplate.img) / 2)

						if Selecteditem.state = 0
							match Selecteditem.itemtemplate.name
								"Disciplinary Hearing DH-S-4137-17092"
									BlurTimer = 1000

									Msg = Chr(34)+"Why does this seem so familiar?"+Chr(34)
									MsgTimer = 70*10
									PlaySound_Strict LoadTempSound("SFX\SCP\1162\NostalgiaCancer"+randi(6,10)+".ogg")
									Selecteditem.state = 1



					"coin"

						if Selecteditem.state = 0
							PlaySound_Strict LoadTempSound("SFX\SCP\1162\NostalgiaCancer"+randi(1,5)+".ogg")


						Msg = ""

						Selecteditem.state = 1
						DrawImage(Selecteditem.itemtemplate.invimg, GraphicWidth / 2 - ImageWidth(Selecteditem.itemtemplate.invimg) / 2, GraphicHeight / 2 - ImageHeight(Selecteditem.itemtemplate.invimg) / 2)

					"scp427"

						if I_427\Using=1:
							Msg = "You closed the locket."
							I_427\Using = false
						else:
							GiveAchievement(Achv427)
							Msg = "You opened the locket."
							I_427\Using = True

						MsgTimer = 70 * 5
						SelectedItem = Null

					"pill"

						if CanUseItem(False, false, True)
							Msg = "You swallowed the pill."
							MsgTimer = 70*7

							RemoveItem(SelectedItem)
							SelectedItem = Null


					"scp500death"

						if CanUseItem(False, false, True)
							Msg = "You swallowed the pill."
							MsgTimer = 70*7

							if I_427\Timer < 70*360:
								I_427\Timer = 70*360


							RemoveItem(SelectedItem)
							SelectedItem = Null


					_:

						;check if the item is an inventory-type object
						if Selecteditem.invSlots>0:
							DoubleClick = 0
							MouseHit1 = 0
							MouseDown1 = 0
							LastMouseHit1 = 0
							OtherOpen = SelectedItem
							SelectedItem = Null





				if SelectedItem != Null:
					if Selecteditem.itemtemplate.img != 0
						var IN: String = Selecteditem.itemtemplate.tempname
						if IN: String = "paper" Or IN: String = "badge" Or IN: String = "oldpaper" Or IN: String = "ticket":
							for a_it.Items = Each Items
								if a_it != SelectedItem
									var IN2: String = a_it\itemtemplate.tempname
									if IN2: String = "paper" Or IN2: String = "badge" Or IN2: String = "oldpaper" Or IN2: String = "ticket":
										if a_it\itemtemplate.img!=0
											if a_it\itemtemplate.img != Selecteditem.itemtemplate.img
												FreeImage(a_it\itemtemplate.img)
												a_it\itemtemplate.img = 0









				if MouseHit2:
					EntityAlpha Dark, 0.0

					IN: String = Selecteditem.itemtemplate.tempname
					if IN: String = "scp1025":
						if Selecteditem.itemtemplate.img!=0: FreeImage(Selecteditem.itemtemplate.img)
						Selecteditem.itemtemplate.img=0
					elif IN: String = "firstaid" Or IN: String="finefirstaid" Or IN: String="firstaid2":
						Selecteditem.state = 0
					elif IN: String = "vest" Or IN: String="finevest"
						Selecteditem.state = 0
						if (Not WearingVest)
							DropItem(SelectedItem,False)

					elif IN: String="hazmatsuit" Or IN: String="hazmatsuit2" Or IN: String="hazmatsuit3"
						Selecteditem.state = 0
						if (Not WearingHazmat)
							DropItem(SelectedItem,False)

					elif IN: String="scp1499" Or IN: String="super1499"
						Selecteditem.state = 0
						;if (Not Wearing1499)
						;	DropItem(SelectedItem,False)
						;


					if Selecteditem.itemtemplate.sound != 66: PlaySound_Strict(PickSFX(Selecteditem.itemtemplate.sound))
					SelectedItem = Null




		if SelectedItem = Null:
			for i = 0 To 6
				if RadioCHN(i) != 0:
					if ChannelPlaying(RadioCHN(i)): PauseChannel(RadioCHN(i))




		for it.Items = Each Items
			if it!=SelectedItem
				match it\itemtemplate.tempname
					"firstaid","finefirstaid","firstaid2","vest","finevest","hazmatsuit","hazmatsuit2","hazmatsuit3","scp1499","super1499"
						it\state = 0




		if PrevInvOpen And (Not InvOpen): MoveMouse viewport_center_x, viewport_center_y

		CatchErrors("DrawGUI")
	

	func DrawMenu()
		CatchErrors("Uncaught (DrawMenu)")

		var x: int, y: int, width: int, height: int
		if api_GetFocus() = 0: ;Game is out of focus -> pause the game
			if (Not Using294):
				MenuOpen = True
				PauseSounds()

			Delay 1000 ;Reduce the CPU take while game is not in focus

		if MenuOpen:

			;DebugLog AchievementsMenu+"|"+OptionsMenu+"|"+QuitMSG

			if PlayerRoom\RoomTemplate.Name: String != "break1" And PlayerRoom\RoomTemplate.Name: String != "gatea"
				if StopHidingTimer = 0:
					if EntityDistance(Curr173\Collider, Collider)<4.0 Or EntityDistance(Curr106\Collider, Collider)<4.0:
						StopHidingTimer = 1

				elif StopHidingTimer < 40
					if KillTimer >= 0:
						StopHidingTimer = StopHidingTimer+FPSfactor

						if StopHidingTimer => 40:
							PlaySound_Strict(HorrorSFX(15))
							Msg = "STOP HIDING"
							MsgTimer = 6*70
							MenuOpen = false
							Return





			InvOpen = false

			width = ImageWidth(PauseMenuIMG)
			height = ImageHeight(PauseMenuIMG)
			x = GraphicWidth / 2 - width / 2
			y = GraphicHeight / 2 - height / 2

			DrawImage PauseMenuIMG, x, y

			Color(255, 255, 255)

			x = x+132*MenuScale
			y = y+122*MenuScale

			if (Not MouseDown1)
				OnSliderID = 0


			if AchievementsMenu > 0:
				AASetFont Font2
				AAText(x, y-(122-45)*MenuScale, "ACHIEVEMENTS",False,True)
				AASetFont Font1
			elif OptionsMenu > 0:
				AASetFont Font2
				AAText(x, y-(122-45)*MenuScale, "OPTIONS",False,True)
				AASetFont Font1
			elif QuitMSG > 0:
				AASetFont Font2
				AAText(x, y-(122-45)*MenuScale, "QUIT?",False,True)
				AASetFont Font1
			elif KillTimer >= 0:
				AASetFont Font2
				AAText(x, y-(122-45)*MenuScale, "PAUSED",False,True)
				AASetFont Font1
			else:
				AASetFont Font2
				AAText(x, y-(122-45)*MenuScale, "YOU DIED",False,True)
				AASetFont Font1


			var AchvXIMG: int = (x + (22*MenuScale))
			var scale: float = GraphicHeight/768.0
			var SeparationConst: int = 76*scale
			var imgsize: int = 64

			if AchievementsMenu <= 0 And OptionsMenu <= 0 And QuitMSG <= 0
				AASetFont Font1
				AAText x, y, "Difficulty: "+SelectedDifficulty\name
				AAText x, y+20*MenuScale, "Save: "+CurrSave
				AAText x, y+40*MenuScale, "Map seed: "+RandomSeed
			elif AchievementsMenu <= 0 And OptionsMenu > 0 And QuitMSG <= 0 And KillTimer >= 0
				if DrawButton(x + 101 * MenuScale, y + 390 * MenuScale, 230 * MenuScale, 60 * MenuScale, "Back"):
					AchievementsMenu = 0
					OptionsMenu = 0
					QuitMSG = 0
					MouseHit1 = false
					SaveOptionsINI()

					AntiAlias Opt_AntiAlias
					TextureLodBias TextureFloat: float


				Color 0,255,0
				if OptionsMenu = 1
					Rect(x-10*MenuScale,y-5*MenuScale,110*MenuScale,40*MenuScale,True)
				elif OptionsMenu = 2
					Rect(x+100*MenuScale,y-5*MenuScale,110*MenuScale,40*MenuScale,True)
				elif OptionsMenu = 3
					Rect(x+210*MenuScale,y-5*MenuScale,110*MenuScale,40*MenuScale,True)
				elif OptionsMenu = 4
					Rect(x+320*MenuScale,y-5*MenuScale,110*MenuScale,40*MenuScale,True)


				if DrawButton(x-5*MenuScale,y,100*MenuScale,30*MenuScale,"GRAPHICS",False): OptionsMenu = 1
				if DrawButton(x+105*MenuScale,y,100*MenuScale,30*MenuScale,"AUDIO",False): OptionsMenu = 2
				if DrawButton(x+215*MenuScale,y,100*MenuScale,30*MenuScale,"CONTROLS",False): OptionsMenu = 3
				if DrawButton(x+325*MenuScale,y,100*MenuScale,30*MenuScale,"ADVANCED",False): OptionsMenu = 4

				var tx: float = (GraphicWidth/2)+(width/2)
				var ty: float = y
				var tw: float = 400*MenuScale
				var th: float = 150*MenuScale

				Color 255,255,255
				match OptionsMenu
					1 ;Graphics
						AASetFont Font1

						y=y+50*MenuScale

						Color 100,100,100
						AAText(x, y, "Enable bump mapping:")
						BumpEnabled = DrawTick(x + 270 * MenuScale, y + MenuScale, BumpEnabled, True)
						if MouseOn(x + 270 * MenuScale, y + MenuScale, 20*MenuScale,20*MenuScale) And OnSliderID=0
							DrawOptionsTooltip(tx,ty,tw,th,"bump")


						y=y+30*MenuScale

						Color 255,255,255
						AAText(x, y, "VSync:")
						Vsync: int = DrawTick(x + 270 * MenuScale, y + MenuScale, Vsync: int)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale) And OnSliderID=0
							DrawOptionsTooltip(tx,ty,tw,th,"vsync")


						y=y+30*MenuScale

						Color 255,255,255
						AAText(x, y, "Anti-aliasing:")
						Opt_AntiAlias = DrawTick(x + 270 * MenuScale, y + MenuScale, Opt_AntiAlias: int)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale) And OnSliderID=0
							DrawOptionsTooltip(tx,ty,tw,th,"antialias")


						y=y+30*MenuScale

						Color 255,255,255
						AAText(x, y, "Enable room lights:")
						EnableRoomLights = DrawTick(x + 270 * MenuScale, y + MenuScale, EnableRoomLights)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale) And OnSliderID=0
							DrawOptionsTooltip(tx,ty,tw,th,"roomlights")


						y=y+30*MenuScale

						ScreenGamma = (SlideBar(x + 270*MenuScale, y+6*MenuScale, 100*MenuScale, ScreenGamma*50.0)/50.0)
						Color 255,255,255
						AAText(x, y, "Screen gamma")
						if MouseOn(x+270*MenuScale,y+6*MenuScale,100*MenuScale+14,20) And OnSliderID=0
							DrawOptionsTooltip(tx,ty,tw,th,"gamma",ScreenGamma)


						;y = y + 50*MenuScale

						y=y+50*MenuScale

						Color 255,255,255
						AAText(x, y, "Particle amount:")
						ParticleAmount = Slider3(x+270*MenuScale,y+6*MenuScale,100*MenuScale,ParticleAmount,2,"MINIMAL","REDUCED","FULL")
						if (MouseOn(x + 270 * MenuScale, y-6*MenuScale, 100*MenuScale+14, 20) And OnSliderID=0) Or OnSliderID=2
							DrawOptionsTooltip(tx,ty,tw,th,"particleamount",ParticleAmount)


						y=y+50*MenuScale

						Color 255,255,255
						AAText(x, y, "Texture LOD Bias:")
						TextureDetails = Slider5(x+270*MenuScale,y+6*MenuScale,100*MenuScale,TextureDetails,3,"0.8","0.4","0.0","-0.4","-0.8")
						match TextureDetails: int
							0
								TextureFloat: float = 0.8
							1
								TextureFloat: float = 0.4
							2
								TextureFloat: float = 0.0
							3
								TextureFloat: float = -0.4
							4
								TextureFloat: float = -0.8

						TextureLodBias TextureFloat
						if (MouseOn(x+270*MenuScale,y-6*MenuScale,100*MenuScale+14,20) And OnSliderID=0) Or OnSliderID=3
							DrawOptionsTooltip(tx,ty,tw,th+100*MenuScale,"texquality")


						y=y+50*MenuScale
						Color 100,100,100
						AAText(x, y, "Save textures in the VRAM:")
						EnableVRam = DrawTick(x + 270 * MenuScale, y + MenuScale, EnableVRam, True)
						if MouseOn(x + 270 * MenuScale, y + MenuScale, 20*MenuScale,20*MenuScale) And OnSliderID=0
							DrawOptionsTooltip(tx,ty,tw,th,"vram")



					2 ;Audio
						AASetFont Font1

						y = y + 50*MenuScale

						MusicVolume = (SlideBar(x + 250*MenuScale, y-4*MenuScale, 100*MenuScale, MusicVolume*100.0)/100.0)
						Color 255,255,255
						AAText(x, y, "Music volume:")
						if MouseOn(x+250*MenuScale,y-4*MenuScale,100*MenuScale+14,20)
							DrawOptionsTooltip(tx,ty,tw,th,"musicvol",MusicVolume)


						y = y + 30*MenuScale

						PrevSFXVolume = (SlideBar(x + 250*MenuScale, y-4*MenuScale, 100*MenuScale, SFXVolume*100.0)/100.0)
						if (Not DeafPlayer): SFXVolume: float = PrevSFXVolume: float
						Color 255,255,255
						AAText(x, y, "Sound volume:")
						if MouseOn(x+250*MenuScale,y-4*MenuScale,100*MenuScale+14,20)
							DrawOptionsTooltip(tx,ty,tw,th,"soundvol",PrevSFXVolume)


						y = y + 30*MenuScale

						Color 100,100,100
						AAText x, y, "Sound auto-release:"
						EnableSFXRelease = DrawTick(x + 270 * MenuScale, y + MenuScale, EnableSFXRelease,True)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th+220*MenuScale,"sfxautorelease")


						y = y + 30*MenuScale

						Color 100,100,100
						AAText x, y, "Enable user tracks:"
						EnableUserTracks = DrawTick(x + 270 * MenuScale, y + MenuScale, EnableUserTracks,True)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th,"usertrack")


						if EnableUserTracks
							y = y + 30 * MenuScale
							Color 255,255,255
							AAText x, y, "User track mode:"
							UserTrackMode = DrawTick(x + 270 * MenuScale, y + MenuScale, UserTrackMode)
							if UserTrackMode
								AAText x, y + 20 * MenuScale, "Repeat"
							else:
								AAText x, y + 20 * MenuScale, "Random"

							if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
								DrawOptionsTooltip(tx,ty,tw,th,"usertrackmode")

							;DrawButton(x, y + 30 * MenuScale, 190 * MenuScale, 25 * MenuScale, "Scan for User Tracks",False)
							;if MouseOn(x,y+30*MenuScale,190*MenuScale,25*MenuScale)
							;	DrawOptionsTooltip(tx,ty,tw,th,"usertrackscan")
							;


					3 ;Controls
						AASetFont Font1

						y = y + 50*MenuScale

						MouseSens = (SlideBar(x + 270*MenuScale, y-4*MenuScale, 100*MenuScale, (MouseSens+0.5)*100.0)/100.0)-0.5
						Color(255, 255, 255)
						AAText(x, y, "Mouse sensitivity:")
						if MouseOn(x+270*MenuScale,y-4*MenuScale,100*MenuScale+14,20)
							DrawOptionsTooltip(tx,ty,tw,th,"mousesensitivity",MouseSens)


						y = y + 30*MenuScale

						Color(255, 255, 255)
						AAText(x, y, "Invert mouse Y-axis:")
						InvertMouse = DrawTick(x + 270 * MenuScale, y + MenuScale, InvertMouse)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th,"mouseinvert")


						y = y + 40*MenuScale

						MouseSmooth = (SlideBar(x + 270*MenuScale, y-4*MenuScale, 100*MenuScale, (MouseSmooth)*50.0)/50.0)
						Color(255, 255, 255)
						AAText(x, y, "Mouse smoothing:")
						if MouseOn(x+270*MenuScale,y-4*MenuScale,100*MenuScale+14,20)
							DrawOptionsTooltip(tx,ty,tw,th,"mousesmoothing",MouseSmooth)


						Color(255, 255, 255)

						y = y + 30*MenuScale
						AAText(x, y, "Control configuration:")
						y = y + 10*MenuScale

						AAText(x, y + 20 * MenuScale, "Move Forward")
						InputBox(x + 200 * MenuScale, y + 20 * MenuScale,100*MenuScale,20*MenuScale,KeyName(Min(KEY_UP,210)),5)
						AAText(x, y + 40 * MenuScale, "Strafe Left")
						InputBox(x + 200 * MenuScale, y + 40 * MenuScale,100*MenuScale,20*MenuScale,KeyName(Min(KEY_LEFT,210)),3)
						AAText(x, y + 60 * MenuScale, "Move Backward")
						InputBox(x + 200 * MenuScale, y + 60 * MenuScale,100*MenuScale,20*MenuScale,KeyName(Min(KEY_DOWN,210)),6)
						AAText(x, y + 80 * MenuScale, "Strafe Right")
						InputBox(x + 200 * MenuScale, y + 80 * MenuScale,100*MenuScale,20*MenuScale,KeyName(Min(KEY_RIGHT,210)),4)

						AAText(x, y + 100 * MenuScale, "Manual Blink")
						InputBox(x + 200 * MenuScale, y + 100 * MenuScale,100*MenuScale,20*MenuScale,KeyName(Min(KEY_BLINK,210)),7)
						AAText(x, y + 120 * MenuScale, "Sprint")
						InputBox(x + 200 * MenuScale, y + 120 * MenuScale,100*MenuScale,20*MenuScale,KeyName(Min(KEY_SPRINT,210)),8)
						AAText(x, y + 140 * MenuScale, "Open/Close Inventory")
						InputBox(x + 200 * MenuScale, y + 140 * MenuScale,100*MenuScale,20*MenuScale,KeyName(Min(KEY_INV,210)),9)
						AAText(x, y + 160 * MenuScale, "Crouch")
						InputBox(x + 200 * MenuScale, y + 160 * MenuScale,100*MenuScale,20*MenuScale,KeyName(Min(KEY_CROUCH,210)),10)
						AAText(x, y + 180 * MenuScale, "Quick Save")
						InputBox(x + 200 * MenuScale, y + 180 * MenuScale,100*MenuScale,20*MenuScale,KeyName(Min(KEY_SAVE,210)),11)
						AAText(x, y + 200 * MenuScale, "Open/Close Console")
						InputBox(x + 200 * MenuScale, y + 200 * MenuScale,100*MenuScale,20*MenuScale,KeyName(Min(KEY_CONSOLE,210)),12)

						if MouseOn(x,y,300*MenuScale,220*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th,"controls")


						for i = 0 To 227
							if KeyHit(i): key = i : break

						if key != 0:
							match SelectedInputBox
								3
									KEY_LEFT = key
								4
									KEY_RIGHT = key
								5
									KEY_UP = key
								6
									KEY_DOWN = key
								7
									KEY_BLINK = key
								8
									KEY_SPRINT = key
								9
									KEY_INV = key
								10
									KEY_CROUCH = key
								11
									KEY_SAVE = key
								12
									KEY_CONSOLE = key

							SelectedInputBox = 0


					4 ;Advanced
						AASetFont Font1

						y = y + 50*MenuScale

						Color 255,255,255
						AAText(x, y, "Show HUD:")
						HUDenabled = DrawTick(x + 270 * MenuScale, y + MenuScale, HUDenabled)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th,"hud")


						y = y + 30*MenuScale

						Color 255,255,255
						AAText(x, y, "Enable console:")
						CanOpenConsole = DrawTick(x +270 * MenuScale, y + MenuScale, CanOpenConsole)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th,"consoleenable")


						y = y + 30*MenuScale

						Color 255,255,255
						AAText(x, y, "Open console on error:")
						ConsoleOpening = DrawTick(x + 270 * MenuScale, y + MenuScale, ConsoleOpening)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th,"consoleerror")


						y = y + 50*MenuScale

						Color 255,255,255
						AAText(x, y, "Achievement popups:")
						AchvMSGenabled: int = DrawTick(x + 270 * MenuScale, y, AchvMSGenabled: int)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th,"achpopup")


						y = y + 50*MenuScale

						Color 255,255,255
						AAText(x, y, "Show FPS:")
						ShowFPS: int = DrawTick(x + 270 * MenuScale, y, ShowFPS: int)
						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th,"showfps")


						y = y + 30*MenuScale

						Color 255,255,255
						AAText(x, y, "Framelimit:")

						Color 255,255,255
						if DrawTick(x + 270 * MenuScale, y, CurrFrameLimit > 0.0):
							;CurrFrameLimit: float = (SlideBar(x + 150*MenuScale, y+30*MenuScale, 100*MenuScale, CurrFrameLimit: float*50.0)/50.0)
							;CurrFrameLimit = Max(CurrFrameLimit, 0.1)
							;Framelimit: int = CurrFrameLimit: float*100.0
							CurrFrameLimit: float = (SlideBar(x + 150*MenuScale, y+30*MenuScale, 100*MenuScale, CurrFrameLimit: float*99.0)/99.0)
							CurrFrameLimit: float = Max(CurrFrameLimit, 0.01)
							Framelimit: int = 19+(CurrFrameLimit*100.0)
							Color 255,255,0
							AAText(x + 5 * MenuScale, y + 25 * MenuScale, Framelimit: int+" FPS")
						else:
							CurrFrameLimit: float = 0.0
							Framelimit = 0

						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th,"framelimit",Framelimit)

						if MouseOn(x+150*MenuScale,y+30*MenuScale,100*MenuScale+14,20)
							DrawOptionsTooltip(tx,ty,tw,th,"framelimit",Framelimit)


						y = y + 80*MenuScale

						Color 255,255,255
						AAText(x, y, "Antialiased text:")
						AATextEnable: int = DrawTick(x + 270 * MenuScale, y + MenuScale, AATextEnable: int)
						if AATextEnable_Prev: int != AATextEnable
							for font.AAFont = Each AAFont
								FreeFont font\lowResFont: int
								if (Not AATextEnable)
									FreeTexture font\texture
									FreeImage font\backup

								Delete font

							if (Not AATextEnable):
								FreeEntity AATextCam
								;for i: int=0 To 149
								;	FreeEntity AATextSprite[i]
								;

							InitAAFont()
							Font1: int = AALoadFont("GFX\font\cour\Courier New.ttf", Int(18 * (GraphicHeight / 1024.0)), 0,0,0)
							Font2: int = AALoadFont("GFX\font\courbd.Courier New.ttf", Int(58 * (GraphicHeight / 1024.0)), 0,0,0)
							Font3: int = AALoadFont("GFX\font\DS-DIGI\DS-Digital.ttf", Int(22 * (GraphicHeight / 1024.0)), 0,0,0)
							Font4: int = AALoadFont("GFX\font\DS-DIGI\DS-Digital.ttf", Int(60 * (GraphicHeight / 1024.0)), 0,0,0)
							Font5: int = AALoadFont("GFX\font\Journal\Journal.ttf", Int(58 * (GraphicHeight / 1024.0)), 0,0,0)
							ConsoleFont: int = AALoadFont("Blitz", Int(22 * (GraphicHeight / 1024.0)), 0,0,0,1)
							;ReloadAAFont()
							AATextEnable_Prev: int = AATextEnable

						if MouseOn(x+270*MenuScale,y+MenuScale,20*MenuScale,20*MenuScale)
							DrawOptionsTooltip(tx,ty,tw,th,"antialiastext")



			elif AchievementsMenu <= 0 And OptionsMenu <= 0 And QuitMSG > 0 And KillTimer >= 0
				var QuitButton: int = 60
				if SelectedDifficulty\saveType = SAVEONQUIT Or SelectedDifficulty\saveType = SAVEANYWHERE:
					var RN: String = PlayerRoom\RoomTemplate.Name: String
					var AbleToSave: int = True
					if RN: String = "173" Or RN: String = "break1" Or RN: String = "gatea": AbleToSave = false
					if (Not CanSave): AbleToSave = false
					if AbleToSave
						QuitButton = 140
						if DrawButton(x, y + 60*MenuScale, 390*MenuScale, 60*MenuScale, "Save & Quit"):
							DropSpeed = 0
							SaveGame(SavePath + CurrSave + "\\")
							NullGame()
							MenuOpen = false
							MainMenuOpen = True
							MainMenuTab = 0
							CurrSave = ""
							FlushKeys()




				if DrawButton(x, y + QuitButton*MenuScale, 390*MenuScale, 60*MenuScale, "Quit"):
					NullGame()
					MenuOpen = false
					MainMenuOpen = True
					MainMenuTab = 0
					CurrSave = ""
					FlushKeys()


				if DrawButton(x+101*MenuScale, y + 344*MenuScale, 230*MenuScale, 60*MenuScale, "Back"):
					AchievementsMenu = 0
					OptionsMenu = 0
					QuitMSG = 0
					MouseHit1 = false

			else:
				if DrawButton(x+101*MenuScale, y + 344*MenuScale, 230*MenuScale, 60*MenuScale, "Back"):
					AchievementsMenu = 0
					OptionsMenu = 0
					QuitMSG = 0
					MouseHit1 = false


				if AchievementsMenu>0:
					;DebugLog AchievementsMenu
					if AchievementsMenu <= Floor(Float(MAXACHIEVEMENTS-1)/12.0):
						if DrawButton(x+341*MenuScale, y + 344*MenuScale, 50*MenuScale, 60*MenuScale, ">"):
							AchievementsMenu = AchievementsMenu+1


					if AchievementsMenu > 1:
						if DrawButton(x+41*MenuScale, y + 344*MenuScale, 50*MenuScale, 60*MenuScale, "<"):
							AchievementsMenu = AchievementsMenu-1



					for i=0 To 11
						if i+((AchievementsMenu-1)*12)<MAXACHIEVEMENTS:
							DrawAchvIMG(AchvXIMG,y+((i/4)*120*MenuScale),i+((AchievementsMenu-1)*12))
						else:
							break



					for i=0 To 11
						if i+((AchievementsMenu-1)*12)<MAXACHIEVEMENTS:
							if MouseOn(AchvXIMG+((i Mod 4)*SeparationConst),y+((i/4)*120*MenuScale),64*scale,64*scale):
								AchievementTooltip(i+((AchievementsMenu-1)*12))
								break

						else:
							break






			y = y+10

			if AchievementsMenu<=0 And OptionsMenu<=0 And QuitMSG<=0:
				if KillTimer >= 0:

					y = y+ 72*MenuScale

					if DrawButton(x, y, 390*MenuScale, 60*MenuScale, "Resume", True, True):
						MenuOpen = false
						ResumeSounds()
						MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0


					y = y + 75*MenuScale
					if (Not SelectedDifficulty\permaDeath):
						if GameSaved:
							if DrawButton(x, y, 390*MenuScale, 60*MenuScale, "Load Game"):
								DrawLoading(0)

								MenuOpen = false
								LoadGameQuick(SavePath + CurrSave + "\\")

								MoveMouse (viewport_center_x,viewport_center_y)
								AASetFont (Font1)
								HidePointer ()

								FlushKeys()
								FlushMouse()
								Playable=True

								UpdateRooms()

								for r.Rooms = Each Rooms
									x = Abs(EntityX(Collider) - EntityX(r\obj))
									z = Abs(EntityZ(Collider) - EntityZ(r\obj))

									if x < 12.0 And z < 12.0:
										MapFound(Floor(EntityX(r\obj) / 8.0), Floor(EntityZ(r\obj) / 8.0)) = Max(MapFound(Floor(EntityX(r\obj) / 8.0), Floor(EntityZ(r\obj) / 8.0)), 1)
										if x < 4.0 And z < 4.0:
											if Abs(EntityY(Collider) - EntityY(r\obj)) < 1.5: PlayerRoom = r
											MapFound(Floor(EntityX(r\obj) / 8.0), Floor(EntityZ(r\obj) / 8.0)) = 1




								DrawLoading(100)

								DropSpeed=0

								UpdateWorld 0.0

								PrevTime = MilliSecs()
								FPSfactor = 0

								ResetInput()

						else:
							DrawFrame(x,y,390*MenuScale, 60*MenuScale)
							Color (100, 100, 100)
							AASetFont Font2
							AAText(x + (390*MenuScale) / 2, y + (60*MenuScale) / 2, "Load Game", True, True)

						y = y + 75*MenuScale


					if DrawButton(x, y, 390*MenuScale, 60*MenuScale, "Achievements"): AchievementsMenu = 1
					y = y + 75*MenuScale
					if DrawButton(x, y, 390*MenuScale, 60*MenuScale, "Options"): OptionsMenu = 1
					y = y + 75*MenuScale
				else:
					y = y+104*MenuScale
					if GameSaved And (Not SelectedDifficulty\permaDeath):
						if DrawButton(x, y, 390*MenuScale, 60*MenuScale, "Load Game"):
							DrawLoading(0)

							MenuOpen = false
							LoadGameQuick(SavePath + CurrSave + "\\")

							MoveMouse (viewport_center_x,viewport_center_y)
							AASetFont (Font1)
							HidePointer ()

							FlushKeys()
							FlushMouse()
							Playable=True

							UpdateRooms()

							for r.Rooms = Each Rooms
								x = Abs(EntityX(Collider) - EntityX(r\obj))
								z = Abs(EntityZ(Collider) - EntityZ(r\obj))

								if x < 12.0 And z < 12.0:
									MapFound(Floor(EntityX(r\obj) / 8.0), Floor(EntityZ(r\obj) / 8.0)) = Max(MapFound(Floor(EntityX(r\obj) / 8.0), Floor(EntityZ(r\obj) / 8.0)), 1)
									if x < 4.0 And z < 4.0:
										if Abs(EntityY(Collider) - EntityY(r\obj)) < 1.5: PlayerRoom = r
										MapFound(Floor(EntityX(r\obj) / 8.0), Floor(EntityZ(r\obj) / 8.0)) = 1




							DrawLoading(100)

							DropSpeed=0

							UpdateWorld 0.0

							PrevTime = MilliSecs()
							FPSfactor = 0

							ResetInput()

					else:
						DrawButton(x, y, 390*MenuScale, 60*MenuScale, "")
						Color 50,50,50
						AAText(x + 185*MenuScale, y + 30*MenuScale, "Load Game", True, True)

					if DrawButton(x, y + 80*MenuScale, 390*MenuScale, 60*MenuScale, "Quit to Menu"):
						NullGame()
						MenuOpen = false
						MainMenuOpen = True
						MainMenuTab = 0
						CurrSave = ""
						FlushKeys()

					y= y + 80*MenuScale


				if KillTimer >= 0 And (Not MainMenuOpen)
					if DrawButton(x, y, 390*MenuScale, 60*MenuScale, "Quit"):
						QuitMSG = 1



				AASetFont Font1
				if KillTimer < 0: RowText(DeathMSG: String, x, y + 80*MenuScale, 390*MenuScale, 600*MenuScale)


			if Fullscreen: DrawImage CursorIMG, ScaledMouseX(),ScaledMouseY()



		AASetFont Font1

		CatchErrors("DrawMenu")
	

	func MouseOn: int(x: int, y: int, width: int, height: int)
		if ScaledMouseX() > x And ScaledMouseX() < x + width:
			if ScaledMouseY() > y And ScaledMouseY() < y + height:
				return True


		return false
	

	;----------------------------------------------------------------------------------------------

	Include "LoadAllSounds.bb"
	func LoadEntities()
		CatchErrors("Uncaught (LoadEntities)")
		DrawLoading(0)

		var i: int

		for i=0 To 9
			TempSounds[i]=0


		PauseMenuIMG: int = LoadImage_Strict("GFX\menu\pausemenu.jpg")
		MaskImage PauseMenuIMG, 255,255,0
		ScaleImage PauseMenuIMG,MenuScale,MenuScale

		SprintIcon: int = LoadImage_Strict("GFX\sprinticon.png")
		BlinkIcon: int = LoadImage_Strict("GFX\blinkicon.png")
		CrouchIcon: int = LoadImage_Strict("GFX\sneakicon.png")
		HandIcon: int = LoadImage_Strict("GFX\handsymbol.png")
		HandIcon2: int = LoadImage_Strict("GFX\handsymbol2.png")

		StaminaMeterIMG: int = LoadImage_Strict("GFX\staminameter.jpg")

		KeypadHUD =  LoadImage_Strict("GFX\keypadhud.jpg")
		MaskImage(KeypadHUD, 255,0,255)

		Panel294 = LoadImage_Strict("GFX\294panel.jpg")
		MaskImage(Panel294, 255,0,255)


		Brightness: int = GetINIFloat("options.ini", "options", "brightness")
		CameraFogNear: float = GetINIFloat("options.ini", "options", "camera fog near")
		CameraFogFar: float = GetINIFloat("options.ini", "options", "camera fog far")
		StoredCameraFogFar: float = CameraFogFar

		;TextureLodBias

		AmbientLightRoomTex: int = CreateTexture(2,2,257)
		TextureBlend AmbientLightRoomTex,5
		SetBuffer(TextureBuffer(AmbientLightRoomTex))
		ClsColor 0,0,0
		Cls
		SetBuffer BackBuffer()
		AmbientLightRoomVal = 0

		SoundEmitter = CreatePivot()

		Camera = CreateCamera()
		CameraViewport Camera,0,0,GraphicWidth,GraphicHeight
		CameraRange(Camera, 0.05, CameraFogFar)
		CameraFogMode (Camera, 1)
		CameraFogRange (Camera, CameraFogNear, CameraFogFar)
		CameraFogColor (Camera, GetINIInt("options.ini", "options", "fog r"), GetINIInt("options.ini", "options", "fog g"), GetINIInt("options.ini", "options", "fog b"))
		AmbientLight Brightness, Brightness, Brightness

		ScreenTexs[0] = CreateTexture(512, 512, 1+256)
		ScreenTexs[1] = CreateTexture(512, 512, 1+256)

		CreateBlurImage()
		CameraProjMode ark_blur_cam,0
		;Listener = CreateListener(Camera)

		FogTexture = LoadTexture_Strict("GFX\fog.jpg", 1)

		Fog = CreateSprite(ark_blur_cam)
		ScaleSprite(Fog, 1.0, Float(GraphicHeight) / Float(GraphicWidth))
		EntityTexture(Fog, FogTexture)
		EntityBlend (Fog, 2)
		EntityOrder Fog, -1000
		MoveEntity(Fog, 0, 0, 1.0)

		GasMaskTexture = LoadTexture_Strict("GFX\GasmaskOverlay.jpg", 1)
		GasMaskOverlay = CreateSprite(ark_blur_cam)
		ScaleSprite(GasMaskOverlay, 1.0, Float(GraphicHeight) / Float(GraphicWidth))
		EntityTexture(GasMaskOverlay, GasMaskTexture)
		EntityBlend (GasMaskOverlay, 2)
		EntityFX(GasMaskOverlay, 1)
		EntityOrder GasMaskOverlay, -1003
		MoveEntity(GasMaskOverlay, 0, 0, 1.0)
		HideEntity(GasMaskOverlay)

		InfectTexture = LoadTexture_Strict("GFX\InfectOverlay.jpg", 1)
		InfectOverlay = CreateSprite(ark_blur_cam)
		ScaleSprite(InfectOverlay, 1.0, Float(GraphicHeight) / Float(GraphicWidth))
		EntityTexture(InfectOverlay, InfectTexture)
		EntityBlend (InfectOverlay, 3)
		EntityFX(InfectOverlay, 1)
		EntityOrder InfectOverlay, -1003
		MoveEntity(InfectOverlay, 0, 0, 1.0)
		;EntityAlpha (InfectOverlay, 255.0)
		HideEntity(InfectOverlay)

		NVTexture = LoadTexture_Strict("GFX\NightVisionOverlay.jpg", 1)
		NVOverlay = CreateSprite(ark_blur_cam)
		ScaleSprite(NVOverlay, 1.0, Float(GraphicHeight) / Float(GraphicWidth))
		EntityTexture(NVOverlay, NVTexture)
		EntityBlend (NVOverlay, 2)
		EntityFX(NVOverlay, 1)
		EntityOrder NVOverlay, -1003
		MoveEntity(NVOverlay, 0, 0, 1.0)
		HideEntity(NVOverlay)
		NVBlink = CreateSprite(ark_blur_cam)
		ScaleSprite(NVBlink, 1.0, Float(GraphicHeight) / Float(GraphicWidth))
		EntityColor(NVBlink,0,0,0)
		EntityFX(NVBlink, 1)
		EntityOrder NVBlink, -1005
		MoveEntity(NVBlink, 0, 0, 1.0)
		HideEntity(NVBlink)

		FogNVTexture = LoadTexture_Strict("GFX\fogNV.jpg", 1)

		DrawLoading(5)

		DarkTexture = CreateTexture(1024, 1024, 1 + 2)
		SetBuffer TextureBuffer(DarkTexture)
		Cls
		SetBuffer BackBuffer()

		Dark = CreateSprite(Camera)
		ScaleSprite(Dark, 1.0, Float(GraphicHeight) / Float(GraphicWidth))
		EntityTexture(Dark, DarkTexture)
		EntityBlend (Dark, 1)
		EntityOrder Dark, -1002
		MoveEntity(Dark, 0, 0, 1.0)
		EntityAlpha Dark, 0.0

		LightTexture = CreateTexture(1024, 1024, 1 + 2+256)
		SetBuffer TextureBuffer(LightTexture)
		ClsColor 255, 255, 255
		Cls
		ClsColor 0, 0, 0
		SetBuffer BackBuffer()

		TeslaTexture = LoadTexture_Strict("GFX\map\tesla.jpg", 1+2)

		Light = CreateSprite(Camera)
		ScaleSprite(Light, 1.0, Float(GraphicHeight) / Float(GraphicWidth))
		EntityTexture(Light, LightTexture)
		EntityBlend (Light, 1)
		EntityOrder Light, -1002
		MoveEntity(Light, 0, 0, 1.0)
		HideEntity Light

		Collider = CreatePivot()
		EntityRadius Collider, 0.15, 0.30
		EntityPickMode(Collider, 1)
		EntityType Collider, HIT_PLAYER

		Head = CreatePivot()
		EntityRadius Head, 0.15
		EntityType Head, HIT_PLAYER


		LiquidObj = LoadMesh_Strict("GFX\items\cupliquid.x") ;optimized the cups dispensed by 294
		HideEntity LiquidObj

		MTFObj = LoadAnimMesh_Strict("GFX\npcs\MTF2.b3d") ;optimized MTFs
		GuardObj = LoadAnimMesh_Strict("GFX\npcs\guard.b3d") ;optimized Guards


		ClassDObj = LoadAnimMesh_Strict("GFX\npcs\classd.b3d")
		ApacheObj = LoadAnimMesh_Strict("GFX\apache.b3d") ;optimized Apaches (helicopters)
		ApacheRotorObj = LoadAnimMesh_Strict("GFX\apacherotor.b3d") ;optimized the Apaches even more

		HideEntity MTFObj
		HideEntity GuardObj
		HideEntity ClassDObj
		HideEntity ApacheObj
		HideEntity ApacheRotorObj


		NPC049OBJ = LoadAnimMesh_Strict("GFX\npcs\scp-049.b3d")
		HideEntity NPC049OBJ
		NPC0492OBJ = LoadAnimMesh_Strict("GFX\npcs\zombie1.b3d")
		HideEntity NPC0492OBJ
		ClerkOBJ = LoadAnimMesh_Strict("GFX\npcs\clerk.b3d")
		HideEntity (ClerkOBJ)






		LightSpriteTex(0) = LoadTexture_Strict("GFX\light1.jpg", 1)
		LightSpriteTex(1) = LoadTexture_Strict("GFX\light2.jpg", 1)
		LightSpriteTex(2) = LoadTexture_Strict("GFX\lightsprite.jpg",1)

		DrawLoading(10)

		DoorOBJ = LoadMesh_Strict("GFX\map\door01.x")
		HideEntity DoorOBJ
		DoorFrameOBJ = LoadMesh_Strict("GFX\map\doorframe.x")
		HideEntity DoorFrameOBJ

		HeavyDoorObj[0] = LoadMesh_Strict("GFX\map\heavydoor1.x")
		HideEntity HeavyDoorObj[0]
		HeavyDoorObj[1] = LoadMesh_Strict("GFX\map\heavydoor2.x")
		HideEntity HeavyDoorObj[1]

		DoorColl = LoadMesh_Strict("GFX\map\doorcoll.x")
		HideEntity DoorColl

		ButtonOBJ = LoadMesh_Strict("GFX\map\Button.x")
		HideEntity ButtonOBJ
		ButtonKeyOBJ = LoadMesh_Strict("GFX\map\ButtonKeycard.x")
		HideEntity ButtonKeyOBJ
		ButtonCodeOBJ = LoadMesh_Strict("GFX\map\ButtonCode.x")
		HideEntity ButtonCodeOBJ
		ButtonScannerOBJ = LoadMesh_Strict("GFX\map\ButtonScanner.x")
		HideEntity ButtonScannerOBJ

		BigDoorOBJ[0] = LoadMesh_Strict("GFX\map\ContDoorLeft.x")
		HideEntity BigDoorOBJ[0]
		BigDoorOBJ[1] = LoadMesh_Strict("GFX\map\ContDoorRight.x")
		HideEntity BigDoorOBJ[1]

		LeverBaseOBJ = LoadMesh_Strict("GFX\map\leverbase.x")
		HideEntity LeverBaseOBJ
		LeverOBJ = LoadMesh_Strict("GFX\map\leverhandle.x")
		HideEntity LeverOBJ


		DrawLoading(15)

		for i = 0 To 5
			GorePics(i) = LoadTexture_Strict("GFX\895pics\pic" + (i + 1) + ".jpg")


		OldAiPics(0) = LoadTexture_Strict("GFX\AIface.jpg")
		OldAiPics(1) = LoadTexture_Strict("GFX\AIface2.jpg")

		DrawLoading(20)

		for i = 0 To 6
			DecalTextures(i) = LoadTexture_Strict("GFX\decal" + (i + 1) + ".png", 1 + 2)

		DecalTextures(7) = LoadTexture_Strict("GFX\items\INVpaperstrips.jpg", 1 + 2)
		for i = 8 To 12
			DecalTextures(i) = LoadTexture_Strict("GFX\decalpd"+(i-7)+".jpg", 1 + 2)

		for i = 13 To 14
			DecalTextures(i) = LoadTexture_Strict("GFX\bullethole"+(i-12)+".jpg", 1 + 2)

		for i = 15 To 16
			DecalTextures(i) = LoadTexture_Strict("GFX\blooddrop"+(i-14)+".png", 1 + 2)

		DecalTextures(17) = LoadTexture_Strict("GFX\decal8.png", 1 + 2)
		DecalTextures(18) = LoadTexture_Strict("GFX\decalpd6.dc", 1 + 2)
		DecalTextures(19) = LoadTexture_Strict("GFX\decal19.png", 1 + 2)
		DecalTextures(20) = LoadTexture_Strict("GFX\decal427.png", 1 + 2)

		DrawLoading(25)

		Monitor = LoadMesh_Strict("GFX\map\monitor.b3d")
		HideEntity Monitor
		MonitorTexture = LoadTexture_Strict("GFX\monitortexture.jpg")

		CamBaseOBJ = LoadMesh_Strict("GFX\map\cambase.x")
		HideEntity(CamBaseOBJ)
		CamOBJ = LoadMesh_Strict("GFX\map\CamHead.b3d")
		HideEntity(CamOBJ)

		Monitor2 = LoadMesh_Strict("GFX\map\monitor_checkpoint.b3d")
		HideEntity Monitor2
		Monitor3 = LoadMesh_Strict("GFX\map\monitor_checkpoint.b3d")
		HideEntity Monitor3
		MonitorTexture2 = LoadTexture_Strict("GFX\map\LockdownScreen2.jpg")
		MonitorTexture3 = LoadTexture_Strict("GFX\map\LockdownScreen.jpg")
		MonitorTexture4 = LoadTexture_Strict("GFX\map\LockdownScreen3.jpg")
		MonitorTextureOff = CreateTexture(1,1)
		SetBuffer TextureBuffer(MonitorTextureOff)
		ClsColor 0,0,0
		Cls
		SetBuffer BackBuffer()
		LightConeModel = LoadMesh_Strict("GFX\lightcone.b3d")
		HideEntity LightConeModel

		for i = 2 To CountSurfaces(Monitor2)
			sf = GetSurface(Monitor2,i)
			b = GetSurfaceBrush(sf)
			if b!=0:
				t1 = GetBrushTexture(b,0)
				if t1!=0:
					name: String = StripPath(TextureName(t1))
					if Lower(name) != "monitortexture.jpg"
						BrushTexture b, MonitorTextureOff, 0, 0
						PaintSurface sf,b

					if name!="": FreeTexture t1

				FreeBrush b


		for i = 2 To CountSurfaces(Monitor3)
			sf = GetSurface(Monitor3,i)
			b = GetSurfaceBrush(sf)
			if b!=0:
				t1 = GetBrushTexture(b,0)
				if t1!=0:
					name: String = StripPath(TextureName(t1))
					if Lower(name) != "monitortexture.jpg"
						BrushTexture b, MonitorTextureOff, 0, 0
						PaintSurface sf,b

					if name!="": FreeTexture t1

				FreeBrush b



		UserTrackMusicAmount: int = 0
		if EnableUserTracks:
			var dirPath: String = "SFX\\Radio\\UserTracks\\"
			if FileType(dirPath)!=2:
				CreateDir(dirPath)


			var Dir: int = ReadDir("SFX\\Radio\\UserTracks\\")
			Repeat
				file: String=File(Dir)
				if file: String="": break
				if FileType("SFX\\Radio\\UserTracks\\"+file: String) = 1:
					test = LoadSound("SFX\\Radio\\UserTracks\\"+file: String)
					if test!=0
						UserTrackName: String(UserTrackMusicAmount: int) = file: String
						UserTrackMusicAmount: int = UserTrackMusicAmount: int + 1

					FreeSound test

			Forever
			CloseDir Dir

		if EnableUserTracks: DebugLog "User Tracks found: "+UserTrackMusicAmount

		InitItemTemplates()

		ParticleTextures(0) = LoadTexture_Strict("GFX\smoke.png", 1 + 2)
		ParticleTextures(1) = LoadTexture_Strict("GFX\flash.jpg", 1 + 2)
		ParticleTextures(2) = LoadTexture_Strict("GFX\dust.jpg", 1 + 2)
		ParticleTextures(3) = LoadTexture_Strict("GFX\npcs\hg.pt", 1 + 2)
		ParticleTextures(4) = LoadTexture_Strict("GFX\map\sun.jpg", 1 + 2)
		ParticleTextures(5) = LoadTexture_Strict("GFX\bloodsprite.png", 1 + 2)
		ParticleTextures(6) = LoadTexture_Strict("GFX\smoke2.png", 1 + 2)
		ParticleTextures(7) = LoadTexture_Strict("GFX\spark.jpg", 1 + 2)
		ParticleTextures(8) = LoadTexture_Strict("GFX\particle.png", 1 + 2)

		SetChunkDataValues()

		;NPCtypeD - different models with different textures (loaded using "CopyEntity") - ENDSHN

		for i=1 To MaxDTextures
			DTextures[i] = CopyEntity(ClassDObj)
			HideEntity DTextures[i]

		;Gonzales
		tex = LoadTexture_Strict("GFX\npcs\gonzales.jpg")
		EntityTexture DTextures[1],tex
		FreeTexture tex
		;SCP-970 corpse
		tex = LoadTexture_Strict("GFX\npcs\corpse.jpg")
		EntityTexture DTextures[2],tex
		FreeTexture tex
		;scientist 1
		tex = LoadTexture_Strict("GFX\npcs\scientist.jpg")
		EntityTexture DTextures[3],tex
		FreeTexture tex
		;scientist 2
		tex = LoadTexture_Strict("GFX\npcs\scientist2.jpg")
		EntityTexture DTextures[4],tex
		FreeTexture tex
		;janitor
		tex = LoadTexture_Strict("GFX\npcs\janitor.jpg")
		EntityTexture DTextures[5],tex
		FreeTexture tex
		;106 Victim
		tex = LoadTexture_Strict("GFX\npcs\106victim.jpg")
		EntityTexture DTextures[6],tex
		FreeTexture tex
		;2nd ClassD
		tex = LoadTexture_Strict("GFX\npcs\classd2.jpg")
		EntityTexture DTextures[7],tex
		FreeTexture tex
		;035 victim
		tex = LoadTexture_Strict("GFX\npcs\035victim.jpg")
		EntityTexture DTextures[8],tex
		FreeTexture tex



		LoadMaterials("DATA\materials.ini")

		OBJTunnel(0)=LoadRMesh("GFX\map\mt1.rmesh",Null)
		HideEntity OBJTunnel(0)
		OBJTunnel(1)=LoadRMesh("GFX\map\mt2.rmesh",Null)
		HideEntity OBJTunnel(1)
		OBJTunnel(2)=LoadRMesh("GFX\map\mt2c.rmesh",Null)
		HideEntity OBJTunnel(2)
		OBJTunnel(3)=LoadRMesh("GFX\map\mt3.rmesh",Null)
		HideEntity OBJTunnel(3)
		OBJTunnel(4)=LoadRMesh("GFX\map\mt4.rmesh",Null)
		HideEntity OBJTunnel(4)
		OBJTunnel(5)=LoadRMesh("GFX\map\mt_elevator.rmesh",Null)
		HideEntity OBJTunnel(5)
		OBJTunnel(6)=LoadRMesh("GFX\map\mt_generator.rmesh",Null)
		HideEntity OBJTunnel(6)

		;TextureLodBias TextureBias
		TextureLodBias TextureFloat: float
		;Devil Particle System
		;ParticleEffect[] numbers:
		;	0 - electric spark
		;	1 - smoke effect

		var t0

		InitParticles(Camera)

		;Spark Effect (short)
		ParticleEffect[0] = CreateTemplate()
		SetTemplateEmitterBlend(ParticleEffect[0], 3)
		SetTemplateInterval(ParticleEffect[0], 1)
		SetTemplateParticlesPerInterval(ParticleEffect[0], 6)
		SetTemplateEmitterLifeTime(ParticleEffect[0], 6)
		SetTemplateParticleLifeTime(ParticleEffect[0], 20, 30)
		SetTemplateTexture(ParticleEffect[0], "GFX\Spark.png", 2, 3)
		SetTemplateOffset(ParticleEffect[0], -0.1, 0.1, -0.1, 0.1, -0.1, 0.1)
		SetTemplateVelocity(ParticleEffect[0], -0.0375, 0.0375, -0.0375, 0.0375, -0.0375, 0.0375)
		SetTemplateAlignToFall(ParticleEffect[0], True, 45)
		SetTemplateGravity(ParticleEffect[0], 0.001)
		SetTemplateAlphaVel(ParticleEffect[0], True)
		;SetTemplateSize(ParticleEffect[0], 0.0625, 0.125, 0.7, 1)
		SetTemplateSize(ParticleEffect[0], 0.03125, 0.0625, 0.7, 1)
		SetTemplateColors(ParticleEffect[0], : String0000FF, : String6565FF)
		SetTemplateFloor(ParticleEffect[0], 0.0, 0.5)

		;Smoke effect (for some vents)
		ParticleEffect[1] = CreateTemplate()
		SetTemplateEmitterBlend(ParticleEffect[1], 1)
		SetTemplateInterval(ParticleEffect[1], 1)
		SetTemplateEmitterLifeTime(ParticleEffect[1], 3)
		SetTemplateParticleLifeTime(ParticleEffect[1], 30, 45)
		SetTemplateTexture(ParticleEffect[1], "GFX\smoke2.png", 2, 1)
		;SetTemplateOffset(ParticleEffect[1], -.3, .3, -.3, .3, -.3, .3)
		SetTemplateOffset(ParticleEffect[1], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
		;SetTemplateVelocity(ParticleEffect[1], -.04, .04, .1, .2, -.04, .04)
		SetTemplateVelocity(ParticleEffect[1], 0.0, 0.0, 0.02, 0.025, 0.0, 0.0)
		SetTemplateAlphaVel(ParticleEffect[1], True)
		;SetTemplateSize(ParticleEffect[1], 3, 3, .5, 1.5)
		SetTemplateSize(ParticleEffect[1], 0.4, 0.4, 0.5, 1.5)
		SetTemplateSizeVel(ParticleEffect[1], .01, 1.01)

		;Smoke effect (for decontamination gas)
		ParticleEffect[2] = CreateTemplate()
		SetTemplateEmitterBlend(ParticleEffect[2], 1)
		SetTemplateInterval(ParticleEffect[2], 1)
		SetTemplateEmitterLifeTime(ParticleEffect[2], 3)
		SetTemplateParticleLifeTime(ParticleEffect[2], 30, 45)
		SetTemplateTexture(ParticleEffect[2], "GFX\smoke.png", 2, 1)
		SetTemplateOffset(ParticleEffect[2], -0.1, 0.1, -0.1, 0.1, -0.1, 0.1)
		SetTemplateVelocity(ParticleEffect[2], -0.005, 0.005, 0.0, -0.03, -0.005, 0.005)
		SetTemplateAlphaVel(ParticleEffect[2], True)
		SetTemplateSize(ParticleEffect[2], 0.4, 0.4, 0.5, 1.5)
		SetTemplateSizeVel(ParticleEffect[2], .01, 1.01)
		SetTemplateGravity(ParticleEffect[2], 0.005)
		t0 = CreateTemplate()
		SetTemplateEmitterBlend(t0, 1)
		SetTemplateInterval(t0, 1)
		SetTemplateEmitterLifeTime(t0, 3)
		SetTemplateParticleLifeTime(t0, 30, 45)
		SetTemplateTexture(t0, "GFX\smoke2.png", 2, 1)
		SetTemplateOffset(t0, -0.1, 0.1, -0.1, 0.1, -0.1, 0.1)
		SetTemplateVelocity(t0, -0.005, 0.005, 0.0, -0.03, -0.005, 0.005)
		SetTemplateAlphaVel(t0, True)
		SetTemplateSize(t0, 0.4, 0.4, 0.5, 1.5)
		SetTemplateSizeVel(t0, .01, 1.01)
		SetTemplateGravity(ParticleEffect[2], 0.005)
		SetTemplateSubTemplate(ParticleEffect[2], t0)

		Room2slCam = CreateCamera()
		CameraViewport(Room2slCam, 0, 0, 128, 128)
		CameraRange Room2slCam, 0.05, 6.0
		CameraZoom(Room2slCam, 0.8)
		HideEntity(Room2slCam)

		DrawLoading(30)

		;LoadRoomMeshes()

		CatchErrors("LoadEntities")
	

	func InitNewGame()
		CatchErrors("Uncaught (InitNewGame)")
		var i: int, de.Decals, d.Doors, it.Items, r.Rooms, sc.SecurityCams, e.Events

		DrawLoading(45)

		HideDistance: float = 15.0

		HeartBeatRate = 70

		AccessCode = 0
		for i = 0 To 3
			AccessCode = AccessCode + randi(1,9)*(10^i)


		if SelectedMap = "":
			CreateMap()
		else:
			LoadMap("Map Creator\\Maps\\"+SelectedMap)

		InitWayPoints()

		DrawLoading(79)

		Curr173 = CreateNPC(NPCtype173, 0, -30.0, 0)
		Curr106 = CreateNPC(NPCtypeOldMan, 0, -30.0, 0)
		Curr106\State = 70 * 60 * randi(12,17)

		for d.Doors = Each Doors
			EntityParent(d.obj, 0)
			if d.obj2 != 0: EntityParent(d.obj2, 0)
			if d.frameobj != 0: EntityParent(d.frameobj, 0)
			if d.buttons[0] != 0: EntityParent(d.buttons[0], 0)
			if d.buttons[1] != 0: EntityParent(d.buttons[1], 0)

			if d.obj2 != 0 And d.dir = 0:
				MoveEntity(d.obj, 0, 0, 8.0 * RoomScale)
				MoveEntity(d.obj2, 0, 0, 8.0 * RoomScale)



		for it.Items = Each Items
			EntityType (it\collider, HIT_ITEM)
			EntityParent(it\collider, 0)


		DrawLoading(80)
		for sc.SecurityCams= Each SecurityCams
			sc\angle = EntityYaw(sc\obj) + sc\angle
			EntityParent(sc\obj, 0)


		for r.Rooms = Each Rooms
			for i = 0 To MaxRoomLights
				if r\Lights[i]!=0: EntityParent(r\Lights[i],0)


			if (Not r\RoomTemplate.DisableDecals):
				if randi(4) = 1:
					de.Decals = CreateDecal(randi(2, 3), EntityX(r\obj)+randf(- 2,2), 0.003, EntityZ(r\obj)+randf(-2,2), 90, randi(360), 0)
					de.Size = randf(0.1, 0.4) : ScaleSprite(de.obj, de.Size, de.Size)
					EntityAlpha(de.obj, randf(0.85, 0.95))


				if randi(4) = 1:
					de.Decals = CreateDecal(0, EntityX(r\obj)+randf(- 2,2), 0.003, EntityZ(r\obj)+randf(-2,2), 90, randi(360), 0)
					de.Size = randf(0.5, 0.7) : EntityAlpha(de.obj, 0.7) : de.ID = 1 : ScaleSprite(de.obj, de.Size, de.Size)
					EntityAlpha(de.obj, randf(0.7, 0.85))



			if (r\RoomTemplate.Name = "start" And IntroEnabled = false):
				PositionEntity (Collider, EntityX(r\obj)+3584*RoomScale, 704*RoomScale, EntityZ(r\obj)+1024*RoomScale)
				PlayerRoom = r
				it = CreateItem("Class D Orientation Leaflet", "paper", 1, 1, 1)
				it\Picked = True
				it\Dropped = -1
				it\itemtemplate.found=True
				Inventory(0) = it
				HideEntity(it\collider)
				EntityType (it\collider, HIT_ITEM)
				EntityParent(it\collider, 0)
				ItemAmount = ItemAmount + 1
				it = CreateItem("Document SCP-173", "paper", 1, 1, 1)
				it\Picked = True
				it\Dropped = -1
				it\itemtemplate.found=True
				Inventory(1) = it
				HideEntity(it\collider)
				EntityType (it\collider, HIT_ITEM)
				EntityParent(it\collider, 0)
				ItemAmount = ItemAmount + 1
			elif (r\RoomTemplate.Name = "173" And IntroEnabled):
				PositionEntity (Collider, EntityX(r\obj), 1.0, EntityZ(r\obj))
				PlayerRoom = r




		var rt.RoomTemplates
		for rt.RoomTemplates = Each RoomTemplates
			FreeEntity (rt\obj)


		var tw.TempWayPoints
		for tw.TempWayPoints = Each TempWayPoints
			Delete tw


		TurnEntity(Collider, 0, randi(160, 200), 0)

		ResetEntity Collider

		if SelectedMap = "": InitEvents()

		for e.Events = Each Events
			if e.EventName = "room2nuke"
				e.EventState = 1
				DebugLog "room2nuke"

			if e.EventName = "room106"
				e.EventState2 = 1
				DebugLog "room106"

			if e.EventName = "room2sl"
				e.EventState3 = 1
				DebugLog "room2sl"



		MoveMouse viewport_center_x,viewport_center_y;320, 240

		AASetFont Font1

		HidePointer()

		BlinkTimer = -10
		BlurTimer = 100
		Stamina = 100

		for i: int = 0 To 70
			FPSfactor = 1.0
			FlushKeys()
			MovePlayer()
			UpdateDoors()
			UpdateNPCs()
			UpdateWorld()
			;Cls
			if (Int(Float(i)*0.27)!=Int(Float(i-1)*0.27)):
				DrawLoading(80+Int(Float(i)*0.27))



		FreeTextureCache
		DrawLoading(100)

		FlushKeys
		FlushMouse

		DropSpeed = 0

		PrevTime = MilliSecs()
		CatchErrors("InitNewGame")
	

	func InitLoadGame()
		CatchErrors("Uncaught (InitLoadGame)")
		var d.Doors, sc.SecurityCams, rt.RoomTemplates, e.Events

		DrawLoading(80)

		for d.Doors = Each Doors
			EntityParent(d.obj, 0)
			if d.obj2 != 0: EntityParent(d.obj2, 0)
			if d.frameobj != 0: EntityParent(d.frameobj, 0)
			if d.buttons[0] != 0: EntityParent(d.buttons[0], 0)
			if d.buttons[1] != 0: EntityParent(d.buttons[1], 0)



		for sc.SecurityCams = Each SecurityCams
			sc\angle = EntityYaw(sc\obj) + sc\angle
			EntityParent(sc\obj, 0)


		ResetEntity Collider

		;InitEvents()

		DrawLoading(90)

		MoveMouse viewport_center_x,viewport_center_y

		AASetFont Font1

		HidePointer ()

		BlinkTimer = BLINKFREQ
		Stamina = 100

		for rt.RoomTemplates = Each RoomTemplates
			if rt\obj != 0: FreeEntity(rt\obj) : rt\obj = 0


		DropSpeed = 0.0

		for e.Events = Each Events
			;Loading the necessary stuff for dimension1499, but this will only be done if the player is in this dimension already
			if e.EventName = "dimension1499"
				if e.EventState = 2

					DrawLoading(91)
					e.room\Objects[0] = CreatePlane()
					var planetex: int = LoadTexture_Strict("GFX\map\dimension1499\grit3.jpg")
					EntityTexture e.room\Objects[0],planetex: int
					FreeTexture planetex: int
					PositionEntity e.room\Objects[0],0,EntityY(e.room\obj),0
					EntityType e.room\Objects[0],HIT_MAP
					;EntityParent e.room\Objects[0],e.room\obj
					DrawLoading(92)
					NTF_1499Sky = sky_CreateSky("GFX\map\sky\1499sky")
					DrawLoading(93)
					for i = 1 To 15
						e.room\Objects[i] = LoadMesh_Strict("GFX\map\dimension1499\1499object"+i+".b3d")
						HideEntity e.room\Objects[i]

					DrawLoading(96)
					CreateChunkParts(e.room)
					DrawLoading(97)
					x: float = EntityX(e.room\obj)
					z: float = EntityZ(e.room\obj)
					var ch.Chunk
					for i = -2 To 2 Step 2
						ch = CreateChunk(-1,x: float*(i*2.5),EntityY(e.room\obj),z: float)

					DrawLoading(98)
					UpdateChunks(e.room,15,False)
					;MoveEntity Collider,0,10,0
					;ResetEntity Collider

					DebugLog "Loaded dimension1499 successful"

					break





		FreeTextureCache

		CatchErrors("InitLoadGame")
		DrawLoading(100)

		PrevTime = MilliSecs()
		FPSfactor = 0
		ResetInput()

	

	func NullGame(playbuttonsfx: int=True)
		CatchErrors("Uncaught (NullGame)")
		var i: int, x: int, y: int, lvl
		var itt.ItemTemplates, s.Screens, lt.LightTemplates, d.Doors, m.Materials
		var wp.WayPoints, twp.TempWayPoints, r.Rooms, it.Items

		KillSounds()
		if playbuttonsfx: PlaySound_Strict ButtonSFX

		FreeParticles()

		ClearTextureCache

		DebugHUD = false

		UnableToMove: int = false

		QuickLoadPercent = -1
		QuickLoadPercent_DisplayTimer: float = 0
		QuickLoad_CurrEvent = Null

		DeathMSG: String=""

		SelectedMap = ""

		UsedConsole = false

		DoorTempID = 0
		RoomTempID = 0

		GameSaved = 0

		HideDistance: float = 15.0

		for lvl = 0 To 0
			for x = 0 To MapWidth+1
				for y = 0 To MapHeight+1
					MapTemp(x, y) = 0
					MapFound(x, y) = 0




		for itt.ItemTemplates = Each ItemTemplates
			itt\found = false


		DropSpeed = 0
		Shake = 0
		CurrSpeed = 0

		DeathTimer=0

		HeartBeatVolume = 0

		StaminaEffect = 1.0
		StaminaEffectTimer = 0
		BlinkEffect = 1.0
		BlinkEffectTimer = 0

		Bloodloss = 0
		Injuries = 0
		Infect = 0

		for i = 0 To 5
			SCP1025state[i] = 0


		SelectedEnding = ""
		EndingTimer = 0
		ExplosionTimer = 0

		CameraShake = 0
		Shake = 0
		LightFlash = 0

		GodMode = 0
		NoClip = 0
		WireframeState = 0
		WireFrame 0
		WearingGasMask = 0
		WearingHazmat = 0
		WearingVest = 0
		Wearing714 = 0
		if WearingNightVision:
			CameraFogFar = StoredCameraFogFar
			WearingNightVision = 0

		I_427\Using = 0
		I_427\Timer = 0.0

		ForceMove = 0.0
		ForceAngle = 0.0
		Playable = True

		CoffinDistance = 100

		Contained106 = false
		if Curr173 != Null: Curr173\Idle = false

		MTFtimer = 0
		for i = 0 To 9
			MTFrooms[i]=Null
			MTFroomState[i]=0


		for s.Screens = Each Screens
			if s\img != 0: FreeImage s\img : s\img = 0
			Delete s


		for i = 0 To MAXACHIEVEMENTS-1
			Achievements(i)=0

		RefinedItems = 0

		ConsoleInput = ""
		ConsoleOpen = false

		EyeIrritation = 0
		EyeStuck = 0

		ShouldPlay = 0

		KillTimer = 0
		FallTimer = 0
		Stamina = 100
		BlurTimer = 0
		SuperMan = false
		SuperManTimer = 0
		Sanity = 0
		RestoreSanity = True
		Crouch = false
		CrouchState = 0.0
		LightVolume = 0.0
		Vomit = false
		VomitTimer = 0.0
		SecondaryLightOn: float = True
		PrevSecondaryLightOn: float = True
		RemoteDoorOn = True
		SoundTransmission = false

		InfiniteStamina: int = false

		Msg = ""
		MsgTimer = 0

		SelectedItem = Null

		for i = 0 To MaxItemAmount - 1
			Inventory(i) = Null

		SelectedItem = Null

		ClosestButton = 0

		for d.Doors = Each Doors
			Delete d


		;ClearWorld

		for lt.LightTemplates = Each LightTemplates
			Delete lt


		for m.Materials = Each Materials
			Delete m


		for wp.WayPoints = Each WayPoints
			Delete wp


		for twp.TempWayPoints = Each TempWayPoints
			Delete twp


		for r.Rooms = Each Rooms
			Delete r


		for itt.ItemTemplates = Each ItemTemplates
			Delete itt


		for it.Items = Each Items
			Delete it


		for pr.Props = Each Props
			Delete pr


		for de.decals = Each Decals
			Delete de


		for n.NPCS = Each NPCs
			Delete n

		Curr173 = Null
		Curr106 = Null
		Curr096 = Null
		for i = 0 To 6
			MTFrooms[i]=Null

		ForestNPC = 0
		ForestNPCTex = 0

		var e.Events
		for e.Events = Each Events
			if e.Sound!=0: FreeSound_Strict e.Sound
			if e.Sound2!=0: FreeSound_Strict e.Sound2
			Delete e


		for sc.securitycams = Each SecurityCams
			Delete sc


		for em.emitters = Each Emitters
			Delete em


		for p.particles = Each Particles
			Delete p


		for rt.RoomTemplates = Each RoomTemplates
			rt\obj = 0


		for i = 0 To 5
			if ChannelPlaying(RadioCHN(i)): StopChannel(RadioCHN(i))


		NTF_1499PrevX: float = 0.0
		NTF_1499PrevY: float = 0.0
		NTF_1499PrevZ: float = 0.0
		NTF_1499PrevRoom = Null
		NTF_1499X: float = 0.0
		NTF_1499Y: float = 0.0
		NTF_1499Z: float = 0.0
		Wearing1499: int = false
		DeleteChunks()

		DeleteElevatorObjects()

		DeleteDevilEmitters()

		NoTarget: int = false

		OptionsMenu: int = -1
		QuitMSG: int = -1
		AchievementsMenu: int = -1

		MusicVolume: float = PrevMusicVolume
		SFXVolume: float = PrevSFXVolume
		DeafPlayer: int = false
		DeafTimer: float = 0.0

		IsZombie: int = false

		Delete Each AchievementMsg
		CurrAchvMSGID = 0

		;DeInitExt

		ClearWorld
		ReloadAAFont()
		Camera = 0
		ark_blur_cam = 0
		Collider = 0
		Sky = 0
		InitFastResize()

		CatchErrors("NullGame")
	

	Include "save.bb"

	;--------------------------------------- music & sounds ----------------------------------------------

	func PlaySound2: int(SoundHandle: int, cam: int, entity: int, range: float = 10, volume: float = 1.0)
		range: float = Max(range, 1.0)
		var soundchn: int = 0

		if volume > 0:
			var dist: float = EntityDistance(cam, entity) / range: float
			if 1 - dist: float > 0 And 1 - dist: float < 1
				var panvalue: float = Sin(-DeltaYaw(cam,entity))
				soundchn: int = PlaySound_Strict (SoundHandle)

				ChannelVolume(soundchn, volume: float * (1 - dist: float)*SFXVolume: float)
				ChannelPan(soundchn, panvalue)



		return soundchn
	

	func LoopSound2: int(SoundHandle: int, Chn: int, cam: int, entity: int, range: float = 10, volume: float = 1.0)
		range: float = Max(range,1.0)

		if volume>0:

			var dist: float = EntityDistance(cam, entity) / range: float
			;if 1 - dist: float > 0 And 1 - dist: float < 1:

				var panvalue: float = Sin(-DeltaYaw(cam,entity))

				if Chn = 0:
					Chn: int = PlaySound_Strict (SoundHandle)
				else:
					if (Not ChannelPlaying(Chn)): Chn: int = PlaySound_Strict (SoundHandle)


				ChannelVolume(Chn, volume: float * (1 - dist: float)*SFXVolume: float)
				ChannelPan(Chn, panvalue)
			;
		else:
			if Chn != 0:
				ChannelVolume (Chn, 0)



		return Chn
	

	func LoadTempSound(file: String)
		if TempSounds[TempSoundIndex]!=0: FreeSound_Strict(TempSounds[TempSoundIndex])
		TempSound = LoadSound_Strict(file)
		TempSounds[TempSoundIndex] = TempSound

		TempSoundIndex=(TempSoundIndex+1) Mod 10

		return TempSound
	

	func LoadEventSound(e.Events,file: String,num: int=0)

		if num=0:
			if e.Sound!=0: FreeSound_Strict e.Sound : e.Sound=0
			e.Sound=LoadSound_Strict(file)
			return e.Sound
		else: if num=1:
			if e.Sound2!=0: FreeSound_Strict e.Sound2 : e.Sound2=0
			e.Sound2=LoadSound_Strict(file)
			return e.Sound2

	

	func UpdateMusic()

		if ConsoleFlush:
			if Not ChannelPlaying(ConsoleMusPlay): ConsoleMusPlay = PlaySound(ConsoleMusFlush)
		elif (Not PlayCustomMusic)
			if NowPlaying != ShouldPlay ; playing the wrong clip, fade out
				CurrMusicVolume: float = Max(CurrMusicVolume - (FPSfactor / 250.0), 0)
				if CurrMusicVolume = 0
					if NowPlaying<66
						StopStream_Strict(MusicCHN)

					NowPlaying = ShouldPlay
					MusicCHN = 0
					CurrMusic=0

			else::
				CurrMusicVolume = CurrMusicVolume + (MusicVolume - CurrMusicVolume) * (0.1*FPSfactor)


			if NowPlaying < 66
				if CurrMusic = 0
					MusicCHN = StreamSound_Strict("SFX\\Music\\"+Music(NowPlaying)+".ogg",0.0,Mode)
					CurrMusic = 1

				SetStreamVolume_Strict(MusicCHN,CurrMusicVolume)

		else:
			if FPSfactor > 0 Or OptionsMenu = 2:
				;CurrMusicVolume = 1.0
				if (Not ChannelPlaying(MusicCHN)): MusicCHN = PlaySound_Strict(CustomMusic)
				ChannelVolume MusicCHN,1.0*MusicVolume



	

	func PauseSounds()
		for e.events = Each Events
			if e.soundchn != 0:
				if (Not e.soundchn_isstream)
					if ChannelPlaying(e.soundchn): PauseChannel(e.soundchn)
				else:
					SetStreamPaused_Strict(e.soundchn,True)


			if e.soundchn2 != 0:
				if (Not e.soundchn2_isstream)
					if ChannelPlaying(e.soundchn2): PauseChannel(e.soundchn2)
				else:
					SetStreamPaused_Strict(e.soundchn2,True)




		for n.npcs = Each NPCs
			if n\soundchn != 0:
				if (Not n\soundchn_isstream)
					if ChannelPlaying(n\soundchn): PauseChannel(n\soundchn)
				else:
					if n\soundchn_isstream=True
						SetStreamPaused_Strict(n\soundchn,True)



			if n\soundchn2 != 0:
				if (Not n\soundchn2_isstream)
					if ChannelPlaying(n\soundchn2): PauseChannel(n\soundchn2)
				else:
					if n\soundchn2_isstream=True
						SetStreamPaused_Strict(n\soundchn2,True)





		for d.doors = Each Doors
			if d.soundchn != 0:
				if ChannelPlaying(d.soundchn): PauseChannel(d.soundchn)



		for dem.DevilEmitters = Each DevilEmitters
			if dem\soundchn != 0:
				if ChannelPlaying(dem\soundchn): PauseChannel(dem\soundchn)



		if AmbientSFXCHN != 0:
			if ChannelPlaying(AmbientSFXCHN): PauseChannel(AmbientSFXCHN)


		if BreathCHN != 0:
			if ChannelPlaying(BreathCHN): PauseChannel(BreathCHN)


		if IntercomStreamCHN != 0
			SetStreamPaused_Strict(IntercomStreamCHN,True)

	

	func ResumeSounds()
		for e.events = Each Events
			if e.soundchn != 0:
				if (Not e.soundchn_isstream)
					if ChannelPlaying(e.soundchn): ResumeChannel(e.soundchn)
				else:
					SetStreamPaused_Strict(e.soundchn,False)


			if e.soundchn2 != 0:
				if (Not e.soundchn2_isstream)
					if ChannelPlaying(e.soundchn2): ResumeChannel(e.soundchn2)
				else:
					SetStreamPaused_Strict(e.soundchn2,False)




		for n.npcs = Each NPCs
			if n\soundchn != 0:
				if (Not n\soundchn_isstream)
					if ChannelPlaying(n\soundchn): ResumeChannel(n\soundchn)
				else:
					if n\soundchn_isstream=True
						SetStreamPaused_Strict(n\soundchn,False)



			if n\soundchn2 != 0:
				if (Not n\soundchn2_isstream)
					if ChannelPlaying(n\soundchn2): ResumeChannel(n\soundchn2)
				else:
					if n\soundchn2_isstream=True
						SetStreamPaused_Strict(n\soundchn2,False)





		for d.doors = Each Doors
			if d.soundchn != 0:
				if ChannelPlaying(d.soundchn): ResumeChannel(d.soundchn)



		for dem.DevilEmitters = Each DevilEmitters
			if dem\soundchn != 0:
				if ChannelPlaying(dem\soundchn): ResumeChannel(dem\soundchn)



		if AmbientSFXCHN != 0:
			if ChannelPlaying(AmbientSFXCHN): ResumeChannel(AmbientSFXCHN)


		if BreathCHN != 0:
			if ChannelPlaying(BreathCHN): ResumeChannel(BreathCHN)


		if IntercomStreamCHN != 0
			SetStreamPaused_Strict(IntercomStreamCHN,False)

	

	func KillSounds()
		var i: int,e.Events,n.NPCs,d.Doors,dem.DevilEmitters,snd.Sound

		for i=0 To 9
			if TempSounds[i]!=0: FreeSound_Strict TempSounds[i] : TempSounds[i]=0

		for e.Events = Each Events
			if e.SoundCHN != 0:
				if (Not e.SoundCHN_isStream)
					if ChannelPlaying(e.SoundCHN): StopChannel(e.SoundCHN)
				else:
					StopStream_Strict(e.SoundCHN)


			if e.SoundCHN2 != 0:
				if (Not e.SoundCHN2_isStream)
					if ChannelPlaying(e.SoundCHN2): StopChannel(e.SoundCHN2)
				else:
					StopStream_Strict(e.SoundCHN2)



		for n.NPCs = Each NPCs
			if n\SoundChn != 0:
				if (Not n\SoundChn_IsStream)
					if ChannelPlaying(n\SoundChn): StopChannel(n\SoundChn)
				else:
					StopStream_Strict(n\SoundChn)


			if n\SoundChn2 != 0:
				if (Not n\SoundChn2_IsStream)
					if ChannelPlaying(n\SoundChn2): StopChannel(n\SoundChn2)
				else:
					StopStream_Strict(n\SoundChn2)



		for d.Doors = Each Doors
			if d.SoundCHN != 0:
				if ChannelPlaying(d.SoundCHN): StopChannel(d.SoundCHN)


		for dem.DevilEmitters = Each DevilEmitters
			if dem\SoundCHN != 0:
				if ChannelPlaying(dem\SoundCHN): StopChannel(dem\SoundCHN)


		if AmbientSFXCHN != 0:
			if ChannelPlaying(AmbientSFXCHN): StopChannel(AmbientSFXCHN)

		if BreathCHN != 0:
			if ChannelPlaying(BreathCHN): StopChannel(BreathCHN)

		if IntercomStreamCHN != 0
			StopStream_Strict(IntercomStreamCHN)
			IntercomStreamCHN = 0

		if EnableSFXRelease
			for snd.Sound = Each Sound
				if snd.internalHandle != 0:
					FreeSound snd.internalHandle
					snd.internalHandle = 0
					snd.releaseTime = 0




		for snd.Sound = Each Sound
			for i = 0 To 31
				if snd.channels[i]!=0:
					StopChannel snd.channels[i]




		DebugLog "Terminated all sounds"

	

	func GetStepSound(entity: int)
		var picker: int,brush: int,texture: int,name: String
		var mat.Materials

		picker = LinePick(EntityX(entity),EntityY(entity),EntityZ(entity),0,-1,0)
		if picker != 0:
			if GetEntityType(picker) != HIT_MAP: return 0
			brush = GetSurfaceBrush(GetSurface(picker,CountSurfaces(picker)))
			if brush != 0:
				texture = GetBrushTexture(brush,3)
				if texture != 0:
					name = StripPath(TextureName(texture))
					if (name != ""): FreeTexture(texture)
					for mat.Materials = Each Materials
						if mat\name = name:
							if mat\StepSound > 0:
								FreeBrush(brush)
								return mat\StepSound-1

							break



				texture = GetBrushTexture(brush,2)
				if texture != 0:
					name = StripPath(TextureName(texture))
					if (name != ""): FreeTexture(texture)
					for mat.Materials = Each Materials
						if mat\name = name:
							if mat\StepSound > 0:
								FreeBrush(brush)
								return mat\StepSound-1

							break



				texture = GetBrushTexture(brush,1)
				if texture != 0:
					name = StripPath(TextureName(texture))
					if (name != ""): FreeTexture(texture)
					FreeBrush(brush)
					for mat.Materials = Each Materials
						if mat\name = name:
							if mat\StepSound > 0:
								return mat\StepSound-1

							break






		return 0
	

	func UpdateSoundOrigin2(Chn: int, cam: int, entity: int, range: float = 10, volume: float = 1.0)
		range: float = Max(range,1.0)

		if volume>0:

			var dist: float = EntityDistance(cam, entity) / range: float
			if 1 - dist: float > 0 And 1 - dist: float < 1:

				var panvalue: float = Sin(-DeltaYaw(cam,entity))

				ChannelVolume(Chn, volume: float * (1 - dist: float))
				ChannelPan(Chn, panvalue)

		else:
			if Chn != 0:
				ChannelVolume (Chn, 0)


	

	func UpdateSoundOrigin(Chn: int, cam: int, entity: int, range: float = 10, volume: float = 1.0)
		range: float = Max(range,1.0)

		if volume>0:

			var dist: float = EntityDistance(cam, entity) / range: float
			if 1 - dist: float > 0 And 1 - dist: float < 1:

				var panvalue: float = Sin(-DeltaYaw(cam,entity))

				ChannelVolume(Chn, volume: float * (1 - dist: float)*SFXVolume: float)
				ChannelPan(Chn, panvalue)

		else:
			if Chn != 0:
				ChannelVolume (Chn, 0)


	
	;--------------------------------------- random -------------------------------------------------------

	func f2s: String(n: float, count: int)
		return Left(n, Len(Int(n))+count+1)
	

	func AnimateNPC(n.NPCs, start: float, quit: float, speed: float, loop=True)
		var newTime: float

		if speed > 0.0:
			newTime = Max(Min(n\Frame + speed * FPSfactor,quit),start)

			if loop And newTime => quit:
				newTime = start

		else:
			if start < quit:
				temp: int = start
				start = quit
				quit = temp


			if loop:
				newTime = n\Frame + speed * FPSfactor

				if newTime < quit:
					newTime = start
				else: if newTime > start
					newTime = quit

			else:
				newTime = Max(Min(n\Frame + speed * FPSfactor,start),quit)


		SetNPCFrame(n, newTime)

	

	func SetNPCFrame(n.NPCs, frame: float)
		if (Abs(n\Frame-frame)<0.001): Return

		SetAnimTime n\obj, frame

		n\Frame = frame
	

	func Animate2: float(entity: int, curr: float, start: int, quit: int, speed: float, loop=True)

		var newTime: float

		if speed > 0.0:
			newTime = Max(Min(curr + speed * FPSfactor,quit),start)

			if loop:
				if newTime => quit:
					;SetAnimTime entity, start
					newTime = start
				else:
					;SetAnimTime entity, newTime

			else:
				;SetAnimTime entity, newTime

		else:
			if start < quit:
				temp: int = start
				start = quit
				quit = temp


			if loop:
				newTime = curr + speed * FPSfactor

				if newTime < quit: newTime = start
				if newTime > start: newTime = quit

				;SetAnimTime entity, newTime
			else:
				;SetAnimTime (entity, Max(Min(curr + speed * FPSfactor,start),quit))
				newTime = Max(Min(curr + speed * FPSfactor,start),quit)



		SetAnimTime entity, newTime
		return newTime

	


	func Use914(item.Items, setting: String, x: float, y: float, z: float)

		RefinedItems = RefinedItems+1

		var it2.Items
		match item.itemtemplate.name
			"Gas Mask", "Heavy Gas Mask"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.12 : ScaleSprite(d.obj, d.Size, d.Size)
						RemoveItem(item)
					"1:1"
						PositionEntity(item.collider, x, y, z)
						ResetEntity(item.collider)
					"fine", "very fine"
						it2 = CreateItem("Gas Mask", "supergasmask", x, y, z)
						RemoveItem(item)

			"SCP-1499"
					match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.12 : ScaleSprite(d.obj, d.Size, d.Size)
						RemoveItem(item)
					"1:1"
						it2 = CreateItem("Gas Mask", "gasmask", x, y, z)
						RemoveItem(item)
					"fine"
						it2 = CreateItem("SCP-1499", "super1499", x, y, z)
						RemoveItem(item)
					"very fine"
						n.NPCs = CreateNPC(NPCtype1499,x,y,z)
						n\State = 1
						n\Sound = LoadSound_Strict("SFX\SCP\1499\Triggered.ogg")
						n\SoundChn = PlaySound2(n\Sound, Camera, n\Collider,20.0)
						n\State3 = 1
						RemoveItem(item)

			"Ballistic Vest"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.12 : ScaleSprite(d.obj, d.Size, d.Size)
						RemoveItem(item)
					"1:1"
						PositionEntity(item.collider, x, y, z)
						ResetEntity(item.collider)
					"fine"
						it2 = CreateItem("Heavy Ballistic Vest", "finevest", x, y, z)
						RemoveItem(item)
					"very fine"
						it2 = CreateItem("Bulky Ballistic Vest", "veryfinevest", x, y, z)
						RemoveItem(item)

			"Clipboard"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(7, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.12 : ScaleSprite(d.obj, d.Size, d.Size)
						for i: int = 0 To 19
							if item.SecondInv[i]!=Null: RemoveItem(item.SecondInv[i])
							item.SecondInv[i]=Null

						RemoveItem(item)
					"1:1"
						PositionEntity(item.collider, x, y, z)
						ResetEntity(item.collider)
					"fine"
						item.invSlots = Max(item.state2,15)
						PositionEntity(item.collider, x, y, z)
						ResetEntity(item.collider)
					"very fine"
						item.invSlots = Max(item.state2,20)
						PositionEntity(item.collider, x, y, z)
						ResetEntity(item.collider)

			"Cowbell":
				match setting:
					"rough","coarse":
						d.Decals = CreateDecal(0, x, 8*RoomScale+0.010, z, 90, randi(360), 0)
						d.Size = 0.2
						EntityAlpha(d.obj, 0.8)
						ScaleSprite(d.obj, d.Size, d.Size)
						RemoveItem(item)
					"1:1","fine","very fine":
						PositionEntity(item.collider, x, y, z)
						ResetEntity(item.collider)

			"Night Vision Goggles":
				match setting:
					"rough", "coarse":
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.12
						ScaleSprite(d.obj, d.Size, d.Size)
						RemoveItem(item)
					"1:1":
						PositionEntity(item.collider, x, y, z)
						ResetEntity(item.collider)
					"fine":
						it2 = CreateItem("Night Vision Goggles", "finenvgoggles", x, y, z)
						RemoveItem(item)
					"very fine":
						it2 = CreateItem("Night Vision Goggles", "supernv", x, y, z)
						it2.state = 1000
						RemoveItem(item)

			"Metal Panel", "SCP-148 Ingot":
				match setting:
					"rough", "coarse":
						it2 = CreateItem("SCP-148 Ingot", "scp148ingot", x, y, z)
						RemoveItem(item)
					"1:1", "fine", "very fine":
						it2 = null
						for it: Items in items:
							if it!=item And it\collider != 0 And it\Picked = false:
								if Distance(EntityX(it\collider,True), EntityZ(it\collider,True), EntityX(item.collider, True), EntityZ(item.collider, True)) < (180.0 * RoomScale):
									it2 = it
									break
								elif Distance(EntityX(it\collider,True), EntityZ(it\collider,True), x,z) < (180.0 * RoomScale)
									it2 = it
									break




						if it2!=Null:
							match it2.itemtemplate.tempname:
								"gasmask", "supergasmask":
									RemoveItem (it2)
									RemoveItem (item)

									it2 = CreateItem("Heavy Gas Mask", "gasmask3", x, y, z)
								"vest":
									RemoveItem (it2)
									RemoveItem(item)
									it2 = CreateItem("Heavy Ballistic Vest", "finevest", x, y, z)
								"hazmatsuit","hazmatsuit2":
									RemoveItem (it2)
									RemoveItem(item)
									it2 = CreateItem("Heavy Hazmat Suit", "hazmatsuit3", x, y, z)

						else:
							if item.itemtemplate.name=="SCP-148 Ingot":
								it2 = CreateItem("Metal Panel", "scp148", x, y, z)
								RemoveItem(item)
							else:
								PositionEntity(item.collider, x, y, z)
								ResetEntity(item.collider)



			"Severed Hand", "Black Severed Hand":
				match setting:
					"rough", "coarse":
						d.Decals = CreateDecal(3, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.12
						ScaleSprite(d.obj, d.Size, d.Size)
					"1:1", "fine", "very fine":
						if (item.itemtemplate.name = "Severed Hand")
							it2 = CreateItem("Black Severed Hand", "hand2", x, y, z)
						else:
							it2 = CreateItem("Severed Hand", "hand", x, y, z)


				RemoveItem(item)
			"First Aid Kit", "Blue First Aid Kit":
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.12 : ScaleSprite(d.obj, d.Size, d.Size)
					"1:1"
					if randi(2)=1:
						it2 = CreateItem("Blue First Aid Kit", "firstaid2", x, y, z)
					else:
						it2 = CreateItem("First Aid Kit", "firstaid", x, y, z)

					"fine"
						it2 = CreateItem("Small First Aid Kit", "finefirstaid", x, y, z)
					"very fine"
						it2 = CreateItem("Strange Bottle", "veryfinefirstaid", x, y, z)

				RemoveItem(item)
			"Level 1 Key Card", "Level 2 Key Card", "Level 3 Key Card", "Level 4 Key Card", "Level 5 Key Card", "Key Card"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.07 : ScaleSprite(d.obj, d.Size, d.Size)
					"1:1"
						it2 = CreateItem("Playing Card", "misc", x, y, z)
					"fine"
						match item.itemtemplate.name
							"Level 1 Key Card"
								match SelectedDifficulty\otherFactors
									EASY
										it2 = CreateItem("Level 2 Key Card", "key2", x, y, z)
									NORMAL
										if randi(5)=1:
											it2 = CreateItem("Mastercard", "misc", x, y, z)
										else:
											it2 = CreateItem("Level 2 Key Card", "key2", x, y, z)

									HARD
										if randi(4)=1:
											it2 = CreateItem("Mastercard", "misc", x, y, z)
										else:
											it2 = CreateItem("Level 2 Key Card", "key2", x, y, z)


							"Level 2 Key Card"
								match SelectedDifficulty\otherFactors
									EASY
										it2 = CreateItem("Level 3 Key Card", "key3", x, y, z)
									NORMAL
										if randi(4)=1:
											it2 = CreateItem("Mastercard", "misc", x, y, z)
										else:
											it2 = CreateItem("Level 3 Key Card", "key3", x, y, z)

									HARD
										if randi(3)=1:
											it2 = CreateItem("Mastercard", "misc", x, y, z)
										else:
											it2 = CreateItem("Level 3 Key Card", "key3", x, y, z)


							"Level 3 Key Card"
								match SelectedDifficulty\otherFactors
									EASY
										if randi(10)=1:
											it2 = CreateItem("Level 4 Key Card", "key4", x, y, z)
										else:
											it2 = CreateItem("Playing Card", "misc", x, y, z)

									NORMAL
										if randi(15)=1:
											it2 = CreateItem("Level 4 Key Card", "key4", x, y, z)
										else:
											it2 = CreateItem("Playing Card", "misc", x, y, z)

									HARD
										if randi(20)=1:
											it2 = CreateItem("Level 4 Key Card", "key4", x, y, z)
										else:
											it2 = CreateItem("Playing Card", "misc", x, y, z)


							"Level 4 Key Card"
								match SelectedDifficulty\otherFactors
									EASY
										it2 = CreateItem("Level 5 Key Card", "key5", x, y, z)
									NORMAL
										if randi(4)=1:
											it2 = CreateItem("Mastercard", "misc", x, y, z)
										else:
											it2 = CreateItem("Level 5 Key Card", "key5", x, y, z)

									HARD
										if randi(3)=1:
											it2 = CreateItem("Mastercard", "misc", x, y, z)
										else:
											it2 = CreateItem("Level 5 Key Card", "key5", x, y, z)


							"Level 5 Key Card"
								var CurrAchvAmount: int=0
								for i = 0 To MAXACHIEVEMENTS-1
									if Achievements(i)=True
										CurrAchvAmount=CurrAchvAmount+1



								DebugLog CurrAchvAmount

								match SelectedDifficulty\otherFactors
									EASY
										if randi(0,((MAXACHIEVEMENTS-1)*3)-((CurrAchvAmount-1)*3))=0
											it2 = CreateItem("Key Card Omni", "key6", x, y, z)
										else:
											it2 = CreateItem("Mastercard", "misc", x, y, z)

									NORMAL
										if randi(0,((MAXACHIEVEMENTS-1)*4)-((CurrAchvAmount-1)*3))=0
											it2 = CreateItem("Key Card Omni", "key6", x, y, z)
										else:
											it2 = CreateItem("Mastercard", "misc", x, y, z)

									HARD
										if randi(0,((MAXACHIEVEMENTS-1)*5)-((CurrAchvAmount-1)*3))=0
											it2 = CreateItem("Key Card Omni", "key6", x, y, z)
										else:
											it2 = CreateItem("Mastercard", "misc", x, y, z)



					"very fine"
						CurrAchvAmount: int=0
						for i = 0 To MAXACHIEVEMENTS-1
							if Achievements(i)=True
								CurrAchvAmount=CurrAchvAmount+1



						DebugLog CurrAchvAmount

						match SelectedDifficulty\otherFactors
							EASY
								if randi(0,((MAXACHIEVEMENTS-1)*3)-((CurrAchvAmount-1)*3))=0
									it2 = CreateItem("Key Card Omni", "key6", x, y, z)
								else:
									it2 = CreateItem("Mastercard", "misc", x, y, z)

							NORMAL
								if randi(0,((MAXACHIEVEMENTS-1)*4)-((CurrAchvAmount-1)*3))=0
									it2 = CreateItem("Key Card Omni", "key6", x, y, z)
								else:
									it2 = CreateItem("Mastercard", "misc", x, y, z)

							HARD
								if randi(0,((MAXACHIEVEMENTS-1)*5)-((CurrAchvAmount-1)*3))=0
									it2 = CreateItem("Key Card Omni", "key6", x, y, z)
								else:
									it2 = CreateItem("Mastercard", "misc", x, y, z)




				RemoveItem(item)
			"Key Card Omni"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.07 : ScaleSprite(d.obj, d.Size, d.Size)
					"1:1"
						if randi(2)=1:
							it2 = CreateItem("Mastercard", "misc", x, y, z)
						else:
							it2 = CreateItem("Playing Card", "misc", x, y, z)

					"fine", "very fine"
						it2 = CreateItem("Key Card Omni", "key6", x, y, z)


				RemoveItem(item)
			"Playing Card", "Coin", "Quarter"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.07 : ScaleSprite(d.obj, d.Size, d.Size)
					"1:1"
						it2 = CreateItem("Level 1 Key Card", "key1", x, y, z)
					"fine", "very fine"
						it2 = CreateItem("Level 2 Key Card", "key2", x, y, z)

				RemoveItem(item)
			"Mastercard"
				match setting
					"rough"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
						d.Size = 0.07 : ScaleSprite(d.obj, d.Size, d.Size)
					"coarse"
						it2 = CreateItem("Quarter", "25ct", x, y, z)
						var it3.Items,it4.Items,it5.Items
						it3 = CreateItem("Quarter", "25ct", x, y, z)
						it4 = CreateItem("Quarter", "25ct", x, y, z)
						it5 = CreateItem("Quarter", "25ct", x, y, z)
						EntityType (it3\collider, HIT_ITEM)
						EntityType (it4\collider, HIT_ITEM)
						EntityType (it5\collider, HIT_ITEM)
					"1:1"
						it2 = CreateItem("Level 1 Key Card", "key1", x, y, z)
					"fine", "very fine"
						it2 = CreateItem("Level 2 Key Card", "key2", x, y, z)

				RemoveItem(item)
			"S-NAV 300 Navigator", "S-NAV 310 Navigator", "S-NAV Navigator", "S-NAV Navigator Ultimate"
				match setting
					"rough", "coarse"
						it2 = CreateItem("Electronical components", "misc", x, y, z)
					"1:1"
						it2 = CreateItem("S-NAV Navigator", "nav", x, y, z)
						it2\state = 100
					"fine"
						it2 = CreateItem("S-NAV 310 Navigator", "nav", x, y, z)
						it2\state = 100
					"very fine"
						it2 = CreateItem("S-NAV Navigator Ultimate", "nav", x, y, z)
						it2\state = 101


				RemoveItem(item)
			"Radio Transceiver"
				match setting
					"rough", "coarse"
						it2 = CreateItem("Electronical components", "misc", x, y, z)
					"1:1"
						it2 = CreateItem("Radio Transceiver", "18vradio", x, y, z)
						it2\state = 100
					"fine"
						it2 = CreateItem("Radio Transceiver", "fineradio", x, y, z)
						it2\state = 101
					"very fine"
						it2 = CreateItem("Radio Transceiver", "veryfineradio", x, y, z)
						it2\state = 101


				RemoveItem(item)
			"SCP-513"
				match setting
					"rough", "coarse"
						PlaySound_Strict LoadTempSound("SFX\SCP\513\914Refine.ogg")
						for n.npcs = Each NPCs
							if n\npctype = NPCtype5131: RemoveNPC(n)

						d.Decals = CreateDecal(0, x, 8*RoomScale+0.010, z, 90, randi(360), 0)
						d.Size = 0.2 : EntityAlpha(d.obj, 0.8) : ScaleSprite(d.obj, d.Size, d.Size)
					"1:1", "fine", "very fine"
						it2 = CreateItem("SCP-513", "scp513", x, y, z)



				RemoveItem(item)
			"Some SCP-420-J", "Cigarette"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8*RoomScale+0.010, z, 90, randi(360), 0)
						d.Size = 0.2 : EntityAlpha(d.obj, 0.8) : ScaleSprite(d.obj, d.Size, d.Size)
					"1:1"
						it2 = CreateItem("Cigarette", "cigarette", x + 1.5, y + 0.5, z + 1.0)
					"fine"
						it2 = CreateItem("Joint", "420s", x + 1.5, y + 0.5, z + 1.0)
					"very fine"
						it2 = CreateItem("Smelly Joint", "420s", x + 1.5, y + 0.5, z + 1.0)


				RemoveItem(item)
			"9V Battery", "18V Battery", "Strange Battery"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.010, z, 90, randi(360), 0)
						d.Size = 0.2 : EntityAlpha(d.obj, 0.8) : ScaleSprite(d.obj, d.Size, d.Size)
					"1:1"
						it2 = CreateItem("18V Battery", "18vbat", x, y, z)
					"fine"
						it2 = CreateItem("Strange Battery", "killbat", x, y, z)
					"very fine"
						it2 = CreateItem("Strange Battery", "killbat", x, y, z)


				RemoveItem(item)
			"ReVision Eyedrops", "RedVision Eyedrops", "Eyedrops"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.010, z, 90, randi(360), 0)
						d.Size = 0.2 : EntityAlpha(d.obj, 0.8) : ScaleSprite(d.obj, d.Size, d.Size)
					"1:1"
						it2 = CreateItem("RedVision Eyedrops", "eyedrops", x,y,z)
					"fine"
						it2 = CreateItem("Eyedrops", "fineeyedrops", x,y,z)
					"very fine"
						it2 = CreateItem("Eyedrops", "supereyedrops", x,y,z)


				RemoveItem(item)
			"Hazmat Suit"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.010, z, 90, randi(360), 0)
						d.Size = 0.2 : EntityAlpha(d.obj, 0.8) : ScaleSprite(d.obj, d.Size, d.Size)
					"1:1"
						it2 = CreateItem("Hazmat Suit", "hazmatsuit", x,y,z)
					"fine"
						it2 = CreateItem("Hazmat Suit", "hazmatsuit2", x,y,z)
					"very fine"
						it2 = CreateItem("Hazmat Suit", "hazmatsuit2", x,y,z)


				RemoveItem(item)

			"Syringe"
				match item.itemtemplate.tempname
					"syringe"
						match setting
							"rough", "coarse"
								d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
								d.Size = 0.07 : ScaleSprite(d.obj, d.Size, d.Size)
							"1:1"
								it2 = CreateItem("Small First Aid Kit", "finefirstaid", x, y, z)
							"fine"
								it2 = CreateItem("Syringe", "finesyringe", x, y, z)
							"very fine"
								it2 = CreateItem("Syringe", "veryfinesyringe", x, y, z)


					"finesyringe"
						match setting
							"rough"
								d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
								d.Size = 0.07 : ScaleSprite(d.obj, d.Size, d.Size)
							"coarse"
								it2 = CreateItem("First Aid Kit", "firstaid", x, y, z)
							"1:1"
								it2 = CreateItem("Blue First Aid Kit", "firstaid2", x, y, z)
							"fine", "very fine"
								it2 = CreateItem("Syringe", "veryfinesyringe", x, y, z)


					"veryfinesyringe"
						match setting
							"rough", "coarse", "1:1", "fine"
								it2 = CreateItem("Electronical components", "misc", x, y, z)
							"very fine"
								n.NPCs = CreateNPC(NPCtype008,x,y,z)
								n\State = 2



				RemoveItem(item)

			"SCP-500-01", "Upgraded pill", "Pill"
				match setting
					"rough", "coarse"
						d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.010, z, 90, randi(360), 0)
						d.Size = 0.2 : EntityAlpha(d.obj, 0.8) : ScaleSprite(d.obj, d.Size, d.Size)
					"1:1"
						it2 = CreateItem("Pill", "pill", x, y, z)
						RemoveItem(item)
					"fine"
						var no427Spawn: int = false
						for it3.Items = Each Items
							if it3\itemtemplate.tempname = "scp427":
								no427Spawn = True
								break


						if (Not no427Spawn):
							it2 = CreateItem("SCP-427", "scp427", x, y, z)
						else:
							it2 = CreateItem("Upgraded pill", "scp500death", x, y, z)

						RemoveItem(item)
					"very fine"
						it2 = CreateItem("Upgraded pill", "scp500death", x, y, z)
						RemoveItem(item)


			_:

				match item.itemtemplate.tempname
					"cup"
						match setting
							"rough", "coarse"
								d.Decals = CreateDecal(0, x, 8 * RoomScale + 0.010, z, 90, randi(360), 0)
								d.Size = 0.2 : EntityAlpha(d.obj, 0.8) : ScaleSprite(d.obj, d.Size, d.Size)
							"1:1"
								it2 = CreateItem("cup", "cup", x,y,z)
								it2\name = item.name
								it2\r = 255-item.r
								it2\g = 255-item.g
								it2\b = 255-item.b
							"fine"
								it2 = CreateItem("cup", "cup", x,y,z)
								it2\name = item.name
								it2\state = 1.0
								it2\r = Min(item.r*randf(0.9,1.1),255)
								it2\g = Min(item.g*randf(0.9,1.1),255)
								it2\b = Min(item.b*randf(0.9,1.1),255)
							"very fine"
								it2 = CreateItem("cup", "cup", x,y,z)
								it2\name = item.name
								it2\state = Max(it2\state*2.0,2.0)
								it2\r = Min(item.r*randf(0.5,1.5),255)
								it2\g = Min(item.g*randf(0.5,1.5),255)
								it2\b = Min(item.b*randf(0.5,1.5),255)
								if randi(5)=1:
									ExplosionTimer = 135



						RemoveItem(item)
					"paper"
						match setting
							"rough", "coarse"
								d.Decals = CreateDecal(7, x, 8 * RoomScale + 0.005, z, 90, randi(360), 0)
								d.Size = 0.12 : ScaleSprite(d.obj, d.Size, d.Size)
							"1:1"
								match randi(6)
									1
										it2 = CreateItem("Document SCP-106", "paper", x, y, z)
									2
										it2 = CreateItem("Document SCP-079", "paper", x, y, z)
									3
										it2 = CreateItem("Document SCP-173", "paper", x, y, z)
									4
										it2 = CreateItem("Document SCP-895", "paper", x, y, z)
									5
										it2 = CreateItem("Document SCP-682", "paper", x, y, z)
									6
										it2 = CreateItem("Document SCP-860", "paper", x, y, z)

							"fine", "very fine"
								it2 = CreateItem("Origami", "misc", x, y, z)


						RemoveItem(item)
					_:
						PositionEntity(item.collider, x, y, z)
						ResetEntity(item.collider)




		if it2 != Null: EntityType (it2\collider, HIT_ITEM)
	

	func Use294()
		var x: float,y: float, xtemp: int,ytemp: int, strtemp: String, temp: int

		ShowPointer()

		x = GraphicWidth/2 - (ImageWidth(Panel294)/2)
		y = GraphicHeight/2 - (ImageHeight(Panel294)/2)
		DrawImage Panel294, x, y
		if Fullscreen: DrawImage CursorIMG, ScaledMouseX(),ScaledMouseY()

		temp = True
		if PlayerRoom\SoundCHN!=0: temp = false

		AAText x+907, y+185, Input294, True,True

		if temp:
			if MouseHit1:
				xtemp = Floor((ScaledMouseX()-x-228) / 35.5)
				ytemp = Floor((ScaledMouseY()-y-342) / 36.5)

				if ytemp => 0 And ytemp < 5:
					if xtemp => 0 And xtemp < 10: PlaySound_Strict ButtonSFX


				strtemp = ""

				temp = false

				match ytemp
					0
						strtemp = (xtemp + 1) Mod 10
					1
						match xtemp
							0
								strtemp = "Q"
							1
								strtemp = "W"
							2
								strtemp = "E"
							3
								strtemp = "R"
							4
								strtemp = "T"
							5
								strtemp = "Y"
							6
								strtemp = "U"
							7
								strtemp = "I"
							8
								strtemp = "O"
							9
								strtemp = "P"

					2
						match xtemp
							0
								strtemp = "A"
							1
								strtemp = "S"
							2
								strtemp = "D"
							3
								strtemp = "F"
							4
								strtemp = "G"
							5
								strtemp = "H"
							6
								strtemp = "J"
							7
								strtemp = "K"
							8
								strtemp = "L"
							9 ;dispense
								temp = True

					3
						match xtemp
							0
								strtemp = "Z"
							1
								strtemp = "X"
							2
								strtemp = "C"
							3
								strtemp = "V"
							4
								strtemp = "B"
							5
								strtemp = "N"
							6
								strtemp = "M"
							7
								strtemp = "-"
							8
								strtemp = " "
							9
								Input294 = Left(Input294, Max(Len(Input294)-1,0))

					4
						strtemp = " "


				Input294 = Input294 + strtemp

				Input294 = Left(Input294, Min(Len(Input294),15))

				if temp And Input294!="": ;dispense
					Input294 = Trim(Lower(Input294))
					if Left(Input294, Min(7,Len(Input294))) = "cup of ":
						Input294 = Right(Input294, Len(Input294)-7)
					elif Left(Input294, Min(9,Len(Input294))) = "a cup of "
						Input294 = Right(Input294, Len(Input294)-9)


					if Input294!=""
						var loc: int = GetINISectionLocation("DATA\SCP-294.ini",Input294)


					if loc > 0:
						strtemp: String = GetINIString2("DATA\SCP-294.ini", loc, "dispensesound")
						if strtemp="":
							PlayerRoom\SoundCHN = PlaySound_Strict (LoadTempSound("SFX\SCP\294\dispense1.ogg"))
						else:
							PlayerRoom\SoundCHN = PlaySound_Strict (LoadTempSound(strtemp))


						if GetINIInt2("DATA\SCP-294.ini", loc, "explosion")=True:
							ExplosionTimer = 135
							DeathMSG = GetINIString2("DATA\SCP-294.ini", loc, "deathmessage")


						strtemp: String = GetINIString2("DATA\SCP-294.ini", loc, "color")

						sep1 = Instr(strtemp, ",", 1)
						sep2 = Instr(strtemp, ",", sep1+1)
						r: int = Trim(Left(strtemp, sep1-1))
						g: int = Trim(Mid(strtemp, sep1+1, sep2-sep1-1))
						b: int = Trim(Right(strtemp, Len(strtemp)-sep2))

						alpha: float = Float(GetINIString2("DATA\SCP-294.ini", loc, "alpha",1.0))
						glow = GetINIInt2("DATA\SCP-294.ini", loc, "glow")
						;if alpha = 0: alpha = 1.0
						if glow: alpha = -alpha

						it.items = CreateItem("Cup", "cup", EntityX(PlayerRoom\Objects[1],True),EntityY(PlayerRoom\Objects[1],True),EntityZ(PlayerRoom\Objects[1],True), r,g,b,alpha)
						it\name = "Cup of "+Input294
						EntityType (it\collider, HIT_ITEM)

					else:
						;out of range
						Input294 = "OUT OF RANGE"
						PlayerRoom\SoundCHN = PlaySound_Strict (LoadTempSound("SFX\SCP\294\outofrange.ogg"))




			 ;if mousehit1

			if MouseHit2 Or (Not Using294):
				HidePointer()
				Using294 = false
				Input294 = ""
				MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0


		else: ;playing a dispensing sound
			if Input294 != "OUT OF RANGE": Input294 = "DISPENSING..."

			if Not ChannelPlaying(PlayerRoom\SoundCHN):
				if Input294 != "OUT OF RANGE":
					HidePointer()
					Using294 = false
					MouseXSpeed() : MouseYSpeed() : MouseZSpeed() : mouse_x_speed_1: float=0.0 : mouse_y_speed_1: float=0.0
					var e.Events
					for e.Events = Each Events
						if e.room = PlayerRoom
							e.EventState2 = 0
							break



				Input294=""
				PlayerRoom\SoundCHN=0



	

	func Use427()
		var i: int,pvt: int,de.Decals,tempchn: int
		var prevI427Timer: float = I_427\Timer

		if I_427\Timer < 70*360
			if I_427\Using=True:
				I_427\Timer = I_427\Timer + FPSfactor
				if Injuries > 0.0:
					Injuries = Max(Injuries - 0.0005 * FPSfactor,0.0)

				if Bloodloss > 0.0 And Injuries <= 1.0:
					Bloodloss = Max(Bloodloss - 0.001 * FPSfactor,0.0)

				if Infect > 0.0:
					Infect = Max(Infect - 0.001 * FPSfactor,0.0)

				for i = 0 To 5
					if SCP1025state[i]>0.0:
						SCP1025state[i] = Max(SCP1025state[i] - 0.001 * FPSfactor,0.0)


				if I_427\Sound[0]=0:
					I_427\Sound[0] = LoadSound_Strict("SFX\SCP\427\Effect.ogg")

				if (Not ChannelPlaying(I_427\SoundCHN[0])):
					I_427\SoundCHN[0] = PlaySound_Strict(I_427\Sound[0])

				if I_427\Timer => 70*180:
					if I_427\Sound[1]=0:
						I_427\Sound[1] = LoadSound_Strict("SFX\SCP\427\Transform.ogg")

					if (Not ChannelPlaying(I_427\SoundCHN[1])):
						I_427\SoundCHN[1] = PlaySound_Strict(I_427\Sound[1])


				if prevI427Timer < 70*60 And I_427\Timer => 70*60:
					Msg = "You feel refreshed and energetic."
					MsgTimer = 70*5
				elif prevI427Timer < 70*180 And I_427\Timer => 70*180:
					Msg = "You feel gentle muscle spasms all over your body."
					MsgTimer = 70*5

			else:
				for i = 0 To 1
					if I_427\SoundCHN[i]!=0:
						if ChannelPlaying(I_427\SoundCHN[i]):
							StopChannel(I_427\SoundCHN[i])




		else:
			if prevI427Timer-FPSfactor < 70*360 And I_427\Timer => 70*360:
				Msg = "Your muscles are swelling. You feel more powerful than ever."
				MsgTimer = 70*5
			elif prevI427Timer-FPSfactor < 70*390 And I_427\Timer => 70*390:
				Msg = "You can't feel your legs. But you don't need legs anymore."
				MsgTimer = 70*5

			I_427\Timer = I_427\Timer + FPSfactor
			if I_427\Sound[0]=0:
				I_427\Sound[0] = LoadSound_Strict("SFX\SCP\427\Effect.ogg")

			if I_427\Sound[1]=0:
				I_427\Sound[1] = LoadSound_Strict("SFX\SCP\427\Transform.ogg")

			for i = 0 To 1
				if (Not ChannelPlaying(I_427\SoundCHN[i])):
					I_427\SoundCHN[i] = PlaySound_Strict(I_427\Sound[i])


			if randf(200)<2.0:
				pvt = CreatePivot()
				PositionEntity pvt, EntityX(Collider)+randf(-0.05,0.05),EntityY(Collider)-0.05,EntityZ(Collider)+randf(-0.05,0.05)
				TurnEntity pvt, 90, 0, 0
				EntityPick(pvt,0.3)
				de.Decals = CreateDecal(20, PickedX(), PickedY()+0.005, PickedZ(), 90, randi(360), 0)
				de.Size = randf(0.03,0.08)*2.0 : EntityAlpha(de.obj, 1.0) : ScaleSprite de.obj, de.Size, de.Size
				tempchn: int = PlaySound_Strict (DripSFX(randi(0,2)))
				ChannelVolume tempchn, randf(0.0,0.8)*SFXVolume
				ChannelPitch tempchn, randi(20000,30000)
				FreeEntity pvt
				BlurTimer = 800

			if I_427\Timer >= 70*420:
				Kill()
				DeathMSG = Chr(34)+"Requesting support from MTF Nu-7. We need more firepower to take this thing down."+Chr(34)
			elif I_427\Timer >= 70*390:
				Crouch = True



	


	func UpdateMTF: int()
		if PlayerRoom\RoomTemplate.Name = "gateaentrance": Return

		var r.Rooms, n.NPCs
		var dist: float, i: int

		;mtf ei vielä spawnannut, spawnataan jos pelaaja menee tarpeeksi lähelle gate b:tä
		if MTFtimer = 0:
			if randi(30)=1 And PlayerRoom\RoomTemplate.Name: String != "dimension1499":

				var entrance.Rooms = Null
				for r.Rooms = Each Rooms
					if Lower(r\RoomTemplate.Name) = "gateaentrance": entrance = r : break


				if entrance != Null:
					if Abs(EntityZ(entrance.obj)-EntityZ(Collider))<30.0:
						;if PlayerRoom\RoomTemplate.Name!="room860" And PlayerRoom\RoomTemplate.Name!="pocketdimension":
						if PlayerInReachableRoom()
							;PlaySound_Strict LoadTempSound("SFX\Character\MTF\Announc.ogg")
							PlayAnnouncement("SFX\Character\MTF\Announc.ogg")


						MTFtimer = FPSfactor
						var leader.NPCs
						for i = 0 To 2
							n.NPCs = CreateNPC(NPCtypeMTF, EntityX(entrance.obj)+0.3*(i-1), 1.0,EntityZ(entrance.obj)+8.0)

							if i = 0:
								leader = n
							else:
								n\MTFLeader = leader


							n\PrevX = i




		else:
			if MTFtimer <= 70*120 ;70*120
				MTFtimer = MTFtimer + FPSfactor
			elif MTFtimer > 70*120 And MTFtimer < 10000
				if PlayerInReachableRoom()
					PlayAnnouncement("SFX\Character\MTF\AnnouncAfter1.ogg")

				MTFtimer = 10000
			elif MTFtimer >= 10000 And MTFtimer <= 10000+(70*120) ;70*120
				MTFtimer = MTFtimer + FPSfactor
			elif MTFtimer > 10000+(70*120) And MTFtimer < 20000
				if PlayerInReachableRoom()
					PlayAnnouncement("SFX\Character\MTF\AnnouncAfter2.ogg")

				MTFtimer = 20000
			elif MTFtimer >= 20000 And MTFtimer <= 20000+(70*60) ;70*120
				MTFtimer = MTFtimer + FPSfactor
			elif MTFtimer > 20000+(70*60) And MTFtimer < 25000
				if PlayerInReachableRoom()
					;if the player has an SCP in their inventory play special voice line.
					for i = 0 To MaxItemAmount-1
						if Inventory(i) != Null:
							if (Left(Inventory(i)\itemtemplate.name, 4) = "SCP-") And (Left(Inventory(i)\itemtemplate.name, 7) != "SCP-035") And (Left(Inventory(i)\itemtemplate.name, 7) != "SCP-093")
								PlayAnnouncement("SFX\Character\MTF\ThreatAnnouncPossession.ogg")
								MTFtimer = 25000
								Return
								break




					PlayAnnouncement("SFX\Character\MTF\ThreatAnnounc"+randi(1,3)+".ogg")

				MTFtimer = 25000

			elif MTFtimer >= 25000 And MTFtimer <= 25000+(70*60) ;70*120
				MTFtimer = MTFtimer + FPSfactor
			elif MTFtimer > 25000+(70*60) And MTFtimer < 30000
				if PlayerInReachableRoom()
					PlayAnnouncement("SFX\Character\MTF\ThreatAnnouncFinal.ogg")

				MTFtimer = 30000




	


	func UpdateInfect()
		var temp: float, i: int, r.Rooms

		var teleportForInfect: int = True

		if PlayerRoom\RoomTemplate.Name = "room860"
			for e.Events = Each Events
				if e.EventName = "room860"
					if e.EventState = 1.0
						teleportForInfect = false

					break


		elif PlayerRoom\RoomTemplate.Name = "dimension1499" Or PlayerRoom\RoomTemplate.Name = "pocketdimension" Or PlayerRoom\RoomTemplate.Name = "gatea"
			teleportForInfect = false
		elif PlayerRoom\RoomTemplate.Name = "break1" And EntityY(Collider)>1040.0*RoomScale
			teleportForInfect = false


		if Infect>0:
			ShowEntity InfectOverlay

			if Infect < 93.0:
				temp=Infect
				if (Not I_427\Using And I_427\Timer < 70*360):
					Infect = Min(Infect+FPSfactor*0.002,100)


				BlurTimer = Max(Infect*3*(2.0-CrouchState),BlurTimer)

				HeartBeatRate = Max(HeartBeatRate, 100)
				HeartBeatVolume = Max(HeartBeatVolume, Infect/120.0)

				EntityAlpha InfectOverlay, Min(((Infect*0.2)^2)/1000.0,0.5) * (Sin(MilliSecs2()/8.0)+2.0)

				for i = 0 To 6
					if Infect>i*15+10 And temp =< i*15+10:
						PlaySound_Strict LoadTempSound("SFX\SCP\008\Voices"+i+".ogg")



				if Infect > 20 And temp =< 20.0:
					Msg = "You feel kinda feverish."
					MsgTimer = 70*6
				elif Infect > 40 And temp =< 40.0
					Msg = "You feel nauseated."
					MsgTimer = 70*6
				elif Infect > 60 And temp =< 60.0
					Msg = "The nausea's getting worse."
					MsgTimer = 70*6
				elif Infect > 80 And temp =< 80.0
					Msg = "You feel very faint."
					MsgTimer = 70*6
				elif Infect =>91.5
					BlinkTimer = Max(Min(-10*(Infect-91.5),BlinkTimer),-10)
					IsZombie = True
					UnableToMove = True
					if Infect >= 92.7 And temp < 92.7:
						if teleportForInfect
							for r.Rooms = Each Rooms
								if r\RoomTemplate.Name="008":
									PositionEntity Collider, EntityX(r\Objects[7],True),EntityY(r\Objects[7],True),EntityZ(r\Objects[7],True),True
									ResetEntity Collider
									r\NPC[0] = CreateNPC(NPCtypeD, EntityX(r\Objects[6],True),EntityY(r\Objects[6],True)+0.2,EntityZ(r\Objects[6],True))
									r\NPC[0]\Sound = LoadSound_Strict("SFX\SCP\008\KillScientist1.ogg")
									r\NPC[0]\SoundChn = PlaySound_Strict(r\NPC[0]\Sound)
									tex = LoadTexture_Strict("GFX\npcs\scientist2.jpg")
									EntityTexture r\NPC[0]\obj, tex
									FreeTexture tex
									r\NPC[0]\State=6
									PlayerRoom = r
									UnableToMove = false
									break





			else:

				temp=Infect
				Infect = Min(Infect+FPSfactor*0.004,100)

				if teleportForInfect
					if Infect < 94.7:
						EntityAlpha InfectOverlay, 0.5 * (Sin(MilliSecs2()/8.0)+2.0)
						BlurTimer = 900

						if Infect > 94.5: BlinkTimer = Max(Min(-50*(Infect-94.5),BlinkTimer),-10)
						PointEntity Collider, PlayerRoom\NPC[0]\Collider
						PointEntity PlayerRoom\NPC[0]\Collider, Collider
						PointEntity Camera, PlayerRoom\NPC[0]\Collider,EntityRoll(Camera)
						ForceMove = 0.75
						Injuries = 2.5
						Bloodloss = 0
						UnableToMove = false

						Animate2(PlayerRoom\NPC[0]\obj, AnimTime(PlayerRoom\NPC[0]\obj), 357, 381, 0.3)
					elif Infect < 98.5

						EntityAlpha InfectOverlay, 0.5 * (Sin(MilliSecs2()/5.0)+2.0)
						BlurTimer = 950

						ForceMove = 0.0
						UnableToMove = True
						PointEntity Camera, PlayerRoom\NPC[0]\Collider

						if temp < 94.7:
							PlayerRoom\NPC[0]\Sound = LoadSound_Strict("SFX\SCP\008\KillScientist2.ogg")
							PlayerRoom\NPC[0]\SoundChn = PlaySound_Strict(PlayerRoom\NPC[0]\Sound)

							DeathMSG = "Subject D-9341 found ingesting Dr. [REDACTED] at Sector [REDACTED]. Subject was immediately terminated by Nine-Tailed Fox and sent for autopsy. "
							DeathMSG = DeathMSG + "SCP-008 infection was confirmed, after which the body was incinerated."

							Kill()
							de.Decals = CreateDecal(3, EntityX(PlayerRoom\NPC[0]\Collider), 544*RoomScale + 0.01, EntityZ(PlayerRoom\NPC[0]\Collider),90,randf(360),0)
							de.Size = 0.8
							ScaleSprite(de.obj, de.Size,de.Size)
						elif Infect > 96
							BlinkTimer = Max(Min(-10*(Infect-96),BlinkTimer),-10)
						else:
							KillTimer = Max(-350, KillTimer)


						if PlayerRoom\NPC[0]\State2=0:
							Animate2(PlayerRoom\NPC[0]\obj, AnimTime(PlayerRoom\NPC[0]\obj), 13, 19, 0.3,False)
							if AnimTime(PlayerRoom\NPC[0]\obj) => 19: PlayerRoom\NPC[0]\State2=1
						else:
							Animate2(PlayerRoom\NPC[0]\obj, AnimTime(PlayerRoom\NPC[0]\obj), 19, 13, -0.3)
							if AnimTime(PlayerRoom\NPC[0]\obj) =< 13: PlayerRoom\NPC[0]\State2=0


						if ParticleAmount>0
							if randi(50)=1:
								p.Particles = CreateParticle(EntityX(PlayerRoom\NPC[0]\Collider),EntityY(PlayerRoom\NPC[0]\Collider),EntityZ(PlayerRoom\NPC[0]\Collider), 5, randf(0.05,0.1), 0.15, 200)
								p\speed = 0.01
								p\SizeChange = 0.01
								p\A = 0.5
								p\Achange = -0.01
								RotateEntity p\pvt, randf(360),randf(360),0



						PositionEntity Head, EntityX(PlayerRoom\NPC[0]\Collider,True), EntityY(PlayerRoom\NPC[0]\Collider,True)+0.65,EntityZ(PlayerRoom\NPC[0]\Collider,True),True
						RotateEntity Head, (1.0+Sin(MilliSecs2()/5.0))*15, PlayerRoom\angle-180, 0, True
						MoveEntity Head, 0,0,-0.4
						TurnEntity Head, 80+(Sin(MilliSecs2()/5.0))*30,(Sin(MilliSecs2()/5.0))*40,0

				else:
					Kill()
					BlinkTimer = Max(Min(-10*(Infect-96),BlinkTimer),-10)
					if PlayerRoom\RoomTemplate.Name = "dimension1499":
						DeathMSG = "The whereabouts of SCP-1499 are still unknown, but a recon team has been dispatched to investigate reports of a violent attack to a church in the Russian town of [REDACTED]."
					elif PlayerRoom\RoomTemplate.Name = "gatea" Or PlayerRoom\RoomTemplate.Name = "break1":
						DeathMSG = "Subject D-9341 found wandering around Gate "
						if PlayerRoom\RoomTemplate.Name = "gatea":
							DeathMSG = DeathMSG + "A"
						else:
							DeathMSG = DeathMSG + "B"

						DeathMSG = DeathMSG + ". Subject was immediately terminated by Nine-Tailed Fox and sent for autopsy. "
						DeathMSG = DeathMSG + "SCP-008 infection was confirmed, after which the body was incinerated."
					else:
						DeathMSG = ""





		else:
			HideEntity InfectOverlay

	

	;--------------------------------------- math -------------------------------------------------------

	func GenerateSeedNumber(seed: String)
	 	var temp: int = 0
	 	var shift: int = 0
	 	for i = 1 To Len(seed)
	 		temp = temp Xor (Asc(Mid(seed,i,1)) Shl shift)
	 		shift=(shift+1) Mod 24

	 	return temp
	

	func Distance: float(x1: float, y1: float, x2: float, y2: float)
		var x: float = x2 - x1, y: float = y2 - y1
		Return(Sqr(x*x + y*y))
	


	func CurveValue: float(number: float, old: float, smooth: float)
		if FPSfactor = 0: return old

		if number < old:
			return Max(old + (number - old) * (1.0 / smooth * FPSfactor), number)
		else:
			return Min(old + (number - old) * (1.0 / smooth * FPSfactor), number)

	

	func CurveAngle: float(val: float, old: float, smooth: float)
		if FPSfactor = 0: return old

	   var diff: float = WrapAngle(val) - WrapAngle(old)
	   if diff > 180: diff = diff - 360
	   if diff < - 180: diff = diff + 360
	   return WrapAngle(old + diff * (1.0 / smooth * FPSfactor))
	




	func WrapAngle: float(angle: float)
		if angle = INFINITY: return 0.0
		While angle < 0
			angle = angle + 360
		Wend
		While angle >= 360
			angle = angle - 360
		Wend
		return angle
	

	func GetAngle: float(x1: float, y1: float, x2: float, y2: float)
		return ATan2( y2 - y1, x2 - x1 )
	

	func CircleToLineSegIsect: int (cx: float, cy: float, r: float, l1x: float, l1y: float, l2x: float, l2y: float)

		;Palauttaa:
		;  True (1) kun:
		;      Ympyrä [keskipiste = (cx, cy): säde = r]
		;      leikkaa janan, joka kulkee pisteiden (l1x, l1y) & (l2x, l2y) kaitta
		;  false (0) muulloin

		;Ympyrän keskipisteen ja (ainakin toisen) janan päätepisteen etäisyys < r
		;-> leikkaus
		if Distance(cx, cy, l1x, l1y) <= r:
			return True


		if Distance(cx, cy, l2x, l2y) <= r:
			return True


		;Vektorit (janan vektori ja vektorit janan päätepisteistä ympyrän keskipisteeseen)
		var SegVecX: float = l2x - l1x
		var SegVecY: float = l2y - l1y

		var PntVec1X: float = cx - l1x
		var PntVec1Y: float = cy - l1y

		var PntVec2X: float = cx - l2x
		var PntVec2Y: float = cy - l2y

		;Em. vektorien pistetulot
		var dp1: float = SegVecX * PntVec1X + SegVecY * PntVec1Y
		var dp2: float = -SegVecX * PntVec2X - SegVecY * PntVec2Y

		;Tarkistaa onko toisen pistetulon arvo 0
		;tai molempien merkki sama
		if dp1 = 0 Or dp2 = 0:
		elif (dp1 > 0 And dp2 > 0) Or (dp1 < 0 And dp2 < 0):
		else:
			;Ei kumpikaan -> ei leikkausta
			return false


		;Janan päätepisteiden kautta kulkevan suoran ;yhtälö; (ax + by + c = 0)
		var a: float = (l2y - l1y) / (l2x - l1x)
		var b: float = -1
		var c: float = -(l2y - l1y) / (l2x - l1x) * l1x + l1y

		;Ympyrän keskipisteen etäisyys suorasta
		var d: float = Abs(a * cx + b * cy + c) / Sqr(a * a + b * b)

		;Ympyrä on liian kaukana
		;-> ei leikkausta
		if d > r: return false

		;var kateetin_pituus: float = Cos(angle) * hyp

		;Jos päästään tänne saakka, ympyrä ja jana leikkaavat (tai ovat sisäkkäin)
		return True
	

	func Min: float(a: float, b: float)
		if a < b:
			return a
		else:
			return b

	

	func Max: float(a: float, b: float)
		if a > b:
			return a
		else:
			return b

	

	func point_direction: float(x1: float,z1: float,x2: float,z2: float)
		var dx: float, dz: float
		dx = x1 - x2
		dz = z1 - z2
		return ATan2(dz,dx)
	

	func point_distance: float(x1: float,z1: float,x2: float,z2: float)
		var dx: float,dy: float
		dx = x1 - x2
		dy = z1 - z2
		return Sqr((dx*dx)+(dy*dy))
	

	func angleDist: float(a0: float,a1: float)
		var b: float = a0-a1
		var bb: float
		if b<-180.0:
			bb = b+360.0
		else: if b>180.0:
			bb = b-360.0
		else:
			bb = b

		return bb
	

	func Inverse: float(number: float)

		return float(1.0-number: float)

	

	func Rnd_Array: float(numb1: float,numb2: float,Array1: float,Array2: float)
		var whatarray: int = randi(1,2)

		if whatarray == 1
			return randf(Array1: float,numb1: float)
		else:
			return randf(numb2: float,Array2: float)



class Decals:
	var obj: int
	var SizeChange: float, Size: float, MaxSize: float
	var AlphaChange: float, Alpha: float
	var blendmode: int
	var fx: int
	var ID: int
	var Timer: float

	var lifetime: float

	var pos: Vector3
	var pitch: float
	var yaw: float
	var roll: float


func CreateDecal(id: int, x: float, y: float, z: float, pitch: float, yaw: float, roll: float) -> Decals:
	var d.Decals = New Decals

	d.x = x
	d.y = y
	d.z = z
	d.pitch = pitch
	d.yaw = yaw
	d.roll = roll

	d.MaxSize = 1.0

	d.Alpha = 1.0
	d.Size = 1.0
	d.obj = CreateSprite()
	d.blendmode = 1

	EntityTexture(d.obj, DecalTextures(id))
	EntityFX(d.obj, 0)
	SpriteViewMode(d.obj, 2)
	PositionEntity(d.obj, x, y, z)
	RotateEntity(d.obj, pitch, yaw, roll)

	d.ID = id

	if DecalTextures(id) == 0 or d.obj == 0:
		return Null

	return d


func UpdateDecals():
	for d: Decals in decals:
		if d.SizeChange != 0:
			d.Size += d.SizeChange * FPSfactor
			ScaleSprite(d.obj, d.Size, d.Size)

			match d.ID:
				0:
					if d.Timer <= 0:
						var angle: float = randi(360)
						var temp: float = randf(d.Size)
						var d2.Decals = CreateDecal(1, EntityX(d.obj) + Cos(angle) * temp, EntityY(d.obj) - 0.0005, EntityZ(d.obj) + Sin(angle) * temp, EntityPitch(d.obj), randf(360), EntityRoll(d.obj))
						d2.Size = randf(0.1, 0.5) : ScaleSprite(d2\obj, d2\Size, d2\Size)
						PlaySound2(DecaySFX(randi(1, 3)), Camera, d2\obj, 10.0, randf(0.1, 0.5))
						d.Timer = randi(50, 100)
					else:
						d.Timer= d.Timer-FPSfactor


			if d.Size >= d.MaxSize: d.SizeChange = 0 : d.Size = d.MaxSize


		if d.AlphaChange != 0:
			d.Alpha = Min(d.Alpha + FPSfactor * d.AlphaChange, 1.0)
			EntityAlpha(d.obj, d.Alpha)


		if d.lifetime > 0:
			d.lifetime=Max(d.lifetime-FPSfactor,5)


		if d.Size <= 0 Or d.Alpha <= 0 Or d.lifetime=5.0 :
			FreeEntity(d.obj)
			Delete (d)






class INIFile:
	var name: String
	var bank: int
	var bankOffset: int = 0
	var size: int


	func ReadINILine: String(file.INIFile)
		var rdbyte: int
		var firstbyte: int = True
		var offset: int = file.bankOffset
		var bank: int = file.bank
		var retStr: String = ""
		rdbyte = PeekByte(bank,offset)
		While ((firstbyte) Or ((rdbyte!=13) And (rdbyte!=10))) And (offset<file.size)
			rdbyte = PeekByte(bank,offset)
			if ((rdbyte!=13) And (rdbyte!=10)):
				firstbyte = false
				retStr=retStr+Chr(rdbyte)

			offset=offset+1
		Wend
		file.bankOffset = offset
		return retStr
	

func UpdateINIFile(filename: String) -> String:
	var file: INIFile = null
	for k: INIFile in iNIFile:
		if k.name = Lower(filename):
			file = k



	if file == null:
		return

	if file.bank!=0:
		FreeBank (file.bank)
	var f: int = ReadFile(file.name)
	var fleSize: int = 1
	while fleSize<FileSize(file.name):
		fleSize *= 2
	
	file.bank = CreateBank(fleSize)
	file.size = 0
	while !Eof(f):
		PokeByte(file.bank,file.size,ReadByte(f))
		file.size=file.size+1
	
	CloseFile(f)


func GetINIString(file: String, section: String, parameter: String, defaultvalue: String="") -> String:
	var TemporaryString: String = ""

	var lfile: INIFile = null
	for k: INIFile in iNIFile:
		if k.name = file.to_lower():
			lfile = k



	if lfile = Null:
		DebugLog "CREATE BANK for "+file
		lfile = New INIFile
		lfile.name = Lower(file)
		lfile.bank = 0
		UpdateINIFile(lfile.name)


	lfile.bankOffset = 0

	section = Lower(section)

	;While Not Eof(f)
	While lfile.bankOffset<lfile.size
		var strtemp: String = ReadINILine(lfile)
		if Left(strtemp,1) = "[":
			strtemp: String = Lower(strtemp)
			if Mid(strtemp, 2, Len(strtemp)-2)=section:
				Repeat
					TemporaryString = ReadINILine(lfile)
					if Lower(Trim(Left(TemporaryString, Max(Instr(TemporaryString, "=") - 1, 0)))) = Lower(parameter):
						;CloseFile f
						return Trim( Right(TemporaryString,Len(TemporaryString)-Instr(TemporaryString,"=")) )

				Until (Left(TemporaryString, 1) = "[") Or (lfile.bankOffset>=lfile.size)

				;CloseFile f
				return defaultvalue


	Wend

	return defaultvalue


	func GetINIInt: int(file: String, section: String, parameter: String, defaultvalue: int = 0)
		var txt: String = GetINIString(file: String, section: String, parameter: String, defaultvalue)
		if Lower(txt) = "true":
			return 1
		elif Lower(txt) = "false"
			return 0
		else:
			return Int(txt)

	

	func GetINIFloat: float(file: String, section: String, parameter: String, defaultvalue: float = 0.0)
		return Float(GetINIString(file: String, section: String, parameter: String, defaultvalue))
	


	func GetINIString2: String(file: String, start: int, parameter: String, defaultvalue: String="")
		var TemporaryString: String = ""
		var f: int = ReadFile(file)

		var n: int=0
		While Not Eof(f)
			var strtemp: String = ReadLine(f)
			n=n+1
			if n=start:
				Repeat
					TemporaryString = ReadLine(f)
					if Lower(Trim(Left(TemporaryString, Max(Instr(TemporaryString, "=") - 1, 0)))) = Lower(parameter):
						CloseFile f
						return Trim( Right(TemporaryString,Len(TemporaryString)-Instr(TemporaryString,"=")) )

				Until Left(TemporaryString, 1) = "[" Or Eof(f)
				CloseFile f
				return defaultvalue

		Wend

		CloseFile f

		return defaultvalue
	

	func GetINIInt2: int(file: String, start: int, parameter: String, defaultvalue: String="")
		var txt: String = GetINIString2(file: String, start: int, parameter: String, defaultvalue: String)
		if Lower(txt) = "true":
			return 1
		elif Lower(txt) = "false"
			return 0
		else:
			return Int(txt)

	


	func GetINISectionLocation: int(file: String, section: String)
		var Temp: int
		var f: int = ReadFile(file)

		section = Lower(section)

		var n: int=0
		While Not Eof(f)
			var strtemp: String = ReadLine(f)
			n=n+1
			if Left(strtemp,1) = "[":
				strtemp: String = Lower(strtemp)
				Temp = Instr(strtemp, section)
				if Temp>0:
					if Mid(strtemp, Temp-1, 1)="[" Or Mid(strtemp, Temp-1, 1)="|":
						CloseFile f
						return n



		Wend

		CloseFile f
	



	func PutINIValue: int(file: String, INI_sSection: String, INI_sKey: String, INI_sValue: String)

		; Returns: True (Success) Or false (Failed)

		INI_sSection = "[" + Trim: String(INI_sSection) + "]"
		var INI_sUpperSection: String = Upper: String(INI_sSection)
		INI_sKey = Trim: String(INI_sKey)
		INI_sValue = Trim: String(INI_sValue)
		var INI_sFilename: String = file: String

		; Retrieve the INI Data (if it exists)

		var INI_sContents: String = INI_FileToString(INI_sFilename)

			; (Re)Create the INI file updating/adding the SECTION, KEY And VALUE

		var INI_bWrittenKey: int = false
		var INI_bSectionFound: int = false
		var INI_sCurrentSection: String = ""

		var INI_lFileHandle: int = WriteFile(INI_sFilename)
		if INI_lFileHandle = 0: return false ; Create file failed!

		var INI_lOldPos: int = 1
		var INI_lPos: int = Instr(INI_sContents, Chr: String(0))

		While (INI_lPos != 0)

			var INI_sTemp: String = Mid: String(INI_sContents, INI_lOldPos, (INI_lPos - INI_lOldPos))

			if (INI_sTemp != ""):

				if Left: String(INI_sTemp, 1) = "[" And Right: String(INI_sTemp, 1) = "]":

						; Process SECTION

					if (INI_sCurrentSection = INI_sUpperSection) And (INI_bWrittenKey = false):
						INI_bWrittenKey = INI_CreateKey(INI_lFileHandle, INI_sKey, INI_sValue)

					INI_sCurrentSection = Upper: String(INI_CreateSection(INI_lFileHandle, INI_sTemp))
					if (INI_sCurrentSection = INI_sUpperSection): INI_bSectionFound = True

				else:
					if Left(INI_sTemp, 1) = ":":
						WriteLine INI_lFileHandle, INI_sTemp
					else:
							; KEY=VALUE
						var lEqualsPos: int = Instr(INI_sTemp, "=")
						if (lEqualsPos != 0):
							if (INI_sCurrentSection = INI_sUpperSection) And (Upper: String(Trim: String(Left: String(INI_sTemp, (lEqualsPos - 1)))) = Upper: String(INI_sKey)):
								if (INI_sValue != ""): INI_CreateKey INI_lFileHandle, INI_sKey, INI_sValue
								INI_bWrittenKey = True
							else:
								WriteLine INI_lFileHandle, INI_sTemp








				; Move through the INI file...

			INI_lOldPos = INI_lPos + 1
			INI_lPos: int = Instr(INI_sContents, Chr: String(0), INI_lOldPos)

		Wend

			; KEY wasn;t found in the INI file - Append a New SECTION if required And create our KEY=VALUE Line

		if (INI_bWrittenKey = false):
			if (INI_bSectionFound = false): INI_CreateSection INI_lFileHandle, INI_sSection
			INI_CreateKey INI_lFileHandle, INI_sKey, INI_sValue


		CloseFile INI_lFileHandle

		return True ; Success

	

	func INI_FileToString: String(INI_sFilename: String)

		var INI_sString: String = ""
		var INI_lFileHandle: int= ReadFile(INI_sFilename)
		if INI_lFileHandle != 0:
			While Not(Eof(INI_lFileHandle))
				INI_sString = INI_sString + ReadLine: String(INI_lFileHandle) + Chr: String(0)
			Wend
			CloseFile INI_lFileHandle

		return INI_sString

	

	func INI_CreateSection: String(INI_lFileHandle: int, INI_sNewSection: String)

		if FilePos(INI_lFileHandle) != 0: WriteLine INI_lFileHandle, "" ; Blank Line between sections
		WriteLine INI_lFileHandle, INI_sNewSection
		return INI_sNewSection

	

	func INI_CreateKey: int(INI_lFileHandle: int, INI_sKey: String, INI_sValue: String)

		WriteLine INI_lFileHandle, INI_sKey + " = " + INI_sValue
		return True

	

	;Save options to .ini.
	func SaveOptionsINI()

		PutINIValue(OptionFile, "options", "mouse sensitivity", MouseSens)
		PutINIValue(OptionFile, "options", "invert mouse y", InvertMouse)
		PutINIValue(OptionFile, "options", "bump mapping enabled", BumpEnabled)
		PutINIValue(OptionFile, "options", "HUD enabled", HUDenabled)
		PutINIValue(OptionFile, "options", "screengamma", ScreenGamma)
		PutINIValue(OptionFile, "options", "antialias", Opt_AntiAlias)
		PutINIValue(OptionFile, "options", "vsync", Vsync)
		PutINIValue(OptionFile, "options", "show FPS", ShowFPS)
		PutINIValue(OptionFile, "options", "framelimit", Framelimit: int)
		PutINIValue(OptionFile, "options", "achievement popup enabled", AchvMSGenabled: int)
		PutINIValue(OptionFile, "options", "room lights enabled", EnableRoomLights: int)
		PutINIValue(OptionFile, "options", "texture details", TextureDetails: int)
		PutINIValue(OptionFile, "console", "enabled", CanOpenConsole: int)
		PutINIValue(OptionFile, "console", "auto opening", ConsoleOpening: int)
		PutINIValue(OptionFile, "options", "antialiased text", AATextEnable)
		PutINIValue(OptionFile, "options", "particle amount", ParticleAmount)
		PutINIValue(OptionFile, "options", "enable vram", EnableVRam)
		PutINIValue(OptionFile, "options", "mouse smoothing", MouseSmooth)

		PutINIValue(OptionFile, "audio", "music volume", MusicVolume)
		PutINIValue(OptionFile, "audio", "sound volume", PrevSFXVolume)
		PutINIValue(OptionFile, "audio", "sfx release", EnableSFXRelease)
		PutINIValue(OptionFile, "audio", "enable user tracks", EnableUserTracks: int)
		PutINIValue(OptionFile, "audio", "user track setting", UserTrackMode: int)

		PutINIValue(OptionFile, "binds", "Right key", KEY_RIGHT)
		PutINIValue(OptionFile, "binds", "Left key", KEY_LEFT)
		PutINIValue(OptionFile, "binds", "Up key", KEY_UP)
		PutINIValue(OptionFile, "binds", "Down key", KEY_DOWN)
		PutINIValue(OptionFile, "binds", "Blink key", KEY_BLINK)
		PutINIValue(OptionFile, "binds", "Sprint key", KEY_SPRINT)
		PutINIValue(OptionFile, "binds", "Inventory key", KEY_INV)
		PutINIValue(OptionFile, "binds", "Crouch key", KEY_CROUCH)
		PutINIValue(OptionFile, "binds", "Save key", KEY_SAVE)
		PutINIValue(OptionFile, "binds", "Console key", KEY_CONSOLE)

	

	;--------------------------------------- MakeCollBox -functions -------------------------------------------------------


	; Create a collision box for a mesh entity taking into account entity scale
	; (will not work in non-uniform scaled space)
	func MakeCollBox(mesh: int)
		var sx: float = EntityScaleX(mesh, 1)
		var sy: float = Max(EntityScaleY(mesh, 1), 0.001)
		var sz: float = EntityScaleZ(mesh, 1)
		GetMeshExtents(mesh)
		EntityBox mesh, Mesh_MinX * sx, Mesh_MinY * sy, Mesh_MinZ * sz, Mesh_MagX * sx, Mesh_MagY * sy, Mesh_MagZ * sz
	

	; Find mesh extents
	func GetMeshExtents(Mesh: int)
		var s: int, surf: int, surfs: int, v: int, verts: int, x: float, y: float, z: float
		var minx: float = INFINITY
		var miny: float = INFINITY
		var minz: float = INFINITY
		var maxx: float = -INFINITY
		var maxy: float = -INFINITY
		var maxz: float = -INFINITY

		surfs = CountSurfaces(Mesh)

		for s = 1 To surfs
			surf = GetSurface(Mesh, s)
			verts = CountVertices(surf)

			for v = 0 To verts - 1
				x = VertexX(surf, v)
				y = VertexY(surf, v)
				z = VertexZ(surf, v)

				if (x < minx): minx = x
				if (x > maxx): maxx = x
				if (y < miny): miny = y
				if (y > maxy): maxy = y
				if (z < minz): minz = z
				if (z > maxz): maxz = z



		Mesh_MinX = minx
		Mesh_MinY = miny
		Mesh_MinZ = minz
		Mesh_MaxX = maxx
		Mesh_MaxY = maxy
		Mesh_MaxZ = maxz
		Mesh_MagX = maxx-minx
		Mesh_MagY = maxy-miny
		Mesh_MagZ = maxz-minz

	

	func EntityScaleX: float(entity: int, globl: int = false)
		if globl: TFormVector 1, 0, 0, entity, 0 else: TFormVector 1, 0, 0, entity, GetParent(entity)
		return Sqr(TFormedX() * TFormedX() + TFormedY() * TFormedY() + TFormedZ() * TFormedZ())
	

	func EntityScaleY: float(entity: int, globl: int = false)
		if globl: TFormVector 0, 1, 0, entity, 0 else: TFormVector 0, 1, 0, entity, GetParent(entity)
		return Sqr(TFormedX() * TFormedX() + TFormedY() * TFormedY() + TFormedZ() * TFormedZ())
	

	func EntityScaleZ: float(entity: int, globl: int = false)
		if globl: TFormVector 0, 0, 1, entity, 0 else: TFormVector 0, 0, 1, entity, GetParent(entity)
		return Sqr(TFormedX() * TFormedX() + TFormedY() * TFormedY() + TFormedZ() * TFormedZ())
	

	func Graphics3DExt: int(width: int,height: int,depth: int=32,mode: int=2)
		;if FE_InitExtFlag = 1: DeInitExt() ;prevent FastExt from breaking itself
		Graphics3D width,height,depth,mode
		InitFastResize()
		;InitExt()
		AntiAlias GetINIInt(OptionFile,"options","antialias")
		;TextureAnisotropy: int (GetINIInt(OptionFile,"options","anisotropy"),-1)
	

	func ResizeImage2(image: int,width: int,height: int)
		img: int = CreateImage(width,height)

		oldWidth: int = ImageWidth(image)
		oldHeight: int = ImageHeight(image)
		CopyRect 0,0,oldWidth,oldHeight,1024-oldWidth/2,1024-oldHeight/2,ImageBuffer(image),TextureBuffer(fresize_texture)
		SetBuffer BackBuffer()
		ScaleRender(0,0,2048.0 / Float(RealGraphicWidth) * Float(width) / Float(oldWidth), 2048.0 / Float(RealGraphicWidth) * Float(height) / Float(oldHeight))

		CopyRect RealGraphicWidth/2-width/2,RealGraphicHeight/2-height/2,width,height,0,0,BackBuffer(),ImageBuffer(img)

		FreeImage image
		return img
	


	func RenderWorld2()
		CameraProjMode ark_blur_cam,0
		CameraProjMode Camera,1

		if WearingNightVision>0 And WearingNightVision<3:
			AmbientLight Min(Brightness*2,255), Min(Brightness*2,255), Min(Brightness*2,255)
		elif WearingNightVision=3
			AmbientLight 255,255,255
		elif PlayerRoom!=Null
			if (PlayerRoom\RoomTemplate.Name!="173") And (PlayerRoom\RoomTemplate.Name!="break1") And (PlayerRoom\RoomTemplate.Name!="gatea"):
				AmbientLight Brightness, Brightness, Brightness



		IsNVGBlinking: int = false
		HideEntity NVBlink

		CameraViewport Camera,0,0,GraphicWidth,GraphicHeight

		var hasBattery: int = 2
		var power: int = 0
		if (WearingNightVision=1) Or (WearingNightVision=2)
			for i: int = 0 To MaxItemAmount - 1
				if (Inventory(i)!=Null):
					if (WearingNightVision = 1 And Inventory(i)\itemtemplate.tempname = "nvgoggles") Or (WearingNightVision = 2 And Inventory(i)\itemtemplate.tempname = "supernv"):
						Inventory(i)\state = Inventory(i)\state - (FPSfactor * (0.02 * WearingNightVision))
						power: int=Int(Inventory(i)\state)
						if Inventory(i)\state<=0.0:
							hasBattery = 0
							Msg = "The batteries in these night vision goggles died."
							BlinkTimer = -1.0
							MsgTimer = 350
							break
						elif Inventory(i)\state<=100.0:
							hasBattery = 1





			if (hasBattery):
				RenderWorld()

		else:
			RenderWorld()


		CurrTrisAmount = TrisRendered()

		if hasBattery=0 And WearingNightVision!=3
			IsNVGBlinking: int = True
			ShowEntity NVBlink: int


		if BlinkTimer < - 16 Or BlinkTimer > - 6
			if WearingNightVision=2 And hasBattery!=0: ;show a HUD
				NVTimer=NVTimer-FPSfactor

				if NVTimer<=0.0:
					for np.NPCs = Each NPCs
						np\NVX = EntityX(np\Collider,True)
						np\NVY = EntityY(np\Collider,True)
						np\NVZ = EntityZ(np\Collider,True)

					IsNVGBlinking: int = True
					ShowEntity NVBlink: int
					if NVTimer<=-10
					NVTimer = 600.0



				Color 255,255,255

				AASetFont Font3

				var plusY: int = 0
				if hasBattery=1: plusY: int = 40

				AAText GraphicWidth/2,(20+plusY)*MenuScale,"REFRESHING DATA IN",True,False

				AAText GraphicWidth/2,(60+plusY)*MenuScale,Max(f2s(NVTimer/60.0,1),0.0),True,False
				AAText GraphicWidth/2,(100+plusY)*MenuScale,"SECONDS",True,False

				temp: int = CreatePivot() : temp2: int = CreatePivot()
				PositionEntity temp, EntityX(Collider), EntityY(Collider), EntityZ(Collider)

				Color 255,255,255;*(NVTimer/600.0)

				for np.NPCs = Each NPCs
					if np\NVName!="" And (Not np\HideFromNVG): ;don't waste your time if the string is empty
						PositionEntity temp2,np\NVX,np\NVY,np\NVZ
						dist: float = EntityDistance(temp2,Collider)
						if dist<23.5: ;don't draw text if the NPC is too far away
							PointEntity temp, temp2
							yawvalue: float = WrapAngle(EntityYaw(Camera) - EntityYaw(temp))
							xvalue: float = 0.0
							if yawvalue > 90 And yawvalue <= 180:
								xvalue: float = Sin(90)/90*yawvalue
							else: if yawvalue > 180 And yawvalue < 270:
								xvalue: float = Sin(270)/yawvalue*270
							else:
								xvalue = Sin(yawvalue)

							pitchvalue: float = WrapAngle(EntityPitch(Camera) - EntityPitch(temp))
							yvalue: float = 0.0
							if pitchvalue > 90 And pitchvalue <= 180:
								yvalue: float = Sin(90)/90*pitchvalue
							else: if pitchvalue > 180 And pitchvalue < 270:
								yvalue: float = Sin(270)/pitchvalue*270
							else:
								yvalue: float = Sin(pitchvalue)


							if (Not IsNVGBlinking: int)
							AAText GraphicWidth / 2 + xvalue * (GraphicWidth / 2),GraphicHeight / 2 - yvalue * (GraphicHeight / 2),np\NVName,True,True
							AAText GraphicWidth / 2 + xvalue * (GraphicWidth / 2),GraphicHeight / 2 - yvalue * (GraphicHeight / 2) + 30.0 * MenuScale,f2s(dist,1)+" m",True,True





				FreeEntity (temp) : FreeEntity (temp2)

				Color 0,0,55
				for k=0 To 10
					Rect 45,GraphicHeight*0.5-(k*20),54,10,True

				Color 0,0,255
				for l=0 To Floor((power: int+50)*0.01)
					Rect 45,GraphicHeight*0.5-(l*20),54,10,True

				DrawImage NVGImages,40,GraphicHeight*0.5+30,1

				Color 255,255,255
			elif WearingNightVision=1 And hasBattery!=0
				Color 0,55,0
				for k=0 To 10
					Rect 45,GraphicHeight*0.5-(k*20),54,10,True

				Color 0,255,0
				for l=0 To Floor((power: int+50)*0.01)
					Rect 45,GraphicHeight*0.5-(l*20),54,10,True

				DrawImage NVGImages,40,GraphicHeight*0.5+30,0



		;render sprites
		CameraProjMode ark_blur_cam,2
		CameraProjMode Camera,0
		RenderWorld()
		CameraProjMode ark_blur_cam,0

		if BlinkTimer < - 16 Or BlinkTimer > - 6
			if (WearingNightVision=1 Or WearingNightVision=2) And (hasBattery=1) And ((MilliSecs2() Mod 800) < 400):
				Color 255,0,0
				AASetFont Font3

				AAText GraphicWidth/2,20*MenuScale,"WARNING: LOW BATTERY",True,False
				Color 255,255,255


	


	func ScaleRender(x: float,y: float,hscale: float=1.0,vscale: float=1.0)
		if Camera!=0: HideEntity Camera
		WireFrame 0
		ShowEntity fresize_image
		ScaleEntity fresize_image,hscale,vscale,1.0
		PositionEntity fresize_image, x, y, 1.0001
		ShowEntity fresize_cam
		RenderWorld()
		HideEntity fresize_cam
		HideEntity fresize_image
		WireFrame WireframeState
		if Camera!=0: ShowEntity Camera
	

	func InitFastResize()
		;Create Camera
		var cam: int = CreateCamera()
		CameraProjMode cam, 2
		CameraZoom cam, 0.1
		CameraClsMode cam, 0, 0
		CameraRange cam, 0.1, 1.5
		MoveEntity cam, 0, 0, -10000

		fresize_cam = cam

		;ark_sw = GraphicsWidth()
		;ark_sh = GraphicsHeight()

		;Create sprite
		var spr: int = CreateMesh(cam)
		var sf: int = CreateSurface(spr)
		AddVertex sf, -1, 1, 0, 0, 0
		AddVertex sf, 1, 1, 0, 1, 0
		AddVertex sf, -1, -1, 0, 0, 1
		AddVertex sf, 1, -1, 0, 1, 1
		AddTriangle sf, 0, 1, 2
		AddTriangle sf, 3, 2, 1
		EntityFX spr, 17
		ScaleEntity spr, 2048.0 / Float(RealGraphicWidth), 2048.0 / Float(RealGraphicHeight), 1
		PositionEntity spr, 0, 0, 1.0001
		EntityOrder spr, -100001
		EntityBlend spr, 1
		fresize_image = spr

		;Create texture
		fresize_texture = CreateTexture(2048, 2048, 1+256)
		fresize_texture2 = CreateTexture(2048, 2048, 1+256)
		TextureBlend fresize_texture2,3
		SetBuffer(TextureBuffer(fresize_texture2))
		ClsColor 0,0,0
		Cls
		SetBuffer(BackBuffer())
		;TextureAnisotropy(fresize_texture)
		EntityTexture spr, fresize_texture,0,0
		EntityTexture spr, fresize_texture2,0,1

		HideEntity fresize_cam
	

	;--------------------------------------- Some new 1.3 -functions -------------------------------------------------------

	func UpdateLeave1499()
		var r.Rooms, it.Items,r2.Rooms,i: int
		var r1499.Rooms

		if (Not Wearing1499) And PlayerRoom\RoomTemplate.Name: String = "dimension1499"
			for r.Rooms = Each Rooms
				if r = NTF_1499PrevRoom
					BlinkTimer = -1
					NTF_1499X: float = EntityX(Collider)
					NTF_1499Y: float = EntityY(Collider)
					NTF_1499Z: float = EntityZ(Collider)
					PositionEntity (Collider, NTF_1499PrevX: float, NTF_1499PrevY: float+0.05, NTF_1499PrevZ: float)
					ResetEntity(Collider)
					PlayerRoom = r
					UpdateDoors()
					UpdateRooms()
					if PlayerRoom\RoomTemplate.Name = "room3storage"
						if EntityY(Collider)<-4600*RoomScale
							for i = 0 To 2
								PlayerRoom\NPC[i]\State = 2
								PositionEntity(PlayerRoom\NPC[i]\Collider, EntityX(PlayerRoom\Objects[PlayerRoom\NPC[i]\State2],True),EntityY(PlayerRoom\Objects[PlayerRoom\NPC[i]\State2],True)+0.2,EntityZ(PlayerRoom\Objects[PlayerRoom\NPC[i]\State2],True))
								ResetEntity PlayerRoom\NPC[i]\Collider
								PlayerRoom\NPC[i]\State2 = PlayerRoom\NPC[i]\State2 + 1
								if PlayerRoom\NPC[i]\State2 > PlayerRoom\NPC[i]\PrevState: PlayerRoom\NPC[i]\State2 = (PlayerRoom\NPC[i]\PrevState-3)


					elif PlayerRoom\RoomTemplate.Name = "pocketdimension"
						CameraFogColor Camera, 0,0,0
						CameraClsColor Camera, 0,0,0

					for r2.Rooms = Each Rooms
						if r2\RoomTemplate.Name = "dimension1499"
							r1499 = r2
							break


					for it.Items = Each Items
						it\disttimer = 0
						if it\itemtemplate.tempname = "scp1499" Or it\itemtemplate.tempname = "super1499"
							if EntityY(it\collider) >= EntityY(r1499\obj)-5
								PositionEntity it\collider,NTF_1499PrevX: float,NTF_1499PrevY: float+(EntityY(it\collider)-EntityY(r1499\obj)),NTF_1499PrevZ: float
								ResetEntity it\collider
								break



					r1499 = Null
					ShouldEntitiesFall = false
					PlaySound_Strict (LoadTempSound("SFX\SCP\1499\break.ogg"))
					NTF_1499PrevX: float = 0.0
					NTF_1499PrevY: float = 0.0
					NTF_1499PrevZ: float = 0.0
					NTF_1499PrevRoom = Null
					break




	

	func CheckForPlayerInFacility()
		;False (=0): NPC is not in facility (mostly meant for "dimension1499")
		;True (=1): NPC is in facility
		;2: NPC is in tunnels (maintenance tunnels/049 tunnels/939 storage room, etc...)

		if EntityY(Collider)>100.0
			return false

		if EntityY(Collider)< -10.0
			return 2

		if EntityY(Collider)> 7.0 And EntityY(Collider)<=100.0
			return 2


		return True
	

	func IsItemGoodFor1162(itt.ItemTemplates)
		var IN: String = itt\tempname: String

		match itt\tempname
			"key1", "key2", "key3"
				return True
			"misc", "420", "cigarette"
				return True
			"vest", "finevest","gasmask"
				return True
			"radio","18vradio"
				return True
			"clipboard","eyedrops","nvgoggles"
				return True
			"drawing"
				if itt\img!=0: FreeImage itt\img
				itt\img = LoadImage_Strict("GFX\items\1048\1048_"+randi(1,20)+".jpg") ;Gives a random drawing.
				return True
			Default
				if itt\tempname != "paper":
					return false
				else: if Instr(itt\name, "Leaflet")
					return false
				else:
					;if the item is a paper, only allow spawning it if the name contains the word "note" or "log"
					;(because those are items created recently, which D-9341 has most likely never seen)
					return ((Not Instr(itt\name, "Note")) And (Not Instr(itt\name, "Log")))


	

	func ControlSoundVolume()
		var snd.Sound,i

		for snd.Sound = Each Sound
			for i=0 To 31
				;if snd.channels[i]!=0:
				;	ChannelVolume snd.channels[i],SFXVolume: float
				;else:
					ChannelVolume snd.channels[i],SFXVolume: float
				;



	

	func UpdateDeafPlayer()

		if DeafTimer > 0
			DeafTimer = DeafTimer-FPSfactor
			SFXVolume: float = 0.0
			if SFXVolume: float > 0.0
				ControlSoundVolume()

			DebugLog DeafTimer
		else:
			DeafTimer = 0
			;if SFXVolume: float < PrevSFXVolume: float
			;	SFXVolume: float = Min(SFXVolume: float + (0.001*PrevSFXVolume)*FPSfactor,PrevSFXVolume: float)
			;	ControlSoundVolume()
			;else:
				SFXVolume: float = PrevSFXVolume: float
				if DeafPlayer: ControlSoundVolume()
				DeafPlayer = false
			;


	

	func CheckTriggers: String()
		var i: int,sx: float,sy: float,sz: float
		var inside: int = -1

		if PlayerRoom\TriggerboxAmount = 0
			return ""
		else:
			for i = 0 To PlayerRoom\TriggerboxAmount-1
				EntityAlpha PlayerRoom\Triggerbox[i],1.0
				sx: float = EntityScaleX(PlayerRoom\Triggerbox[i], 1)
				sy: float = Max(EntityScaleY(PlayerRoom\Triggerbox[i], 1), 0.001)
				sz: float = EntityScaleZ(PlayerRoom\Triggerbox[i], 1)
				GetMeshExtents(PlayerRoom\Triggerbox[i])
				if DebugHUD
					EntityColor PlayerRoom\Triggerbox[i],255,255,0
					EntityAlpha PlayerRoom\Triggerbox[i],0.2
				else:
					EntityColor PlayerRoom\Triggerbox[i],255,255,255
					EntityAlpha PlayerRoom\Triggerbox[i],0.0

				if EntityX(Collider)>((sx: float*Mesh_MinX)+PlayerRoom\x) And EntityX(Collider)<((sx: float*Mesh_MaxX)+PlayerRoom\x)
					if EntityY(Collider)>((sy: float*Mesh_MinY)+PlayerRoom\y) And EntityY(Collider)<((sy: float*Mesh_MaxY)+PlayerRoom\y)
						if EntityZ(Collider)>((sz: float*Mesh_MinZ)+PlayerRoom\z) And EntityZ(Collider)<((sz: float*Mesh_MaxZ)+PlayerRoom\z)
							inside: int = i: int
							break





			if inside: int > -1: return PlayerRoom\TriggerboxName[inside: int]


	

	func ScaledMouseX: int()
		return Float(MouseX()-(RealGraphicWidth*0.5*(1.0-AspectRatioRatio)))*Float(GraphicWidth)/Float(RealGraphicWidth*AspectRatioRatio)
	

	func ScaledMouseY: int()
		return Float(MouseY())*Float(GraphicHeight)/Float(RealGraphicHeight)
	

	func CatchErrors(location: String)
		var errStr: String = ErrorLog()
		var errF: int
		if Len(errStr)>0:
			if FileType(ErrorFile)=0:
				errF = WriteFile(ErrorFile)
				WriteLine errF,"An error occured in SCP - Containment Breach!"
				WriteLine errF,"Version: "+VersionNumber
				WriteLine errF,"Save compatible version: "+CompatibleNumber
				WriteLine errF,"Date and time: "+CurrentDate()+" at "+CurrentTime()
				WriteLine errF,"Total video memory (MB): "+TotalVidMem()/1024/1024
				WriteLine errF,"Available video memory (MB): "+AvailVidMem()/1024/1024
				GlobalMemoryStatus m.MEMORYSTATUS
				WriteLine errF,"Global memory status: "+(m\dwAvailPhys: int/1024/1024)+" MB/"+(m\dwTotalPhys: int/1024/1024)+" MB ("+(m\dwAvailPhys: int/1024)+" KB/"+(m\dwTotalPhys: int/1024)+" KB)"
				WriteLine errF,"Triangles rendered: "+CurrTrisAmount
				WriteLine errF,"Active textures: "+ActiveTextures()
				WriteLine errF,""
				WriteLine errF,"Error(s):"
			else:
				var canwriteError: int = True
				errF = OpenFile(ErrorFile)
				While (Not Eof(errF))
					var l: String = ReadLine(errF)
					if Left(l,Len(location))=location
						canwriteError = false
						break

				Wend
				if canwriteError
					SeekFile errF,FileSize(ErrorFile)


			if canwriteError
				WriteLine errF,location+" ***************"
				While Len(errStr)>0
					WriteLine errF,errStr
					DebugLog errStr
					errStr = ErrorLog()
				Wend

			Msg = "Blitz3D Error! Details in "+Chr(34)+ErrorFile+Chr(34)
			MsgTimer = 20*70
			CloseFile errF

	

	func Create3DIcon(width: int,height: int,modelpath: String,modelX: float=0,modelY: float=0,modelZ: float=0,modelPitch: float=0,modelYaw: float=0,modelRoll: float=0,modelscaleX: float=1,modelscaleY: float=1,modelscaleZ: float=1,withfog: int=False)
		var img: int = CreateImage(width,height)
		var cam: int = CreateCamera()
		var model: int

		CameraRange cam,0.01,16
		CameraViewport cam,0,0,width,height
		if withfog
			CameraFogMode cam,1
			CameraFogRange cam,CameraFogNear,CameraFogFar


		if Right(Lower(modelpath: String),6)=".rmesh"
			model = LoadRMesh(modelpath: String,Null)
		else:
			model = LoadMesh(modelpath: String)

		ScaleEntity model,modelscaleX,modelscaleY,modelscaleZ
		PositionEntity model,modelX: float,modelY: float,modelZ: float
		RotateEntity model,modelPitch: float,modelYaw: float,modelRoll: float

		;Cls
		RenderWorld
		CopyRect 0,0,width,height,0,0,BackBuffer(),ImageBuffer(img)

		FreeEntity model
		FreeEntity cam
		return img: int
	

	func PlayAnnouncement(file: String) ;This func streams the announcement currently playing

		if IntercomStreamCHN != 0:
			StopStream_Strict(IntercomStreamCHN)
			IntercomStreamCHN = 0


		IntercomStreamCHN = StreamSound_Strict(file: String,SFXVolume,0)

	

func UpdateStreamSounds()
	var e: Events

	if FPSfactor > 0:
		if IntercomStreamCHN != 0:
			SetStreamVolume_Strict(IntercomStreamCHN,SFXVolume)

		for e = Each Events
			if e.SoundCHN!=0:
				if e.SoundCHN_isStream
					SetStreamVolume_Strict(e.SoundCHN,SFXVolume)


			if e.SoundCHN2!=0:
				if e.SoundCHN2_isStream
					SetStreamVolume_Strict(e.SoundCHN2,SFXVolume)





	if (Not PlayerInReachableRoom()):
		if PlayerRoom\RoomTemplate.Name != "break1" And PlayerRoom\RoomTemplate.Name != "gatea":
			if IntercomStreamCHN != 0:
				StopStream_Strict(IntercomStreamCHN)
				IntercomStreamCHN = 0

			if PlayerRoom\RoomTemplate.Name: String != "dimension1499":
				for e = Each Events
					if e.SoundCHN!=0 And e.SoundCHN_isStream:
						StopStream_Strict(e.SoundCHN)
						e.SoundCHN = 0
						e.SoundCHN_isStream = 0

					if e.SoundCHN2!=0 And e.SoundCHN2_isStream:
						StopStream_Strict(e.SoundCHN2)
						e.SoundCHN = 0
						e.SoundCHN_isStream = 0








func TeleportEntity(entity: int,x: float,y: float,z: float,customradius: float=0.3,isglobal: int=False,pickrange: float=2.0,dir: int=0)
	var pvt
	var pick

	pvt = CreatePivot()
	PositionEntity(pvt, x,y+0.05,z,isglobal)
	if dir == 0:
		RotateEntity(pvt,90,0,0)
	else:
		RotateEntity (pvt,-90,0,0)

	pick = EntityPick(pvt,pickrange)
	if pick != 0:
		if dir == 0:
			PositionEntity(entity, x,PickedY()+customradius: float+0.02,z,isglobal)
		else:
			PositionEntity(entity, x,PickedY()+customradius: float-0.02,z,isglobal)

		DebugLog("Entity teleported successfully")
	else:
		PositionEntity(entity,x,y,z,isglobal)
		DebugLog ("Warning: no ground found when teleporting an entity")

	FreeEntity (pvt)
	ResetEntity (entity)
	DebugLog ("Teleported entity to: "+EntityX(entity)+"/"+EntityY(entity)+"/"+EntityZ(entity))



func PlayStartupVideos()

	if GetINIInt("options.ini","options","play startup video")=0:
		return

	var Cam = CreateCamera()
	CameraClsMode (Cam, 0, 1)
	var Quad = CreateQuad()
	var Texture = CreateTexture(2048, 2048, 256 Or 16 Or 32)
	EntityTexture (Quad, Texture)
	EntityFX (Quad, 1)
	CameraRange (Cam, 0.01, 100)
	TranslateEntity (Cam, 1.0 / 2048 ,-1.0 / 2048 ,-1.0)
	EntityParent (Quad, Cam, 1)

	var ScaledGraphicHeight: int
	var Ratio: float = Float(RealGraphicWidth)/Float(RealGraphicHeight)
	if Ratio>1.76 And Ratio<1.78
		ScaledGraphicHeight = RealGraphicHeight
		DebugLog "Not Scaled"
	else:
		ScaledGraphicHeight: int = Float(RealGraphicWidth)/(16.0/9.0)
		DebugLog "Scaled: "+ScaledGraphicHeight


	var moviefile: String = "GFX\menu\startup_Undertow"
	BlitzMovie_Open(moviefile: String+".avi") ;Get movie size
	var moview = BlitzMovie_GetWidth()
	var movieh = BlitzMovie_GetHeight()
	BlitzMovie_Close()
	var image = CreateImage(moview, movieh)
	var SplashScreenVideo = BlitzMovie_OpenDecodeToImage(moviefile: String+".avi", image, false)
	SplashScreenVideo = BlitzMovie_Play()
	var SplashScreenAudio = StreamSound_Strict(moviefile + ".ogg",SFXVolume,0)
	while !(GetKey() or (!IsStreamPlaying_Strict(SplashScreenAudio))):
		Cls()
		ProjectImage(image, RealGraphicWidth, ScaledGraphicHeight, Quad, Texture)
		Flip()

	StopStream_Strict(SplashScreenAudio)
	BlitzMovie_Stop()
	BlitzMovie_Close()
	FreeImage (image)

	Cls()
	Flip()

	moviefile: String = "GFX\\menu\\startup_TSS"
	BlitzMovie_Open(moviefile + ".avi")
	moview = BlitzMovie_GetWidth()
	movieh = BlitzMovie_GetHeight()
	BlitzMovie_Close()
	image = CreateImage(moview, movieh)
	SplashScreenVideo = BlitzMovie_OpenDecodeToImage(moviefile + ".avi", image, false)
	SplashScreenVideo = BlitzMovie_Play()
	SplashScreenAudio = StreamSound_Strict(moviefile + ".ogg",SFXVolume,0)

	while !(GetKey() or !IsStreamPlaying_Strict(SplashScreenAudio)):
		Cls()
		ProjectImage(image, RealGraphicWidth, ScaledGraphicHeight, Quad, Texture)
		Flip()

	StopStream_Strict(SplashScreenAudio)
	BlitzMovie_Stop()
	BlitzMovie_Close()

	FreeTexture (Texture)
	FreeEntity (Quad)
	FreeEntity (Cam)
	FreeImage (image)
	Cls()
	Flip()



	func ProjectImage(img, w: float, h: float, Quad: int, Texture: int)

		var img_w: float = ImageWidth(img)
		var img_h: float = ImageHeight(img)
		if img_w > 2048:
			img_w = 2048
		if img_h > 2048:
			img_h = 2048
		if img_w < 1:
			img_w = 1
		if img_h < 1:
			img_h = 1

		if w > 2048: w = 2048
		if h > 2048: h = 2048
		if w < 1: w = 1
		if h < 1: h = 1

		var w_rel: float = w / img_w
		var h_rel: float = h / img_h
		var g_rel: float = 2048.0 / Float(RealGraphicWidth)
		var dst_x = 1024 - (img_w / 2.0)
		var dst_y = 1024 - (img_h / 2.0)
		CopyRect (0, 0, img_w, img_h, dst_x, dst_y, ImageBuffer(img), TextureBuffer(Texture))
		ScaleEntity (Quad, w_rel * g_rel, h_rel * g_rel, 0.0001)
		RenderWorld()



	func CreateQuad():

		mesh = CreateMesh()
		surf = CreateSurface(mesh)
		v0 = AddVertex(surf,-1.0, 1.0, 0, 0, 0)
		v1 = AddVertex(surf, 1.0, 1.0, 0, 1, 0)
		v2 = AddVertex(surf, 1.0,-1.0, 0, 1, 1)
		v3 = AddVertex(surf,-1.0,-1.0, 0, 0, 1)
		AddTriangle(surf, v0, v1, v2)
		AddTriangle(surf, v0, v2, v3)
		UpdateNormals (mesh)
		return mesh


	func CanUseItem(canUseWithHazmat: int, canUseWithGasMask: int, canUseWithEyewear: int)
		if (!canUseWithHazmat and WearingHazmat):
			Msg = "You can't use that item while wearing a hazmat suit."
			MsgTimer = 70*5
			return false
		elif (!canUseWithGasMask and (WearingGasMask or Wearing1499)):
			Msg = "You can't use that item while wearing a gas mask."
			MsgTimer = 70*5
			return false
		elif (!canUseWithEyewear and (WearingNightVision))
			Msg = "You can't use that item while wearing headgear."


		return true
	

func ResetInput():

	FlushKeys()
	FlushMouse()
	MouseHit1 = 0
	MouseHit2 = 0
	MouseDown1 = 0
	MouseUp1 = 0
	MouseHit(1)
	MouseHit(2)
	MouseDown(1)
	GrabbedEntity = 0
	Input_ResetTime: float = 10.0


func Update096ElevatorEvent(e: Events, EventState: float, d: Doors, elevatorobj: int) -> float:
	var prevEventState: float = EventState

	if EventState < 0:
		EventState = 0
		prevEventState = 0


	if d.openstate == 0 and !d.open:
		if Abs(EntityX(Collider)-EntityX(elevatorobj: int,True))<=280.0*RoomScale+(0.015*FPSfactor):
			if Abs(EntityZ(Collider)-EntityZ(elevatorobj: int,True))<=280.0*RoomScale+(0.015*FPSfactor):
				if Abs(EntityY(Collider)-EntityY(elevatorobj: int,True))<=280.0*RoomScale+(0.015*FPSfactor):
					d.locked = True
					if EventState == 0:
						TeleportEntity(Curr096.Collider,EntityX(d.frameobj),EntityY(d.frameobj)+1.0,EntityZ(d.frameobj),Curr096.CollRadius)
						PointEntity Curr096.Collider,elevatorobj
						RotateEntity Curr096.Collider,0,EntityYaw(Curr096.Collider),0
						MoveEntity Curr096.Collider,0,0,-0.5
						ResetEntity Curr096.Collider
						Curr096.State = 6
						SetNPCFrame(Curr096,0)
						e.Sound = LoadSound_Strict("SFX\\SCP\\096\\ElevatorSlam.ogg")
						EventState += + FPSfactor * 1.4






	if EventState > 0:
		if prevEventState = 0:
			e.SoundCHN = PlaySound_Strict(e.Sound)


		if EventState > 70*1.9 and EventState < 70*2+FPSfactor:
			CameraShake = 7
		elif EventState > 70*4.2 and EventState < 70*4.25+FPSfactor:
			CameraShake = 1
		elif EventState > 70*5.9 and EventState < 70*5.95+FPSfactor:
			CameraShake = 1
		elif EventState > 70*7.25 and EventState < 70*7.3+FPSfactor:
			CameraShake = 1
			d.fastopen = true
			d.open = true
			Curr096.State = 4
			Curr096.LastSeen = 1
		elif EventState > 70*8.1 and EventState < 70*8.15+FPSfactor
			CameraShake = 1


		if EventState <= 70*8.1:
			d.openstate = min(d.openstate,20)

		EventState += FPSfactor * 1.4

	return EventState


func RotateEntity90DegreeAngles(entity: int) -> int:
	var angle: float = WrapAngle(entity)

	if angle < 45:
		return 0
	elif angle >= 45 and angle < 135:
		return 90
	elif angle >= 135 And angle < 225:
		return 180
	else::
		return 270


class ConsoleMsg:
	var txt: String
	var isCommand: int
	var r: int
	var g: int
	var b: int
