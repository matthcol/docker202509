LOCK TABLES event WRITE;
insert into event (name, evt_type, distance)
values  ('1500 m', 'track', 1500),
    ('Long Jump', 'field', NULL);
UNLOCK TABLES;
