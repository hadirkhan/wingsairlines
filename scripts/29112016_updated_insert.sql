
INSERT into countries 
values(1,'USA', 'US');

INSERT into cities
values(1 , 1 , 'Chicago' , 'CHI');
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
values(1,75);
INSERT into airplane_type
values(2,100);

INSERT into airplane
values(760 , 1);
INSERT into airplane
values(820 , 2);

INSERT into airport
values(1,1,1,'Chicago' , POINT(10,80));
INSERT into airport
values(2,2,1,'New York' , POINT(10,80));
INSERT into airport
values(3,3,1,'San Francisco' , POINT(10,80));
INSERT into airport
values(4,4,1,'Texas' , POINT(10,80));


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
values(1,1,100);
INSERT into fare
values(2,2,200);
INSERT into fare
values(3,3,250);
INSERT into fare
values(4,4,350);
INSERT into fare
values(5,5,100);
INSERT into fare
values(6,6,150);
INSERT into fare
values(7,7,250);
INSERT into fare
values(8,8,350);
INSERT into fare
values(9,9,300);

INSERT into flight
values('ABC', 1);
INSERT into flight
values('DEF', 1);
INSERT into flight
values('XYZ', 2);


INSERT into flight_leg
values(1,'XYZ',1,'2016-12-10 15:00:00','2016-12-10 17:00:00',2);

INSERT into flight_workdays
values('ABC',1);
INSERT into flight_workdays
values('ABC',2);
INSERT into flight_workdays
values('ABC',3);
INSERT into flight_workdays
values('ABC',4);
INSERT into flight_workdays
values('DEF',1);
INSERT into flight_workdays
values('DEF',2);
INSERT into flight_workdays
values('XYZ',1);
INSERT into flight_workdays
values('XYZ',2);
INSERT into flight_workdays
values('XYZ',3);
INSERT into flight_workdays
values('XYZ',4);
INSERT into flight_workdays
values('XYZ',5);
INSERT into flight_workdays
values('XYZ',6);
INSERT into flight_workdays
values('XYZ',7);


INSERT into aircraft_type_seat_class
values('Business' , 1 , 25);
INSERT into aircraft_type_seat_class
values('Economy' , 1 , 50);
INSERT into aircraft_type_seat_class
values('Business' , 2 , 25);
INSERT into aircraft_type_seat_class
values('Economy' , 2 , 75);


INSERT into aircraft_type_seat_class_codes
values (1,'Business' ,1);
INSERT into aircraft_type_seat_class_codes
values (2,'Economy' ,1);
INSERT into aircraft_type_seat_class_codes
values (3,'Business' ,2);
INSERT into aircraft_type_seat_class_codes
values (4,'Economy' ,2);

INSERT into leg_instance
values ('2016-12-10' ,'XYZ',1,760, '2016-12-10 02:00:00','2016-12-10 05:00:00', 50,null,25);

INSERT into leg_instanace_seats
values (1,1,'2016-12-10','XYZ',1,0 );
INSERT into leg_instanace_seats
values (2,1,'2016-12-10','XYZ',1,0 );
INSERT into leg_instanace_seats
values (3,2,'2016-12-10','XYZ',1,0 );
INSERT into leg_instanace_seats
values (4,2,'2016-12-10','XYZ',1,0 );


