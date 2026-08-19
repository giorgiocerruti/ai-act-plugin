"""Fixture di test — NON è codice di produzione.
API REST CRUD senza alcun componente di IA. Ci sono parole che potrebbero
sembrare firme weak (score, credit) ma NON c'è tecnologia IA strong.
Atteso: nessun componente IA, fuori perimetro. Il classificatore NON deve inventare un componente.
"""
from fastapi import FastAPI

app = FastAPI()

# Un negozio: 'credit' qui è credito commerciale, 'score' è un voto prodotto. Nessuna IA.
PRODUCTS = {}


@app.get("/product/{pid}/score")
def product_score(pid: int) -> dict:
    """Media dei voti utente su un prodotto. Aritmetica, nessun modello."""
    votes = PRODUCTS.get(pid, {}).get("votes", [])
    return {"score": sum(votes) / len(votes) if votes else 0}


@app.post("/customer/{cid}/credit")
def set_credit(cid: int, amount: float) -> dict:
    """Imposta il credito commerciale (store credit) del cliente. Nessuna valutazione."""
    return {"customer": cid, "credit": amount}
