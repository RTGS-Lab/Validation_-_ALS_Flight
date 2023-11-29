SELECT
  to_timestamp((message::json->'Data'->>'Time')::int) as "time",
--  (message::json->'Data'->>'Devices') AS "Errors",
  (elems1->'Kestrel'->'ALS'->>'Clear') as "Clear",
  (elems1->'Kestrel'->'ALS'->>'Red') as "Red",
  (elems1->'Kestrel'->'ALS'->>'Green') as "Green",
  (elems1->'Kestrel'->'ALS'->>'Blue') as "Blue",
  (elems1->'Kestrel'->'ALS'->>'IR') as "IR",
  ((elems2->'Talon-SDI12'->'Apogee')::float)*1600 as "PAR",
  ((elems3->'Apogee Pyro'->'Solar')::float)*1.6 as "Solar"
FROM public.raw_data, jsonb_array_elements((message::jsonb)->'Data'->'Devices') elems1, jsonb_array_elements((message::jsonb)->'Data'->'Devices') elems2, jsonb_array_elements((message::jsonb)->'Data'->'Devices') elems3
where
  node_id = 'e00fce684e946ef10bf44eb7' AND event = 'data/v2' and published_at > '2023-11-16 00:00:00' and published_at < '2023-11-28 00:00:00' and elems1 ? 'Kestrel' and elems2 ? 'Talon-SDI12' and elems3 ? 'Apogee Pyro'
  ORDER BY 1