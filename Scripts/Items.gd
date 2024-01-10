

const MaxItemAmount: int = 10

var Inventory: Array[Items] = Array(MaxItemAmount + 1)





func CreateItemTemplate(name: String, tempname: String, objpath: String, invimgpath: String, imgpath: String, scale: float, texturepath: String = "",invimgpath2: String="",Anim: int=0, texflags: int=9) -> ItemTemplates:
	var it: ItemTemplates = ItemTemplates.new()
	var n
	
	
	for it2: itemtemplates in ItemTemplates:
		if it2.objpath == objpath and it2.obj != 0 :
			it.obj = CopyEntity(it2.obj)
			it.parentobjpath=it2.objpath
			break
	
	
	if it.obj == 0:
		if Anim != 0:
			it.obj = LoadAnimMesh_Strict(objpath)
			it.isAnim=True
		else:
			it.obj = LoadMesh_Strict(objpath)
			it.isAnim=False
		
		it.objpath = objpath
	
	it.objpath = objpath
	
	var texture: int
	
	if texturepath != "" :
		for it2: itemtemplates in ItemTemplates:
			if it2.texpath == texturepath and it2.tex != 0:
				texture = it2.tex
				break
			
		
		if texture == 0:
			texture = LoadTexture_Strict(texturepath,texflags) #int
			it.texpath = texturepath
		EntityTexture(it.obj, texture)
		it.tex = texture
	  
	
	it.scale = scale
	ScaleEntity (it.obj, scale, scale, scale, True)
	

	for it2: itemtemplates in ItemTemplates:
		if it2.invimgpath == invimgpath and it2.invimg != 0 :
			it.invimg = it2.invimg 
			if it2.invimg2 != 0 :
				it.invimg2=it2.invimg2 
			
			break
		
	
	if it.invimg == 0 :
		it.invimg = LoadImage_Strict(invimgpath)
		it.invimgpath = invimgpath
		MaskImage(it.invimg, 255, 0, 255)
	
	
	if (invimgpath2 != ""):
		if it.invimg2==0:
			it.invimg2 = LoadImage_Strict(invimgpath2)
			MaskImage(it.invimg2,255,0,255)
		
	else:
		it.invimg2 = 0
	
	
	it.imgpath = imgpath
	
	it.tempname = tempname
	it.name = name
	
	it.sound = 1

	HideEntity(it.obj)
	
	return it
	


func InitItemTemplates() -> void:
	var it: ItemTemplates


	it = CreateItemTemplate("Recall Protocol RP-106-N", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docRP.jpg", 0.0025) : it\sound = 0
	it = CreateItemTemplate("Document SCP-682", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc682.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-173", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc173.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-372", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc372.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-049", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc049.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-096", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc096.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-008", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc008.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-012", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc012.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-500", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc500.png", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-714", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc714.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-513", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc513.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-035", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc035.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("SCP-035 Addendum", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc035ad.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-939", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc939.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-966", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc966.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-970", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc970.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-1048", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc1048.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-1123", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc1123.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-1162", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc1162.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document SCP-1499", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc1499.png", 0.003) : it\sound = 0
	it = CreateItemTemplate("Incident Report SCP-1048-A", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc1048a.jpg", 0.003) : it\sound = 0
	
	it = CreateItemTemplate("Drawing", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc1048.jpg", 0.003) : it\sound = 0
	
	it = CreateItemTemplate("Leaflet", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\leaflet.jpg", 0.003, "GFX\items\notetexture.jpg") : it\sound = 0
	
	it = CreateItemTemplate("Dr. L's Note", "paper", "GFX\items\paper.x", "GFX\items\INVnote.jpg", "GFX\items\docL1.jpg", 0.0025, "GFX\items\notetexture.jpg") : it\sound = 0
	it = CreateItemTemplate("Dr L's Note", "paper", "GFX\items\paper.x", "GFX\items\INVnote.jpg", "GFX\items\docL2.jpg", 0.0025, "GFX\items\notetexture.jpg") : it\sound = 0
	it = CreateItemTemplate("Blood-stained Note", "paper", "GFX\items\paper.x", "GFX\items\INVnote.jpg", "GFX\items\docL3.jpg", 0.0025, "GFX\items\notetexture.jpg") : it\sound = 0
	it = CreateItemTemplate("Dr. L's Burnt Note", "paper", "GFX\items\paper.x", "GFX\items\INVbn.jpg", "GFX\items\docL4.jpg", 0.0025, "GFX\items\BurntNoteTexture.jpg") : it\sound = 0
	it = CreateItemTemplate("Dr L's Burnt Note", "paper", "GFX\items\paper.x", "GFX\items\INVbn.jpg", "GFX\items\docL5.jpg", 0.0025, "GFX\items\BurntNoteTexture.jpg") : it\sound = 0
	it = CreateItemTemplate("Scorched Note", "paper", "GFX\items\paper.x", "GFX\items\INVbn.jpg", "GFX\items\docL6.jpg", 0.0025, "GFX\items\BurntNoteTexture.jpg") : it\sound = 0
	
	it = CreateItemTemplate("Journal Page", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docGonzales.jpg", 0.0025) : it\sound = 0
	
	
	it = CreateItemTemplate("Log #1", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\f4.jpg", 0.004, "GFX\items\f4.jpg") : it\sound = 0
	it = CreateItemTemplate("Log #2", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\f5.jpg", 0.004, "GFX\items\f4.jpg") : it\sound = 0
	it = CreateItemTemplate("Log #3", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\f6.jpg", 0.004, "GFX\items\f4.jpg") : it\sound = 0
	
	it = CreateItemTemplate("Strange Note", "paper", "GFX\items\paper.x", "GFX\items\INVnote.jpg", "GFX\items\docStrange.jpg", 0.0025, "GFX\items\notetexture.jpg") : it\sound = 0
	
	it = CreateItemTemplate("Nuclear Device Document", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docNDP.jpg", 0.003) : it\sound = 0	
	it = CreateItemTemplate("Class D Orientation Leaflet", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docORI.jpg", 0.003) : it\sound = 0	
	
	it = CreateItemTemplate("Note from Daniel", "paper", "GFX\items\note.x", "GFX\items\INVnote2.jpg", "GFX\items\docdan.jpg", 0.0025) : it\sound = 0
	
	it = CreateItemTemplate("Burnt Note", "paper", "GFX\items\paper.x", "GFX\items\INVbn.jpg", "GFX\items\bn.it", 0.003, "GFX\items\BurntNoteTexture.jpg")
	it.img = BurntNote
	it.sound = 0
	
	it = CreateItemTemplate("Mysterious Note", "paper", "GFX\items\paper.x", "GFX\items\INVnote.jpg", "GFX\items\sn.it", 0.003, "GFX\items\notetexture.jpg") : it\sound = 0	
	
	it = CreateItemTemplate("Mobile Task Forces", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docMTF.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Security Clearance Levels", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docSC.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Object Classes", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docOBJC.jpg", 0.003) : it\sound = 0
	it = CreateItemTemplate("Document", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docRAND3.jpg", 0.003) : it\sound = 0 
	it = CreateItemTemplate("Addendum: 5/14 Test Log", "paper", "GFX\items\paper.x", "GFX\items\INVnote.jpg", "GFX\items\docRAND2.jpg", 0.003, "GFX\items\notetexture.jpg") : it\sound = 0 
	it = CreateItemTemplate("Notification", "paper", "GFX\items\paper.x", "GFX\items\INVnote.jpg", "GFX\items\docRAND1.jpg", 0.003, "GFX\items\notetexture.jpg") :it\sound = 0 	
	it = CreateItemTemplate("Incident Report SCP-106-0204", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docIR106.jpg", 0.003) : it\sound = 0 
	
	it = CreateItemTemplate("Ballistic Vest", "vest", "GFX\items\vest.x", "GFX\items\INVvest.jpg", "", 0.02,"GFX\items\Vest.png") : it\sound = 2

	it = CreateItemTemplate("Bulky Ballistic Vest", "veryfinevest", "GFX\items\vest.x", "GFX\items\INVvest.jpg", "", 0.025,"GFX\items\Vest.png")
	it.sound = 2
	
	it = CreateItemTemplate("Hazmat Suit", "hazmatsuit", "GFX\items\hazmat.b3d", "GFX\items\INVhazmat.jpg", "", 0.013)
	it.sound = 2
	it = CreateItemTemplate("Hazmat Suit", "hazmatsuit2", "GFX\items\hazmat.b3d", "GFX\items\INVhazmat.jpg", "", 0.013)
	it\sound = 2
	it = CreateItemTemplate("Heavy Hazmat Suit", "hazmatsuit3", "GFX\items\hazmat.b3d", "GFX\items\INVhazmat.jpg", "", 0.013)
	it\sound = 2
	
	it = CreateItemTemplate("cup", "cup", "GFX\items\cup.x", "GFX\items\INVcup.jpg", "", 0.04) : it\sound = 2
	
	it = CreateItemTemplate("Empty Cup", "emptycup", "GFX\items\cup.x", "GFX\items\INVcup.jpg", "", 0.04) : it\sound = 2	
	
	it = CreateItemTemplate("SCP-500-01", "scp500", "GFX\items\pill.b3d", "GFX\items\INVpill.jpg", "", 0.0001) : it\sound = 2
	EntityColor it\obj,255,0,0
	
	it = CreateItemTemplate("First Aid Kit", "firstaid", "GFX\items\firstaid.x", "GFX\items\INVfirstaid.jpg", "", 0.05)
	it = CreateItemTemplate("Small First Aid Kit", "finefirstaid", "GFX\items\firstaid.x", "GFX\items\INVfirstaid.jpg", "", 0.03)
	it = CreateItemTemplate("Blue First Aid Kit", "firstaid2", "GFX\items\firstaid.x", "GFX\items\INVfirstaid2.jpg", "", 0.03, "GFX\items\firstaidkit2.jpg")
	it = CreateItemTemplate("Strange Bottle", "veryfinefirstaid", "GFX\items\eyedrops.b3d", "GFX\items\INVbottle.jpg", "", 0.002, "GFX\items\bottle.jpg")	
	
	it = CreateItemTemplate("Gas Mask", "gasmask", "GFX\items\gasmask.b3d", "GFX\items\INVgasmask.jpg", "", 0.02) : it\sound = 2
	it = CreateItemTemplate("Gas Mask", "supergasmask", "GFX\items\gasmask.b3d", "GFX\items\INVgasmask.jpg", "", 0.021) : it\sound = 2
	it = CreateItemTemplate("Heavy Gas Mask", "gasmask3", "GFX\items\gasmask.b3d", "GFX\items\INVgasmask.jpg", "", 0.021) : it\sound = 2
	
	it = CreateItemTemplate("Origami", "misc", "GFX\items\origami.b3d", "GFX\items\INVorigami.jpg", "", 0.003) : it\sound = 0
	
	CreateItemTemplate("Electronical components", "misc", "GFX\items\electronics.x", "GFX\items\INVelectronics.jpg", "", 0.0011)
	
	it = CreateItemTemplate("Metal Panel", "scp148", "GFX\items\metalpanel.x", "GFX\items\INVmetalpanel.jpg", "", RoomScale) : it\sound = 2
	it = CreateItemTemplate("SCP-148 Ingot", "scp148ingot", "GFX\items\scp148.x", "GFX\items\INVscp148.jpg", "", RoomScale) : it\sound = 2
	
	CreateItemTemplate("S-NAV 300 Navigator", "nav", "GFX\items\navigator.x", "GFX\items\INVnavigator.jpg", "GFX\items\navigator.png", 0.0008)
	CreateItemTemplate("S-NAV Navigator", "nav", "GFX\items\navigator.x", "GFX\items\INVnavigator.jpg", "GFX\items\navigator.png", 0.0008)
	CreateItemTemplate("S-NAV Navigator Ultimate", "nav", "GFX\items\navigator.x", "GFX\items\INVnavigator.jpg", "GFX\items\navigator.png", 0.0008)
	CreateItemTemplate("S-NAV 310 Navigator", "nav", "GFX\items\navigator.x", "GFX\items\INVnavigator.jpg", "GFX\items\navigator.png", 0.0008)
	
	CreateItemTemplate("Radio Transceiver", "radio", "GFX\items\radio.x", "GFX\items\INVradio.jpg", "GFX\items\radioHUD.png", 1.0)
	CreateItemTemplate("Radio Transceiver", "fineradio", "GFX\items\radio.x", "GFX\items\INVradio.jpg", "GFX\items\radioHUD.png", 1.0)
	CreateItemTemplate("Radio Transceiver", "veryfineradio", "GFX\items\radio.x", "GFX\items\INVradio.jpg", "GFX\items\radioHUD.png", 1.0)
	CreateItemTemplate("Radio Transceiver", "18vradio", "GFX\items\radio.x", "GFX\items\INVradio.jpg", "GFX\items\radioHUD.png", 1.02)
	
	it = CreateItemTemplate("Cigarette", "cigarette", "GFX\items\420.x", "GFX\items\INV420.jpg", "", 0.0004) : it\sound = 2
	
	it = CreateItemTemplate("Joint", "420s", "GFX\items\420.x", "GFX\items\INV420.jpg", "", 0.0004) : it\sound = 2
	
	it = CreateItemTemplate("Smelly Joint", "420s", "GFX\items\420.x", "GFX\items\INV420.jpg", "", 0.0004) : it\sound = 2
	
	it = CreateItemTemplate("Severed Hand", "hand", "GFX\items\severedhand.b3d", "GFX\items\INVhand.jpg", "", 0.04) : it\sound = 2
	it = CreateItemTemplate("Black Severed Hand", "hand2", "GFX\items\severedhand.b3d", "GFX\items\INVhand2.jpg", "", 0.04, "GFX\items\shand2.png") : it\sound = 2
	
	CreateItemTemplate("9V Battery", "bat", "GFX\items\Battery\Battery.x", "GFX\items\Battery\INVbattery9v.jpg", "", 0.008)
	CreateItemTemplate("18V Battery", "18vbat", "GFX\items\Battery\Battery.x", "GFX\items\Battery\INVbattery18v.jpg", "", 0.01, "GFX\items\Battery\Battery 18V.jpg")
	CreateItemTemplate("Strange Battery", "killbat", "GFX\items\Battery\Battery.x", "GFX\items\Battery\INVbattery22900.jpg", "", 0.01,"GFX\items\Battery\Strange Battery.jpg")
	
	CreateItemTemplate("Eyedrops", "fineeyedrops", "GFX\items\eyedrops.b3d", "GFX\items\INVeyedrops.jpg", "", 0.0012, "GFX\items\eyedrops.jpg")
	CreateItemTemplate("Eyedrops", "supereyedrops", "GFX\items\eyedrops.b3d", "GFX\items\INVeyedrops.jpg", "", 0.0012, "GFX\items\eyedrops.jpg")
	CreateItemTemplate("ReVision Eyedrops", "eyedrops","GFX\items\eyedrops.b3d", "GFX\items\INVeyedrops.jpg", "", 0.0012, "GFX\items\eyedrops.jpg")
	CreateItemTemplate("RedVision Eyedrops", "eyedrops", "GFX\items\eyedrops.b3d", "GFX\items\INVeyedropsred.jpg", "", 0.0012,"GFX\items\eyedropsred.jpg")
	
	it = CreateItemTemplate("SCP-714", "scp714", "GFX\items\scp714.b3d", "GFX\items\INV714.jpg", "", 0.3)
	it\sound = 3
	
	it = CreateItemTemplate("SCP-1025", "scp1025", "GFX\items\scp1025.b3d", "GFX\items\INV1025.jpg", "", 0.1)
	it\sound = 0
	
	it = CreateItemTemplate("SCP-513", "scp513", "GFX\items\513.x", "GFX\items\INV513.jpg", "", 0.1)
	it\sound = 2

	
	it = CreateItemTemplate("SCP-1123", "1123", "GFX\items\HGIB_Skull1.b3d", "GFX\items\inv1123.jpg", "", 0.015) : it\sound = 2
	

	
	it = CreateItemTemplate("Night Vision Goggles", "supernv", "GFX\items\NVG.b3d", "GFX\items\INVsupernightvision.jpg", "", 0.02) : it\sound = 2
	it = CreateItemTemplate("Night Vision Goggles", "nvgoggles", "GFX\items\NVG.b3d", "GFX\items\INVnightvision.jpg", "", 0.02) : it\sound = 2
	it = CreateItemTemplate("Night Vision Goggles", "finenvgoggles", "GFX\items\NVG.b3d", "GFX\items\INVveryfinenightvision.jpg", "", 0.02) : it\sound = 2
	
	it = CreateItemTemplate("Syringe", "syringe", "GFX\items\Syringe\syringe.b3d", "GFX\items\Syringe\inv.png", "", 0.005) : it\sound = 2
	it = CreateItemTemplate("Syringe", "finesyringe", "GFX\items\Syringe\syringe.b3d", "GFX\items\Syringe\inv.png", "", 0.005) : it\sound = 2
	it = CreateItemTemplate("Syringe", "veryfinesyringe", "GFX\items\Syringe\syringe.b3d", "GFX\items\Syringe\inv.png", "", 0.005) : it\sound = 2
	

	



	CreateItemTemplate("Emily Ross' Badge", "badge", "GFX\items\badge.x", "GFX\items\INVbadge.jpg", "GFX\items\badge1.jpg", 0.0001, "GFX\items\badge1_tex.jpg")
	it = CreateItemTemplate("Lost Key", "key", "GFX\items\key.b3d", "GFX\items\INV1162_1.jpg", "", 0.001, "GFX\items\key2.png","",0,1+2+8) : it\sound = 3
	it = CreateItemTemplate("Disciplinary Hearing DH-S-4137-17092", "oldpaper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\dh.s", 0.003) : it\sound = 0
	it = CreateItemTemplate("Coin", "coin", "GFX\items\key.b3d", "GFX\items\INVcoin.jpg", "", 0.0005, "GFX\items\coin.png","",0,1+2+8) : it\sound = 3
	it = CreateItemTemplate("Movie Ticket", "ticket", "GFX\items\key.b3d", "GFX\items\INVticket.jpg", "GFX\items\ticket.png", 0.002, "GFX\items\tickettexture.png","",0,1+2+8) : it\sound = 0
	CreateItemTemplate("Old Badge", "badge", "GFX\items\badge.x", "GFX\items\INVoldbadge.jpg", "GFX\items\badge2.png", 0.0001, "GFX\items\badge2_tex.png","",0,1+2+8)
	
	it = CreateItemTemplate("Quarter","25ct", "GFX\items\key.b3d", "GFX\items\INVcoin.jpg", "", 0.0005, "GFX\items\coin.png","",0,1+2+8) : it\sound = 3
	it = CreateItemTemplate("Wallet","wallet", "GFX\items\wallet.b3d", "GFX\items\INVwallet.jpg", "", 0.0005,"","",1) : it\sound = 2
	
	CreateItemTemplate("SCP-427","scp427","GFX\items\427.b3d","GFX\items\INVscp427.jpg", "", 0.001)
	it = CreateItemTemplate("Upgraded pill", "scp500death", "GFX\items\pill.b3d", "GFX\items\INVpill.jpg", "", 0.0001) : it\sound = 2
	EntityColor (it.obj,255,0,0)
	
	it = CreateItemTemplate("The Modular Site Project", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docMSP.jpg", 0.003) : it\sound = 0
	
	it = CreateItemTemplate("Research Sector-02 Scheme", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\docmap.jpg", 0.003) : it\sound = 0
	
	it = CreateItemTemplate("Document SCP-427", "paper", "GFX\items\paper.x", "GFX\items\INVpaper.jpg", "GFX\items\doc427.jpg", 0.003) : it\sound = 0
	
	for it: ItemTemplates in itemTemplates:
		if (it.tex!=0) :
			if (it.texpath!="") :
				for it2: ItemTemplates in itemTemplates:
					if (it2!=it) and (it2.tex==it.tex) :
						it2.tex = 0
					
				
			
			FreeTexture (it.tex)
			it.tex = 0
		
	
 



class Items:
	var name: String
	var collider: int
	var model: int
	var itemtemplate: ItemTemplates
	var DropSpeed: float
	
	var r: int
	var g: int
	var b: int
	var a: float
	
	var level
	
	var SoundChn: int
	
	var dist: float
	var disttimer: float
	
	var state: float
	var state2: float
	
	var Picked: int
	var Dropped: int
	
	var invimg: int
	var WontColl: int = False
	var xspeed: float
	var zspeed: float
	var SecondInv: Array[Items] #[20]
	var ID: int
	var invSlots: int


func CreateItem(name: String, tempname: String, x: float, y: float, z: float, r: int=0,g: int=0,b: int=0,a: float=1.0,invSlots: int=0) -> Items:
	CatchErrors("Uncaught (CreateItem)")
	
	var i: Items = Items.new()
	
	name = Lower(name)
	tempname = Lower (tempname)
	
	for it: ItemTemplates in itemTemplates:
		if Lower(it.name) == name:
			if Lower(it.tempname) == tempname: 
				i.itemtemplate = it
				i.collider = CreatePivot()
				EntityRadius (i.collider, 0.01)
				EntityPickMode (i.collider, 1, False)
				i.model = CopyEntity(it.obj,i.collider)
				i.name = it.name
				ShowEntity (i.collider)
				ShowEntity (i.model) 
	
	i.WontColl = false
	
	if i.itemtemplate == null:
		RuntimeError("Item template not found ("+name+", "+tempname+")")
	
	ResetEntity (i.collider)
	PositionEntity(i.collider, x, y, z, True)
	RotateEntity (i.collider, 0, Rand(360), 0)
	i.dist = EntityDistance(Collider, i.collider)
	i.DropSpeed = 0.0
	
	if tempname == "cup": 
		i.r=r
		i.g=g
		i.b=b
		i.a=a
		
		var liquid = CopyEntity(LiquidObj)
		ScaleEntity (liquid, i.itemtemplate.scale,i.itemtemplate.scale,i.itemtemplate.scale,true)
		PositionEntity (liquid, EntityX(i.collider,true),EntityY(i.collider,true),EntityZ(i.collider,true))
		EntityParent (liquid, i.model)
		EntityColor (liquid, r,g,b)
		
		if a < 0:  
			EntityFX (liquid, 1)
		EntityAlpha (liquid, abs(a))
		
		
		
		EntityShininess (liquid, 1.0)
	
	
	i.invimg = i.itemtemplate.invimg
	if (tempname=="clipboard") and (invSlots==0): 
		invSlots = 10
		SetAnimTime (i.model,17.0)
		i.invimg = i.itemtemplate.invimg2
	elif (tempname=="wallet") and (invSlots==0): 
		invSlots = 10
		SetAnimTime (i.model,0.0)
	
	
	i.invSlots=invSlots
	
	i.ID=LastItemID+1
	LastItemID=i.ID
	
	CatchErrors("CreateItem")
	return i


func RemoveItem(i: Items):
	CatchErrors("Uncaught (RemoveItem)")

	FreeEntity(i.model)
	FreeEntity(i.collider)
	i.collider = 0
	
	for n: int in range(0, MaxItemAmount):
		if Inventory[n] == i:
			DebugLog ("Removed "+i.itemtemplate.name+" from slot "+n)
			Inventory[n] = null
			ItemAmount -= 1
			break
		
	if SelectedItem == i: 
		match SelectedItem.itemtemplate.tempname:
			"nvgoggles", "supernv":
				WearingNightVision = false
			"gasmask", "supergasmask", "gasmask2", "gasmask3":
				WearingGasMask = false
			"vest", "finevest", "veryfinevest":
				WearingVest = false
			"hazmatsuit","hazmatsuit2","hazmatsuit3":
				WearingHazmat = false
			"scp714":
				Wearing714 = false
			"scp1499","super1499":
				Wearing1499 = false
			"scp427":
				I_427.Using = false
		
		
		SelectedItem = null
	
	if i.itemtemplate.img != 0:
		FreeImage (i.itemtemplate.img)
		i.itemtemplate.img = 0
	
	Delete(i)
	
	CatchErrors("RemoveItem")



func UpdateItems():
	CatchErrors("Uncaught (UpdateItems)")
	var n
	var tempv: Vector3
	var temp: int
	var np: NPCs
	var pick: int
	
	var HideDist = HideDistance*0.5
	var deletedItem: int = false
	
	ClosestItem = null
	for i: Items in items:
		i.Dropped = 0
		
		if (not i.Picked): 
			if i.disttimer < MilliSecs2(): 
				i.dist = EntityDistance(Camera, i.collider)
				i.disttimer = MilliSecs2() + 700
				if i.dist < HideDist:
					ShowEntity (i.collider)
			
			
			if i.dist < HideDist: 
				ShowEntity (i.collider)
				
				if i.dist < 1.2: 
					if ClosestItem == null: 
						if EntityInView(i.model, Camera): 
							if EntityVisible(i.collider,Camera): 
								ClosestItem = i
							
						
					elif ClosestItem == i or i.dist < EntityDistance(Camera, ClosestItem.collider):  
						if EntityInView(i.model, Camera): 
							if EntityVisible(i.collider,Camera): 
								ClosestItem = i
							
						
					
				
				
				if EntityCollided(i.collider, HIT_MAP): 
					i.DropSpeed = 0
					i.xspeed = 0.0
					i.zspeed = 0.0
				else:
					if ShouldEntitiesFall:
						pick = LinePick(EntityX(i.collider),EntityY(i.collider),EntityZ(i.collider),0,-10,0)
						if pick:
							i.DropSpeed -= 0.0004 * FPSfactor
							TranslateEntity (i.collider, i.xspeed*FPSfactor, i.DropSpeed * FPSfactor, i.zspeed*FPSfactor)
							if i.WontColl:
								ResetEntity(i.collider)
						else:
							i.DropSpeed = 0
							i.xspeed = 0.0
							i.zspeed = 0.0
						
					else:
						i.DropSpeed = 0
						i.xspeed = 0.0
						i.zspeed = 0.0
					
				
				
				if i.dist<HideDist*0.2: 
					for i2: Items in items:
						if i != i2 and !i2.Picked and i2.dist < HideDist * 0.2: 
							
							xtemp = (EntityX(i2.collider,true)-EntityX(i.collider,true))
							ytemp = (EntityY(i2.collider,true)-EntityY(i.collider,true))
							ztemp = (EntityZ(i2.collider,true)-EntityZ(i.collider,true))
							
							ed = xtemp * xtemp + ztemp * ztemp
							if ed<0.07 and abs(ytemp)<0.25: 

								if PlayerRoom.RoomTemplate.Name != "room2storage":
									var t: float = 0.07 - ed 
									xtemp *= t
									ztemp *= t
									
									while abs(xtemp) + abs(ztemp) < 0.001:
										xtemp += Rnd(-0.002,0.002)
										ztemp += Rnd(-0.002,0.002)
									Wend
									
									TranslateEntity (i2.collider,xtemp,0,ztemp)
									TranslateEntity (i.collider,-xtemp,0,-ztemp)
								
							
						
					
				
				
				if EntityY(i.collider) < - 35.0:
					DebugLog ("remove: " + i.itemtemplate.name)
					RemoveItem(i)
					deletedItem = true
			else:
				HideEntity (i.collider)
			
		else:
			i.DropSpeed = 0
			i.xspeed = 0.0
			i.zspeed = 0.0
		
		
		if not deletedItem: 
			CatchErrors(char(34) + i.itemtemplate.name + char(34) + " item")
		
		deletedItem = false
	
	
	if ClosestItem != null: 

		
		if MouseHit1:
			PickItem(ClosestItem)


func PickItem(item: Items):
	var canpickitem: bool = true
	var fullINV: bool = true
	
	for n: int in range(0, MaxItemAmount):
		if Inventory[n] == null:
			fullINV = false
			break
	
	if WearingHazmat > 0: 
		Msg = "You cannot pick up any items while wearing a hazmat suit."
		MsgTimer = 70*5
		return
	
	
	CatchErrors("Uncaught (PickItem)")
	if (not fullINV): 
		for n: int in range(0, MaxItemAmount):
			if Inventory[n] == null:
				match (item.itemtemplate.tempname):
					"1123":
						if not (Wearing714 == 1): 
							if PlayerRoom.RoomTemplate.Name != "room1123": 
								ShowEntity (Light)
								LightFlash = 7
								PlaySound_Strict(LoadTempSound("SFX\SCP\1123\Touch.ogg"))
								DeathMSG = "Subject D-9341 was shot dead after attempting to attack a member of Nine-Tailed Fox. Surveillance tapes show that the subject had been "
								DeathMSG += "wandering around the site approximately 9 minutes prior, shouting the phrase " + Chr(34) + "get rid of the four pests" + Chr(34)
								DeathMSG += " in chinese. SCP-1123 was found in [REDACTED] nearby, suggesting the subject had come into physical contact with it. How "
								DeathMSG += "exactly SCP-1123 was removed from its containment chamber is still unknown."
								Kill()
							
							for e: Events in events:
								if e.eventname == "room1123":  
									if e.eventstate == 0: 
										ShowEntity (Light)
										LightFlash = 3
										PlaySound_Strict(LoadTempSound("SFX\SCP\1123\Touch.ogg"))
									
									e.eventstate = max(1, e.eventstate)
									
									break
						return
					
					"killbat":
						ShowEntity (Light)
						LightFlash = 1.0
						PlaySound_Strict(IntroSFX(11))
						DeathMSG = "Subject D-9341 found dead inside SCP-914's output booth next to what appears to be an ordinary nine-volt battery. The subject is covered in severe "
						DeathMSG += "electrical burns, and assumed to be killed via an electrical shock caused by the battery. The battery has been stored for further study."
						Kill()
					"scp148":
						GiveAchievement(Achv148)	
					"scp513":
						GiveAchievement(Achv513)
					"scp860":
						GiveAchievement(Achv860)
					"key6":
						GiveAchievement(AchvOmni)
					"veryfinevest":
						Msg = "The vest is too heavy to pick up."
						MsgTimer = 70*6
						break
					"firstaid", "finefirstaid", "veryfinefirstaid", "firstaid2":
						item.state = 0
					"navigator", "nav":
						if item.itemtemplate.name == "S-NAV Navigator Ultimate":
							GiveAchievement(AchvSNAV)
					"hazmatsuit", "hazmatsuit2", "hazmatsuit3":
						canpickitem = true
						for z: int in range(0, MaxItemAmount):
							if Inventory[z] != null: 
								if Inventory[z].itemtemplate.tempname in ["hazmatsuit", "hazmatsuit2", "hazmatsuit3"]:
									canpickitem = false
									break
								elif Inventory[z].itemtemplate.tempname in ["vest", "finevest"]: 
									canpickitem = 2
									break
								
						
						if canpickitem == false: 
							Msg = "You are not able to wear two hazmat suits at the same time."
							MsgTimer = 70 * 5
							return
						elif canpickitem == 2: 
							Msg = "You are not able to wear a vest and a hazmat suit at the same time."
							MsgTimer = 70 * 5
							return
						else:

							SelectedItem = item
						
					"vest","finevest":
						canpickitem = true
						for z: int in range(0, MaxItemAmount):
							if Inventory[z] != null: 
								if Inventory[z].itemtemplate.tempname in ["vest", "finevest"]: 
									canpickitem = false
									Exit
								elif Inventory[z].itemtemplate.tempname in ["hazmatsuit", "hazmatsuit2", "hazmatsuit3"]: 
									canpickitem = 2
									break

						
						
						if canpickitem == false: 
							Msg = "You are not able to wear two vests at the same time."
							MsgTimer = 70 * 5
							return
						elif canpickitem == 2: 
							Msg = "You are not able to wear a vest and a hazmat suit at the same time."
							MsgTimer = 70 * 5
							return
						else:
							SelectedItem = item
						
				
				if item.itemtemplate.sound != 66:
					PlaySound_Strict(PickSFX(item.itemtemplate.sound))
				item.Picked = True
				item.Dropped = -1
				
				item.itemtemplate.found=true
				ItemAmount += 1
				
				Inventory[n] = item
				HideEntity(item.collider)
				break
	else:
		Msg = "You cannot carry any more items."
		MsgTimer = 70 * 5
	
	CatchErrors("PickItem")


func DropItem(item: Items,playdropsound: bool = true):
	if WearingHazmat > 0: 
		Msg = "You cannot drop any items while wearing a hazmat suit."
		MsgTimer = 70*5
		return
	
	
	CatchErrors("Uncaught (DropItem)")
	if playdropsound: 
		if item.itemtemplate.sound != 66:
			PlaySound_Strict(PickSFX(item.itemtemplate.sound))
	
	
	item.Dropped = 1
	
	ShowEntity(item.collider)
	PositionEntity(item.collider, EntityX(Camera), EntityY(Camera), EntityZ(Camera))
	RotateEntity(item.collider, EntityPitch(Camera), EntityYaw(Camera)+Rnd(-20,20), 0)
	MoveEntity(item.collider, 0, -0.1, 0.1)
	RotateEntity(item.collider, 0, EntityYaw(Camera)+Rnd(-110,110), 0)
	
	ResetEntity (item.collider)
	
	item.Picked = False
	for z: int in range(0, MaxItemAmount):
		if Inventory[z] == item:
			Inventory[z] = null
	
	match item.itemtemplate.tempname:
		"gasmask", "supergasmask", "gasmask3":
			WearingGasMask = False
		"hazmatsuit",  "hazmatsuit2", "hazmatsuit3":
			WearingHazmat = False
		"vest", "finevest":
			WearingVest = False
		"nvgoggles":
			if WearingNightVision == 1:
				CameraFogFar = StoredCameraFogFar
				WearingNightVision = False
		"supernv":
			if WearingNightVision == 2:
				CameraFogFar = StoredCameraFogFar
				WearingNightVision = False
		"finenvgoggles":
			if WearingNightVision == 3:
				CameraFogFar = StoredCameraFogFar
				WearingNightVision = false
		"scp714":
			Wearing714 = false
		"scp1499","super1499":
			Wearing1499 = false
		"scp427":
			I_427.Using = false
	
	CatchErrors("DropItem")
	



func Update294():
	CatchErrors("Uncaught (Update294)")
	
	if CameraShakeTimer > 0: 
		CameraShakeTimer = CameraShakeTimer - (FPSfactor/70)
		CameraShake = 2
	
	
	if VomitTimer > 0: 
		DebugLog (VomitTimer)
		VomitTimer -= FPSfactor/70
		
		if (MilliSecs2() % 1600) < Rand(200, 400): 
			if BlurTimer == 0:
				BlurTimer = randf(10, 20)*70
			CameraShake = randf(0, 2)
		
		

		
		if randi(50) == 50 and (MilliSecs2() % 4000) < 200:
			PlaySound_Strict(CoughSFX(Rand(0,2)))
		

		if VomitTimer < 10 and randi(0, 500 * VomitTimer) < 2: 
			if (not ChannelPlaying(VomitCHN)) and (not Regurgitate): 
				VomitCHN = PlaySound_Strict(LoadTempSound("SFX\SCP\294\Retch" + Rand(1, 2) + ".ogg"))
				Regurgitate = MilliSecs2() + 50
			
		
		
		if Regurgitate > MilliSecs2() and Regurgitate != 0: 
			mouse_y_speed_1 += 1.0
		else:
			Regurgitate = 0
		
		
	elif VomitTimer < 0: 
		VomitTimer -= FPSfactor/70
		
		if VomitTimer > -5: 
			if MilliSecs2() % 400 < 50:
				CameraShake = 4 
			mouse_x_speed_1 = 0.0
			Playable = false
		else:
			Playable = true
		
		
		if (not Vomit): 
			BlurTimer = 40 * 70
			VomitSFX = LoadSound_Strict("SFX\SCP\294\Vomit.ogg")
			VomitCHN = PlaySound_Strict(VomitSFX)
			PrevInjuries = Injuries
			PrevBloodloss = Bloodloss
			Injuries = 1.5
			Bloodloss = 70
			EyeIrritation = 9 * 70
			
			pvt = CreatePivot()
			PositionEntity(pvt, EntityX(Camera), EntityY(Collider) - 0.05, EntityZ(Camera))
			TurnEntity(pvt, 90, 0, 0)
			EntityPick(pvt, 0.3)
			de.decals = CreateDecal(5, PickedX(), PickedY() + 0.005, PickedZ(), 90, 180, 0)
			de.Size = 0.001
			de.SizeChange = 0.001
			de.MaxSize = 0.6
			EntityAlpha(de.obj, 1.0)
			EntityColor(de.obj, 0.0, Rnd(200, 255), 0.0)
			ScaleSprite (de.obj, de.size, de.size)
			FreeEntity (pvt)
			Vomit = True
		
		
		UpdateDecals()
		
		mouse_y_speed_1 += max((1.0 + VomitTimer / 10), 0.0)
		
		if VomitTimer < -15: 
			FreeSound_Strict(VomitSFX)
			VomitTimer = 0
			if KillTimer >= 0: 
				PlaySound_Strict(BreathSFX(0,0))
			
			Injuries = PrevInjuries
			Bloodloss = PrevBloodloss
			Vomit = false
		
	
	
	CatchErrors("Update294")
