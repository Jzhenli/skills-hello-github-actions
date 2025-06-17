"""
My first application
"""

from threading import Thread
import uvicorn
from fastapi_offline import FastAPIOffline


PORT = 19800
app = FastAPIOffline(title="HelloWorld API")


@app.get("/")
async def root():
    return {"message": "Hello World"}







