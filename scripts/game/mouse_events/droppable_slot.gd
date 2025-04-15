class_name DroppableSlot extends PanelContainer

func add_entity(entity: DraggableEntity) -> void:
  entity.dragged_away.connect(dragged_away)
  add_child(entity)


func dragged_away(entity: DraggableEntity) -> void:
  entity.dragged_away.disconnect(dragged_away)
  remove_child(entity)


func is_empty() -> bool:
  return false

# On mouse over - query neighbors