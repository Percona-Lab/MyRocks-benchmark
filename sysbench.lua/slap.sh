$1 --user=$2 --password=$3 --delimiter=";" \
--create="drop table if exists tt; create table tt (id int not null primary key auto_increment,
username varchar(100) not null) engine = $4; insert into tt values (null, \"foobar\" ); insert into tt select null, username from tt;" \
--query="SELECT * FROM tt" --concurrency=1 --iterations=$5
