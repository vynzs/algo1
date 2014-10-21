with objet_packing; use objet_packing;

package Parseur is
   
   Erreur_Lecture_Benchmark : exception;

   procedure Lecture_En_Tete(Nom_Entree :in String; Nombre_Objets, Largeur_Ruban : out Integer);
   procedure Lecture(Nom_Entree : in String; Objets : in out Tableau_Objets) ; 
   
end Parseur;
