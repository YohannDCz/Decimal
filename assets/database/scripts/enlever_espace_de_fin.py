import os

# Spécifiez le chemin vers le dossier contenant les fichiers
dossier = "/Users/yohanndicrescenzo/Desktop/Decimal/assets/images/users/cover_pictures"

# Parcourir tous les fichiers dans le dossier
for nom_fichier in os.listdir(dossier):
    chemin_fichier = os.path.join(dossier, nom_fichier)
    
    # Enlever l'espace à la fin du nom du fichier
    nouveau_nom_fichier = nom_fichier.rstrip()
    
    # Renommer le fichier si nécessaire
    if nouveau_nom_fichier != nom_fichier:
        nouveau_chemin_fichier = os.path.join(dossier, nouveau_nom_fichier)
        os.rename(chemin_fichier, nouveau_chemin_fichier)
        print(f"{nom_fichier} a été renommé en {nouveau_nom_fichier}")
