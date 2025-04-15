class_name MouseDriver extends Control

# TODO: Come up with a way to generate these programatically
@onready var seat_1: DroppableSlot = $SeatingArea/Table1/Seat
@onready var seat_2: DroppableSlot = $SeatingArea/Table1/Seat2
@onready var seat_3: DroppableSlot = $SeatingArea/Table2/Seat3
@onready var seat_4: DroppableSlot = $SeatingArea/Table2/Seat4

@onready var source_1: SourceSlot = $UnitMenu/SourceSlot
@onready var source_2: SourceSlot = $UnitMenu/SourceSlot2
@onready var source_3: SourceSlot = $UnitMenu/SourceSlot3
@onready var source_4: SourceSlot = $UnitMenu/SourceSlot4

@onready var slot_list: Array[DroppableSlot] = [seat_1, seat_2, seat_3, seat_4, source_1, source_2, source_3, source_4]


func _init() -> void:
  pass


func _ready() -> void:
  MouseEventsBus.global_entity_dropped.connect(_on_entity_dropped)


func _on_entity_dropped(entity: DraggableEntity) -> void:
  var slot: DroppableSlot = get_slot_at_pos(get_global_mouse_position())
  if slot:
    if not entity.can_move_to_slot(slot):
      entity.revert_pos()
    else:
      entity.move_to_slot(slot)
  else:
    entity.revert_pos()


func get_slot_at_pos(pos: Vector2) -> DroppableSlot:
  for slot in slot_list:
    if slot.get_global_rect().has_point(pos):
      return slot
  return null
