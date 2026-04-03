select v.maker, m.model 
from motorcycle m 

-- соединение по модели
left join vehicle v on m.model = v.model 

-- фильтруем по мощности, цене и типу
where m.horsepower > 150 
and m.price < 20000 
and m.type = 'Sport'

order by m.horsepower desc
