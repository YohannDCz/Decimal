#!/bin/bash

# Vérifiez si le dossier est fourni en argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <chemin_vers_dossier>"
    exit 1
fi

dossier="$1"

# Parcourez chaque fichier image du dossier
for fichier_input in "$dossier"/*.{jpg,jpeg,png,gif}; do
    # Vérifiez si le fichier existe (pour éviter les erreurs avec des extensions non trouvées)
    if [ -f "$fichier_input" ]; then
        # Redimensionne l'image à une résolution inférieure (par exemple, 512x512) et remplace l'image originale
        convert "$fichier_input" -resize 512x512 "$fichier_input"
        
        echo "Image $fichier_input redimensionnée et remplacée."
    fi
done
