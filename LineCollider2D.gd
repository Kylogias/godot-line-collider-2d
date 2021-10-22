extends PhysicsBody2D

export (Array, NodePath) var lines_to_follow = [NodePath("Line2D")]

func _ready():
	var num_segments : int = 0
	var line_points : Array = []
	for path_to_line in lines_to_follow:
		var line : Line2D = get_node(path_to_line)
		var translated_points : Array
		for i in range(0, len(line.points)):
			translated_points.append(line.points[i] + line.position)
		line_points.append_array(translated_points)
		num_segments += len(line.points)
		line_points.append(Vector2(419430.4, 419430.4))
	for current_segment in range(0, num_segments):
		if line_points[current_segment+1] == Vector2(419430.4, 419430.4) or line_points[current_segment] == Vector2(419430.4, 419430.4):
			continue
		var segment_collider := CollisionShape2D.new()
		segment_collider.shape = SegmentShape2D.new()
		segment_collider.shape.a = line_points[current_segment]
		segment_collider.shape.b = line_points[current_segment+1]
		add_child(segment_collider)
