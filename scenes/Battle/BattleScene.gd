extends Node2D

var enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	%FightControls.modulate = Color.TRANSPARENT

	var tween = create_tween()
	tween.tween_property( %EnemyRect,  "position", Vector2(332, 0), 1 )
	tween.tween_property( %PlayerRect, "position", Vector2(100, 183), 1 )
	tween.tween_property( %FightIntro, "modulate", Color.TRANSPARENT, 0.5 )
	tween.tween_property( %FightControls, "modulate", Color.WHITE, 0.5 )
	tween.finished.connect( player_turn )


func _process(delta):
	%PlayerHealthBar.health = Global.player_health

	if enemy == null : return

	%EnemyHealthBar.health = enemy.battle_stats.hp

	if enemy.battle_stats.hp <= 0:
		enemy.queue_free() 
		disable_player()
		var tween : Tween = create_tween()
		tween.tween_property( %FightControls, "modulate", Color.TRANSPARENT, 0.5 )
		tween.tween_property( %VictoryPanel, "position", Vector2(180, 88), 2 )
		%BackToGameButton.grab_focus()


func player_turn():
	var children = %AttackButtonContainer.get_children()
	for child in children :
		child.disabled = false
	
	children[0].grab_focus()


func disable_player():
	var children = %AttackButtonContainer.get_children()
	for child in children :
		child.disabled = true


func _on_button_1_pressed():
	enemy.battle_stats.hp -= max( 0, 2 - enemy.battle_stats.def )
	%PlayerRect.play("Attack")
	disable_player()


func _on_button_2_pressed():
	enemy.battle_stats.hp -= max( 0, 3 - enemy.battle_stats.def )
	%PlayerRect.play("Use")
	disable_player()


func _on_button_3_pressed():
	enemy.battle_stats.hp -= max( 0, 1 - enemy.battle_stats.def )
	disable_player()


func enemy_turn():
	if enemy == null : return
	Global.player_node.hit( max( 0, enemy.battle_stats.atk - 1 ) )
	%PlayerRect.play("Damaged")


func _on_player_rect_animation_finished():
	if %PlayerRect.animation == "Attack" or %PlayerRect.animation == "Use":
		enemy_turn()
	if  %PlayerRect.animation == "Damaged" :
		player_turn()
	%PlayerRect.play("Idle")


func _on_back_to_game_button_pressed():
	get_tree().paused = false
	queue_free()
