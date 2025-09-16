create table event (
	id integer auto_increment,
	name varchar(150) not null,
    evt_type varchar(10) not null,
    distance integer null,
	constraint pk_event primary key(id)
);