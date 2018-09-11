extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var GuildManager = preload("Guild.gd").new()
onready var CharManager = preload("Char.gd").new()
onready var DungeonManager = preload("DungeonManager.gd").new()

onready var GlobalVar = get_node("/root/GlobalVar")

var availableCharToRecruit = []


var playerGuild


var timer
var timeElapsed = 0


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	timer = get_node("MainTimer")
	timer.start()
	timer.connect("timeout", self, "_on_MainTimer_timeout")
	playerGuild = GuildManager.initGuild("DDM")
	GlobalVar.setPlayerGuild(playerGuild)
	DungeonManager.initDungeons()
	for i in range(8):
		var character = CharManager.generateRandomChar()
		GlobalVar.playerGuild.addMember(character)
		GlobalVar.globalCharTab.push_front(character)
	pass


func _on_MainTimer_timeout():
	timeElapsed += 1
	$HUD.update_time(timeElapsed)
	GlobalVar.playerGuild.timeout()
	$HUD.refreshListMember(GlobalVar.playerGuild.guildMembers)
	$HUD.timeoutChildren()

	if len(availableCharToRecruit) < 3:
		var character = CharManager.generateRandomChar()
		availableCharToRecruit.push_front(character)
		GlobalVar.globalCharTab.push_front(character)
		$HUD.refreshListRecruit(availableCharToRecruit)
		print('New Char to recruit !',availableCharToRecruit )
	



	
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
