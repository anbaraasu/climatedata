create table climate_data ( 
     id int primary key auto_increment,
     city varchar(255),
     country varchar(255),
     month_data varchar(255),
     temperature DECIMAL(5,2),
     humidity DECIMAL(5,2),
     precipitation DECIMAL(5,2)
);

insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Mumbai', 'India', 'January', 25.7, 60.5, 10.2);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Mumbai', 'India', 'February', 27.9, 62.3, 5.1);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Mumbai', 'India', 'March', 29.8, 65.7, 0.0);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Mumbai', 'India', 'April', 31.6, 70.2, 0.8);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Mumbai', 'India', 'May', 33.4, 75.6, 20.4);

insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Delhi', 'India', 'January', 14.6, 55.5, 15.2);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Delhi', 'India', 'February', 16.8, 57.3, 10.1);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Delhi', 'India', 'March', 20.7, 60.7, 5.0);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Delhi', 'India', 'April', 25.6, 65.2, 0.8);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Delhi', 'India', 'May', 30.4, 70.6, 10.4);

insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Bangalore', 'India', 'January', 20.6, 65.5, 5.2);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Bangalore', 'India', 'February', 22.8, 67.3, 0.1);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Bangalore', 'India', 'March', 26.7, 70.7, 0.0);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Bangalore', 'India', 'April', 31.6, 75.2, 0.8);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Bangalore', 'India', 'May', 33.4, 80.6, 10.4);

--chennai data
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Chennai', 'India', 'January', 25.6, 65.5, 5.2);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Chennai', 'India', 'February', 27.8, 67.3, 0.1);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Chennai', 'India', 'March', 30.7, 70.7, 0.0);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Chennai', 'India', 'April', 35.6, 75.2, 0.8);
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('Chennai', 'India', 'May', 37.4, 80.6, 10.4);

commit;

--git add, commit and push this file to your github repository

--insert data for new delhi india
insert into climate_data (city, country, month_data, temperature, humidity, precipitation) values ('New Delhi', 'India', 'January', 14.6, 55.5, 15.2);
