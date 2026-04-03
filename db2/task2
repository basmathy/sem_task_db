-- находим автомобиль с лучшей средней позицией
select c.name car_name, c.class car_class,
       avg(r.position) average_position,
       count(r.position) race_count,
       cl.country car_country

from classes cl

-- соединение с машинами и результатами
left join cars c on cl.class = c.class
left join results r on c.name = r.car

group by c.name, c.class, cl.country

-- берем один лучший результат
order by avg(r.position), c.name
limit 1
