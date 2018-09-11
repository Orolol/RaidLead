extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const listMemberScn = preload("res://GuildMemberDungeon.tscn")
const listDungeonScn = preload("res://DungeonInList.tscn")

var selectedChar = []
var chosenDungeon = null
var indexDun = 0


class RunningDungeon:
	var dungeon
	var chars
	var progression
	var status
	func _init(d,c,b):
		self.dungeon = d
		self.chars = c
		self.progression = 0
		self.status = "running"
	func timeout():
		if self.status == "running" :
			self.progression += 20
			print(self.status+ ' ' + self.dungeon.name + ' ' + str(self.progression) + "%"  )
		if self.progression == 100:
			self.status = "complete"
			for c in self.chars:
				c.iLevel += 5
				c.skill += 5
			print('complete  ' + self.dungeon.name  )
			GlobalVar.runningDungeon.erase(self)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	refreshListMember()
	refreshListDungeon()
	$Run.connect("pressed", self, "runDungeon")
	pass


func getDungeonById(id):
	for i in GlobalVar.availableDungeonList:
		if i.id == id:
			return i
	return null

func runDungeon():
	GlobalVar.runningDungeon.push_front(RunningDungeon.new(chosenDungeon, selectedChar, getDiff()))

func refreshListMember():
	for child in $ListMemberContainer/ScrollContainer/ListMemberOnline.get_children():
		child.queue_free()
	for newMember in GlobalVar.playerGuild.guildMembers:
		var isSel = false
		for i in selectedChar:
			if i.id == newMember.id:
				isSel = true
		if newMember.status == "online":
			var item = listMemberScn.instance()
			if isSel:
				item.get_node("NameLabel").set("custom_colors/font_color", Color(255,50,120))
				item.get_node("View").connect("pressed", self, "removeChar", [newMember.id])
			else:
				item.get_node("View").connect("pressed", self, "viewChar", [newMember.id])

			item.get_node("NameLabel").text = newMember.name
			item.get_node("StatusLabel").text = newMember.charClass
			item.rect_min_size = Vector2(230,25)
			item.get_node("Go").connect("pressed", self, "selectChar", [newMember])
			$ListMemberContainer/ScrollContainer/ListMemberOnline.add_child(item)

func refreshListDungeon():
	for child in $DungeonList/ScrollContainer/ListDungeonAvailable.get_children():
		child.queue_free()
	for dun in GlobalVar.availableDungeonList:
		var item = listDungeonScn.instance()
		item.get_node("Label").text = dun.name + " (" + str(dun.difficulty) + ")"
		item.rect_min_size = Vector2(320,50)
		item.get_node("Button").connect("pressed", self, "choseDungeon", [dun])
		$DungeonList/ScrollContainer/ListDungeonAvailable.add_child(item)

func choseDungeon(i):
	chosenDungeon = i
	$DungeonRecap/Name.text = i.name
	$DungeonRecap/Description.text = "Difficulty = " + str(i.difficulty) + " nbBoss = " + str(i.nbBoss)
	getDiff()
	refreshListDungeon()

func getDiff():
	var totalPower = 0
	var tank = 0
	var dps = 0
	var healer = 0
	for f in selectedChar:
		totalPower += int(f.skill) + int(f.iLevel)
		if f.charClass == "Healer":
			healer += 1
		if f.charClass == "Tank":
			tank += 1
		if f.charClass == "Dps":
			dps += 1
	
	totalPower *= 0.1
	if tank < 1:
		totalPower *= 0.3
	if healer < 1:
		totalPower *= 0.3
	if chosenDungeon != null:
		$DungeonRecap/CurrentDifficulty.text = str((totalPower / chosenDungeon.difficulty) * 100) + "%"


func selectChar(i):
	selectedChar.push_front(i)
	getDiff()
	refreshListMember()

func removeChar(i):
	for j in selectedChar:
		if i.id == j.id:
			selectedChar.erase(j)
	refreshListMember()

func timeout():
	refreshListMember()
	refreshListDungeon()

