create schema sensor;

use sensor;

create table leitura(
codigo int not null primary key,
hora char (12) not null,
temperatura double not null,
umidade double not null
);