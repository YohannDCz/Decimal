import os

# Spécifiez le chemin du dossier où vous voulez enlever le suffixe "(copy)"
dossier = "/Users/yohanndicrescenzo/Desktop/Decimal/assets/images/users/cover_pictures"

# Liste tous les fichiers dans le dossier
for nom_fichier in os.listdir(dossier):
    if nom_fichier.endswith("(copy)"):
        nouveau_nom = nom_fichier.replace("(copy)", "")
        os.rename(os.path.join(dossier, nom_fichier), os.path.join(dossier, nouveau_nom))
        print(f"{nom_fichier} a été renommé en {nouveau_nom}")
