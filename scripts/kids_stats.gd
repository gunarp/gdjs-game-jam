extends Node

var kids_stats = {}
var test_kid_id := 0 # Choose kid to modify

func _ready():
    kids_stats = load_kids_stats("res://kids_database.json") # Load JSON

func _input(event):
    if event.is_action_pressed("show_kid_stats"):
        print("K key pressed!") # Debug
        display_all_kids_stats()
    if event.is_action_pressed("stat_up_stinkiness"):
      adjust_stat(test_kid_id, "stinkiness", 1)
    if event.is_action_pressed("stat_down_stinkiness"):
      adjust_stat(test_kid_id, "stinkiness", -1)
    
func adjust_stat(kid_id: int, stat:String, delta: int):
  var kid_key = str(kid_id)
  if kids_stats.has(kid_key):
    var stats = kids_stats[kid_key]
    if stats.has(stat):
      stats[stat]+= delta
      print("🟢", stat, " for Kid ", kid_id, "is now", stats[stat])
    else:
      print("❌ Stat", stat, "not found for Kid", kid_id)
            
func load_kids_stats(path: String) -> Dictionary:
    var file = FileAccess.open(path, FileAccess.READ)
    var text = file.get_as_text()
    var parsed = JSON.parse_string(text)
    return parsed if typeof(parsed) == TYPE_DICTIONARY else {}

func display_all_kids_stats():
    for kid_id in kids_stats.keys():
        var stats = kids_stats[kid_id]
        print("Kid ID:", kid_id)
        print("Name:", stats["name"])
        print("Kindness:", stats["kindness"])
        print("Focus:", stats["focus"])
        print("Stinkiness:", stats["stinkiness"])
        print("------------------")
        
func set_stats(kid_id: int, new_stats: Dictionary) -> void:
  var kid_key = str(kid_id)
  if kids_stats.has(kid_key):
     kids_stats[kid_key] = new_stats
     print("Stats updated for Kid", kid_id, "->", new_stats)
  else:
    print("Kid ID", kid_id, "not found in the database")
