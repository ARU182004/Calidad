from params import *
import pandas as pd
import pyodbc 
import os

## Conexión al TIGA
cnxn_TIGA = pyodbc.connect(CNXN_TIGA)
print("Conectando a la base de datos... ")
cnxn = pyodbc.connect(CNXN_TIGA)
cursor = cnxn.cursor()
print("Conectado.")
cursor.execute('SET LANGUAGE SPANISH')
cursor.commit()

def obtener_codigo_de_Excel(file_path):
    df = pd.read_excel(file_path)
    codigo = df['CODIGO'].iloc[-1]
    print(codigo)
    return codigo

def obtener_tipo_de_Excel(file_path):
    df = pd.read_excel(file_path)
    tipo = df['TIPO'].iloc[-1]
    negocio = df['NEGOCIO'].iloc[-1]
    print(tipo)
    return tipo,negocio


def reemplazarVariablesQueries(query : str) -> str:
    file_path = os.path.join(EXCEL_PATH,"base_creacion_ppts.xlsx") 
    codigo = obtener_codigo_de_Excel(file_path)
    return query.replace('%proyecto_reemplazo%', codigo)


def obtenerDatosDe(nombre_query : str) -> pd.DataFrame:
    print(f"Extrayendo datos de {nombre_query}...")
    sql = reemplazarVariablesQueries(open(os.path.join(QUERIES_PATH, f'{nombre_query}.sql'), 'r', encoding='utf-8-sig').read())
    cursor.execute(sql)
    dataframe_resultante = pd.DataFrame.from_records(cursor.fetchall(), columns=[col[0] for col in cursor.description]).drop_duplicates()
    print("Se extrajeron " + str(len(dataframe_resultante.index)) + " filas y " + str(len(dataframe_resultante.columns)) + " columnas de " + nombre_query + ".")
    return dataframe_resultante



def obtenerpath(tipo,negocio,codigo):
    programado = 'PROGRAMADOS'
    anio= '2024'
    if codigo.__contains__('NPRO'):
        programado = 'NO PROGRAMADOS'
    if codigo.__contains__('2025'):
        anio = '2025'

    if negocio == 'SEGUROS':
        final = os.path.join(FINAL_PATH,"Auditoria Interna - Evaluaciones-Documentos Seguros")
    elif negocio == 'PRIMA':
        final = os.path.join(FINAL_PATH,"Auditoria Interna - Evaluaciones-Documentos Prima AFP")
    
    elif negocio == 'SALUD':
        final = os.path.join(FINAL_PATH,"Auditoria Interna - Evaluaciones-Documentos Salud")
    
    elif negocio == 'CREDISEGUROS':
        final = os.path.join(FINAL_PATH,"Auditoria Interna - Evaluaciones-Documentos Crediseguro")
    
    final= os.path.join(final,anio)
    final = os.path.join(final,programado)
    final = os.path.join(final,codigo)

    if tipo=='Memorando':
        final=os.path.join(final,"Documentacion")
        final=os.path.join(final,"Planificacion")
        final=os.path.join(final,"07. Sprint Planning.pptx")
    elif tipo=='Observaciones Borrador':
        final=os.path.join(final,"Informe Borrador")
        final=os.path.join(final,"02. Borrador Observaciones.pptx")
    elif tipo=='Observaciones Final':
        final=os.path.join(final,"Informe Final")
        final=os.path.join(final,"02. Observaciones.pptx")        
    elif tipo=='Informe Final':
        final=os.path.join(final,"Informe Final")
        final=os.path.join(final,"01. Informe Final.pptx")
    elif tipo=='Informe Borrador':
        final=os.path.join(final,"Informe Borrador")
        final=os.path.join(final,"01. Borrador Informe.pptx")
    
    
    return final
    
        
    