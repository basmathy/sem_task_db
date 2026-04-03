-- выбираем лучший автомобиль в каждом классе
select car_name, car_class, average_position, race_count
from (
    select c.name car_name, c.class car_class, 
           avg(r.position) average_position, 
           count(r.position) race_count, 

           -- нумерация внутри класса по средней позиции
           row_number() over (partition by c.class order by avg(r.position), c.name) as rn
    from classes cl

    -- соединение с машинами и результатами
    left join cars c on cl.class = c.class
    left join results r on c.name = r.car

    group by c.name, c.class
) t

-- берем только лучшую машину в каждом классе
where rn = 1

order by average_position, car_name
