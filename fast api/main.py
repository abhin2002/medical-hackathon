from fastapi import FastAPI, HTTPException
from motor.motor_asyncio import AsyncIOMotorClient
from pymongo.errors import ServerSelectionTimeoutError
from pydantic import BaseModel

app = FastAPI()

class SignUpRequest(BaseModel):
    email: str
    password: str
    confirm_password: str
    mobile_number: str
    facilities: str

@app.on_event("startup")
async def startup_db_client():
    app.mongodb_client = AsyncIOMotorClient('mongodb+srv://helloworld:devji@cluster0.jsly6sz.mongodb.net/')
    try:
        # The ismaster command is cheap and does not require auth.
        app.mongodb_client.admin.command('ismaster')
        print("Connected to mongodb")
    except ServerSelectionTimeoutError:
        print("Can't connect to MongoDB Atlas Server")

@app.on_event("shutdown")
async def shutdown_db_client():
    app.mongodb_client.close()

@app.post("/signup")
async def sign_up(request: SignUpRequest):
    # Perform any necessary validation checks here

    # For demonstration purposes, just print the received data
    print(f"Received SignUp Request:\n{request}")

    # You can add your MongoDB or any other SignUp logic here
    # For example, you might want to insert the data into a MongoDB collection

    # Insert into MongoDB (you need to customize this based on your MongoDB schema)
    db = app.mongodb_client.get_database("vaidyan")
    users_collection = db.get_collection("users")

    # You may want to hash the password before storing it
    # For demonstration purposes, it's stored as plain text (not recommended in production)
    user_data = {
        "email": request.email,
        "password": request.password,
        "mobile_number": request.mobile_number,
        "facilities": request.facilities,
    }

    result = await users_collection.insert_one(user_data)

    return {"message": "SignUp successful"}

@app.get("/")
def read_root():
    return {"Hello": "World"}
