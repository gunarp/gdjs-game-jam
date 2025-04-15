extends Control

class_name DraggableEntity

signal dragged_away(entity: DraggableEntity)

const TWEEN_TIME = 0.25

var unit_id: int

var mouse_offset: Vector2
var is_being_dragged: bool
var dragged_from_pos: Vector2

@onready var texture_rect: TextureRect = $TextureRect
# @onready var card_face: Panel = $CardFace
# @onready var value_label: Label = $CardFace/ValueLabel
# @onready var sprite_2d: Sprite2D = $CardFace/Sprite2D


func _init() -> void:
  pass


func get_preview() -> Control:
  return texture_rect.duplicate()


func _on_mouse_button_down() -> void:
  print("down")
  mouse_offset = get_local_mouse_position()
  dragged_from_pos = global_position
  z_index += 1
  is_being_dragged = true


func _on_mouse_button_up() -> void:
  print("up")
  MouseEventsBus.global_entity_dropped.emit(self)
  z_index -= 1
  is_being_dragged = false


func revert_pos() -> void:
  move_to_pos(dragged_from_pos)


func tween_pos_done() -> void:
  z_index -= 1


func can_move_to_slot(slot: DroppableSlot) -> bool:
  return slot.is_empty()


func move_to_pos(pos: Vector2) -> void:
  z_index += 1
  var tween: Tween = get_tree().create_tween()
  tween.set_ease(Tween.EASE_IN_OUT)
  tween.tween_property(self, "global_position", pos, TWEEN_TIME)
  tween.tween_callback(tween_pos_done)


func move_to_slot(slot: DroppableSlot) -> void:
  var old_pos: Vector2 = global_position
  dragged_away.emit(self)
  # card_source = slot.slot_type
  # toggle_flip(slot.slot_type != DroppableSlot.MouseEventsCardSlotType.DECK)
  slot.add_entity(self)
  set_deferred("global_position", old_pos)
  call_deferred("move_to_pos", slot.global_position)


func _on_gui_input(event: InputEvent) -> void:
  if event is InputEventMouseButton:
    var mouse_event: InputEventMouseButton = event as InputEventMouseButton
    if mouse_event.button_index == 1:
      if mouse_event.button_mask == 1:
        _on_mouse_button_down()
      else:
        _on_mouse_button_up()
  elif is_being_dragged and event is InputEventMouseMotion:
    var mouse_event: InputEventMouseMotion = event as InputEventMouseMotion
    global_position = get_global_mouse_position() - mouse_offset
