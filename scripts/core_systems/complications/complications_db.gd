extends Node

class_name ComplicationsDb


func _ready() -> void:
  pass


# Return the complication modifiers between units 1 and 2
func get_complications(unit_1: int, unit_2: int) -> ComplicationData:
  return


# up to 105 relations is kinda wild...
func set_complications(new_data: Array[ComplicationData]) -> void:
  pass
