"""Fixture di test — NON è codice di produzione.
Chatbot di assistenza clienti (LLM). Interagisce con persone → art. 50 §1.
Nessun dominio Allegato III. Atteso: rischio limitato (trasparenza art. 50).
"""
import os
from openai import OpenAI

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))


def reply(user_message: str) -> str:
    """Risponde al cliente. Nota: si presenta come 'assistente', non dichiara di essere IA."""
    resp = client.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "Sei l'assistente del negozio. Rispondi gentilmente."},
            {"role": "user", "content": user_message},
        ],
    )
    return resp.choices[0].message.content
