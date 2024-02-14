import random
import supabase_py
from googleapiclient.discovery import build

# Configurez votre client Supabase
supabase_url = "https://hxlaujiaybgubdzzkoxu.supabase.co"
supabase_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4bGF1amlheWJndWJkenprb3h1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc3MDgxMzksImV4cCI6MjAxMzI4NDEzOX0.il1HcIVUBZvy66iyBfcsWAwf5HNp7ly5F4KVnZKd8AQ"
supabase = supabase_py.create_client(supabase_url, supabase_key)

# Configurez votre client API YouTube
youtube = build('youtube', 'v3', developerKey='AIzaSyCSdx8eoblnTjrIoIcpVTxYEyyWgLt5PNw')

def get_video_links(channel_id):
    request = youtube.search().list(
        part='snippet',
        channelId=channel_id,
        maxResults=10,  # Limitez à 71 vidéos
        type='video'
    )
    response = request.execute()
    print(response)
    video_links = ['https://www.youtube.com/watch?v=' + item['id']['videoId'] for item in response['items']]
    return video_links

def insert_video_links_into_supabase(video_links):
    for idx, link in enumerate(video_links, start=1):
        data = {
            "id": idx,
            "url": link
        }
        response = supabase.table("videos").insert(data)
        if response.error:
            print(f"Erreur Supabase: {response.error}")

if __name__ == "__main__":
    channel_id = 'UC0Y28j5f48s8f60n7v095vQt'  # Remplacez par l'ID de votre chaîne
    video_links = get_video_links(channel_id)
    if video_links:
        insert_video_links_into_supabase(video_links)
    else:
        print("Aucun lien vidéo trouvé.")
