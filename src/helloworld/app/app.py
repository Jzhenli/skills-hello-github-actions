"""
My first application
"""

import toga
import asyncio
from threading import Thread
import uvicorn
from fastapi_offline import FastAPIOffline


PORT = 19800
app = FastAPIOffline(title="HelloWorld API")


@app.get("/")
async def root():
    return {"message": "Hello World"}


def run_uviron():
    uvicorn.run(app=app, host="0.0.0.0", port=PORT)


def run_server():
    fastapi_thread = Thread(target=run_uviron, daemon=True)
    fastapi_thread.start()


class HelloWorld(toga.App):
    def startup(self):
        """Construct and show the Toga application.

        Usually, you would add your application to a main content box.
        We then create a main window (with a name matching the app), and
        show the main window.
        """
        loading_html = "<h1>Loading...</h1>"  

        self.loading_view = toga.WebView()
        self.loading_view.set_content(
            "http://loading",
            loading_html,
        )

        self.main_window = toga.Window()
        self.main_window.size = (1024, 768)
        self.main_window.content = self.loading_view
        self.main_window.show()
    
    async def on_running(self, **kwargs):
        await asyncio.sleep(1)
        app_view = toga.WebView(url=f"http://127.0.0.1:{PORT}/docs")
        self.main_window.content = app_view


def main():
    run_server()
    ui_app = HelloWorld()
    ui_app.main_loop()

