# 2-App-Basics

## Exercice 1

1) Une erreur est affichée car il manque une boucle ForEach ainsi qu'un id self pour attribuer une valeur unique au tableau.

## Exercice 2

1) Un bouton a été ajouté pour pouvoir insérer de nouveaux items dans la liste.

2) La boucle ForEach permet de boucler sur chaque item du tableau, son rôle est de modiier des éléments sur chaque item, la séparation du bouton de la boucle est donc normale car si le bouton se situait dans la boucle foreach, j'aurai dans ma vue ce bouton qui apparaitra sur chacun des items de ma liste.

## Exercice 3

1) Le code ne fonctionne pas, plus précisément le bouton pour ajouter un nouvel item car il manque un @state.
2) L'intégration d'un @state permet d'ajouter, supprimer ou modifier des éléments en stockant les informations en mémoire.


# 4-Ajout-Items

## Exercice 1

1) Le bouton dans la liste appelle la méthode addItem mais il ne modifie pas l'affichage de l'inventaire car il n'utilise pas @State ou @Binding pour mettre à jour l'état de l'inventaire.

## Exercice 2

1) @StateObject a été ajouté pour rafraîchir la vue chaque fois que loot change. La classe Inventory utilise @Published pour suivre le changement.
2) @StateObject est utilisé pour créer et gérer un objet observable dans une vue tandis que @ObservedObject est utilisé pour observer un objet créé ailleurs et passé à la vue, et @State est destiné à gérer des états simples.


# 5-Modele

## Exercice 2

1) Une erreur parle de Identifiable car l'id a été omis et par conséquent, il nous était impossible de récupérer l'item correspondant dans la vue. Il fallait donc ajouter une variable id de type UUID pour résoudre le problème.

## Exercice 3

1)  La balise tag() permet d'indexer les éléments du tableau. Cette balise était nécessaire pour identifier l'élément sélectionné.

## Exercice 7

1) Si on n’attend pas avant de lancer l’animation. L’animation se lance en même temps que la vue et donc tous les éléments nécessaires à l’animation ne sont pas encore chargés. Il faut donc attendre que la vue soit chargée avant de lancer l’animation. Et cela rend l'animation plus naturelle.

