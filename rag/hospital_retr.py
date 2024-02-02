# Recommended Hospital Retrieval
from openai import OpenAI

import pandas as pd
from dotenv import load_dotenv
import os #provides ways to access the Operating System and allows us to read the environment variables

load_dotenv()

# List of hospitals with their facilities as strings
hospital_data = [
    "Elite Hospital: Emergency Room, ICU, Surgery Department",
    "Daya Hospital: Emergency Room, Pediatrics Department",
    "Kinder Hospital: Emergency Room, Radiology Department, Pharmacy",
    # Add more hospitals as needed
]

def generate_recommendation(symptoms, accident_details):
    # Generate recommendation text using OpenAI API
    prompt = f"Given the symptoms: {symptoms}, and accident details: {accident_details}, recommend a suitable hospital based on the following options:\n"
    prompt += '\n'.join(hospital_data)
    client = OpenAI(
        # This is the default and can be omitted
        api_key=os.environ.get("OPENAI_API_KEY"),
    )


    response =  client.chat.completions.create(
        messages=[
            {
                "role": "system",
                "content": "You are a doctor in a hospital and a patient has just arrived with the following symptoms and accident details. Please recommend a suitable hospital only based on the options. Return only the hospital name strictly enclosed in double quotes."

            },
            {
                "role": "user",
                "content": prompt
            }
        ],
        model="gpt-3.5-turbo",
    )

    rec = response.choices[0].message.content
    hospital = rec.split('"')[1]
    return hospital, rec


if __name__ == "__main__":
    patient_symptoms = "Fever headache"
    accident_details = "Old patient having heart attack"
    recommendation, rec = generate_recommendation(patient_symptoms, accident_details)
    print("Recommended Hospital:", recommendation)
    print("Recommended Hospital:", rec)
