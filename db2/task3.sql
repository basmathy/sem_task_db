-- выбираем автомобили из класса с лучшей средней позицией
select car_name, car_class, average_position, race_count, car_country, total_races
from (
    select c.name car_name, c.class car_class, 
           avg(r.position) average_position, 
           count(r.position) race_count, 
           cl.country car_country, 
           cls.total_races, 

           -- ранжирование классов по средней позиции
           dense_rank() over (order by cls.class_average_position) as rn
    from classes cl

    -- соединение с машинами, результатами и агрегатами по классу
    left join cars c on cl.class = c.class
    left join results r on c.name = r.car
    left join (
        -- расчет средней позиции и количества гонок по классу
        select c.class, 
               avg(r.position) class_average_position, 
               count(r.position) total_races
        from cars c
        left join results r on c.name = r.car
        group by c.class
    ) cls on c.class = cls.class

    group by c.name, c.class, cl.country, cls.class_average_position, cls.total_races
) t

-- оставляем только лучший класс
where rn = 1

order by average_position, car_name
