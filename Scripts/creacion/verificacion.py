import os
import time
from pptx import Presentation
from params import *
from functions import *
from creaciones import *

def main():
    file_path = os.path.join(EXCEL_PATH, "base_creacion_ppts.xlsx")
    file_path_v2 = os.path.join(EXCEL_PATH, "base_creacion_ppts_2.xlsx")
    
    
    try:
        if os.path.exists(file_path_v2):
            
            
            print("aruuuu")
            df_datos = pd.DataFrame()
            df_calificativo_total = pd.DataFrame()
            df_calificativo_unidad_responsable = pd.DataFrame()
            df_cantidad_controles = pd.DataFrame()
            df_observaciones_informe = pd.DataFrame()
            time.sleep(5)
            tipo,negocio = obtener_tipo_de_Excel(file_path)
            codigo = obtener_codigo_de_Excel(file_path)

            if tipo == 'Memorando':
                df_datos = obtenerDatosDe("memorando")
                output_path = os.path.join(RESULTS_PATH, "memorandom_modificado.pptx")
                create_memorando(tipo,negocio,codigo,df_datos, output_path)

            elif tipo == 'Informe Final' or tipo == 'Informe Borrador':

                df_datos = obtenerDatosDe("memorando")
                df_calificativo_total = obtenerDatosDe("calificativo_total")
                df_calificativo_unidad_responsable = obtenerDatosDe("calificativo_unidad_responsable")
                df_cantidad_controles=obtenerDatosDe("cantidad_controles")
                df_observaciones_informe = obtenerDatosDe("observaciones_informe")

                output_path = os.path.join(RESULTS_PATH, "informe_modificado.pptx")
                create_informe_ppt(tipo,negocio,codigo,df_datos,df_calificativo_total,df_calificativo_unidad_responsable,df_cantidad_controles,df_observaciones_informe, output_path)

            elif tipo == 'Observaciones Final' or tipo == 'Observaciones Borrador':

                df_datos = obtenerDatosDe('Observaciones')
                output_path = os.path.join(RESULTS_PATH, "observaciones_modificado.pptx")
                create_observaciones_ppt(tipo,negocio,codigo,df_datos, output_path)
            else:
                print("no se encontro tipo")

            os.remove(file_path_v2)
        
            
        else:
            print("base_creacion_ppts_2 no existe.")
            
        time.sleep(30)
    
    except Exception as e:
        print(f"Error: {e}")
        time.sleep(30)

if __name__ == "__main__":
    main()