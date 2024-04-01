from fastapi import FastAPI, HTTPException, Query
from typing import Optional
from fastapi.middleware.cors import CORSMiddleware
from pymongo import MongoClient
from typing import List, Dict
from db import get_database
from bson import ObjectId
import json
from dotenv import load_dotenv
from fastapi.encoders import jsonable_encoder
from pymongo.errors import PyMongoError  # Import PyMongoError

load_dotenv() 

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class JSONEncoder(json.JSONEncoder):
    ''' extend json-encoder class'''
    def default(self, o):
        if isinstance(o, ObjectId):
            return str(o)
        if isinstance(o, bytes):
            return o.decode('ascii')
        return json.JSONEncoder.default(self, o)

# @app.get("/")
# def read_root():
#     return {"Hello": "World"}

# @app.get("/cities/test")
# def test_db_connection():
#     try:
#         db = get_database()
#         collection = db['city_questions']
#         count = collection.count_documents({})
#         return {"document_count": count}
#     except PyMongoError as e:
#         raise HTTPException(status_code=500, detail=str(e))

@app.get("/cities/all")
def get_all_cities(city_name: Optional[str] = Query(None, alias="city")):
    try:
        db = get_database()
        collection = db['city_questions']
        query = {}
        if city_name:
            # If a city_name is provided, filter documents by this city
            query["city"] = {"$regex": city_name, "$options": "i"}  # Case-insensitive matching
        documents = list(collection.find(query))
        for doc in documents:
            doc["_id"] = str(doc["_id"])  # Convert ObjectId to string for JSON serialization
        if not documents:
            return {"message": "No cities found matching the criteria"}
        return jsonable_encoder(documents)
    except PyMongoError as e:
        raise HTTPException(status_code=500, detail=str(e))