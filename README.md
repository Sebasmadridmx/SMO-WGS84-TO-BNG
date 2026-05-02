# smo_wgs84_to_bng

Convert between WGS84 (GPS latitude/longitude) and OSGB36 British National Grid (easting/northing) using a 7-parameter Helmert transformation. Pure Ruby, no external dependencies.

---

## Installation

```bash
gem install smo_wgs84_to_bng
```

Or add to your Gemfile:

```ruby
gem 'smo_wgs84_to_bng'
```

---

## Usage

### Forward conversion (WGS84 to BNG)

#### Single point

```ruby
require 'smo_wgs84_to_bng'

# Hash
SmoWgs84ToBng.convert_to_hash(id: 'GULLY_001', lat: 51.4779, lon: -0.0015)
# => { id: 'GULLY_001', easting: 538884.8, northing: 177321.9 }

# Hash with extra keys preserved
SmoWgs84ToBng.convert_to_hash(id: 'GULLY_001', lat: 51.4779, lon: -0.0015, material: 'concrete')
# => { id: 'GULLY_001', easting: 538884.8, northing: 177321.9, material: 'concrete' }

# Array (extra keys are dropped)
SmoWgs84ToBng.convert_to_array(id: 'GULLY_001', lat: 51.4779, lon: -0.0015)
# => ['GULLY_001', 538884.8, 177321.9]

# JSON string
SmoWgs84ToBng.convert_to_json(id: 'GULLY_001', lat: 51.4779, lon: -0.0015)
# => '{"id":"GULLY_001","easting":538884.8,"northing":177321.9}'
```

#### Batch

```ruby
points = [
  { id: 'A', lat: 51.4779, lon: -0.0015 },
  { id: 'B', lat: 55.9486, lon: -3.1999, material: 'iron' }
]

SmoWgs84ToBng.convert_many_to_hash(points)
# => [{ id: 'A', easting: ..., northing: ... }, { id: 'B', easting: ..., northing: ..., material: 'iron' }]

SmoWgs84ToBng.convert_many_to_array(points)
# => [['A', ..., ...], ['B', ..., ...]]

SmoWgs84ToBng.convert_many_to_json(points)
# => '[{"id":"A",...},{"id":"B",...}]'
```

### Reverse conversion (BNG to WGS84)

#### Single point

```ruby
SmoWgs84ToBng.reverse_to_hash(id: 'GULLY_001', easting: 538885, northing: 177322)
# => { id: 'GULLY_001', lat: 51.4779, lon: -0.0015 }

SmoWgs84ToBng.reverse_to_array(id: 'GULLY_001', easting: 538885, northing: 177322)
# => ['GULLY_001', 51.4779, -0.0015]

SmoWgs84ToBng.reverse_to_json(id: 'GULLY_001', easting: 538885, northing: 177322)
# => '{"id":"GULLY_001","lat":51.4779,"lon":-0.0015}'
```

#### Batch

```ruby
points = [
  { id: 'A', easting: 538885, northing: 177322 },
  { id: 'B', easting: 325162, northing: 673961 }
]

SmoWgs84ToBng.reverse_many_to_hash(points)
SmoWgs84ToBng.reverse_many_to_array(points)
SmoWgs84ToBng.reverse_many_to_json(points)
```

---

## Accuracy

This gem uses a 7-parameter Helmert transformation based on the parameters published in the Ordnance Survey guide "A Guide to Coordinate Systems in Great Britain". Typical accuracy is approximately 3-5 metres across mainland Great Britain. It is suitable for GIS, asset management, and field data workflows but is not appropriate for survey-grade or engineering applications where sub-metre accuracy is required.

---

## Validation and Errors

All inputs are validated. The following error classes are defined:

| Class | Raised when |
|---|---|
| `SmoWgs84ToBng::Error` | Base class for all gem errors |
| `SmoWgs84ToBng::MissingIdError` | `id` is nil or missing |
| `SmoWgs84ToBng::MissingCoordinateError` | `lat`, `lon`, `easting`, or `northing` is nil |
| `SmoWgs84ToBng::InvalidCoordinateError` | Coordinate value is not numeric |
| `SmoWgs84ToBng::OutOfBoundsError` | Coordinates fall outside reasonable GB bounds |

**Accepted bounds:**

- Latitude: 49.0 to 61.0
- Longitude: -8.5 to 2.0
- Easting: 0 to 700,000
- Northing: 0 to 1,300,000

Batch methods include the index of the offending point in the error message, e.g. `"id is required for point at index 2"`.

---

## Coordinate Systems

- **WGS84** (EPSG:4326): The geographic coordinate system used by GPS. Coordinates expressed as latitude and longitude in decimal degrees.
- **OSGB36 British National Grid** (EPSG:27700): The coordinate reference system used by Ordnance Survey for Great Britain. Coordinates expressed as easting and northing in metres.

---

## Limitations

- Designed for mainland Great Britain only.
- Not suitable for Ireland or Northern Ireland (use ITM or Irish Grid instead).
- Not suitable for the Channel Islands or other British Overseas Territories.
- Accuracy degrades at the edges of the coverage area.
- Not for survey-grade applications.

---

## License

[MIT](LICENSE)

---

## Buy Me a Coffee

If this gem saves you time, a coffee is always appreciated.

<p align="center">
  <a href="https://buymeacoffee.com/smadrid">
    <img src="https://raw.githubusercontent.com/Sebasmadridmx/SMO-WGS84-TO-BNG/main/qr-code.png" width="250" alt="Buy Me a Coffee QR code">
  </a>
</p>
