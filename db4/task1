-- рекурсивно получаем сотрудника и всех его подчиненных
with recursive subordinates as
    (
     select e.employeeid, e.name, e.managerid, e.departmentid, e.roleid
     from employees e
     where e.employeeid = 1

     union all

     select e.employeeid, e.name, e.managerid, e.departmentid, e.roleid
     from employees e
     join subordinates s on e.managerid = s.employeeid
    )

select s.employeeid EmployeeID, 
       s.name EmployeeName, 
       s.managerid ManagerID, 
       d.departmentname DepartmentName, 
       r.rolename RoleName, 
       p.project_names ProjecctNames, 
       t.task_names TaskNames
from subordinates s

-- соединение со справочниками отдела и роли
join departments d on s.departmentid = d.departmentid
join roles r on s.roleid = r.roleid

-- список проектов отдела
left join lateral (
    select string_agg(distinct p.projectname, ', ' order by p.projectname) project_names
    from projects p
    where p.departmentid = s.departmentid
) p on true

-- список задач сотрудника
left join lateral (
    select string_agg(distinct t.taskname, ', ' order by t.taskname) task_names
    from tasks t
    where t.assignedto = s.employeeid
) t on true

order by s.name
