-- объединяем автомобили, мотоциклы и велосипеды
select v.maker, c.model, c.horsepower, c.engine_capacity, v."type" vehicle_type
from car c 

-- соединение по модели
left join vehicle v on c.model = v.model

-- фильтры для автомобилей
where c.horsepower > 150 
and c.engine_capacity < 3
and c.price < 35000

union all

select v.maker, m.model, m.horsepower, m.engine_capacity, v."type" 
from motorcycle m 

-- соединение по модели
left join vehicle v on m.model = v.model

-- фильтры для мотоциклов
where m.horsepower > 150 
and m.engine_capacity < 1.5
and m.price < 20000

union all

select v.maker, b.model, null horsepower, null engine_capacity, v."type" 
from bicycle b 

-- соединение по модели
left join vehicle v on b.model = v.model

-- фильтры для велосипедов
where b.gear_count > 18
and b.price < 4000

order by horsepower desc nulls last
