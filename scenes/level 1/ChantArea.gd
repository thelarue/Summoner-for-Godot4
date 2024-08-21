extends Area2D

const LINES : Array = [
	"Joka ilta kun lamppu sammuu",
	"Ja saapuu se oikea yo",
	"Ilkeys nurkassa varttuu ja lapsiansa syo",
	"Kuoleman pelko heraa",
	"Ne joukkoja ikkunas alle keraa",
	"Katesi ristiin laita",
	"Ettei perkele niskojasi taita",
	"Ahhh, it did not work....",
	"Let's try again",
]
var last_line = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_overlapping_bodies(): return
	if $ChantTimer.time_left > 0 : return
	if $"../CommonCultist" == null : return
	if $"../CommonCultist".velocity.length() > 0 : return
	$"../CommonCultist".show_thought( LINES[last_line] )
	last_line += 1
	if last_line >= LINES.size(): last_line = 0
	$ChantTimer.start()
