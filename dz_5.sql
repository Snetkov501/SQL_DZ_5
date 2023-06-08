CREATE DATABASE IF NOT EXISTS dz_5;

USE dz_5;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

-- 1 Создайте представление, в которое попадут автомобили стоимостью  до 25 000 

CREATE or replace  view result as
select name, cost
from Cars
where cost < 25000
order by  cost;

select *from result;

-- 2 	Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 
alter  view result as
select name, cost
from Cars
where cost < 30000
order by  cost;
select *from result;

-- 3 	Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE or replace  view result2 as
select name, cost
from Cars
where name = "Audi" or name = "Skoda"
order by  cost;
select *from result2;

/*Добавьте новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
Мы можем вычислить это значение без использования оконной функции SQL, 
но это может быть очень сложно. Проще это сделать с помощью оконной функции LEAD . 
Эта функция сравнивает значения из одной строки со следующей строкой, 
чтобы получить результат. 
В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.*/



CREATE TABLE `dz_5`.`stashion` (
  `train_id_integer` INT NOT NULL,
  `station_name` VARCHAR(45) NOT NULL,
  `station_time` TIME NOT NULL);
  
INSERT INTO `dz_5`.`stashion` (`train_id_integer`, `station_name`, `station_time`) VALUES ('110', 'СанФранциско', '10:00:00');
INSERT INTO `dz_5`.`stashion` (`train_id_integer`, `station_name`, `station_time`) VALUES ('110', 'РедвуСити', '10:54:00');
INSERT INTO `dz_5`.`stashion` (`train_id_integer`, `station_name`, `station_time`) VALUES ('110', 'ПалоАльто', '11:02:00');
INSERT INTO `dz_5`.`stashion` (`train_id_integer`, `station_name`, `station_time`) VALUES ('110', 'СанХосе', '12:35:00');
INSERT INTO `dz_5`.`stashion` (`train_id_integer`, `station_name`, `station_time`) VALUES ('120', 'СанФранциско', '11:00:00');
INSERT INTO `dz_5`.`stashion` (`train_id_integer`, `station_name`, `station_time`) VALUES ('120', 'ПалоАльто', '12:49:00');
INSERT INTO `dz_5`.`stashion` (`train_id_integer`, `station_name`, `station_time`) VALUES ('120', 'СанХосе', '13:30:00');

select*from stashion;
  
select train_id_integer, station_name, station_time,
timediff -- timediff формат SELECT TIMEDIFF(unload_time , record_time) AS dif FROM table;
(lead(station_time) over(PARTITION BY train_id_integer ORDER BY train_id_integer), -- время_2 столбец  по смещению
station_time) -- время_1 наш первый столбец
as station_time_next -- альтернативное имя нового столбца 
from stashion; 