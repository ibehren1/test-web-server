import os
from http.server import HTTPServer, BaseHTTPRequestHandler

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        color = os.environ.get('COLOR', 'blue')
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(f'<html><body style="background-color:{color};"></body></html>'.encode())

HTTPServer(('0.0.0.0', 8080), Handler).serve_forever()
