extends Node2D


const PLAYER_RECT_POSITION : Vector2 = Vector2(114, 175)
const PLAYER_BATTLE_GROUP : Array = [
	{ 
		"name"    : "Little girl",
		"actions" : [ "Poke", "Fry", "Do what has to do", "back", "need", "more", "action", "tags" ],
		"texture" : preload("res://SpriteFrames/little_girl.tres"),
	},
	{
		"name"    : "test summon",
		"actions" : [ "no", "more", "dummy", "texts", "yet", "we", "need" ],
		"texture" : preload("res://SpriteFrames/test_summon.tres"),
	},
	{
		"name"    : "Stolen dog",
		"actions" : [ "still", "no", "dummy", "texts" ],
		"texture" : preload("res://SpriteFrames/mutatedDog.tres")
	}
]


var enemy
var player_selected_unit : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	%IntroEffect.play()
	%FightControls.modulate = Color.TRANSPARENT
	
	%EnemyRect.sprite_frames = enemy.battle_sprite

	%PlayerMenu.battle_scene = self

	var tween = create_tween()
	tween.tween_property( %EnemyRect,  "position", Vector2(332, 15), 1 )
	tween.tween_property( %PlayerRect, "position", PLAYER_RECT_POSITION, 1 )
	tween.tween_property( %FightIntro, "modulate", Color.TRANSPARENT, 0.5 )
	tween.tween_property( %FightControls, "modulate", Color.WHITE, 0.5 )
	tween.finished.connect( %PlayerMenu.enable_player )


func _process(_delta):
	%PlayerHealthBar.health = Global.player_health

	if enemy == null : return

	if enemy.battle_stats.hp <= 0:
		%EnemyRect.play("Defeated")
		%PlayerMenu.disable_player()


func _on_button_3_pressed():
	enemy.battle_stats.hp -= max( 0, 8 - enemy.battle_stats.def )
	%AttackSound.play()
	%PlayerMenu.disable_player()
	%AttackLabel.text = "You do things to the enemy"
	show_attack_panel()


func enemy_turn():
	if enemy == null : return
	%EnemyRect.play("Attack")
	%AttackSound.play()
	%AttackLabel.text = "Enemy %s you" % [ enemy.battle_stats.attack_text ]
	show_attack_panel()


func _on_player_rect_animation_finished():
	if %PlayerRect.animation == "Attack" or %PlayerRect.animation == "Use":
		%EnemyRect.play("Damaged")
	if %PlayerRect.animation == "Damaged":
		%PlayerMenu.player_turn()
	%PlayerRect.play("Idle")


func _on_back_to_game_button_pressed():
	get_tree().paused = false
	queue_free()


func _on_enemy_rect_animation_finished():
	if %EnemyRect.animation == "Attack" or %EnemyRect.animation == "Use":
		Global.player_node.hit( max( 0, enemy.battle_stats.atk - 1 ) )
		%PlayerRect.play("Damaged")
	if %EnemyRect.animation == "Damaged" :
		enemy_turn()
		return
	if %EnemyRect.animation == "Defeated" :
		if enemy != null : enemy.queue_free() 
		%VictorySound.play()
		var tween : Tween = create_tween()
		tween.tween_property( %FightControls, "modulate", Color.TRANSPARENT, 0.5 )
		tween.tween_property( %VictoryPanel, "position", Vector2(180, 88), 1 )
		%BackToGameButton.grab_focus()
	else:
		%EnemyRect.play("Idle")


func show_attack_panel():
	var tween = create_tween()
	tween.tween_property( %AttackPanel, "modulate", Color.WHITE, 0.5 )
	tween.tween_property( %AttackPanel, "modulate", Color.WHITE_SMOKE, 2 )
	tween.tween_property( %AttackPanel, "modulate", Color.TRANSPARENT, 0.5 )


func start_change_summon():
	var tween = create_tween()
	tween.set_parallel( true )
	tween.tween_property( %PlayerRect, "position", Vector2( %PlayerRect.position.x, 400 ), 0.5 ) 
	tween.finished.connect( _change_summon )


func _change_summon():
	%PlayerRect.sprite_frames = PLAYER_BATTLE_GROUP[ player_selected_unit ].texture
	var tween = create_tween()
	tween.set_parallel( true )
	tween.tween_property( %PlayerRect, "position", PLAYER_RECT_POSITION, 0.5 )

