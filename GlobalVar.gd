
extends Node

var current_scene = null
var globalCharTab = []
var availableDungeonList = []
var playerGuild

func _ready():
        var root = get_tree().get_root()
        current_scene = root.get_child( root.get_child_count() -1 )

func setPlayerGuild(guild):
	playerGuild = guild



func FindCharacterById(id):
	for c in globalCharTab:
		if c.id == id:
			return c
	return null