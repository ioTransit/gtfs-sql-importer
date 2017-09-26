SELECT 'gtfs_route_types_fkey', count(distinct (feed_index, route_type))
  FROM gtfs_routes a
    LEFT JOIN gtfs_route_types b using (route_type)
  WHERE b.description IS NULL;

SELECT 'gtfs_routes_fkey', count(distinct (feed_index, agency_id))
  FROM gtfs_routes a
    LEFT JOIN gtfs_agency b using (feed_index, agency_id)
  WHERE b.agency_id IS NULL;

SELECT 'gtfs_calendar_fkey', count(distinct (feed_index, service_id))
  FROM gtfs_calendar_dates
    LEFT JOIN gtfs_calendar b using (feed_index, service_id)
  WHERE coalesce(b.monday, b.friday) IS NULL;

SELECT 'gtfs_fare_attributes_fkey', count(distinct (feed_index, agency_id))
  FROM gtfs_fare_attributes a
    LEFT JOIN gtfs_agency b using (feed_index, agency_id)
  WHERE b.agency_id IS NULL;

SELECT 'gtfs_fare_rules_service_fkey', count(distinct (feed_index, service_id))
  FROM gtfs_fare_rules a
    LEFT JOIN gtfs_calendar b using (feed_index, service_id)
  WHERE coalesce(b.monday, b.friday) IS NULL;

SELECT 'gtfs_fare_rules_fare_id_fkey', count(distinct (feed_index, fare_id))
  FROM gtfs_fare_rules a
    LEFT JOIN gtfs_fare_attributes b using (feed_index, fare_id)
  WHERE b.price IS NULL;

SELECT 'gtfs_fare_rules_route_id_fkey', count(distinct (feed_index, route_id))
  FROM gtfs_fare_rules a
    LEFT JOIN gtfs_routes b using (feed_index, route_id)
  WHERE b.agency_id IS NULL;

SELECT 'gtfs_trips_route_id_fkey', count(distinct (feed_index, route_id))
  FROM gtfs_trips a
    LEFT JOIN gtfs_routes b using (feed_index, route_id)
  WHERE b.agency_id IS NULL;

SELECT 'gtfs_trips_calendar_fkey', count(distinct (feed_index, service_id))
  FROM gtfs_trips a
    LEFT JOIN gtfs_calendar b using (feed_index, service_id)
  WHERE coalesce(b.monday, b.friday) IS NULL;

SELECT 'gtfs_stop_times_trips_fkey', count(distinct (feed_index, trip_id))
  FROM gtfs_stop_times a
    LEFT JOIN gtfs_trips b using (feed_index, trip_id)
  WHERE b.service_id IS NULL;

SELECT 'gtfs_stop_times_stops_fkey', count(distinct (feed_index, stop_id))
  FROM gtfs_stop_times a
    LEFT JOIN gtfs_stops b using (feed_index, stop_id)
  WHERE coalesce(stop_lat, stop_lon) IS NULL;

SELECT 'gtfs_frequencies_trip_fkey', count(distinct (feed_index, trip_id))
  FROM gtfs_frequencies a
    LEFT JOIN gtfs_trips b using (feed_index, trip_id)
  WHERE b.service_id IS NULL;

SELECT 'gtfs_transfers_from_stop_fkey', count(distinct (a.feed_index, from_stop_id))
  FROM gtfs_transfers a
    LEFT JOIN gtfs_stops b on a.feed_index = b.feed_index and a.from_stop_id::text = b.stop_id::text
  WHERE coalesce(stop_lat, stop_lon) IS NULL;

SELECT 'gtfs_transfers_to_stop_fkey', count(distinct (a.feed_index, to_stop_id))
  FROM gtfs_transfers a
    LEFT JOIN gtfs_stops b on a.feed_index = b.feed_index and a.to_stop_id::text = b.stop_id::text
  WHERE coalesce(stop_lat, stop_lon) IS NULL;

SELECT 'gtfs_transfers_from_route_fkey', count(distinct (a.feed_index, from_route_id))
  FROM gtfs_transfers a
    LEFT JOIN gtfs_routes b on a.feed_index = b.feed_index and a.from_route_id::text = b.route_id::text
  WHERE b.agency_id IS NULL;

SELECT 'gtfs_transfers_to_route_fkey', count(distinct (a.feed_index, to_route_id))
  FROM gtfs_transfers a
    LEFT JOIN gtfs_routes b on a.feed_index = b.feed_index and a.to_route_id::text = b.route_id::text
  WHERE b.agency_id IS NULL;

SELECT 'gtfs_transfers_service_fkey', count(distinct (feed_index, service_id))
  FROM gtfs_transfers a
    LEFT JOIN gtfs_calendar b using (feed_index, service_id)
  WHERE coalesce(b.monday, b.friday) IS NULL;
