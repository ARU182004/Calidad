## Importacion de Librerias
import pyodbc 
import pandas as pd
import os
import numpy as np
import openpyxl as ox
import datetime
from params import *




## Conexión al TIGA
cnxn_TIGA = pyodbc.connect(CNXN_TIGA)
print("Conectando a la base de datos... ")
cnxn = pyodbc.connect(CNXN_TIGA)
cursor = cnxn.cursor()
print("Conectado.")
cursor.execute('SET LANGUAGE SPANISH')
cursor.commit()




def reemplazarVariablesQueries(query : str, codigo) -> str:
    return query.replace('%proyecto_reemplazo%', codigo)


def obtenerDatosDe(nombre_query : str,codigo) -> pd.DataFrame:
    print(f"Extrayendo datos de {nombre_query}...")
    sql = reemplazarVariablesQueries(open(os.path.join(QUERIES_PATH, f'{nombre_query}.sql'), 'r', encoding='utf-8-sig').read(),codigo)
    cursor.execute(sql)
    dataframe_resultante = pd.DataFrame.from_records(cursor.fetchall(), columns=[col[0] for col in cursor.description]).drop_duplicates()
    print("Se extrajeron " + str(len(dataframe_resultante.index)) + " filas y " + str(len(dataframe_resultante.columns)) + " columnas de " + nombre_query + ".")
    return dataframe_resultante


