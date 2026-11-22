# Laboratorio 3 · Parte A: función que saluda con el nombre recibido en el evento.
import json


def lambda_handler(event, context):
    nombre = event.get("nombre", "mundo")
    return {
        "statusCode": 200,
        "body": json.dumps({"mensaje": f"Hola, {nombre}!"}),
    }
