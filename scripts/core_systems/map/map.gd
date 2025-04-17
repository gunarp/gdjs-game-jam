extends Node

class_name Map

func _ready() -> void:
  pass

func get_neighbors(seat_id: int) -> Array[Neighbor]:
  return []


func set_seat(seat_id: int, unit_id: int) -> void:
  pass


func clear_seat(seat_id: int) -> void:
  pass


# return a -1 if the seat is empty
func get_seat(seat_id: int) -> int:
  return 0


func change_map(new_map_data: MapData) -> void:
  pass

