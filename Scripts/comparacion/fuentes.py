from functions import *

project_code = "PS - PRO - 003 - 2024"
df_calificativo_total = obtenerDatosDe("calificativo_total",project_code)
df_calificativo_unidad_responsable = obtenerDatosDe("calificativo_unidad_responsable",project_code)
df_cantidad_controles=obtenerDatosDe("cantidad_controles",project_code)
df_observaciones_informe = obtenerDatosDe("observaciones_informe",project_code)
df_memorando = obtenerDatosDe("memorando",project_code)


#observaciones
df_slide_1_observaciones = obtenerDatosDe("memorando",project_code)
df_observaciones = obtenerDatosDe('Observaciones',project_code)