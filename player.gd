extends CharacterBody2D
signal health_depleted
var health = 100.0
@onready var death_timer = $Timer
func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right",
	"move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		#get_node("HappyBoo").play_walk_animation()
		$HappyBoo.play_walk_animation()
	else:
		get_node("HappyBoo").play_idle_animation()
	
	const DAMAGE_RATE = 15.0
	var overlapping_mobs = %hurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
			var smoke = SMOKE_SCENE.instantiate()
			get_parent().add_child(smoke)
			smoke.global_position = global_position	
			health_depleted.emit()
		
			
