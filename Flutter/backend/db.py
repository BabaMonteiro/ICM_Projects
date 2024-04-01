from pymongo import MongoClient
import os
from dotenv import load_dotenv
load_dotenv() 


def get_database():
    CONNECTION_STRING = os.getenv("MONGO_URL")
    client = MongoClient(CONNECTION_STRING, tls=True, ssl=True)
    return client["Quizzy"]