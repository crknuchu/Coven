extends Area3D

func _physics_process(_delta):
	for body in self.get_overlapping_bodies():
		if body is Player:
			Global.player.has_red_key = true
			print("picked up red key")
			queue_free()
