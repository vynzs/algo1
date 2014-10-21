with Objet_Packing;
use Objet_Packing;
with Ada.Text_Io;
use Ada.Text_Io;

package body Packing is

   procedure Tri_Bulle (T : in out Tableau_Objet) is
      Temp : Objet;
   begin
      for I in T'First..(T'Last - 1) loop
         for J in T'First..(T'Last - 1) loop
            if Hauteur(Objet_De_Tableau(T, J)) < Hauteur(Objet_De_Tableau(T, J + 1)) then
               Temp := Objet_De_Tableau(T, J);
               Ajout_Objet(T, J, Objet_De_Tableau(T, J + 1));
               Ajout_Objet(T, J + 1, Temp);
            end if;
         end loop;
      end loop;
   end;

         --a chaque iteration du premier for, l'objet le plus petit non encore trie est mis a sa place a l'extremite gauche du tableau

   procedure Next_Fit_Decreasing_Height(Objets : in out Tableau_Objet; Largeur_Ruban : in Integer; Hauteur_Ruban : out Integer) is
      Hr : Integer := 0;
      Niveau_Courant : Integer := 1;
      Largeur_Restante_Courante : Integer := Largeur_Ruban;
      Niveau_Vide : Boolean := True;
      T_O : Tableau_Objet := Objets;
      begin
         Tri_Bulle(T_O);
         for I in Objets'Range loop
            if Largeur(Objet_De_Tableau(T_O, I)) > Largeur_Ruban then
               raise Objet_Trop_Grand;
            end if;
            --excepion

            if Niveau_Vide then
               Hr := Hr + Hauteur(Objet_De_Tableau(T_O, I));
               Niveau_Vide := False;
            end if;
            --Pose du premier element dun niveau

            if Largeur_Restante_Courante >= Largeur(Objet_De_Tableau(T_O, I)) then
               Place_Objet( T_O(I), Niveau_Courant);
               Largeur_Restante_Courante :=Largeur_Restante_Courante - Largeur(Objet_De_Tableau(T_O, I));
            else
               Largeur_Restante_Courante:= Largeur_Ruban;
               Niveau_Courant := Niveau_Courant + 1;
               Niveau_Vide := True;
            end if;

         end loop;

         Hauteur_Ruban := Hr;
         Objets := T_O;

      exception
         when Objet_Trop_Grand
           => Put_Line("Un Objet Est Plus Large Que Le Ruban");
      end;

end Packing;




