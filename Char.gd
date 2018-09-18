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
		energy = int(rand_range(50,60))
		name = var1
		status = "online"
		id = var2
		maxEnergy = int(rand_range(50,150))
		iLevel = int(rand_range(50,150))
		skill = int(rand_range(50,150))
		charClass = var3
	func timeout(dayPeriod):
		if status == "online":
			if dayPeriod == "earlyNight":
				energy -= 1
			if dayPeriod == "lateNight":
				energy -= 1
			energy -= 1
			if energy < 0:
				status = "offline"
				# print( name+ ' lougout !')
			if dayPeriod == "lateNight" && energy < 50:
				status = "offline"
				# print( name+ ' lougout !')
			if dayPeriod == "earlyNight" && energy < 20:
				status = "offline"
				# print( name+ ' lougout !')
		if status == "in dungeon":
			if energy > 0:
				if dayPeriod == "earlyNight":
					energy -= 1
				if dayPeriod == "lateNight":
					energy -= 1
				energy -= 1
			else:
				print(name + ' is exhausted') 
		elif  status == "offline":
			energy += 1
			if energy > 100:
				status = "online"
				# print( name+ ' logon !')
				energy = maxEnergy
			if dayPeriod == "evening":
				status = "online"
				# print( name+ ' logon !')




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
