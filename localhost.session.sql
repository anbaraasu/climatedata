# how to remove duplicate records in role table with role_name, account, project, skill_name columns which does not have primary key id using group by 

delete r1 (
    select r1.* from role r1 join role r2
    on r1.role_name = r2.role_name
    AND r1.account = r2.account
    AND r1.project = r2.project
    AND r1.skill_name = r2.skill_name
    GROUP BY   r1.r
)