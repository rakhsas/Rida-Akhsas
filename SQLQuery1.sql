Create database tpVente ;
use tpVente ;
create table  article (
numart int ,
desart varchar(12),
puart money ,
qtenstock int ,
SMin int ,
Smax int ,
constraint pkart primary key (numart));
insert into article values 
(1,'AZ123',50,12,2,30),
(2,'RTE34',45,34,6,40),
(3,'BR23P',90,10,4,40),
(4,'POI89',150,55,8,60),
(5,'FDEZ4',750,35,4,40),
(6,'AZQ23',50,29,2,40);
SELECT*FROM article; 

create table  commande (
numcmd int ,
datecm date ,
constraint pkcmd primary key (numcmd));
insert into commande values 
(1,'2022-02-16'),
(2,'2022-05-10'),
(3,'2022-07-26'),
(4,'2022-09-16'),
(5,'2022-04-13'),
(6,'2022-03-04');
SELECT*FROM commande; 

create table lgcmd (
numart int ,
numcmd int ,
qtcmd int ,
constraint pklgcmd primary key (numart,numcmd),
constraint fkcmd foreign key(numcmd) references  commande (numcmd),
constraint fkart foreign key (numart) references article (numart)
);
insert into lgcmd values 
(1,2,10),
(2,6,4),
(3,4,5),
(4,1,6),
(5,4,5),
(6,2,8);
SELECT*FROM lgcmd;
/*Ecrire un programme affiche la liste des commandes 
et affiche dans une nouvelle colonne 
si la commande date de plus que 3 mois 
ou bien mois que 3 mois par rapport à la date d’aujourd’hui ?*/

SELECT * ,'NVCL'=
case
when datediff (month ,getdate(),Datecm)<3 then 'moins de trois mois'
else 'plus de trois mois'
end
from commande

/*		THE END		*/
/*Ecrire un programme qui calcule 
le montant de la commande numéro X et 
affiche un message 'Commande Normale' 
ou 'Commande Spéciale' selon que 
le montant est inférieur ou supérieur à 500DH */

select n.numcmd , (n.qtcmd*a.puart)  , 'type commande ' =
case 
when   (n.qtcmd*a.puart) >500  then 'commande spéciale'
else 'commande normale'
end 
from commande c , article a , lgcmd n
where (c.numcmd=n.numcmd and n.numart=a.numart) ;

/*		THE END		*/
/*Ecrire un programme qui calcule le reste de la quantité de stock après une commande ;
et si la nouvelle valeur de quantité de stock est inférieure au seuil minimum ajoutez à la quantité de stock 10*/

select  qc.numcmd ,qs.SMin , ( qs.qtenstock - qc.qtcmd) ,'ajout'=
case
when ( qs.qtenstock - qc.qtcmd)<=qs.SMin then qs.qtenstock+10
else ( qs.qtenstock - qc.qtcmd)
end
from lgcmd qc, article qs

/*		THE END		*/
/*Ecrire un programme qui tant que la quantité de stock d’un article X 
n’as pas atteint le seuil minimum ajouter une commande avec une quantité
de commande égale seuil* 3
*/
select  qc.numcmd ,qs.SMin ,  qs.qtenstock  ,'ajout'=
case
when qs.qtenstock>=qs.SMin then qs.SMin*3
else qtenstock 
end
from lgcmd qc, article qs
/*		THE END		*/
/*Créer une procédure stockée qui calcule le nombre d'articles par commande*/
