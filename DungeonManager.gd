extends Panel


class Dungeon:
	var name
	var difficulty
	var nbBoss
	var duration
	func _init(a,b,c,d):
		self.name = a
		self.difficulty = b
		self.nbBoss = c
		self.duration = d
	


func _ready():
	GlobalVar.availableDungeonList.push_front(Dungeon.new("LowLvl Dungon", 50, 3, 30))
	GlobalVar.availableDungeonList.push_front(Dungeon.new("midvl Dungon", 80, 3, 40))
	GlobalVar.availableDungeonList.push_front(Dungeon.new("hard Dungon", 100, 4, 50))
	print("DUNGEONS", GlobalVar.availableDungeonList)
	pass

func initDungeons():
	GlobalVar.availableDungeonList.push_front(Dungeon.new("LowLvl Dungon", 50, 3, 30))
	GlobalVar.availableDungeonList.push_front(Dungeon.new("midvl Dungon", 80, 3, 40))
	GlobalVar.availableDungeonList.push_front(Dungeon.new("hard Dungon", 100, 4, 50))
	print("DUNGEONS", GlobalVar.availableDungeonList)

