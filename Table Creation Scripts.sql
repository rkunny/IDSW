create database IDSW;

use idsw;

create table team (
team_name varchar (50) primary key
);

create table ps_funding_method (
funding_methods varchar (50) primary key
);

insert into ps_funding_method (funding_methods) 
values ('PS-Funding Method'),
('Billable To Clinet (Fixed Fee)'),
('Billable To Client (T&M w/Cap)'),
('Billable To Client (T&M)'),
('OIE Expenses Only'),
('Deferred (Internal Projects)'),
('Billable To Client (Fixed Fee)');

create table accounting_type (
type_of_accounting varchar (50) primary key
);

insert into accounting_type (type_of_accounting)
values ('Billable (To The Client)'),
('Capitalized'),
('Expensed'),
('Non Billable (To The Client)'),
('Billable To Client Variable (T&M)'), 
('Deferred'),
('Bilable To Client (Fixed Fee)');

create table billable_type (
type_of_billable varchar (50) primary key
);

insert into billable_type (type_of_billable) 
values ('Billable'),
('Non Billable');


create table planview_projects (
planview_id int (20) primary key,
planview_project_name varchar (100),
ps_funding_method varchar (50), foreign key (ps_funding_method) references ps_funding_method (funding_methods),
accounting_type varchar (50), foreign key (accounting_type) references accounting_type (type_of_accounting),
billable_type varchar (50), foreign key (billable_type) references billable_type (type_of_billable),
idsw enum ('Y','N')
);

create table business_unit(
bu_name varchar (25) primary key,
value_text varchar (5)
);

create table sigma(
sigma_num varchar (20) primary key,
sigma_name varchar (100), 
business_unit varchar (25), foreign key (business_unit) references business_unit(bu_name)
);

create table sigma_project_mapping (
id int auto_increment primary key,
planview_id int (20), foreign key (planview_id) references planview_projects(planview_id),
planview_project_name varchar (100),
sigma_num varchar (20), foreign key (sigma_num) references sigma(sigma_num),
sigma varchar (100),
business_unit varchar (25), foreign key (business_unit) references business_unit (bu_name)
);

create table location (
location_name varchar (50) primary key
);

create table people (
employee_id varchar (10) primary key,
employee_name varchar (50),
planview_name varchar (50),
location varchar (50), foreign key (location) references location(location_name),
team_name varchar (50), foreign key (team_name) references team (team_name),
onshore_offshore enum ('On','Off'),
track_billable enum ('Y','N')
);

create table forecast_hrs (
id int auto_increment primary key,
client_name varchar (100),
project_name varchar (100),
task varchar (50),
employee_name varchar (50),
forecast_date date,
adj_unit float (7,2),
tkt_name varchar (50)
);

create table product(
product_name varchar (50) primary key,
p_business_unit varchar (25), foreign key (p_business_unit) references business_unit(bu_name),
product_value varchar (3)
);

create table clients(
id int auto_increment primary key,
client_name varchar(50),
product_name varchar (50), foreign key (product_name) references product(product_name)
);

create table project_status(
project_status enum ("Acceptance","Active","Awaiting Delivery","Awaiting Release","Cancelled","Closed","Complete","Done",
"Failed Acceptance", "Need Information", "Not Started","On Hold", "Waiting for Resolution", "Yet To Start") primary key
);


create table project_estimates(
jira_key varchar (20) primary key,
planview_project_id int (20), foreign key (planview_project_id) references planview_projects(planview_id),
project_status varchar (25),
project_estimate int (10)
);

create table time_logging(
id int auto_increment primary key,
employee_id varchar (10), foreign key (employee_id) references people(employee_id),
planview_project_id int (20), foreign key (planview_project_id) references planview_projects(planview_id),
work_description varchar (100),
work_date date, 
time_logged int (6)
);

drop table time_logging;
