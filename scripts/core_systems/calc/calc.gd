class_name LevelCalculator

# computes changes at the end of a level
# Honestly this could just be a global function,
# don't think it actually needs this much stuff

# 1. takes snapshot of stats of all units
# 2. for each student, compiles all neighbors + complications associated with neighbors
# 3. Calculates how stats should be modified, and returns

# This function could probably be simplified into taking one parameter that holds all this, but this is fine
static func calculate_stats(num_units: int, unit_db: UnitsDb, complications_db: ComplicationsDb, map_db: Map) -> Array[UnitStats]:
  var old_stats : Array[UnitStats]
  for i in range(num_units):
    old_stats.append(unit_db.get_stats(i))

  # now we build up our new stats
  var new_stats : Array[UnitStats]
  for i in range(num_units):
    new_stats.append(old_stats[i].duplicate(true))
    # get neighbors for this unit
    # potential optimization, change the get_neighbors function to also return who is sitting in which seat
    var neighbors : Array[Neighbor] = map_db.get_neighbors(i)
    # for each neighbor, get complications
    for neighbor in neighbors:
      var neighbor_unit_id = map_db.get_seat(neighbor.seat_id)
      var neighbor_stats = old_stats[neighbor_unit_id]
      var comp : ComplicationData = complications_db.get_complications(i, neighbor_unit_id)
      var change_to_apply : UnitStats = calculate_stat_change(old_stats[i].duplicate(true), neighbor_stats, neighbor.distance, comp)
      apply_stat_change(new_stats[i], change_to_apply)

  return new_stats


static func calculate_stat_change(original: UnitStats, other: UnitStats, distance: int, complication: ComplicationData) -> UnitStats:
  return


static func apply_stat_change(initial: UnitStats, applied_change: UnitStats) -> void:
  pass
