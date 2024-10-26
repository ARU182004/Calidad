import fitz  
import pandas as pd
import re
import os
from params import *

def extract_email_info(pdf_path):
    doc = fitz.open(pdf_path)
    email_info = {
        'From': '',
        'Fecha_envio': '',
        'Para': '',
        'Asunto':''     
    }

    for page_num in range(len(doc)):
        page = doc.load_page(page_num)
        text = page.get_text("text")
        lines = text.split('\n')
        contador = 0
        collecting_recipients = False
        recipients = []

        for line in lines:
            line = line.strip()
            
            
            if contador == 5:
                email_info['From'] = line[:].strip()
            elif contador == 6:
                email_info['Fecha_envio'] = line[:].strip()
            elif contador ==4:
                email_info['Asunto'] = line[:].strip()
            if line.startswith("Para:"):
                collecting_recipients = True
                line = line[5:].strip()

            if collecting_recipients:
                if line.startswith("CC:"):
                    collecting_recipients = False
                    break
                else:
                    names = re.findall(r'[^<>;]+(?=<)', line)
                    names = [name.strip() for name in names if name.strip()]
                    recipients.extend(names)
            contador += 1
        
        email_info['Para'] = ', '.join(recipients)

    return email_info

def save_to_excel(email_info_list, output_excel):
    df = pd.DataFrame(email_info_list)
    df.to_excel(os.path.join(RESULTS_PATH,output_excel), index=False)

pdf_path = os.path.join(CORREOS_PATH, "02. Reunión de Inicio.pdf")

email_info_list = [extract_email_info(pdf_path)]

for info in email_info_list:
    print("From:", info['From'])
    print("Fecha_envio:", info['Fecha_envio'])
    print("Para:", info['Para'])
    print("Asunto:", info['Asunto'])
    
    


output_excel = 'emails_info.xlsx'
save_to_excel(email_info_list, output_excel)

print(f"Datos guardados en {output_excel}")