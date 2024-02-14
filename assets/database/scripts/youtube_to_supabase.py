from pytube import Channel
from supabase_py import create_client, SupabaseClient

# Initialize Supabase client
SUPABASE_URL = "https://hxlaujiaybgubdzzkoxu.supabase.co"
SUPABASE_API_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4bGF1amlheWJndWJkenprb3h1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc3MDgxMzksImV4cCI6MjAxMzI4NDEzOX0.il1HcIVUBZvy66iyBfcsWAwf5HNp7ly5F4KVnZKd8AQ"
supabase: SupabaseClient = create_client(SUPABASE_URL, SUPABASE_API_KEY)

# Fetch YouTube videos
channel_url = 'https://www.youtube.com/@Aibient/'
channel = Channel(channel_url)
video_urls = [video.watch_url for video in channel.video_urls]

# Insert video URLs into Supabase
table_name = 'videos'
column_name = 'URL'

for video_url in video_urls:
    data = {column_name: video_url}
    supabase.table(table_name).insert([data]).execute()
