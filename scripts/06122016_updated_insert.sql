INSERT into countries
values(1,'USA', 'US');

INSERT into cities
values(1 , 1 , 'Chicago' , 'CH');
INSERT into cities
values(2 , 1 , 'New York' , 'NY');
INSERT into cities
values(3 , 1 , 'San Francisco' , 'SF');
INSERT into cities
values(4 , 1 , 'Texas' , 'TX');


INSERT into location
values(1,1,'IL' , 46330);
INSERT into location
values(2,1,'NY' , 46330);
INSERT into location
values(3,1,'CA' , 46330);
INSERT into location
values(4,1,'TX' , 46330);


INSERT into airplane_type
values('WA-A300',75);
INSERT into airplane_type
values('WA-A400',100);

INSERT into airplane
values(9342, 'WA-A300');
INSERT into airplane
values(3894, 'WA-A400');

INSERT into airport
values(1,1,1,'O''Hare International' , POINT(10,80));
INSERT into airport
values(2,2,1,' John F. Kennedy International' , POINT(10,80));
INSERT into airport
values(3,3,1,'San Fransisco International' , POINT(10,80));
INSERT into airport
values(4,4,1,'Dallas/Fort Worth International' , POINT(10,80));

INSERT into weekdays
values(1, 'Sunday');
INSERT into weekdays
values(2, 'Monday');
INSERT into weekdays
values(3, 'Tuesday');
INSERT into weekdays
values(4, 'Wednesday');
INSERT into weekdays
values(5, 'Thursday');
INSERT into weekdays
values(6, 'Friday');
INSERT into weekdays
values(7, 'Saturday');

INSERT into route
values(1, 1,2,200);
INSERT into route
values(2, 1,3,400);
INSERT into route
values(3, 1,4,600);

INSERT into route
values(4, 2,1,200);
INSERT into route
values(5, 2,3,500);
INSERT into route
values(6, 2,4,700);

INSERT into route
values(7, 3,1,400);
INSERT into route
values(8, 3,2,500);
INSERT into route
values(9, 3,4,500);

INSERT into fare
values(1,1,310);
INSERT into fare
values(2,2,290);
INSERT into fare
values(3,3,430);
INSERT into fare
values(4,4,185);
INSERT into fare
values(5,5,580);
INSERT into fare
values(6,6,220);
INSERT into fare
values(7,7,360);
INSERT into fare
values(8,8,470);
INSERT into fare
values(9,9, 45);

INSERT into flight
values('W-ABC', 1);
INSERT into flight
values('W-DEF', 1);
INSERT into flight
values('W-XYZ', 2);


INSERT into flight_leg
values(1,'W-ABC',1,'2016-12-08 17:45:00','2016-12-08 15:45:00',2);
INSERT into flight_leg
values(1,'W-DEF',4,'2016-12-09 23:00:00','2016-12-09 22:30:00',1);
INSERT into flight_leg
values(1,'W-XYZ',1,'2016-12-10 04:15:00','2016-12-10 01:15:00',3);
INSERT into flight_leg
values(2,'W-XYZ',5,'2016-12-11 19:45:00','2016-12-11 18:45:00',1);

INSERT into flight_workdays
values('W-ABC',1);
INSERT into flight_workdays
values('W-ABC',2);
INSERT into flight_workdays
values('W-ABC',3);
INSERT into flight_workdays
values('W-ABC',4);
INSERT into flight_workdays
values('W-DEF',1);
INSERT into flight_workdays
values('W-DEF',2);
INSERT into flight_workdays
values('W-XYZ',1);
INSERT into flight_workdays
values('W-XYZ',2);
INSERT into flight_workdays
values('W-XYZ',3);
INSERT into flight_workdays
values('W-XYZ',4);
INSERT into flight_workdays
values('W-XYZ',5);
INSERT into flight_workdays
values('W-XYZ',6);
INSERT into flight_workdays
values('W-XYZ',7);


INSERT into aircraft_type_seat_class
values('Business' , 'WA-A300' , 25);
INSERT into aircraft_type_seat_class
values('Economy' , 'WA-A300' , 50);
INSERT into aircraft_type_seat_class
values('Business' , 'WA-A400' , 25);
INSERT into aircraft_type_seat_class
values('Economy' , 'WA-A400' , 75);


INSERT into aircraft_type_seat_class_codes
values (1,'Business' , 'WA-A300');
INSERT into aircraft_type_seat_class_codes
values (2,'Economy' , 'WA-A300');
INSERT into aircraft_type_seat_class_codes
values (3,'Business' , 'WA-A400');
INSERT into aircraft_type_seat_class_codes
values (4,'Economy' , 'WA-A400');


INSERT into leg_instance
values ('2016-12-08', 'W-ABC', 1, 9342, '2016-12-08 17:45:00','2016-12-08 15:45:00', 50, null, 25);

INSERT into leg_instance
values ('2016-12-09', 'W-DEF', 1, 3894, '2016-12-09 23:00:00','2016-12-09 22:30:00', 50, null, 25);

INSERT into leg_instance
values ('2016-12-10', 'W-XYZ', 1, 9342, '2016-12-10 04:15:00','2016-12-10 01:15:00', 50, null, 25);

INSERT into leg_instance
values ('2016-12-11', 'W-XYZ', 2, 3894, '2016-12-11 19:45:00','2016-12-11 18:45:00', 50, null, 25);


INSERT into leg_instanace_seats
values (1,1,'2016-12-08','W-ABC',1,0 );
INSERT into leg_instanace_seats
values (2,1,'2016-12-08','W-ABC',1,0 );
INSERT into leg_instanace_seats
values (3,2,'2016-12-08','W-ABC',1,0 );
INSERT into leg_instanace_seats
values (4,2,'2016-12-08','W-ABC',1,0 );

INSERT into leg_instanace_seats
values (1,1,'2016-12-09','W-DEF',1,0 );
INSERT into leg_instanace_seats
values (2,1,'2016-12-09','W-DEF',1,0 );
INSERT into leg_instanace_seats
values (3,2,'2016-12-09','W-DEF',1,0 );
INSERT into leg_instanace_seats
values (4,2,'2016-12-09','W-DEF',1,0 );

INSERT into leg_instanace_seats
values (1,1,'2016-12-10','W-XYZ',1,0 );
INSERT into leg_instanace_seats
values (2,1,'2016-12-10','W-XYZ',1,0 );
INSERT into leg_instanace_seats
values (3,2,'2016-12-10','W-XYZ',1,0 );
INSERT into leg_instanace_seats
values (4,2,'2016-12-10','W-XYZ',1,0 );

INSERT into leg_instanace_seats
values (1,1,'2016-12-11','W-XYZ',2,0 );
INSERT into leg_instanace_seats
values (2,1,'2016-12-11','W-XYZ',2,0 );
INSERT into leg_instanace_seats
values (3,2,'2016-12-11','W-XYZ',2,0 );
INSERT into leg_instanace_seats
values (4,2,'2016-12-11','W-XYZ',2,0 );
