extends CanvasLayer


const listMemberScn = preload("res://GuildMemberInList.tscn")
const listRecruitScn = preload("res://RecruitableInList.tscn")
const CharacterOverviewPanel = preload("res://CharacterOverviewPanel.tscn")
const DungeonRun = preload("res://DungeonRun.tscn")

onready var CharManager = preload("Char.gd").new()

var playerGuild
var listRecruit


func _ready():
	$MenuBot/GuildMemberButton.connect("pressed", self, "showMenuGuildMember")
	$MenuBot/RecruitButton.connect("pressed", self, "showMenuRecruit")
	$MenuBot/DungeonButton.connect("pressed", self, "showDungeon")
	pass

	
func showMenuGuildMember():
	if $ListMemberContainer.is_visible_in_tree():
		$ListMemberContainer.hide()
	else:
		$ListMemberContainer.show()
		
func showMenuRecruit():
	if $ListRecruitableContainer.is_visible_in_tree():
		$ListRecruitableContainer.hide()
	else:
		$ListRecruitableContainer.show()

func showDungeon():
	var view = DungeonRun.instance()
	view.get_node("Close").connect("pressed", self, "closePanel", [view])
	add_child(view)


func update_time(time):
	$Label.text = str(time)
	
func refreshListMember(list):
	for child in $ListMemberContainer/ScrollContainer/ListMemberOnline.get_children():
		child.queue_free()
	for newMember in list:
		var item = listMemberScn.instance()
		item.get_node("NameLabel").text = newMember.name
		item.get_node("StatusLabel").text = newMember.status
		item.rect_min_size = Vector2(230,25)
		item.get_node("View").connect("pressed", self, "viewChar", [newMember.id])
		$ListMemberContainer/ScrollContainer/ListMemberOnline.add_child(item)

func refreshListRecruit(list):
	for child in $ListRecruitableContainer/ScrollContainer/ListRecruitable.get_children():
		child.queue_free()
	listRecruit = list
	for newMember in list:
		var item = listRecruitScn.instance()
		item.get_node("NameLabel").text = newMember.name
		item.get_node("ClassLabel").text = newMember.charClass
		item.rect_min_size = Vector2(230,25)
		item.get_node("RecruitButton").connect("pressed", self, "recruitChar", [newMember.id])
		$ListRecruitableContainer/ScrollContainer/ListRecruitable.add_child(item)

func viewChar(i):
	var c = GlobalVar.FindCharacterById(i)
	var view = CharacterOverviewPanel.instance()
	view.set_char(c)
	view.get_node("Close").connect("pressed", self, "closePanel", [view])
	add_child(view)
	print(c)

func closePanel(v):
	v.queue_free()


func timeoutChildren():
	for node in get_children():
		if(node.has_method("timeout")): 
			node.timeout()

	
func recruitChar(i):
	for r in listRecruit:
		if r.id == i:
			GlobalVar.playerGuild.addMember(r)
			listRecruit.erase(r)
	refreshListRecruit(listRecruit)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
