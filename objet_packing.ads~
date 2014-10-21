package Objet_Packing is

   type Objet is private;

   type Tableau_Objet is array(Integer range <>) of Objet;
   --je sais pas pourquoi mais les tableaux non con(s)traint veulent pas etre private

   function Nouvel_Objet (N, H, L : Integer) return Objet;
   --cree un objet (numero, hauteur, largeur, niveau) le niveau est initialise a -1

   function Numero(O : Objet) return Integer;

   function Hauteur(O : Objet) return Integer;

   function Largeur(O : Objet) return Integer;

   function Niveau(O : objet) return Integer;

   procedure Ajout_Objet (T : in out Tableau_Objet; I: Integer; O: Objet);
   --met l'objet O a la place I du tableau T

   function Objet_De_Tableau(T : Tableau_Objet; I : Integer) return Objet;
   --donne l'objet O a la place I du tableau T

   procedure Place_Objet(O : in out Objet; N : integer);
   --place l' objet O dans le n-ieme niveau

private

    type Objet is record
      Num : Integer;
      Haut : Integer;
      Large : Integer;
      Niveau :Integer;
    end record;

   end Objet_Packing;
