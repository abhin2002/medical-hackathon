from gtts import gTTS
import os

def text_to_speech(text, language='ml', filename='output.mp3'):
    tts = gTTS(text=text, lang=language, slow=False)
    tts.save(filename)
    os.system(f'start {filename}')

if __name__ == "__main__":
    malayalam_text = "ശരിക്കും നിങ്ങൾ സ്രദ്ധിക്കുക കാരണം എന്തു എപ്പോൾ വേണേലുെം സമ്പവിക്കാം"

    # Malayalam language code is 'ml'
    text_to_speech(malayalam_text, language='ml')
