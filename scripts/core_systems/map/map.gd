extends Node

class_name Map
  
class Seat_Info:
  var unit_id = -1
  var neighbors: Array[Neighbor]

var map: Array[Seat_Info] = []

func _ready() -> void:
  var seat_vals = [1, 0, 3, 2]
  for i in range(4):
    var temp = Neighbor.new()
    var temp_seat = Seat_Info.new()
    temp.seat_id = seat_vals[i]
    temp.distance = 1
    
    var temp_arr: Array[Neighbor] = [temp]
    
    temp_seat.neighbors = temp_arr
    map.append(temp_seat)
  
  print(map)
  pass

func _to_string() -> String:
  return "hello!"

func get_neighbors(seat_id: int) -> Array[Neighbor]:
  return map[seat_id].neighbors

func set_seat(seat_id: int, unit_id: int) -> void:
  map[seat_id].unit_id = unit_id
  pass

func clear_seat(seat_id: int) -> void:
  map[seat_id].unit_id = -1
  pass

# return a -1 if the seat is empty
func get_seat(seat_id: int) -> int:
  return map[seat_id].unit_id

func change_map(new_map_data: MapData) -> void:
  pass

# if all of the seats are full, returns 1
func is_seating_full() -> bool:
  var count = 0
  for i in map.size():
    # if seat is not empty, increase count by 1
    count += int(get_seat(i) != -1)
  return count == map.size()
