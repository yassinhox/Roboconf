# Roboconf

Regarder le google drive !!!  


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
            fichier qui permet de generer le graph en html, je le push demain
              
              
Je me suis inspiré de cette video (il y en a 4 de très intéréssantes) : 
https://www.youtube.com/watch?v=h9ap54iMqcU

