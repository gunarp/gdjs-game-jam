class_name GameState extends Control

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

@onready var submit_button: Button = $SubmitButton
@onready var pause_button: Button = $PauseMenu/BackButton

var fill_count: int
const NUM_UNITS = 5

func _ready() -> void:
  submit_button.pressed.connect(_on_submit_button_pressed)
  pause_button.pressed.connect(_on_back_button_pressed)
  submit_button.hide()
  $PauseMenu.visible = false

  MouseEventsBus.global_entity_dropped.connect(_on_entity_dropped)


func get_slot_at_pos(pos: Vector2) -> DroppableSlot:
  for slot in slot_list:
    if slot.get_global_rect().has_point(pos):
      return slot
  return null


func swap_seat(entity: DraggableEntity, dest: DroppableSlot) -> void:
  var other_entity = dest.get_node("Draggable") as DraggableEntity
  var source = entity.get_parent()

  entity.manual_unparent()
  other_entity.move_to_slot(source)
  entity.move_to_slot(dest)


func move_entity_to_open_slot(entity: DraggableEntity, dest: DroppableSlot) -> void:
  var old_fill_count: int = fill_count

  # TODO: update core system state here... potentially
  if dest is Seat:
    fill_count += 1
  else:
    fill_count -= 1

  entity.move_to_slot(dest)

  if fill_count == NUM_UNITS:
    submit_button.show()
  elif old_fill_count == NUM_UNITS:
    submit_button.hide()


func _on_entity_dropped(entity: DraggableEntity) -> void:
  var slot: DroppableSlot = get_slot_at_pos(get_global_mouse_position())

  if slot == null:
    entity.revert_pos()
  else:
    if slot.is_empty():
      move_entity_to_open_slot(entity, slot)
    else:
      swap_seat(entity, slot)


func _on_submit_button_pressed() -> void:
  # kickoff calculation procedure
  var new_unit_stats = LevelCalculator.calculate_stats(NUM_UNITS, $CoreState/UnitsDb, $CoreState/ComplicationsDb, $CoreState/Map)
  for i in range(NUM_UNITS):
    $CoreState/UnitsDb.set_stats(i, new_unit_stats[i])
  # TODO: Present stat screen
  $PauseMenu.visible = true


func _on_back_button_pressed() -> void:
  $PauseMenu.visible = false
