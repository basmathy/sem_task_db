-- выбираем активных клиентов с тратами и разными отелями
select t.id_customer, c.name name, 
       sum(t.book_num) total_bookings,
       sum(t.total_spent) total_spent,
       count(distinct t.id_hotel) unique_hotels
from
    (
     -- считаем бронирования и траты по клиенту и отелю
     select b.id_customer, r.id_hotel, 
            count(*) book_num, 
            sum(r.price) total_spent
     from booking b
     left join room r on b.id_room = r.id_room
     group by b.id_customer, r.id_hotel
     order by b.id_customer
    ) as t

-- соединение с клиентами и отелями
left join customer c on t.id_customer = c.id_customer
left join hotel h on t.id_hotel = h.id_hotel

group by t.id_customer, c.name

-- фильтр по количеству, отелям и тратам
having sum(t.book_num) > 2 
and count(distinct t.id_hotel) > 1 
and sum(t.total_spent) > 500

order by total_spent, t.id_customer
