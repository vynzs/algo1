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
   Erreur_Lecture_Benchmark : exception;
   Index, Largeur, Hauteur : Integer;

   procedure Lecture_En_Tete(Nom_Entree :in String; Nombre_Objets, Largeur_Ruban : out Integer) is

   begin
      Open (File => Input,
            Mode => In_File,
            Name => Nom_Entree);

      Nombre_Objets := Get(Input);
      Nb_Obj := Nombre_Objets ; -- Stock pour utilisation future
      Largeur_Ruban := Get(Input);
      Close (Input);
   exception
      when End_Error =>
         Close (Input);
         raise Erreur_Lecture_Benchmark;
   end Lecture_En_Tete;

   procedure Lecture(Nom_Entree : in String, Objets : in Tableau_Objet) is -- SQUA UN OBJET ?
      Index, Hauteur, Largeur : Integer;
      O : Objet;

   begin
      Open (File => Input,
            Mode => In_File,
            Name => Nom_Entree);
      Index:=Get(Input); -- On passe les carac globales pour arriver au 1er objet
      Index:=Get(Input);

      for I in Objets'Range loop
         Index := Get(Input);
         Largeur := Get(Input);
         Hauteur := Get(Input);
         O := Nouvel_Objet(Index, Hauteur, Largeur);
         Ajout_Objet(Objets, O, I);
         -- AJOUTE EN INDEX L'OBJET
      end loop;

   exception
      when End_Error =>
         Close (Input);
         raise Erreur_Lecture_Benchmark;

   end Lecture;










