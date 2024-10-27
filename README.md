# Automatización de Calidad 🔍

## 📝 Descripción del Proyecto
El siguiente proyecto trata la automatizacion del proceso de calidad mediante scipts en python con tres objetivos principales:
#### 1. Creacion de informes PPTS
#### 2. Extraccion de informacion de informes y correos
#### 3. Comparacion y verificacion de fidelidad de la informacion

## 🧑‍🤝‍🧑 Integrantes del Equipo

Un equipo diverso y apasionado de practicantes del equipo de Analitica e Innovacion en Auditoria. Permítanos presentarnos:

|    Leandro Machaca    |    Diego Andia      | Angel |
| ----------- | ----------- | ----------- |
| ![](https://avatars.githubusercontent.com/u/185544377?v=4) | ![](https://avatars.githubusercontent.com/u/185552755?v=4) | ![](https://avatars.githubusercontent.com/u/185560432?v=4) |
| [github.com/Leandro](https://github.com/ARU182004) | [github.com/Diego](https://github.com/diegoandiapr) | [github.com/Angel](https://github.com/AngelZip7) |


## 📂 Estructura del Repositorio
- 📁 `querys`: En esta carpeta se encuentran laas querys utilizadas para la creacion de informes PPTS y comparacion de informacion.
- 📁 `scripts`: En esta carpeta se encuentran los archivos estáticos del proyecto.
- | 📁 `comparacion`: En esta carpeta se encuentran los scripts necesarios para realizar la comparacion de informacion.
- | 📁 `creacion`: En esta carpeta se encuentran los scripts necesarios para la creacion de informes PPTS.
- 📁 `Utils`: En esta carpeta se encuentra los archivos y funciones utilitarias o auxiliares.
- 📁 `Plantillas_final`: En esta carpeta se encuentran las plantillas de informes PPTS.
- | 📁 `PACIFICO`: En esta carpeta se encuentran las plantillas de informes PPTS de Pacifico Seguros.
- | 📁 `PRIMA_AFP`: En esta carpeta se encuentran las plantillas de informes PPTS de Prima AFP.
- | 📁 `SALUD`: En esta carpeta se encuentran las plantillas de informes PPTS de Pacifico Salud.
- | 📁 `CREDISEGURO`: En esta carpeta se encuentran las plantillas de informes PPTS de Crediseguro.
- 📄 `README.md`: ¡Estás aquí! Este archivo contiene la información esencial que necesitas para comprender el proyecto.

## 🚀 Objetivos del Proyecto
El proyecto se divide en dos partes: 
1. **Creacion Automatica de Informes PPTS** a traves de un chatbot en Microsoft Teams para facilitar el acceso a la informacion 
2. **Extraccion de la informacion de PPTS y correos** para realizar la verificacion de fidelidad de informacion segun ciertas normas. 
Ambas implementaciones son realizadas con python y estan documentadas en este repositorio y ejecutadas en el terminal <6001> de Pacifico Seguros.

## Fuentes de datos

La principal fuente de datos son extraidas mediente querys de la base de datos **PROYECTOSIAV2**, esta informacion contiene la siguiente informacion:

```sql
calificativo_total.sql -> contiene campos como IFC_total, IFC_inherente, cantidad de controles a nivel de proyecto
calificativo_unidad_responsable.sql -> contiene campos como IFC_total, IFC_inherente, cantidad de controles a nivel de unidades responsables involucradas, solo se extraen las que cumplen con el requisito minimo de IFC
cantidad_controles.sql -> contiene el las cantidades de controles segun el riesgo y efectividad
memorando.sql -> contiene informacion basica del proyecto como fechas, equipo, nombre, codigo
observaciones.sql -> contiene todas las observaciones de seguimiento asociadas al proyecto
observaciones_informe.sql -> contiene solo las 3 primeras observaciones por orden de ID
```
## Scripts

### Creacion de Informes PPTS
en el archivo **verificacion.py** se encuentra la funcion principal, esta funcion se ejecuta cada 2 minutos programados desde el Windows Scheduler. En esta funcion ser verifica la existencia de el siguiente archivo: 
```python
file_path = os.path.join(EXCEL_PATH, "base_creacion_ppts.xlsx") # archivo base
file_path_v2 = os.path.join(EXCEL_PATH, "base_creacion_ppts_2.xlsx") # archivo a verificar
```
Si es que existe el achivo  **base_creacion_ppts_2.xlsx** se extrae la los datos de la ultima fila de la tabla que hay en este archivo, ya que este es el ultimo registro -  pedido de creacion de infrome desde el chatbot. Una vez se tengga esa informacion, se elimina el archivo y se pricede a la creacion segun el tipo de informe y negocio al que pertenece el proyecto.

```python
elif tipo == 'Observaciones Final' or tipo == 'Observaciones Borrador':
        df_datos = obtenerDatosDe('Observaciones')
        output_path = os.path.join(RESULTS_PATH, "observaciones_modificado.pptx")
        create_observaciones_ppt(tipo,negocio,codigo,df_datos, output_path)
```
Por ejemplo para el Informe de Observaciones final, se requiere consultar a la base de datos usando la query de **Observaciones.sql** guardandolo en un dataframe y luego se llama a la funcion de creacion.

### Logica de asignacion de informacion

Es importante entender la la logica de como se rellena la informacion extraida de la base de datos en las plantillas de cada informe. Para ello es improtante conocer 3 puntos importantes:
#### 1. Listas de diccionarios
En el archivo **params.py** estan definidas las rutas de exportacion, conexxiones a base de datos y las listas de diccioanrios por cada query, por ejemplo:

```python
cantidad_controles_list = [
    {},
    {},
        {
            "E_c":"EFECTIVOS_CRITICO","E_a":"EFECTIVOS_ALTO","E_r": "EFECTIVOS_RELEVANTE", "E_m": "EFECTIVOS_MODERADO","E_b":"EFECTIVOS_BAJO","T_efec":"EFECTIVOS_TOTAL",
            "Enf_c":"EFECTIVO_NO_FORMALIZADO_CRITICO","Enf_a":"EFECTIVO_NO_FORMALIZADO_ALTO","Enf_r": "EFECTIVO_NO_FORMALIZADO_RELEVANTE", "Enf_m": "EFECTIVO_NO_FORMALIZADO_MODERADO","Enf_b":"EFECTIVO_NO_FORMALIZADO_BAJO","T_efe_n":"EFECTIVO_NO_FORMALIZADO_TOTAL",
            "Ip_c":"INEFECTIVO_PRUEBA_CRITICO","Ip_a":"INEFECTIVO_PRUEBA_ALTO","Ip_r": "INEFECTIVO_PRUEBA_RELEVANTE", "Ip_m": "INEFECTIVO_PRUEBA_MODERADO","Ip_b":"INEFECTIVO_PRUEBA_BAJO","T_inef_p":"INEFECTIVO_PRUEBA_TOTAL",
            "Id_c":"INEFECTIVO_DISEÑO_CRITICO","Id_a":"INEFECTIVO_DISEÑO_ALTO","Id_r": "INEFECTIVO_DISEÑO_RELEVANTE", "Id_m": "INEFECTIVO_DISEÑO_MODERADO","Id_b":"INEFECTIVO_DISEÑO_BAJO","T_inef_d":"INEFECTIVO_DISEÑO_TOTAL",
            "Ci_c":"CONTROL_INEXISTENTE_CRITICO","Ci_a":"CONTROL_INEXISTENTE_ALTO","Ci_r": "CONTROL_INEXISTENTE_RELEVANTE", "Ci_m": "CONTROL_INEXISTENTE_MODERADO","Ci_b":"CONTROL_INEXISTENTE_BAJO","T_inex":"CONTROL_INEXISTENTE_TOTAL",
            "T_critico":"CONTROL_CRITICO_TOTAL","T_alto":"CONTROL_ALTO_TOTAL","T_relevante": "CONTROL_RELEVANTE_TOTAL", "T_mode": "CONTROL_MODERADO_TOTAL","T_bajo":"CONTROL_BAJO_TOTAL","T_contr":"TOTAL_CONTROLES"
        }  
    ]
```
Se tiene una lista para la query de **cantidad_controles.sql** donde se tiene
* **Indice del diccionario (pisicion en la lista)** -> numero de slide en la que se debe completar la informacion de ese diccionario
* **Llave (key) en cada diccionario** -> nombre del valor a reemplazar en la plantillas, puede esatr en un cuadro de texto o tabla
* **valor (value) en cada diccionario** -> nombre de la columna del dataframe que corresponde a esa query


### Funciones de creacion











