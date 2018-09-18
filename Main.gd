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
var timeElapsed = 120
var dayPeriod = "evening"
var speed = 2


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	timer = get_node("MainTimer")
	timer.wait_time = 1 /  float(speed )
	timer.start()
	timer.connect("timeout", self, "_on_MainTimer_timeout")
	playerGuild = GuildManager.initGuild("DDM")
	GlobalVar.setPlayerGuild(playerGuild)
	DungeonManager.initDungeons()
	$HUD/AccelerateTime.connect("pressed", self, "AccTime")
	$HUD/DecelerateTime.connect("pressed", self, "Dccime")
	for i in range(8):
		var character = CharManager.generateRandomChar()
		GlobalVar.playerGuild.addMember(character)
		GlobalVar.globalCharTab.push_front(character)
	pass

func AccTime():
	if speed < 5:
		speed += 1
	timer = get_node("MainTimer")
	timer.wait_time = 1 /  float(speed )
func Dccime():
	if speed > 1:
		speed -= 1
	timer = get_node("MainTimer")
	print(float(1 / speed ))
	timer.wait_time = 1 /  float(speed )


func _on_MainTimer_timeout():
	timeElapsed += 1
	var day = timeElapsed / 144
	var hour = (timeElapsed / 6 ) % 24
	var minutes = (timeElapsed % 6 ) * 10

	if hour >= 0 && hour < 2:
		dayPeriod = "earlyNight"
	elif hour >= 2  && hour < 6:
		dayPeriod = "lateNight"
	elif hour >= 6  && hour < 9:
		dayPeriod = "earlyMorning"
	elif hour >= 9  && hour < 12:
		dayPeriod = "morning"
	elif hour >= 12  && hour < 16:
		dayPeriod = "afternoon"
	elif hour >= 16  && hour < 20:
		dayPeriod = "lateAfternoon"
	elif hour >= 20  && hour < 24:
		dayPeriod = "evening"

	
	$HUD.update_time(str(hour) + ":" + str(minutes) + " day " + str(day))
	GlobalVar.playerGuild.timeout(dayPeriod)
	$HUD.refreshListMember(GlobalVar.playerGuild.guildMembers)
	$HUD.timeoutChildren()

	for d  in GlobalVar.runningDungeon :
		d.timeout()

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
