extends Node2D

const PLAYER_RECT_POSITION : Vector2 = Vector2(100, 184)
const PLAYER_BATTLE_SPRITES : Array = [
	preload("res://SpriteFrames/little_girl.tres"),
	preload("res://SpriteFrames/test_summon.tres"),
	preload("res://SpriteFrames/mutatedDog.tres")
]

const ACTION_TAGS : Array = [
	[ "Poke", "Fry", "Do what has to do" ],
	[ "Blush", "Grow beard", "dunno out of dummy text" ],
	[ "no", "more", "dummy texts" ]
]

var enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	%IntroEffect.play()
	%FightControls.modulate = Color.TRANSPARENT
	
	%EnemyRect.sprite_frames = enemy.battle_sprite

	var tween = create_tween()
	tween.tween_property( %EnemyRect,  "position", Vector2(332, 0), 1 )
	tween.tween_property( %PlayerRect, "position", PLAYER_RECT_POSITION, 1 )
	tween.tween_property( %FightIntro, "modulate", Color.TRANSPARENT, 0.5 )
	tween.tween_property( %FightControls, "modulate", Color.WHITE, 0.5 )
	tween.finished.connect( player_turn )


func _process(_delta):
	%PlayerHealthBar.health = Global.player_health

	if enemy == null : return

	%EnemyHealthBar.health = enemy.battle_stats.hp

	if enemy.battle_stats.hp <= 0:
		%EnemyRect.play("Defeated")
		disable_player()



func player_turn():
	disable_player()
	var children = %AttackButtonContainer.get_children()
	children[0].grab_focus()


func disable_player():
	var children = %AttackButtonContainer.get_children()
	for child in children :
		if "disabled" in child:
			child.disabled = true


func _on_button_1_pressed():
	enemy.battle_stats.hp -= max( 0, 2 - enemy.battle_stats.def )
	%AttackSound.play()
	%PlayerRect.play("Attack")
	disable_player()
	%AttackLabel.text = "You poke the enemy"
	show_attack_panel()


func _on_button_2_pressed():
	enemy.battle_stats.hp -= max( 0, 3 - enemy.battle_stats.def )
	%AttackSound.play()
	%PlayerRect.play("Use")
	disable_player()
	%AttackLabel.text = "You fry the enemy"
	show_attack_panel()


func _on_button_3_pressed():
	enemy.battle_stats.hp -= max( 0, 8 - enemy.battle_stats.def )
	%AttackSound.play()
	disable_player()
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
		player_turn()
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


func _on_summon_change_button_pressed():
	var tween = create_tween()
	tween.tween_property( %PlayerRect, "position", Vector2( %PlayerRect.position.x, 400 ), 1 ) 
	tween.finished.connect( _change_summon )


func _change_summon():
	var buttons = %PlayerBattleantButtonContainer.get_children()
	var battleant_index : int = 0
	var idx : int = 0
	
	for button in buttons:
		if button.button_pressed :
			battleant_index = idx
		idx += 1
		button.button_pressed = false
	
	buttons = %AttackButtonContainer.get_children()
	idx = 0
	for button in buttons:
		button.text = ACTION_TAGS[battleant_index][idx]
		idx += 1

	%PlayerRect.sprite_frames = PLAYER_BATTLE_SPRITES[ battleant_index ]
	var tween = create_tween()
	tween.tween_property( %PlayerRect, "position", PLAYER_RECT_POSITION, 1 )
