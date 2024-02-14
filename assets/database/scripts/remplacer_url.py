import re
from supabase_py import create_client, SupabaseClient

# Initialisation du client Supabase
url: str = "https://your_domain.supabase.co"
anon_key: str = "your_anon_key"
supabase: SupabaseClient = create_client(url, anon_key)

# Charger le fichier SQL
with open('/mnt/data/users.sql', 'r') as f:
    content = f.read()

# Obtenir les URLs depuis le bucket "Assets" dans Supabase
response = supabase.storage.list_buckets('Assets')
if response['error'] is None and response['data']:
    files = [file['name'] for file in response['data']]
    
    # Remplacer les URLs dans le contenu SQL
    index = 0
    def replacer(match):
        nonlocal index
        url = files[index % len(files)]  # Utilisez l'URL correspondante
        index += 1  # Passez à l'URL suivante pour le prochain remplacement
        return f"{match.group(1)}{url}"
        
    new_content = re.sub(r"('profile_photo', ')([^']+)", replacer, content)

    # Sauvegarder dans un nouveau fichier SQL
    with open('/mnt/data/users_updated.sql', 'w') as f:
        f.write(new_content)
else:
    print(f"Erreur lors de la récupération des données: {response['error'].message}")
