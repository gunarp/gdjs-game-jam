extends Node

class_name Map
  
class SeatInfo:
  var unit_id = -1
  var neighbors: Array[Neighbor]
  
  func _to_string():
    return "unit_id: " + str(self.unit_id) + ", " + str(neighbors)

var map: Array[SeatInfo] = []

func _to_string() -> String:
  return "hello!"

func _ready() -> void:
  var zone_size = [3, 2]
  var zone_first_seat = 0
  
  # for each given zone
  for i in zone_size: # i.e. 3, 2
    for seat in range(i): #for each seat in zone i, i.e. 0, 1, 2
      var temp_seat = SeatInfo.new()
      var temp_arr: Array[Neighbor] = []
      
      for neighbor in range(i): # compare to the other seats
        var temp = Neighbor.new()
        if neighbor != seat:
          temp.seat_id = neighbor + zone_first_seat
          temp.distance = abs(neighbor - seat)
          temp_arr.append(temp)
          
      temp_seat.neighbors = temp_arr
      map.append(temp_seat)
    zone_first_seat += i
  
  print(map)
  print(map.size())
  pass

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
