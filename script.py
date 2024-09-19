from flask import Flask, request, jsonify
import subprocess
import json

app = Flask(__name__)

@app.route('/execute', methods=['POST'])
def execute():
    data = request.get_json()
    script = data.get('script')
    print(script)
    if not script:
        return jsonify({"error": "No script provided"}), 400

    with open("/app/script-result.py", "w") as file:
        file.write(script)

    result = subprocess.run(
    ["nsjail", "--config", "nsjail.cfg", "--", "/usr/local/bin/python3", "script-result.py"],
    capture_output=True, text=True)

    print(result)
    if result.returncode != 0:
        return jsonify({"error": "Error in executing script"}), 500

    try:
        main_result = json.loads(result.stdout)
    except json.JSONDecodeError:
        return jsonify({"error": "main() function did not return valid JSON"}), 500

    return jsonify({"result": main_result, "stdout": result.stderr})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)
