extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

class Guild:
	var name
	var guildMembers
	func _init(varName):
		self.name = varName
		self.guildMembers = []
	func addMember(member):
		self.guildMembers.push_front(member)
	func timeout(dayPeriod):
		for member in self.guildMembers:
			member.timeout(dayPeriod)


func _ready():
	print('Init GuildManager')
	pass

func initGuild(name):
	var guild = Guild.new(name)
	return guild







	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
