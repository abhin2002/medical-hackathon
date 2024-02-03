import pyaudio
from google.cloud import speech
from google.oauth2 import service_account



# ********************************** Recording ***********************************************

def record_audio(duration=5, sample_rate=44100, channels=2, chunk=1024, format=pyaudio.paInt16):
    p = pyaudio.PyAudio()

    # Open stream
    stream = p.open(format=format,
                    channels=channels,
                    rate=sample_rate,
                    input=True,
                    frames_per_buffer=chunk)

    print("Recording...")
    
    frames = []
    for i in range(0, int(sample_rate / chunk * duration)):
        data = stream.read(chunk)
        frames.append(data)

    print("Recording done.")

    # Stop stream
    stream.stop_stream()
    stream.close()
    p.terminate()
    
    return (b''.join(frames))
    
# **********************************************************************************


# ********************************** Transcribing ***********************************************

def transcribe(content):
    # Load the service account key from the JSON file
    credentials = service_account.Credentials.from_service_account_file(
        r"C:\Users\itsab\Documents\Github\medical-hackathon\transcription\keys\speech-2-text-413005-3bd2d41b5e92.json",
        scopes=["https://www.googleapis.com/auth/cloud-platform"],
    )

    client = speech.SpeechClient(credentials=credentials)
    
    # Configure the audio file
    audio = speech.RecognitionAudio(content=content)
    config = speech.RecognitionConfig(
        encoding=speech.RecognitionConfig.AudioEncoding.LINEAR16,
        sample_rate_hertz=44100,
        language_code="ml-IN",
        audio_channel_count = 2,
    )
    print("Transcribing.....")
    
    # Perform the transcription
    response = client.recognize(config=config, audio=audio)
    # Print the transcription results
    res = [result.alternatives[0].transcript for result in response.results]
    res = res[0]
    print("Transcription complete !")
    
    return res

# **********************************************************************************

# ********************************** Translating ***********************************************

from deep_translator import GoogleTranslator

def translate_malayalam_to_english(text):
    print("Translating...")
    print("Text to be translated:", text)
    translator = GoogleTranslator(source= "ml", target= "en")
    translatedText = translator.translate(text)
    print("Translation Completed  !")
    return translatedText
    
    

# **********************************************************************************

# ********************************** order main function ***********************************************

def audioTanslate():
    audio = record_audio()    
    transcript = transcribe(audio)
    translation = translate_malayalam_to_english(transcript)
    print("Translation :", translation)
    
# **********************************************************************************
    
if __name__ == "__main__":
    audioTanslate()
