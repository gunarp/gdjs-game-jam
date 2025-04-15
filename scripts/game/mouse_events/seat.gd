class_name Seat extends DroppableSlot

@export var seat_id: int
var seated_unit_id: int = -1


func add_entity(entity: DraggableEntity) -> void:
  print(entity.unit_id, " moved into ", seat_id)
  seated_unit_id = entity.unit_id
  super(entity)


func dragged_away(entity: DraggableEntity) -> void:
  print(entity.unit_id, " taken out of ", seat_id)
  seated_unit_id = -1
  super(entity)


func is_empty() -> bool:
  return seated_unit_id == -1