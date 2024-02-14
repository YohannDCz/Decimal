
from supabase import create_client

# Initialize Supabase client
url = "https://hxlaujiaybgubdzzkoxu.supabase.co"
anon_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4bGF1amlheWJndWJkenprb3h1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc3MDgxMzksImV4cCI6MjAxMzI4NDEzOX0.il1HcIVUBZvy66iyBfcsWAwf5HNp7ly5F4KVnZKd8AQ"
supabase = create_client(url, anon_key)

# Obtenez tous les enregistrements de la table "users", triés par "id"
response = supabase.from_("users").select("*").order("id").execute()
rows = response.data  # Obtenez les données de la réponse

if rows:
    # Parcourir les lignes et mettre à jour la colonne "profile_photo"
    for row in rows:
        user_id = row['id']
        username = row['name']  # Assumons que la colonne contenant le nom de l'utilisateur est appelée "username"
        
        # Convertir le nom d'utilisateur en minuscules et remplacer les espaces par des traits d'union
        username_sanitized = username.lower().replace(' ', '-')
        
        new_profile_photo_url = f"https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/other_user/cover/{username_sanitized}.png"

        # Mettre à jour la colonne "profile_photo" pour cet utilisateur
        update_response = supabase.from_("users").update({"cover_photo": new_profile_photo_url}).match({"id": user_id}).execute()

        if update_response.data:
            print(f"Mis à jour l'utilisateur {user_id} avec la nouvelle URL: {new_profile_photo_url}")
        else:
            print(f"Erreur lors de la mise à jour de l'utilisateur {user_id}")

# Note: Replace 'your_supabase_url', 'your_anon_key', and 'your_bucket_url' with your actual values.
