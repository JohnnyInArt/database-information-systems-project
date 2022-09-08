
-- Creation of schema and constraints

drop database if exists PiattaformaX;
create database if not exists PiattaformaX;
use PiattaformaX;

drop table if exists Utente;
drop table if exists Admin;
drop table if exists User;
drop table if exists Scuola;
drop table if exists Istruzione;
drop table if exists Proposta;
drop table if exists Frequenza;
drop table if exists Amicizia;
drop table if exists Datore;
drop table if exists Impiego_Passato;
drop table if exists Professionista;
drop table if exists Dipendente;



create table Utente (
 UserId varchar(20) primary key,
 Password varchar(20) not null,
 Nome varchar(40)  not null,
 Cognome varchar(40) not null
) engine = InnoDB;

create table Admin (
 UserId varchar(20) primary key,
 Ultimo_accesso DATETIME, 
 foreign key(UserId) references Utente(UserId)
) engine = InnoDB;

create table User (
 UserId varchar(20) primary key,
 Data_nascita date,
 Sesso enum('M', 'F'),
 Citta varchar(58),
 Citta_nascita varchar(58),
 foreign key(UserId) references Utente(UserId) on delete cascade
) engine = InnoDB;

create table Scuola (
 Nome varchar(80) primary key
) engine = InnoDB;

create table Istruzione (
 Tipologia varchar(40)  primary key
) engine = InnoDB;

create table Proposta (
 Scuola varchar(80),
 Istruzione varchar(40),
 primary key (Scuola, Istruzione),
 foreign key (Scuola) references Scuola(Nome) on update cascade,
 foreign key (Istruzione) references Istruzione(Tipologia)  on update cascade
) engine = InnoDB;

create table Frequenza (
 UserId varchar(20),
 Scuola varchar(80),
 Anno_fine year null,
 primary key (UserId, Scuola),
 foreign key(UserId) references User(UserId) on delete cascade,
 foreign key(Scuola) references Scuola(Nome) on update cascade
) engine = InnoDB;


create table Amicizia (
 UserId varchar(20),
 Amico_UserId varchar(20),
 Data datetime null, 
 primary key (UserId, Amico_UserId),
 foreign key(UserId) references User(UserId) on delete cascade,
 foreign key(Amico_UserId) references User(UserId) on delete cascade
) engine = InnoDB;


create table Datore (
 Nome varchar(35) primary key,
 Citta varchar(58)
) engine = InnoDB;

create table Impiego_Passato (
 UserId varchar(20),
 Datore varchar(35),
 Data_inizio date,
 Data_fine date,
 primary key (UserId, Datore),
 foreign key(UserId) references User(UserId) on delete cascade,
 foreign key(Datore) references Datore(Nome) on update cascade
) engine = InnoDB;

create table Professionista (
 UserId varchar(20) primary key,
 Area varchar(15),
 Titolo_professionale varchar(30) null,
 foreign key(UserId) references User(UserId) on delete cascade
) engine = InnoDB;

create table Dipendente (
 UserId varchar(20) primary key,
 Datore varchar(35),
 Livello smallint,
 Titolo_professionale varchar(30),
 Data_inizio date,
 foreign key(UserId) references User(UserId) on delete cascade,
 foreign key(Datore) references Datore(Nome) on update cascade
) engine = InnoDB;


-- Instance creation: database population  


/* 
   Change the path of all csv files in relation to where they are saved
   for the command "load data local infile '~/database-project/res/cvs/nameFile.csv'" in Linux,
   '~' stends for /home/userName/

   Using only '\ n' in the command 'lines terminated by' 
*/
load data local infile '~/Documenti/1_Università/2 anno/Basi Dati e Sistemi Informativi/5_Progetto/CVS File/Utente.csv' 
into table Utente
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


load data local infile '~/Documenti/1_Università/2 anno/Basi Dati e Sistemi Informativi/5_Progetto/CVS File/Admin.csv' 
into table Admin
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


load data local infile '~/Documenti/1_Università/2 anno/Basi Dati e Sistemi Informativi/5_Progetto/CVS File/User.csv'
into table User
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

insert into Istruzione(Tipologia) values
('Istruzione primaria'),
('Istruzione secondaria di primo grado'),
('Istruzione secondaria di secondo grado'),
('Istruzione superiore');


load data local infile '~/Documenti/1_Università/2 anno/Basi Dati e Sistemi Informativi/5_Progetto/CVS File/Scuola.csv'
into table Scuola
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


load data local infile '~/Documenti/1_Università/2 anno/Basi Dati e Sistemi Informativi/5_Progetto/CVS File/Proposta.csv'
into table Proposta
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


load data local infile '~/Documenti/1_Università/2 anno/Basi Dati e Sistemi Informativi/5_Progetto/CVS File/Frequenza.csv'
into table Frequenza
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


insert into Amicizia(UserId,Amico_UserId,Data) values
('agata_2U','thestefano','2019-01-21 09:00:02'),
('agata_2U','sapling.linda','2019-06-29 23:57:54'),
('agata_2U','blld','2017-12-04 06:36:53'),
('alipedebus','jest_giampietro','2020-03-11 09:05:11'),
('jest_giampietro','thestefano','2018-12-03 19:43:01'),
('jest_giampietro','alipedebus','2017-12-04 10:19:38'),
('thestefano','sapling.linda','2019-08-14 09:55:02'),
('thestefano','le_lelio','2020-09-23 18:31:23'),
('blld','AAagnese','2020-02-20 22:20:42'),
('blld','le_lelio','2017-07-19 14:31:48'),
('AAagnese','thestefano','2019-03-18 13:04:31'),
('AAagnese','le_lelio','2019-06-27 04:23:27'),
('AAagnese','blld','2019-06-01 20:07:31'),
('le_lelio','BYOBleonardo','2019-08-14 17:53:51'),
('le_lelio','thestefano','2020-02-25 22:08:09'),
('Placido.CC','hannesforthis','2018-12-03 13:26:36'),
('Dependable_michele','BYOBleonardo','2018-12-07 02:47:09'),
('Dependable_michele','thestefano','2017-07-21 09:40:00'),
('Dependable_michele','blld','2017-12-18 11:11:32'),
('BYOBleonardo','Dependable_michele','2018-12-03 07:30:59'),
('BYOBleonardo','sapling.linda','2020-04-13 12:37:54'),
('hannesforthis','AAagnese','2017-01-25 15:55:52'),
('hannesforthis','Placido.CC','2018-12-03 19:48:19'),
('99crispina','offiammetta','2019-08-28 14:23:14'),
('99crispina','Odeon','2019-12-16 11:17:04'),
('offiammetta','Placido.CC','2017-12-29 15:06:47'),
('offiammetta','99crispina','2020-03-10 10:44:06'),
('Odeon','hannesforthis','2020-05-08 12:33:24'),
('Odeon','99crispina','2019-07-02 13:01:11'),
('Odeon','thestefano','2017-08-10 07:40:06'),
('Odeon','Dependable_michele','2020-05-15 17:56:38'),
('offiammetta','AAagnese',null),
('Placido.CC','blld',null),
('agata_2U','Odeon',null),
('alipedebus','BYOBleonardo',null);


load data local infile '~/Documenti/1_Università/2 anno/Basi Dati e Sistemi Informativi/5_Progetto/CVS File/Datore.csv'
into table Datore
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


load data local infile '~/Documenti/1_Università/2 anno/Basi Dati e Sistemi Informativi/5_Progetto/CVS File/Impiego_Passato.csv'
into table Impiego_Passato
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


load data local infile '~/Documenti/1_Università/2 anno/Basi Dati e Sistemi Informativi/5_Progetto/CVS File/Professionista.csv'
into table Professionista
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


load data local infile '~/Documenti/1_Università/2 anno/Basi Dati e Sistemi Informativi/5_Progetto/CVS File/Dipendente.csv'
into table Dipendente
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines;





-- Additional bound via views and/or triggers


/* 
   Table added to test the trigger and allow you to unsubscribe from the platform, 
   users are saved in the 'Utenti_disiscritti' table once they have been deleted 
   from the 'Utente' tab. There is no primary key to allow new users to be able to
   subscribe to the platform with a UserId identical to a user who has unsubscribed.
*/
drop table if exists Utenti_disiscritti;
create table Utenti_disiscritti (
 UserId varchar(20),
 Nome varchar(40),
 Cognome varchar(40)
);


/* 
   Register users who unsubscribe from the platform are saved to a table.
*/
drop trigger if exists Utente_eliminati_log;
DELIMITER $$

create trigger Utente_eliminati_log 
before delete on Utente
for each row
begin 
       insert into Utenti_disiscritti
       values (OLD.UserId,OLD.Nome,OLD.Cognome);
end$$
DELIMITER ;


insert into Utente(UserId, Password, Nome, Cognome) 
values ('And3', 'Password1', 'Gino', 'Freschi');
delete from `PiattaformaX`.`Utente` where (`UserId` = 'And3');


/* 
   Calculate the age of all users registered on the platform.
*/

drop view if exists Eta_User;
SELECT * FROM PiattaformaX.Eta_User;
create view Eta_User(`UserId`, `Eta`) as
select UserId,
       case  when ((month(current_DATE) > month(Data_nascita)) or
               (month(current_DATE) = month(Data_nascita) and
               day(current_DATE) >= day(Data_nascita)))
		then year(current_DATE) - year(Data_nascita)
        else year(current_DATE) - year(Data_nascita) - 1
	   end
from User;


/* 
   View of workers currently employed with previous work and non-work experience.   
*/
drop view if exists Lavoratore_dipendente;
SELECT * FROM PiattaformaX.Lavoratore_dipendente;	
create view Lavoratore_dipendente
(`Nome`, `Cognome`, `Eta`, `Sesso`, `Città`, `Città di nascita`, `Datore attuale`, `Datore passato`, `Durata impiego`) as
select distinct U.Nome,
	   U.cognome,
       E.Eta,
       Us.Sesso,
       Us.Citta,
       Us.Citta_nascita,
	   D.Datore, 
	   I.Datore,
	   year(I.Data_fine) - year(I.Data_inizio)
from Utente U natural join User Us
             natural join Dipendente D
             left join Impiego_Passato I  on D.UserId = I.UserId,
             Eta_User E
where E.UserId = Us.UserId
order by U.Nome, U.Cognome;

/*
   View of the Users who have had previous work experience.
*/
drop view if exists Lavori_pregressi;
SELECT * FROM PiattaformaX.Lavori_pregressi;
create view Lavori_pregressi(`UserId`, `Datore`, `Durata impiego`) as
 select U.UserId,
        I.Datore,
        year(Data_fine) - year(Data_inizio)
from Utente U natural join User Us 
              natural join Impiego_Passato I
order by U.Nome, U.Cognome;

    
/*
   View of the Users who are freelancers.
*/   
drop view if exists Liberi_professionisti;
SELECT * FROM PiattaformaX.Liberi_professionisti;
create view Liberi_professionisti
(`Nome`,`Cognome`,`Eta`,`Sesso`,`Città`,`Città di nascita`,`Area professionale`,`Titolo professionale`) as
select U.Nome,
       U.Cognome,
       E.Eta,
       Us.Sesso,
       Us.Citta,
       Us.Citta_nascita,
       P.Area,
       P.Titolo_professionale
from Utente  U natural join User Us natural join Professionista P, Eta_User E
where  Us.UserId = E.UserId and
       Us.UserId not in (select distinct D.UserId
					        from Dipendente D );







-- Queries   		  



# Possibly of various types: selections, projections, joins, with grouping,
# nested, with flow control functions.


/* 
   Select all the Users by Name, Surname and year of birth, 
   sort them by date of birth in descending order.
*/

select U.Nome,
	   U.Cognome,
       year(Us.Data_nascita)
from Utente U, User Us
where U.UserId = Us.UserId
order by Data_nascita desc;

/*
   Username and school of all users who attended a high school, enrolled after
   2000 and sorted by surname and name in ascending order.
*/


drop view if exists Immatricolazione;
SELECT * FROM PiattaformaX.Immatricolazione;
create view Immatricolazione(`UserId`, `Anno_imm`) as
Select F.UserId,
       F.Anno_fine
from Frequenza F, Proposta P
where F.Scuola = P.Scuola and 
      Istruzione = 'Istruzione secondaria di primo grado';

Select Us.UserId,
       F.Scuola,
       I.Anno_imm as 'Anno immatricolazione' 
from Utente U natural join User Us 
      join Frequenza F on  Us.UserId = F.UserId
      left join Immatricolazione I  on F.UserId = I.UserId
where F.Scuola like 'Liceo%' and 
	  I.Anno_imm >= 2000
order by Cognome, Nome;



/* 
   Determine the Users who are employees and among them extract those with an age 
   greater than the average. Use the Lavoratore_dipendente view. 
*/
select L.`Nome`,
       L.`Cognome`,
       L.`Datore attuale`,
       L.`Eta`
from Lavoratore_dipendente L
where  Eta > (select avg(Eta)
			  from Eta_User natural join Dipendente);



/*
   The name and professional title of all employees who have a level between 5 and 7. 
   Sort them in ascending order according to the start year of the employment contract.
*/
 
 select U.Nome,
        D.Titolo_professionale,
        D.Livello,
        D.Data_inizio
from Utente U join Dipendente D on U.UserId = D.UserId
where livello >= 5 and livello <= 7
order by Data_inizio;

/* 
   Select the users who have a namesake within the platform and are also the same age.
*/

select distinct U1.UserId,
                U1.Nome,
				U1.Cognome,
                E1.Eta 
from Utente U1 natural join Eta_User E1, 
        Utente U2 natural join Eta_User E2
where U1.Nome = U2.Nome and
	  U1.Cognome = U2.Cognome and
      E1.Eta = E2.Eta and
      U1.UserId <> U2.UserId;
      

/*
   Number of users who have attended primary, 
   middle, high schools and university. 
*/

select P.Istruzione, count(*)
from   Proposta P join Frequenza F on P.Scuola = F.Scuola
group by P.Istruzione;


/* 
   Name of the high schools attended by more than 2 members of the platform.
   Sorted by school name.
*/

select F.Scuola
from  Frequenza F 
where F.Scuola like 'Liceo%'
group by F.Scuola
having count(*) >= 2
order by F.Scuola;




/* 
   Selection of name, surname, employer and duration of employment of Users who were
   born before 1980-01-01 and who had a past employment. Sort by duration of employment 
   and name.
*/

select  U.Nome,
        U.Cognome,
        Us.Data_nascita,
        I.Datore,
        year(Data_fine) - year(Data_inizio)  'Durata impiego'
from Utente U, User Us, Impiego_Passato I
where Us.Data_nascita < '1980-01-01' and
        U.UserId = I.UserId  and
		Us.UserId = I.UserId
order by year(Data_fine) - year(Data_inizio) desc,
          U.Nome;
          
-- with explicit join
		 
select  U.Nome,
        U.Cognome,
        Us.Data_nascita,
        I.Datore,
        year(Data_fine) - year(Data_inizio)  'Durata impiego'
from Utente U join User Us on U.UserId = Us.UserId  
                join Impiego_Passato I on Us.UserId = I.UserId 
where Us.Data_nascita < '1980-01-01'
order by year(Data_fine) - year(Data_inizio) desc,
          U.Nome;


/*
  Select the name, surname and city of the Users who attended university.
*/

-- nested
select  U.Nome,
		U.Cognome,
        Us.Citta
from Utente U natural join User Us
where Us.UserId in (select F.UserId
                    from Frequenza F, Proposta P
                    where F.Scuola = P.Scuola and
					P.Istruzione = 'Istruzione superiore');


				
/*
   Select the users who do NOT have a namesake within the platform and 
   are also the same age.
*/
   
select U1.UserId,
	   U1.Nome,
       U1.Cognome,
       E1.Eta
from Utente U1 join Eta_User E1 on U1.UserId = E1.UserId
where not exists (select U2.UserId
				  from Utente U2
                  where U1.UserId <> U2.UserId and
                        U1.Nome = U2.Nome and
	                    U1.Cognome = U2.Cognome);


/* 
   Mostra gli User che hanno avuto esperienze di lavoro pregresse e quelli alla 
   prima esperienza lavorativa. Specificando nome, cognome, datore di lavoro e 
   la durata del impiego se è terminato.
*/

select  case when `Datore passato` is Null
			    then concat(Nome , ' ', Cognome,' è al suo primo impiego presso ' , `Datore attuale`, '.') 
			when (`Datore passato` is not Null and Sesso = 'M')
                 then concat(Nome , ' ', Cognome, ' è stato impiegato presso ', `Datore passato`, ' per ', `Durata Impiego`, ' anni.')
                 else concat(Nome , ' ', Cognome, ' è stata impiegata presso ', `Datore passato`, ' per ', `Durata Impiego`, ' anni.')
			end as 'Esperienze lavorative'
from Lavoratore_dipendente;







--  Procedures and functions 


/* 
   Table where platform access errors are logged.
*/
drop table if exists Error_log;
create table Error_log(
messaggio_di_errore varchar(255)
);

/* 
   Procedure for entering Users on the platform. It Carries out various checks 
   such as: the presence of a User with the same UserId (count (UserId) is used to 
   see if there is an element equal to the one we want to insert in the User table), 
   the length of the password which must not be less than 6 characters, the length of 
   the name and surname which must not be less than one character and finally the 
   presence of numeric characters in the name and surname.
*/
   
DELIMITER $$

drop procedure if exists InserisciUtente$$
create Procedure InserisciUtente(UserId varchar(20), Password varchar(20),
								  Nome varchar(40), Cognome varchar(20))
begin
declare presenza_UserId smallint;
select count(UserId) into presenza_UserId
from Utente U
where U.UserId = UserId;
if  presenza_UserId = 1 then insert into Error_log
				           values (concat(current_date, ': ', UserId, ' rappresenta un nome utente già in uso.'));
select 'Nome utente già in uso.';
else if length(Password) <= 6 
     then insert into Error_log
            values (concat(current_date, ': ' , Password, ' password non valuta, è minore di 6 caratteri ', UserId));
select 'Password non valida, troppo corta.';
else if char_length(Nome) <= 1 or char_length(Cognome) <= 1
     then insert into Error_log
           values (concat(current_date, ': ', 'nome o cognome troppo corto. ', Nome ,' ', Cognome));
select 'Nome o Cognome troppo corto.';
else if Nome like '%1%' or '%2%' or '%3%' or '%4%' or '%5%' or '%6%' or '%7%' or '%8%' or '%9%' or '%0%'      
        then insert into Error_log  values (concat(current_date, ': ', Nome ,' contiene caratteri numerici'));
select 'Il Nome non può contiene caratteri numerici.'; 
else if Cognome like '%1%'  or '%2%'  or '%3%' or '%4%' or '%5%' or '%6%' or '%7%' or '%8%' or '%9%' or '%0%'
        then insert into Error_log  values (concat(current_date, ': ', Cognome ,' contiene caratteri numerici'));
select 'Il Cognome non può contiene caratteri numerici.'; 
else insert into Utente values (UserId, Password, Nome, Cognome);
end if;
end if;
end if;
end if;
end if;
end $$
DELIMITER ;


call InserisciUtente('Adid1', 'password', 'Paolo', 'Rossi');
call InserisciUtente('Adid1','password','Alessandro','Rossi'); -- UserId already existing
call InserisciUtente('Adid2','pass','Paolo','Rossi'); -- Short password 
call InserisciUtente('Adid4','password','P','Rossi'); -- Short name
call InserisciUtente('Adid5','password','Paolo','R'); -- Short surname
call InserisciUtente('Adid6','password','P123l0','Rossi'); -- Name contains numeric characters
call InserisciUtente('Adid7','password','Paolo','R410i'); -- Surname contains numeric characters





/* 
   Procedure for entering User data. Check that: the User is present in the table 
   'Utente' and that the date of birth is not less than 1900.
*/

DELIMITER $$

drop procedure if exists InserisciDatiUser$$
create procedure InserisciDatiUser(UserId varchar(20), Data_nascita date, Sesso enum('M','F'),
								   Citta varchar(58), Citta_nascita varchar(58))
begin
declare presenza_UserId varchar(20);
select count(UserId) into presenza_UserId
from Utente U
where U.UserId = UserId;
if  presenza_UserId = 0 then insert into Error_log
                              values (concat(current_date, ': ', UserId,' rappresnta un utente non registrato'));
select 'Utente inesistente.';
else if year(Data_nascita) < 1900 then insert into Error_log
                                       values (concat(current_date, ': ', Data_nascita, ' non è possibile inserire data di nascita precedente il 1990'));
select 'Data di nascita non valida';
else insert into User values (UserId, Data_nascita, Sesso, Citta, Citta_nascita);
end if;
end if;
end$$
DELIMITER ;

DELETE FROM `PiattaformaX`.`User` WHERE (`UserId` = 'Adid1');
call InserisciDatiUser('Adid1', '1899-12-31', 'M', 'Napoli', 'Caserta'); -- Data di naxscita invalida
call InserisciDatiUser('NonRegistrato', '1999-01-01', 'F', 'Milano', 'Bergamo'); -- Utente inesistente
call InserisciDatiUser('Adid1', '1990-01-01', 'M', 'Napoli', 'Caserta'); 




/*
   Determine the employers who are located in the specified city. 
   DELIMITER is not specified because the procedure consists of a single instruction.
*/

drop procedure if exists sedeDatore;
create procedure sedeDatore (Citta varchar(58))
comment 'Determina i datori che si trovano nella citta specificata'
select D.Nome, D.Citta
from Datore D
where D.Citta = Citta;

call sedeDatore("Pisa");


/* 
   This function takes in a username and returns the list of friends.
   Remember that Users who have a pending friend request are identified by 
   the NULL value in the Date field, because this column represents the day in
   which a friendship is made. 
*/
drop function lista_amici;
DELIMITER $$
create function lista_amici(UserId varchar(20))
returns varchar(20000)
begin
declare Lista_amici varchar(20000);
select group_concat(Amico_UserId separator ', ')  into Lista_amici
from Amicizia A1
where A1.UserId = UserId and 
       Data is not null;
return Lista_amici;
end$$
DELIMITER ;


/* 
   Returns the friends list for each User. 
*/
select UserId, 
       if (lista_amici(UserId) is Null,
         '- Attualmente non hai nessun amcio sulla piattaforma -',
           concat('Lista amici: ', lista_amici(UserId))) as 'Amici'
from User
order by UserId;




/*
   Entering the date (YYYY-MM-DD) in which you were hired, the function calculates
   how long you have been working for an employer. 
   Example with data: 1990-01-01, result 30; 1990-07-01, result 29.
*/
    
drop  function anni_di_lavoro;
DELIMITER $$
create function anni_di_lavoro(Data_assunzione date) 
returns int
deterministic
begin 
declare Data_corrente date;
declare result int;
select current_date() into Data_corrente;
select case  when ((month(Data_corrente) > month(Data_assunzione)) or
               (month(Data_corrente) = month(Data_assunzione) and
               day(Data_corrente) >= day(Data_assunzione)))
		then year(Data_corrente) - year(Data_assunzione)
        else year(Data_corrente) - year(Data_assunzione) - 1
	     end  into result;
return result;
end$$
DELIMITER ;

/* 
   Duration of current employment in years. If an employee's working years 
   result is 0, it is because he has been working for less than 1 year.
*/
select L.Nome,
       L.Cognome,
       L.`Datore attuale`,
	   anni_di_lavoro(D.Data_inizio) as 'Durata impiego attuale in anni'
from  Lavoratore_dipendente L, Dipendente D
where L.`Datore attuale` = D.Datore
order by anni_di_lavoro(D.Data_inizio) desc,
		  L.Nome;






