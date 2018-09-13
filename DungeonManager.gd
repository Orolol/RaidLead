extends Panel

var indexDun = 0

class Dungeon:
	var id
	var name
	var difficulty
	var nbBoss
	var duration
	var nbPlayer
	func _init(ind, a,b,c,d,e):
		self.id = ind
		self.name = a
		self.difficulty = b
		self.nbBoss = c
		self.duration = d
		self.nbPlayer = d

func _ready():
	pass
	

func initDungeons():
	GlobalVar.availableDungeonList.push_front(Dungeon.new(getInd(), "LowLvl Dungon", 50, 3, 10,5))
	GlobalVar.availableDungeonList.push_front(Dungeon.new(getInd(),"midvl Dungon", 80, 3, 15,5))
	GlobalVar.availableDungeonList.push_front(Dungeon.new(getInd(),"hard Dungon", 100, 4, 20,5))
	print("DUNGEONS", GlobalVar.availableDungeonList)


func getInd():
	indexDun += 1 
	return indexDun
