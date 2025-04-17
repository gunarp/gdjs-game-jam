extends Node

class_name UnitsDb

func _ready() -> void:
  pass


func get_stats(unit_id: int) -> UnitStats:
  return UnitStats.new()


func set_stats(unit_id: int, new_stats: UnitStats) -> void:
  pass
