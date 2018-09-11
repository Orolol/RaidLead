extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var charToDisplay

func _ready():
	pass

	
func set_char(c):
	charToDisplay = c
	get_node("NamePlate").text = c.name
	refreshChar()

func refreshChar():
	get_node("AttributesContainer").get_node("Ilvl").get_node("Label").text = "iLvl"
	get_node("AttributesContainer").get_node("Ilvl").get_node("Value").text = str(charToDisplay.iLevel)
	get_node("AttributesContainer").get_node("Energy").get_node("Label").text = "Energy"
	get_node("AttributesContainer").get_node("Energy").get_node("Value").text = str(charToDisplay.energy)
	get_node("AttributesContainer").get_node("Class").get_node("Label").text = "Class"
	get_node("AttributesContainer").get_node("Class").get_node("Value").text = str(charToDisplay.charClass)
	get_node("AttributesContainer").get_node("Skill").get_node("Label").text = "Skill"
	get_node("AttributesContainer").get_node("Skill").get_node("Value").text = str(charToDisplay.skill)
	
func timeout():
	refreshChar()
	
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
