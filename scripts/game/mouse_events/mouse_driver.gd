class_name MouseDriver extends Control

# TODO: Come up with a way to generate these programatically
@onready var seat_1: DroppableSlot = $SeatingArea/Table1/Seat
@onready var seat_2: DroppableSlot = $SeatingArea/Table1/Seat2
@onready var seat_3: DroppableSlot = $SeatingArea/Table1/Seat3
@onready var seat_4: DroppableSlot = $SeatingArea/Table2/Seat3
@onready var seat_5: DroppableSlot = $SeatingArea/Table2/Seat4

@onready var source_1: SourceSlot = $UnitMenu/SourceSlot
@onready var source_2: SourceSlot = $UnitMenu/SourceSlot2
@onready var source_3: SourceSlot = $UnitMenu/SourceSlot3
@onready var source_4: SourceSlot = $UnitMenu/SourceSlot4
@onready var source_5: SourceSlot = $UnitMenu/SourceSlot5

@onready var slot_list: Array[DroppableSlot] = [seat_1, seat_2, seat_3, seat_4, seat_5, source_1, source_2, source_3, source_4, source_5]


func _init() -> void:
  pass


func _ready() -> void:
  MouseEventsBus.global_entity_dropped.connect(_on_entity_dropped)


func _on_entity_dropped(entity: DraggableEntity) -> void:
  var slot: DroppableSlot = get_slot_at_pos(get_global_mouse_position())
  if slot is Seat:
    if slot.is_empty():
      entity.move_to_slot(slot)
    else:
      print("would swap seats")
      # TODO: swap the two
      # we have the desitnation seat
      # we need to plumb source seat for this entity
      # we also need to get the entity in the desitnation seat

      # print(slot.get_children())
      for i in slot.get_children():
        print(i.name)
      # var other_entity = slot.find_child("DraggableEntity", false, false) as DraggableEntity
      var other_entity = slot.get_node("Draggable") as DraggableEntity
      var source_slot = entity.get_parent()
      entity.manual_unparent()

      other_entity.move_to_slot(source_slot)
      entity.move_to_slot(slot)

      # get source seat
      # source_seat = entity.parent
      # unparent this entity
      # entity.dragged_away.emit(entity)
      # other.move_to_slot(source)
      # this.move_to_slot(dest)
      # entity.revert_pos()
      pass
  elif slot is SourceSlot:
    if slot.is_empty():
      entity.move_to_slot(slot)
    else:
      entity.revert_pos()
  else:
    entity.revert_pos()


func get_slot_at_pos(pos: Vector2) -> DroppableSlot:
  for slot in slot_list:
    if slot.get_global_rect().has_point(pos):
      return slot
  return null
