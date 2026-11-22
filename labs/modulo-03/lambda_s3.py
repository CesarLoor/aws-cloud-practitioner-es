# Laboratorio 3 · Parte B: registra el nombre de cada archivo nuevo en el bucket.
# No escribas desde aquí en el mismo bucket que dispara la función: se invocaría en bucle.


def lambda_handler(event, context):
    for registro in event["Records"]:
        print("Nuevo archivo:", registro["s3"]["object"]["key"])
