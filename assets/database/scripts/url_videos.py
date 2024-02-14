import random
import requests
from bs4 import BeautifulSoup
from supabase_py import create_client, SupabaseClient

# Initialisation du client Supabase
supabase_url: str = "https://hxlaujiaybgubdzzkoxu.supabase.co"
supabase_key: str = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4bGF1amlheWJndWJkenprb3h1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc3MDgxMzksImV4cCI6MjAxMzI4NDEzOX0.il1HcIVUBZvy66iyBfcsWAwf5HNp7ly5F4KVnZKd8AQ"
supabase: SupabaseClient = create_client(supabase_url, supabase_key)

# Fonction pour récupérer les liens des vidéos YouTube
def fetch_youtube_video_links():
    url = "https://www.youtube.com/@Aibient/videos"
    r = requests.get(url)
    soup = BeautifulSoup(r.text, 'html.parser')
    video_links = ['https://www.youtube.com' + vid['href'] for vid in soup.findAll(attrs={'class':'yt-uix-tile-link'})]
    return video_links

# Fonction pour insérer les liens dans la table Supabase
def insert_into_supabase(video_links):
    for id in range(1, 72):  # IDs de 1 à 71
        random_video_link = random.choice(video_links)
        row = {
            'id': id,
            'url': random_video_link
        }
        supabase.table('video').upsert(row)

if __name__ == "__main__":
    video_links = fetch_youtube_video_links()
    insert_into_supabase(video_links)
