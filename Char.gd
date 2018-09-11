extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var indexName = 0
var tabNameRand = ['Bob', 'Andre', 'Karl', 'Jospeh', 'Lordon', 'Oro', 'Kydia']
var tabClassRand = ['Tank', 'Healer','Dps', 'Dps']


class Character:
	var id
	var name
	var energy
	var status
	var maxEnergy
	var charClass
	var iLevel
	var skill
	func _init(var1, var2, var3):
		print('ok')
		self.energy = int(rand_range(50,60))
		self.name = var1
		self.status = "online"
		self.id = var2
		self.maxEnergy = int(rand_range(50,150))
		self.iLevel = int(rand_range(50,150))
		self.skill = int(rand_range(50,150))
		self.charClass = var3
	func timeout():
		if self.status == "online":
			self.energy -= 1
			if self.energy < 0:
				self.status = "offline"
				print( self.name+ ' lougout !')
		elif  self.status == "offline":
			self.energy += 1
			if self.energy > 100:
				self.status = "online"
				print( self.name+ ' logon !')
				self.energy = maxEnergy




func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	print('Init Char Manager')
	pass


func generateRandomChar():
	var character = Character.new( tabNameRand[int(rand_range(0,len(tabNameRand)))] + "_" + str(indexName), indexName, tabClassRand[int(rand_range(0,len(tabClassRand)))])
	indexName  += 1
	return character
	pass





	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
