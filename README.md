# Roboconf
J'ai mis le dossier src du projet. Je n'ai pas pris tout le projet de Loic psk ça me générait des erreurs immenses. 
En plus, à chaque compilation, de nouveaux fichiers sont générés et c'était juste trop de fichiers en trop.
Il y a 3 fichiers importants : 

I) MyDsl.xtext : 
                 Il contient la grammaire écrite par Loic. J'ai rajouté un autre champ 'facetList' pour les Components psk 
                 sur le site de RoboConf (http://roboconf.net/en/user-guide/roboconf-dsl.html) il es possible de spécifier
                 une liste de facet. 
                 Il va falloir rajouter la possibilité de spécifier des 'instanceOf' mais ça ne devrait pas être la mort

II) validation/MyDslValidator.xtend : 
                 Ce fichier est important pour l'étape 1, pour le checker. Il faut écrire différentes méthodes qui vont vérifier
                 si les lignes écrites sont correctes. Je vais essayer d'en écrire une plus compliquée pour avoir un exemple. Il
                 y en a tout de même un très simple.

III) generator/MyDslGenerator.xtend :
                 Ce fichier est important pour l'étape 2, pour la génération d'un HTML. C'est assez chiant psk dans ce fichier,
                 il y a une méthode qui va ouvrir un fichier, et va écrire des choses. Notre méthode va écrire du code Javascript/HTML
                 qui va représenter le graph écrit en .dsl (notre langage) en JointJS. J'ai crée un dossier HTML dans lequel je vais
                 mettre un fichier qui contient du code .dsl et un HTML qui va être générer automatiquement grâce à ce fichier.
              
