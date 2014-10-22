with Objet_Packing;
use Objet_Packing;
with Ada.Text_Io;
use Ada.Text_Io;

package body Packing is

   procedure Echange (T : in out Tableau_Objets; I,J : in Integer) is
      Tmp : Objet;
   begin
      Tmp:=T(I);
      T(I):=T(J);
      T(J):=Tmp;
   end Echange;

   procedure TriR_Aux (T : in out Tableau_Objets; TF, TL : Integer) is
      Ind : Integer := (TF+TL)/2;
      D,F : Integer := Ind;
      Tmp,P : Objet;
      I : Integer := TF;
      J : Integer := Ind+1;

   begin
      if TL-TF >= 1 then
         P := T(Ind);
         while I < D loop
            if Hauteur(T(I)) = Hauteur(P) then
               Echange(T,I,D-1);
               D:=D-1;
            elsif Hauteur(T(I)) > Hauteur(P) then
               I:=I+1;
            else
               if J < TL + 1 then -- Ptet toujours faire methode 2
                  Echange(T,I,J);
                  J:=J+1;
               else
                  Tmp := T(F);
                  T(F) := T(I);
                  T(I) := T(D-1);
                  T(D-1) := Tmp;
                  F := F-1;
                  D := D-1;
               end if;
            end if;
         end loop;

         while J < TL +1 loop
            if Hauteur (T(J)) = Hauteur(P) then
               Echange(T,J,F+1);
               J:=J+1;
               F:=F+1;
            elsif Hauteur (T(J)) > Hauteur (P) then
               Tmp:=T(D);
               T(D):=T(J);
               T(J):=T(F+1);
               T(F+1):=Tmp;
               D:=D+1;
               F:=F+1;
               J:=J+1;
            else
               J:=J+1;
            end if;
         end loop;
         TriR_Aux(T,TF,D-1);
         TriR_Aux(T,F+1,TL);
      end if;
   exception
      when Constraint_Error =>
         New_Line;
         Put(Integer'Image(Ind));
         Put(Integer'Image(TF));
         Put(Integer'Image(TL));
         Put(Integer'Image(T'First));
         raise Constraint_Error;
   end TriR_Aux;

   procedure TriR(T : in out Tableau_Objets) is
   begin
      TriR_Aux(T,T'First,T'Last);
   end TriR;


   procedure Tri_Bulle (T : in out Tableau_Objets) is
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

   procedure Next_Fit_Decreasing_Height(Objets : in out Tableau_Objets; Largeur_Ruban : in Integer; Hauteur_Ruban : out Integer) is
      T_O : Tableau_Objets := Objets;
      Hr : Integer ;
      Niveau_Courant : Integer := 1;
      Largeur_Restante_Courante : Integer := Largeur_Ruban;
      -- Niveau_Vide : Boolean := True;
      begin
         TriR(T_O);
        Hr := Hauteur(Objet_De_Tableau(T_O, T_O'First)); -- Init hauteur totale à hauteur du 1er niveau
         for I in Objets'Range loop
            if Largeur(Objet_De_Tableau(T_O, I)) > Largeur_Ruban then
               raise Objet_Trop_Grand;
            end if;
            --excepion

            --if Niveau_Vide then
            --   Hr := Hr + Hauteur(Objet_De_Tableau(T_O, I));
            --   Niveau_Vide := False;
            --end if;
            --Pose du premier element dun niveau // PLACE RIEN DU TOUT OUAIS

            if Largeur_Restante_Courante >= Largeur(Objet_De_Tableau(T_O, I)) then
               Place_Objet( T_O(I), Niveau_Courant);
               Largeur_Restante_Courante :=Largeur_Restante_Courante - Largeur(Objet_De_Tableau(T_O, I));
            else
               Largeur_Restante_Courante:= Largeur_Ruban - Largeur(Objet_De_Tableau(T_O, I));
               Niveau_Courant := Niveau_Courant + 1;
               --Niveau_Vide := True;
                Place_Objet( T_O(I), Niveau_Courant);
                Hr := Hr + Hauteur(Objet_De_Tableau(T_O, I));
            end if;

         end loop;

         Hauteur_Ruban := Hr;
         Objets := T_O;

      exception
         when Objet_Trop_Grand
           => Put_Line("Un Objet Est Plus Large Que Le Ruban");
      end;

end Packing;




