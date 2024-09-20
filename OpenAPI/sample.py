import requests
import json

# Define your API key and endpoint
api_key = 'your_api_key_here'
endpoint = 'https://dotnetai.openai.azure.com/v1/engines/davinci-codex/completions'

# Function to generate text using Azure OpenAI
def generate_text(prompt, max_tokens=50):
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f'Bearer {api_key}'
    }
    
    data = {
        'prompt': prompt,
        'max_tokens': max_tokens
    }
    
    response = requests.post(endpoint, headers=headers, json=data)
    
    if response.status_code == 200:
        result = response.json()
        return result['choices'][0]['text']
    else:
        response.raise_for_status()

# Example usage
prompt = "Once upon a time"
try:
    generated_text = generate_text(prompt)
    print("Generated Text:", generated_text)
except requests.exceptions.RequestException as e:
    print(f'Error: {e}')