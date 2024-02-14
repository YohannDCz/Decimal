import os

def rename_files_in_folder(folder_path):
    for filename in os.listdir(folder_path):
        original_file_path = os.path.join(folder_path, filename)
        
        # Vérifie si c'est un fichier et non un dossier
        if os.path.isfile(original_file_path):
            new_filename = f"{filename} (copy)"
            new_file_path = os.path.join(folder_path, new_filename)
            
            # Renommer le fichier
            os.rename(original_file_path, new_file_path)
        else:
            print(f"{filename} est un dossier, il ne sera pas renommé.")

# Chemin du dossier contenant les fichiers à renommer
folder_path = '/Users/yohanndicrescenzo/Desktop/Decimal/assets/images/users/cover_pictures'

rename_files_in_folder(folder_path)
