module SmoWgs84ToBng
  module Validator
    LAT_MIN  =   49.0
    LAT_MAX  =   61.0
    LON_MIN  =   -8.5
    LON_MAX  =    2.0
    E_MIN    =    0.0
    E_MAX    = 700_000.0
    N_MIN    =    0.0
    N_MAX    = 1_300_000.0

    module_function

    def validate_wgs84!(id:, lat:, lon:, index: nil)
      ctx = index ? " for point at index #{index}" : ""

      raise MissingIdError, "id is required#{ctx}" if id.nil?

      raise MissingCoordinateError, "lat is required#{ctx}" if lat.nil?
      raise MissingCoordinateError, "lon is required#{ctx}" if lon.nil?

      unless numeric?(lat)
        raise InvalidCoordinateError, "lat must be numeric#{ctx}"
      end
      unless numeric?(lon)
        raise InvalidCoordinateError, "lon must be numeric#{ctx}"
      end

      lat_f = lat.to_f
      lon_f = lon.to_f

      unless lat_f.between?(LAT_MIN, LAT_MAX)
        raise OutOfBoundsError, "lat #{lat_f} is outside GB bounds (#{LAT_MIN}..#{LAT_MAX})#{ctx}"
      end
      unless lon_f.between?(LON_MIN, LON_MAX)
        raise OutOfBoundsError, "lon #{lon_f} is outside GB bounds (#{LON_MIN}..#{LON_MAX})#{ctx}"
      end
    end

    def validate_bng!(id:, easting:, northing:, index: nil)
      ctx = index ? " for point at index #{index}" : ""

      raise MissingIdError, "id is required#{ctx}" if id.nil?

      raise MissingCoordinateError, "easting is required#{ctx}" if easting.nil?
      raise MissingCoordinateError, "northing is required#{ctx}" if northing.nil?

      unless numeric?(easting)
        raise InvalidCoordinateError, "easting must be numeric#{ctx}"
      end
      unless numeric?(northing)
        raise InvalidCoordinateError, "northing must be numeric#{ctx}"
      end

      e_f = easting.to_f
      n_f = northing.to_f

      unless e_f.between?(E_MIN, E_MAX)
        raise OutOfBoundsError, "easting #{e_f} is outside GB bounds (#{E_MIN}..#{E_MAX})#{ctx}"
      end
      unless n_f.between?(N_MIN, N_MAX)
        raise OutOfBoundsError, "northing #{n_f} is outside GB bounds (#{N_MIN}..#{N_MAX})#{ctx}"
      end
    end

    def numeric?(val)
      val.is_a?(Numeric)
    end
  end
end
