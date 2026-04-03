-- определяем предпочитаемый тип отелей для каждого клиента
select t.id_customer, c.name, t.preferred_hotel_type, 
       string_agg(distinct h.name, ', ' order by h.name) visited_hotels
from
    (
     -- классифицируем клиента по средней цене отелей
     select b.id_customer, case
        when max(case when hot.avg_price > 300 then 1 else 0 end) = 1 then 'дорогой'
        when max(case when hot.avg_price >= 175 then 1 else 0 end) = 1 then 'средний'
        else 'дешевый'
        end preferred_hotel_type
     from booking b
     left join room r on b.id_room = r.id_room
     left join
         (
          -- средняя цена по каждому отелю
          select id_hotel, avg(price) avg_price
          from room
          group by id_hotel
         ) hot on r.id_hotel = hot.id_hotel
     group by b.id_customer
    ) as t

-- соединение с бронированиями, отелями и клиентами
left join booking b on t.id_customer = b.id_customer
left join room r on b.id_room = r.id_room
left join hotel h on r.id_hotel = h.id_hotel
left join customer c on t.id_customer = c.id_customer

group by t.id_customer, c.name, t.preferred_hotel_type

-- сортировка по типу отеля
order by case
   when t.preferred_hotel_type = 'дешевый' then 1
   when t.preferred_hotel_type = 'средний' then 2
   else 3
   end, t.id_customer
