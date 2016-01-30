[![Stories in Ready](https://badge.waffle.io/sowfrancis/Decibel.png?label=ready&title=Ready)](https://waffle.io/sowfrancis/Decibel)
# Decibel

Prérequis

installer ruby version 2.2.1
installer postgresql
ajouter la gem pg dans le fichier gemfile et ensuite dans le terminal, faites un 'bundle install'

Créer les bases de données de development et de test

se connecter dans le client de pg
  dans le terminal faite la commande:
  "sudo -i -u postgres" 

Création de l'utilisateur decibel
  "createuser decibel" 

Création de la base de dev
  "createdb decibel_development"

Création de la base de test
  "createdb decibel_test"

vous pouvez faire un "psql-l" pour voir si vous avez bien créer les bases de données
qui vous seront nécessaire au démarrage de l'application.

Ensuite toujours en étant connecter dans le client de pg faite:

pour se connecter en tant que postgres
  "psql"

donner les droits 
  
1.  "GRANT ALL PRIVILEGES ON DATABASE decibel_test TO decibel ;"
 
2.  "ALTER USER decibel WITH PASSWORD 'spider';" pour ajouter un mot de passe à decibel

puis  quittez avec \q

Vous êtes enfin prêt à démarrer l'application.

Installation

Cloner
Installer les dépendances: bundle install
Initialiser les bases de données de dev et de test: rake db:migrate 

et c'est partie.

Peace.






