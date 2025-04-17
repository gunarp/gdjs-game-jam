class_name Seat extends DroppableSlot

@export var seat_id: int
var seated_unit_id: int = -1


func add_entity(entity: DraggableEntity) -> void:
  seated_unit_id = entity.unit_id
  super(entity)
  # TODO: call into core system element


func dragged_away(entity: DraggableEntity) -> void:
  seated_unit_id = -1
  super(entity)
  # TODO: call into core system element


func is_empty() -> bool:
  return seated_unit_id == -1


func get_seated_unit_id() -> int:
  return seated_unit_id