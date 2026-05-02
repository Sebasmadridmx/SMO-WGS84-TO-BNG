require_relative "lib/smo_wgs84_to_bng"

# --- Forward: WGS84 -> BNG ---

puts SmoWgs84ToBng.convert_to_hash(id: "GULLY_001", lat: 51.4779, lon: -0.0015).inspect
puts SmoWgs84ToBng.convert_to_array(id: "GULLY_001", lat: 51.4779, lon: -0.0015).inspect
puts SmoWgs84ToBng.convert_to_json(id: "GULLY_001", lat: 51.4779, lon: -0.0015)

puts

# --- Reverse: BNG -> WGS84 ---

puts SmoWgs84ToBng.reverse_to_hash(id: "GULLY_001", easting: 538883, northing: 177331).inspect
puts SmoWgs84ToBng.reverse_to_array(id: "GULLY_001", easting: 538883, northing: 177331).inspect
puts SmoWgs84ToBng.reverse_to_json(id: "GULLY_001", easting: 538883, northing: 177331)

puts

# --- Batch ---

points = [
  { id: "A", lat: 51.4779, lon: -0.0015, material: "concrete" },
  { id: "B", lat: 55.9486, lon: -3.1999 },
]

puts SmoWgs84ToBng.convert_many_to_hash(points).inspect
puts SmoWgs84ToBng.convert_many_to_json(points)
