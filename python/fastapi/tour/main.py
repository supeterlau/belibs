from typing import Optional

from fastapi import FastAPI

app = FastAPI()

@app.get("/echo")
def read_echo():
  return {"Done": "Echo"}

@app.get("/user/{user_id}")
def read_user(user_id: int, q: Optional[str] = None):
  return {"user_id": user_id, "q": q}
