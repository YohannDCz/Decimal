import supabase_py
import youtube_dl

# Configurez votre client Supabase
supabase_url = "https://hxlaujiaybgubdzzkoxu.supabase.co"
supabase_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4bGF1amlheWJndWJkenprb3h1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc3MDgxMzksImV4cCI6MjAxMzI4NDEzOX0.il1HcIVUBZvy66iyBfcsWAwf5HNp7ly5F4KVnZKd8AQ"
supabase = supabase_py.create_client(supabase_url, supabase_key)

def get_video_links(channel_url):
    ydl_opts = {
        'quiet': True,
        'extract_flat': True,
        'force_generic_extractor': True,
    }
    with youtube_dl.YoutubeDL(ydl_opts) as ydl:
        result = ydl.extract_info(channel_url, download=False)
        if 'entries' in result:
            return [entry['url'] for entry in result['entries']]
    return []

def insert_video_links_into_supabase(video_links):
    for idx, link in enumerate(video_links, start=1):
        if 1 <= idx <= 71:  # Assurez-vous que l'ID est entre 1 et 71
            data = {
                "id": idx,
                "url": link
            }
            response = supabase.table("video").insert(data)
            if response.error:
                print(f"Erreur Supabase: {response.error}")

if __name__ == "__main__":
    channel_url = 'https://www.youtube.com/@Aibient'
    video_links = get_video_links(channel_url)
    if video_links:
        insert_video_links_into_supabase(video_links)
    else:
        print("Aucun lien vidéo trouvé.")
