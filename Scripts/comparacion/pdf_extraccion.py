import extract_msg
import re
import csv
import os
from params import *

def extract_email_info_from_msg(msg_path, proyecto):
    msg = extract_msg.Message(msg_path)
    
    def extract_names(text):
        return re.sub(r'\s*<[^>]+>', '', text).strip()

    email_info = {
        'From': extract_names(msg.sender),
        'Fecha_envio': msg.date,
        'Para': extract_names(msg.to),
        'CC': extract_names(msg.cc),
        'Asunto': msg.subject,
        'Cuerpo': ''
    }

    cuerpo = msg.body
    firma_indicadores = ["Saludos", "Atentamente", "Cordialmente", "Gracias", "Sinceramente"]

    for indicador in firma_indicadores:
        if indicador in cuerpo:
            cuerpo = cuerpo.split(indicador, 1)[0]
            break

    email_info['Cuerpo'] = cuerpo.strip()

    # Lista de filas para escribir en el CSV
    rows = []
    for campo, valor in email_info.items():
        rows.append({
            'proyecto': proyecto,
            'archivo': msg_path,
            'campo_encontrado': campo,
            'valor_campo': valor
        })

    return rows

def write_csv(filename, data):
    # Escribir en un archivo CSV
    with open(filename, 'w', newline='', encoding='utf-8') as csvfile:
        fieldnames = ['proyecto', 'archivo', 'campo_encontrado', 'valor_campo']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()
        for row in data:
            writer.writerow(row)



# Recolectar datos de todos los archivos .msg
all_data = []
for msg_file in msg_files:
    all_data.extend(extract_email_info_from_msg(os.path.join(CORREOS_PATH,msg_file), proyecto))

# Escribir la información recolectada en un archivo CSV
write_csv('output_emails.csv', all_data)

print(f"Datos guardados en output_emails.csv")