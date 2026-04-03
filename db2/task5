-- выбираем автомобили с низкой средней позицией
select car_name, car_class, average_position, race_count, car_country, total_races, low_position_count
from (
    select c.name car_name, c.class car_class, 
           avg(r.position) average_position, 
           count(r.position) race_count, 
           cl.country car_country, 
           cls.total_races, 
           cls.low_position_count
    from classes cl

    -- соединение с машинами, результатами и агрегатами по классу
    left join cars c on cl.class = c.class
    left join results r on c.name = r.car
    left join (
        -- считаем общее число гонок и машин с низкой средней позицией по классу
        select t.class, sum(t.race_count) total_races, count(*) low_position_count
        from (
            select c.class, c.name, 
                   avg(r.position) average_position, 
                   count(r.position) race_count
            from cars c
            left join results r on c.name = r.car
            group by c.class, c.name
        ) t
        where t.average_position > 3.0
        group by t.class
    ) cls on c.class = cls.class

    group by c.name, c.class, cl.country, cls.total_races, cls.low_position_count
) t

-- оставляем только машины с низкой средней позицией
where average_position > 3.0

order by low_position_count desc, car_name
