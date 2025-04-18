extends Resource

class_name Neighbor
var seat_id: int
var distance: int

func _to_string() -> String:
  return "seat_id: " + str(seat_id) + ", distance: " + str(distance)
