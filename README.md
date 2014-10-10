facturation
===========

Générateur de factures, avoirs, devis et nodes de frais en PDF depuis des fichiers de template en LaTeX

Dépendances :
-------------

- ruby ;
- ruby gems : rake, yaml, erb ;
- pdflatex ;

Mode d'emploi
-------------

- Modifier le fichier config.yaml avec les informations de votre entreprise ;
- Modifier, aJouter vos clients dans le fichier config.yaml ;
- Invoquer les tâches définies dans le rakefile pour générer factures, avoirs, devis et nodes de frais :

```
rake -T
rake avoir[client]    # Generate 'avoir' for a client
rake clean            # Remove any temporary products.
rake clobber          # Remove any generated file.
rake devis[client]    # Generate 'devis' for a client
rake expense[client]  # Generate 'expense' report for a client
rake invoice[client]  # Generate 'invoice' for a client
```
