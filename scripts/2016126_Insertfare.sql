DELETE from leg_instanace_seats where leg_instance_leg_no = 2 and leg_instance_flight_no = 'W-XYZ' and  seat_no = 1;
DELETE from leg_instanace_seats where leg_instance_leg_no = 2 and leg_instance_flight_no = 'W-XYZ' and  seat_no = 2;
DELETE from leg_instanace_seats where leg_instance_leg_no = 2 and leg_instance_flight_no = 'W-XYZ' and  seat_no = 3;
DELETE from leg_instanace_seats where leg_instance_leg_no = 2 and leg_instance_flight_no = 'W-XYZ' and  seat_no = 4;
DELETE from leg_instance where leg_no = 2 and flight_no = 'W-XYZ';
DELETE from flight_leg where leg_no = 2 and flight_no = 'W-XYZ';

UPDATE flight set no_of_stops = 1
where flight_no = 'W-XYZ';

INSERT into flight
values('W-PQR', 1);
INSERT into flight
values('W-STV', 1);
INSERT into flight
values('W-RQP', 1);
INSERT into flight
values('W-VTS', 1);
INSERT into flight
values('W-FED', 1);
INSERT into flight
values('W-CBA', 1);
INSERT into flight
values('W-ZYX', 1);
INSERT into flight
values('W-GHI', 1);
INSERT into flight
values('W-IHG', 1);
INSERT into flight
values('W-MNO', 1);
INSERT into flight
values('W-GFE', 1);
INSERT into flight
values('W-EFG', 1);
INSERT into flight
values('W-KLM', 1);
INSERT into flight
values('W-TRP', 1);


INSERT into flight_workdays
values('W-ABC',5);
INSERT into flight_workdays
values('W-ABC',6);
INSERT into flight_workdays
values('W-ABC',7);
INSERT into flight_workdays
values('W-DEF',4);
INSERT into flight_workdays
values('W-DEF',5);
INSERT into flight_workdays
values('W-DEF',6);
INSERT into flight_workdays
values('W-DEF',7);

INSERT into flight_workdays
values('W-STV',5);
INSERT into flight_workdays
values('W-PQR',6);
INSERT into flight_workdays
values('W-RPQ',7);
INSERT into flight_workdays
values('W-VTS',4);
INSERT into flight_workdays
values('W-FED',5);
INSERT into flight_workdays
values('W-CBA',6);
INSERT into flight_workdays
values('W-ZYX',7);

INSERT into flight_workdays
values('W-GHI',5);
INSERT into flight_workdays
values('W-IHG',6);
INSERT into flight_workdays
values('W-MNO',7);
INSERT into flight_workdays
values('W-GFE',4);
INSERT into flight_workdays
values('W-EFG',5);
INSERT into flight_workdays
values('W-KLM',6);
INSERT into flight_workdays
values('W-TRP',7);

INSERT into flight_workdays
values('W-TRP',1);
INSERT into flight_workdays
values('W-KLM',2);
INSERT into flight_workdays
values('W-RPQ',3);
INSERT into flight_workdays
values('W-TRP',4);
INSERT into flight_workdays
values('W-KLM',5);
INSERT into flight_workdays
values('W-EFG',6);
INSERT into flight_workdays
values('W-MNO',7);

INSERT into flight_workdays
values('W-IHG',1);
INSERT into flight_workdays
values('W-GHI',2);
INSERT into flight_workdays
values('W-ZYX',3);
INSERT into flight_workdays
values('W-CBA',4);
INSERT into flight_workdays
values('W-FED',5);
INSERT into flight_workdays
values('W-VTS',6);
INSERT into flight_workdays
values('W-RQP',1);

UPDATE fare SET special_code = 'W-ABC'
where route_id =1;
UPDATE fare SET special_code = 'W-PQR'
where route_id =2;
UPDATE fare SET special_code = 'W-MNO'
where route_id =3;
UPDATE fare SET special_code = 'W-DEF'
where route_id =4;
UPDATE fare SET special_code = 'W-EFG'
where route_id =5;
UPDATE fare SET special_code = 'W-KLM'
where route_id =6;
UPDATE fare SET special_code = 'W-RQP'
where route_id =7;
UPDATE fare SET special_code = 'W-GFE'
where route_id =8;
UPDATE fare SET special_code = 'W-TRP'
where route_id =9;

INSERT into fare
values(1,'W-XYZ',280);
INSERT into fare
values(1,'W-STV',180);
INSERT into fare
values(1,'W-FED',200);

INSERT into fare
values(2,'W-GHI',250);
INSERT into fare
values(4,'W-VTS',230);
INSERT into fare
values(4,'W-CBA',320);
INSERT into fare
values(4,'W-ZYX',190);
INSERT into fare
values(7,'W-IHG',280);

INSERT into flight_leg
values(1,'W-STV',1,'2016-12-10 21:00:00','2016-12-10 19:00:00',2);
INSERT into flight_leg
values(1,'W-PQR',2,'2016-12-12 19:00:00','2016-12-12 15:00:00',4);
INSERT into flight_leg
values(1,'W-RQP',7,'2016-12-10 17:00:00','2016-12-10 15:00:00',2);
INSERT into flight_leg
values(1,'W-VTS',4,'2016-12-10 21:00:00','2016-12-10 19:00:00',2);

INSERT into flight_leg
values(1,'W-FED',1,'2016-12-11 02:30:00','2016-12-11 00:00:00',2.5);
INSERT into flight_leg
values(1,'W-CBA',4,'2016-12-12 15:00:00','2016-12-12 17:00:00',2);
INSERT into flight_leg
values(1,'W-ZYX',4,'2016-12-10 15:00:00','2016-12-10 17:00:00',2);

INSERT into flight_leg
values(1,'W-GHI',2,'2016-12-10 21:00:00','2016-12-10 19:00:00',2);
INSERT into flight_leg
values(1,'W-IHG',7,'2016-12-12 19:00:00','2016-12-12 15:00:00',4);
INSERT into flight_leg
values(1,'W-MNO',3,'2016-12-10 17:00:00','2016-12-10 15:00:00',2);
INSERT into flight_leg
values(1,'W-GFE',8,'2016-12-10 21:00:00','2016-12-10 19:00:00',2);

INSERT into flight_leg
values(1,'W-EFG',5,'2016-12-10 21:00:00','2016-12-10 19:00:00',2);
INSERT into flight_leg
values(1,'W-KLM',6,'2016-12-12 19:00:00','2016-12-12 15:00:00',4);
INSERT into flight_leg
values(1,'W-TRP',9,'2016-12-10 21:00:00','2016-12-10 19:00:00',2);