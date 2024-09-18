  # API to Execute Python code on Server

  This is a secure application for executing scripts on a server through a Flask App using nsjail to create a sandboxed envireonment.

  ## Steps to Run:
1. Clone the repository from github:
   1. git clone https://github.com/nina-simon/stacksync.git
   2. cd stacksync
2. Buid Docker Image
   1. docker build -t flask-nsjail-app .
3. Run Docker container
   1. docker run -p 8080:8080 flask-nsjail-app


## Example Request

curl -X POST http://localhost:8080/execute \
-H "Content-Type: application/json" \
-d '{"script":"def main():\\n    return {\"message\": \"Hello, World!\"}"}'

## Example Response

{
  "result": {"message": "Hello, World!"},
  "stdout": ""
}
