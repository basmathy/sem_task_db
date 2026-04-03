-- строим иерархию всех подчиненных для каждого сотрудника
with recursive subordinates as
    (
     select e.employeeid managerid, e.employeeid subordinateid
     from employees e

     union all

     select s.managerid, e.employeeid
     from subordinates s
     join employees e on e.managerid = s.subordinateid
    )

select e.employeeid EmployeeID, 
       e.name EmployeeName, 
       e.managerid ManagerID, 
       d.departmentname DepartmentName, 
       r.rolename RoleName, 
       p.project_names ProjectNames, 
       t.task_names TaskNames, 
       sc.subordinates_count TotalSubordinates
from employees e

-- соединение со справочниками отдела и роли
join departments d on e.departmentid = d.departmentid
join roles r on e.roleid = r.roleid

-- список проектов отдела
left join lateral (
    select string_agg(distinct p.projectname, ', ' order by p.projectname) project_names
    from projects p
    where p.departmentid = e.departmentid
) p on true

-- список задач сотрудника
left join lateral (
    select string_agg(distinct t.taskname, ', ' order by t.taskname) task_names
    from tasks t
    where t.assignedto = e.employeeid
) t on true

-- считаем всех подчиненных (кроме самого сотрудника)
left join lateral (
    select count(*) - 1 subordinates_count
    from subordinates s
    where s.managerid = e.employeeid
) sc on true

-- фильтр по роли и наличию подчиненных
where r.rolename = 'Менеджер'
and sc.subordinates_count > 0

order by e.name
