extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const listMemberScn = preload("res://GuildMemberDungeon.tscn")
const listDungeonScn = preload("res://DungeonInList.tscn")


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	refreshListMember()
	refreshListDungeon()
	pass

func refreshListMember():
	for child in $ListMemberContainer/ScrollContainer/ListMemberOnline.get_children():
		child.queue_free()
	for newMember in GlobalVar.playerGuild.guildMembers:
		if newMember.status == "online":
			var item = listMemberScn.instance()
			item.get_node("NameLabel").text = newMember.name
			item.get_node("StatusLabel").text = newMember.charClass
			item.rect_min_size = Vector2(230,25)
			item.get_node("View").connect("pressed", self, "viewChar", [newMember.id])
			$ListMemberContainer/ScrollContainer/ListMemberOnline.add_child(item)

func refreshListDungeon():
	for child in $DungeonList/ScrollContainer/ListDungeonAvailable.get_children():
		child.queue_free()
	for dun in GlobalVar.availableDungeonList:
		var item = listDungeonScn.instance()
		item.get_node("Label").text = dun.name + " (" + str(dun.difficulty) + ")"
		item.rect_min_size = Vector2(350,50)
		$DungeonList/ScrollContainer/ListDungeonAvailable.add_child(item)

func timeout():
	refreshListMember()
	refreshListDungeon()

