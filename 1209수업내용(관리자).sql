CREATE ROLE r_demo;

GRANT CREATE view, CREATE synonym TO r_demo;
GRANT select on hr.jobs to r_demo;
GRANT r_demo to demo;



















