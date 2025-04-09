from flask import Flask, jsonify, request
from flask_cors import CORS
import json
import os

app = Flask(__name__)
CORS(app)  # Permite peticiones desde Flutter

# Datos simulados en memoria
events = [
    {
        "id": 1,
        "title": "Conferencia de flutter 2025",
        "description": "Evento sobre Flutter y desarrollo móvil",
        "date": "2025-05-10",
        "location": "Barranquilla, Colombia",
        "capacity": 100
    },
    {
        "id": 2,
        "title": "AI Summit",
        "description": "Conferencia sobre Inteligencia Artificial",
        "date": "2025-06-15",
        "location": "Cochabamba, Bolivia",
        "capacity": 150
    }
]

subscriptions = []
feedbacks = []

# Cargar feedbacks anteriores si existen
if os.path.exists('feedbacks.json'):
    with open('feedbacks.json', 'r', encoding='utf-8') as f:
        feedbacks = json.load(f)

@app.route('/events', methods=['GET'])
def get_events():
    return jsonify(events), 200

@app.route('/subscribe', methods=['POST'])
def subscribe():
    data = request.json
    subscriptions.append(data)
    return jsonify({"message": "Suscripción registrada correctamente."}), 201

@app.route('/feedback', methods=['POST'])
def submit_feedback():
    data = request.json
    evento_id = data.get('evento_id')
    mensaje = data.get('mensaje')
    rating = data.get('rating')  # Opcional

    if not evento_id or not mensaje:
        return jsonify({"error": "Se requieren 'evento_id' y 'mensaje'."}), 400

    feedback = {
        "evento_id": evento_id,
        "mensaje": mensaje,
        "rating": rating
    }

    feedbacks.append(feedback)

    # Guardar en archivo
    with open('feedbacks.json', 'w', encoding='utf-8') as f:
        json.dump(feedbacks, f, ensure_ascii=False, indent=2)

    return jsonify({"message": "Gracias por tu feedback anónimo."}), 201

@app.route('/subscribed', methods=['GET'])
def get_subscriptions():
    return jsonify(subscriptions), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)


#¿Qué hace este backend?
#GET /events → Devuelve la lista de eventos.
#POST /subscribe → Recibe datos de suscripción y los guarda.
#POST /feedback → Recibe feedback anónimo.
#GET /subscribed → Devuelve las suscripciones actuales (por si lo necesito mostrar).

#http://127.0.0.1:5000 → Es mi localhost, accesible desde tu computadora.
#http://172.20.10.2:5000 → Es la IP de tu red local (por si otro dispositivo quiere acceder).
#0.0.0.0 → Significa “acepta conexiones desde cualquier red disponible”.

#guarda los feedbacks en un archivo feedbacks.json para que no se pierdan al cerrar el servidor.