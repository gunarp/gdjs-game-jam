extends DroppableSlot

class_name SourceSlot

const UNIT = preload("res://scenes/game/draggable.tscn")

@export var unit_id: int


func _ready() -> void:
  # this might be the spot where we'd intialize whatever the unit renders as on the screen
  var child = UNIT.instantiate()
  child.unit_id = unit_id
  add_child(child)


func dragged_away(entity: DraggableEntity) -> void:
  super(entity)