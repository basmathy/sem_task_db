-- выбираем клиентов с более чем двумя бронированиями в разных отелях
select c.name, c.email, c.phone, sum(t.book_num) book_num,

       -- список отелей, где останавливался клиент
       (select string_agg(distinct hot.name, ', ' order by hot.name)
        from booking book
        left join room ro on book.id_room = ro.id_room
        left join hotel hot on ro.id_hotel = hot.id_hotel
        where book.id_customer = t.id_customer) hotel_list,

       -- средняя длительность проживания
       (select avg(book.check_out_date - book.check_in_date)
        from booking book
        where book.id_customer = t.id_customer) avg_stay_days
from
    (
     -- считаем количество бронирований по клиенту и отелю
     select b.id_customer, r.id_hotel, count(*) book_num
     from booking b
     left join room r on b.id_room = r.id_room
     group by b.id_customer, r.id_hotel
     order by b.id_customer
    ) as t

-- соединение с клиентами и отелями
left join customer c on t.id_customer = c.id_customer
left join hotel h on t.id_hotel = h.id_hotel

group by t.id_customer, c.name, c.email, c.phone

-- фильтр по числу бронирований и количеству отелей
having sum(t.book_num) > 2 and count(distinct t.id_hotel) >= 2

order by book_num desc, t.id_customer
