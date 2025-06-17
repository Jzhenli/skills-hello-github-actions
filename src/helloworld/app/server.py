import time
import os
import uvicorn
import threading

def start_uvicorn():
    from .app import app
    uvicorn.run(app=app, host="0.0.0.0", port=19800)

def foreground_cmd_app():
    start_uvicorn()

def background_cmd_app():
    def wait_and_run_uvicron():
        while not (app_env := os.getenv("APP_ENV", None)):
            time.sleep(0.1)
            print("Waitting for APP_ENV ....")

        start_uvicorn()
        
    fastapi_thread = threading.Thread(target=wait_and_run_uvicron, daemon=True)
    fastapi_thread.start()