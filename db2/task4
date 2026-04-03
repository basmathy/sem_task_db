-- выбираем автомобили лучше среднего по своему классу
select car_name, car_class, average_position, race_count, car_country
from (
    select c.name car_name, c.class car_class, 
           avg(r.position) average_position, 
           count(r.position) race_count, 
           cl.country car_country, 
           cls.class_average_position, 
           cls.car_count
    from classes cl

    -- соединение с машинами, результатами и агрегатами по классу
    left join cars c on cl.class = c.class
    left join results r on c.name = r.car
    left join (
        -- средняя позиция и количество машин в классе
        select c.class, 
               avg(r.position) class_average_position, 
               count(distinct c.name) car_count
        from cars c
        left join results r on c.name = r.car
        group by c.class
    ) cls on c.class = cls.class

    group by c.name, c.class, cl.country, cls.class_average_position, cls.car_count
) t

-- фильтр: лучше среднего и минимум 2 машины в классе
where average_position < class_average_position
and car_count >= 2

order by car_class, average_position, car_name
