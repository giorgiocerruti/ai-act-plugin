"""Fixture di test — NON è codice di produzione.
Screening automatico di CV per assunzioni: dominio Allegato III §4 (lavoro),
componente IA strong (openai). Atteso: alto rischio, provider se immesso col proprio marchio.
"""
import os
from openai import OpenAI

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))


def score_candidate(cv_text: str) -> float:
    """Assegna un punteggio di idoneità al candidato per la selezione (hiring)."""
    resp = client.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "Sei un recruiter. Valuta il candidato da 0 a 100."},
            {"role": "user", "content": cv_text},
        ],
    )
    return float(resp.choices[0].message.content)


def rank_candidates(resumes: list[str]) -> list[tuple[str, float]]:
    scored = [(cv, score_candidate(cv)) for cv in resumes]
    return sorted(scored, key=lambda x: x[1], reverse=True)
