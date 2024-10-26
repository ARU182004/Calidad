import pandas as pd
import os
from fuentes import *
from params import *

# Filtrar el Excel por código de proyecto
def filtrar_excel_por_proyecto(excel_file, project_code):
    df = pd.read_excel(excel_file)
    return df[df['Proyecto'] == project_code]

def comparar_calificativo_unidad_responsable(excel_df, df_base, compare_dict, project_code):
    resultados = []

    # Iterar sobre las claves del diccionario de comparación en pares de dos (ej: unidad_auditada_2, calificativo_2, etc.)
    for i in range(2, 4):  # Asumiendo que las comparaciones van desde _2 hasta _3
        campos_excel = [f"unidad_auditada_{i}", f"calificativo_{i}", f"efectividad_{i}", f"numero_de_controles_{i}"]
        # Filtrar las filas del Excel correspondientes a estos campos
        filas_excel = excel_df[excel_df['Campo encontrado'].isin(campos_excel)]
        
        if not filas_excel.empty and len(df_base) >= i - 1:  # Verificar que existan filas en el Excel y suficientes registros en el DataFrame
            for campo_excel in campos_excel:
                if campo_excel in filas_excel['Campo encontrado'].values:
                    valor_excel = str(filas_excel[filas_excel['Campo encontrado'] == campo_excel]['Valor de campo'].iloc[0])
                    columna_base = compare_dict.get(campo_excel)
                    valor_base = str(df_base[columna_base].iloc[i-2])  # Compara con la fila correspondiente del DataFrame
                    flag = 1 if valor_excel == valor_base else 0

                    resultados.append({
                        'codigo_proyecto': project_code,
                        'archivo': filas_excel['Archivo'].iloc[0],
                        'campo_encontrado': campo_excel,
                        'valor_excel': valor_excel,
                        'valor_base': valor_base,
                        'flag': flag
                    })

    return pd.DataFrame(resultados)


def comparar_valores(excel_df, df_base, compare_dict, project_code):
    resultados = []

    for campo_excel, columna_base in compare_dict.items():
        # Filtrar las filas del Excel que correspondan al campo en cuestión
        filas_excel = excel_df[excel_df['Campo encontrado'] == campo_excel]

        # Iterar sobre las filas filtradas
        for _, row in filas_excel.iterrows():
            valor_excel = str(row['Valor de campo'])  # Convertir a string
            valor_base = str(df_base[columna_base].iloc[0])  # Convertir a string
            flag = 1 if valor_excel == valor_base else 0

            # Añadir los resultados al dataframe temporal
            resultados.append({
                'codigo_proyecto': project_code,
                'archivo': row['Archivo'],
                'campo_encontrado': campo_excel,
                'valor_excel': valor_excel,
                'valor_base': valor_base,
                'flag': flag
            })

    return pd.DataFrame(resultados)

# Función principal
def main():
    # Variables iniciales
    excel_file = os.path.join(RESULTS_PATH,"informe_result.xlsx")
   

    # Filtrar los registros del Excel para el proyecto especificado
    excel_df = filtrar_excel_por_proyecto(excel_file, project_code)

    diccionarios_comparacion = {
        "memorando": memorando_compare,
        "cantidad_controles": cantidad_controles_compare,
        "calificativo_total": calificativo_total_compare,
        "calificativo_unidad_responsable": calificativo_unidad_responsable_compare
        
    }

    # DataFrames de base de datos (suponiendo que ya los tienes cargados)
    dataframes_base = {
        "memorando": df_memorando,
        "cantidad_controles": df_cantidad_controles,
        "calificativo_total": df_calificativo_total,
        "calificativo_unidad_responsable": df_calificativo_unidad_responsable
        
    }

    # Realizar comparaciones para cada diccionario y DataFrame correspondiente
    resultados_finales = []
    
    for nombre, compare_dict in diccionarios_comparacion.items():
        df_base = dataframes_base[nombre]
        if nombre == "calificativo_unidad_responsable":
            resultados_finales.append(comparar_calificativo_unidad_responsable(excel_df, df_base, compare_dict, project_code))
        else:
            resultados_finales.append(comparar_valores(excel_df, df_base, compare_dict, project_code))
    
    # Concatenar todos los resultados en un solo DataFrame
    resultados_df = pd.concat(resultados_finales, ignore_index=True)

    # Guardar el resultado en un nuevo archivo Excel
    resultados_df.to_csv(os.path.join(RESULTS_PATH,"resultado_comparacion.csv"), index=False)
    print("Comparación completada. Archivo guardado como 'resultado_comparacion.xlsx'.")

# Ejecutar la función principal
if __name__ == "__main__":
    main()