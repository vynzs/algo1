with Objet_Packing;
use Objet_Packing;

Package Packing is

   Objet_Trop_Grand : exception;
   --levee dans next_fit_decreasing_height si un objet est plus large qu le ruban

   procedure Tri_Bulle(T : in out Tableau_Objet);
   --tri quadratique dans l'ordre decroissant des hauteur

   procedure Next_Fit_Decreasing_Height(Objets : in out Tableau_Objet; Largeur_Ruban : in Integer; Hauteur_Ruban : out Integer);
   --Requiert : objets : tableau d'objets quelconque, largeur_ruban : largeu du ruban utilise
   --garantie : objets tableau trie par hauteur decroissante d'objet place dans des niveaux croissant, hauteur_ruban : hauteur du ruban necessaire

end Packing;
