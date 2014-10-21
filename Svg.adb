with Ada.Text_Io, Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;
with Objet_Packing;
use Objet_Packing;

package body Svg is -- Trac� "� l'envers" pour le moment", tout de Haut gauche vers Bas droite (rect, lignes)
   type Point is  record
      X : Natural;
      Y : Natural;
   end record;
   type Couleur is record
      R : Integer range 0..255;
      G : Integer range 0..255;
      B : Integer range 0..255;
   end record;
   Output : File_Type;
   Coord_Act : Point;
   Hauteur_Niveau: Integer :=0 ;

   Noir : Couleur := (0,0,0);
   Gris : Couleur := (110,110,110);
   Rouge : Couleur := (150,0,0);
   Bleu : Couleur := (0,0,150);

   Set_Couleurs : array ( Integer range 0..2 , Integer range 0..1 ) of Couleur := ( 0 => ( 0 => Noir, 1 => Gris), 1 => ( 0 => Bleu, 1 => Rouge), 2 => ( 0 => Gris, 1=> Rouge) );
   X : Integer range Set_Couleurs'Range(1) := Set_Couleurs'First(1);
   Y : Integer range Set_Couleurs'Range(2) := Set_Couleurs'First(2);
   -- On change de couleur � chaque objet (indice 1). On change de "set de couleur" � chaque niveau (indice 2)
   -- Doit partir de 0 pour modulo facile.

   procedure Trace_Ligne  (A,B : in Point; Col : in Couleur) is
   begin
      Put(Output, " <line x1=""" & Integer'Image(A.X) & """ y1 =""" & Integer'Image (A.Y) & """ " ); -- Point de d�part
      Put(Output, " x2=""" & Integer'Image(B.X) & """ y2 =""" & Integer'Image (B.Y) & """ " ); -- Point d'arriv�e
      Put(Output, " style=""stroke:rgb(" & Integer'Image (Col.R) & "," & Integer'Image (Col.G) & "," & Integer'Image(Col.B) & ");stroke-width:2"" />"); -- Couleur et �paisseur;
      Put_Line (Output, ""); -- Retour � la ligne
   end Trace_Ligne;

   procedure Trace_Ruban (Largeur,Hauteur : in Integer ) is
   begin
      Trace_Ligne ((0,0),(Largeur,0),Noir);
      Trace_Ligne ((0,0),(0,Hauteur),Noir);
      Trace_Ligne ((Largeur,0),(Largeur,Hauteur),Noir);
   end Trace_Ruban;

   procedure Trace_Rectangle (Obj : in Objet; ColE : in Couleur ) is -- SQUA UN OBJET ???
   begin

      Put(Output, "  <rect x=""" & Integer'Image(Coord_Act.X) & """ y=""" & Integer'Image(Coord_Act.Y) & """ " ); -- D�part rectangle (Haut,Gauche)
      Put(Output, "width=""" & Integer'Image(Largeur(Obj)) & """ " ); -- Largeur
      Put(Output, "height=""" & Integer'Image(Hauteur(Obj)) & """ " ); -- Hauteur
      Put(Output, " style=""fill:rgb(" & Integer'Image (ColE.R) & "," & Integer'Image (ColE.G) & "," & Integer'Image(ColE.B) & ");" );
      Put(Output, " stroke:black;stroke-width:1;opacity:0.5"" />"); -- Autre custom plus tart ptet

      Coord_Act.X := Coord_Act.X + Largeur(Obj) ; -- On se d�place pour le prochain rectangle
   end Trace_Rectangle;

   procedure Init(Sortie : in String; Objets : in Tableau_Objets; Largeur,Haut : in Integer) is
   begin
      Coord_Act := (others => 0);
      Create (File => Output, Mode => Out_File, Name => Sortie);
      Put(Output, " <svg height=""" & Integer'Image(Haut + 100) & """ width=""" & Integer'Image(Largeur + 100) & """> "); -- En t�te pour le moment
      Hauteur_Niveau := Hauteur( Objets(Objets'First) );
   end Init;



   procedure Sauvegarde (Sortie : in String; Objets : in Tableau_Objets; Largeur, Haut : in Integer) is
      Mauvais_Rangement : exception;
   begin
      
      Init(Sortie, Objets,Largeur,Haut);
      Trace_Ruban (Largeur, Haut);
      for I in Objets'Range loop
         Trace_Rectangle (Objets(I),Set_Couleurs(X,Y));
         X:= (X+1) mod Set_Couleurs'Last(1); -- Couleur prochain objet

         if I<Objets'Last and then Niveau(Objet_De_Tableau(Objets, I)) /= Niveau(Objet_De_Tableau(Objets,I+1)) then -- On s'appr�tre � changer de Niveau
	    Put(Integer'Image( Niveau(Objet_De_Tableau(Objets, I))));
	    Put(Integer'Image( Niveau(Objet_De_Tableau(Objets, I+1))));
	    New_Line;
            Coord_Act.X := 0;
            Coord_Act.Y := Coord_Act.Y + Hauteur_Niveau;
            Hauteur_Niveau := Hauteur(Objet_De_Tableau(Objets, I+1));  -- Hauteur du niveau = Hauteur du 1er objet du Niveau suivant
            Y:= (Y+1) mod Set_Couleurs'Last(2); -- Change de set de couleur.
         end if;

        -- if Coord_Act.X > Largeur or Coord_Act.Y > Haut then -- Test d�bordement du Ruban
          --  Put ("Alerte : Objets d�passant le ruban pr�vu");
        -- end if;

      end loop;
	Put(Integer'Image(Niveau(Objet_De_Tableau(Objets, Objets'Last))));
      Put_Line(Output, "</svg>");
      Close (Output);
      
   exception
      when Mauvais_Rangement =>
	Put_Line(Output, "</svg>");
	 Close (Output);
	 raise Mauvais_Rangement;
	 
   end Sauvegarde;
   
   
end Svg;
