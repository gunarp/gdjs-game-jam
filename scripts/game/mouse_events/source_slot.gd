extends DroppableSlot

class_name SourceSlot

const UNIT = preload("res://scenes/game/draggable.tscn")

@export var unit_id: int

var _empty: bool = false

func _ready() -> void:
  var child = UNIT.instantiate()
  child.unit_id = unit_id
  add_entity(child)


func add_entity(entity: DraggableEntity) -> void:
  print("unit ", entity.unit_id, " moved into source")
  _empty = false
  super(entity)


func dragged_away(entity: DraggableEntity) -> void:
  print("unit ", entity.unit_id, " moved away from source")
  _empty = true
  super(entity)


func is_empty() -> bool:
  return _empty