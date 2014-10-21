--Parseur.Lecture_En_Tete(Argument(1), Nombre_Objets, Largeur_Ruban);
--
--      Parseur.Lecture_En_Tete(Argument(1), Nombre_Objets, Largeur_Ruban);
--
--      declare
--              Objets : Tableau_Objets(1..Nombre_Objets);
--      begin
--         Parseur.Lecture(Argument(1), Objets);
--         exception
--      when Parseur.Erreur_Lecture_Benchmark
--              => Put_Line(Standard_Error, "le fichier d'entree est illisible");
--end;
with Ada.Text_Io, Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;
with Objet_Packing;
use Objet_Packing;

package body Parseur is
   Input :  File_Type; -- Oublie pas Close(Input)
   Nb_Obj : Integer ;
   Index, Largeur, Hauteur : Integer;

   procedure Lecture_En_Tete(Nom_Entree :in String; Nombre_Objets, Largeur_Ruban : out Integer) is

   begin
      Open (File => Input,
            Mode => In_File,
            Name => Nom_Entree);

      Get(Input, Nombre_Objets);
      Nb_Obj := Nombre_Objets ; -- Stock pour utilisation future
      Get(Input, Largeur_Ruban);
      Close (Input);
   exception
      when End_Error =>
         Close (Input);
         raise Erreur_Lecture_Benchmark;
   end Lecture_En_Tete;

   procedure Lecture(Nom_Entree : in String; Objets : in out Tableau_Objets) is -- SQUA UN OBJET ?
      Index, Hauteur, Largeur : Integer;
      O : Objet;

   begin
      Open (File => Input,
            Mode => In_File,
            Name => Nom_Entree);
      Get(Input,Index); -- On passe les carac globales pour arriver au 1er objet
      Get(Input,Index);

      for I in Objets'Range loop
         Get(Input,Index);
         Get(Input,Largeur);
         Get(Input,Hauteur);
         O := Nouvel_Objet(Index, Hauteur, Largeur);
         Ajout_Objet(Objets, I, O);
         -- AJOUTE EN INDEX L'OBJET
      end loop;

   exception
      when End_Error =>
         Close (Input);
         raise Erreur_Lecture_Benchmark;

   end Lecture;

end Parseur;









