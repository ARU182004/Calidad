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
1. **Creacion Automatica de Informes PPTS** a traves de un chatbot en Microsoft Teams para facilitar el acceso a la informacion, posibilidad de crear los sigueintes tipos de informes:
   * Sprint Planning (Memorando)
   * Informe borrador de Observaciones
   * Informe Final de Observaciones
   * Informe Borrador
   * Informe Final
     
3. **Extraccion de la informacion de PPTS y correos** para realizar la verificacion de fidelidad de informacion segun ciertas normas. 
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
Estos son las funciones que se usan para la extranccion de datos de la base **PROYECTOSIAV2**
```python
## Conexión al TIGA
cnxn_TIGA = pyodbc.connect(CNXN_TIGA)
print("Conectando a la base de datos... ")
cnxn = pyodbc.connect(CNXN_TIGA)
cursor = cnxn.cursor()
print("Conectado.")
cursor.execute('SET LANGUAGE SPANISH')
cursor.commit()

def obtenerDatosDe(nombre_query : str) -> pd.DataFrame:
    print(f"Extrayendo datos de {nombre_query}...")
    sql = reemplazarVariablesQueries(open(os.path.join(QUERIES_PATH, f'{nombre_query}.sql'), 'r', encoding='utf-8-sig').read())
    cursor.execute(sql)
    dataframe_resultante = pd.DataFrame.from_records(cursor.fetchall(), columns=[col[0] for col in cursor.description]).drop_duplicates()
    print("Se extrajeron " + str(len(dataframe_resultante.index)) + " filas y " + str(len(dataframe_resultante.columns)) + " columnas de " + nombre_query + ".")
    return dataframe_resultante
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

#### 2. Plantillas de PPTS
Contamos con plantillas para los diferentes tipos de informe como Sprint Planning (Memorando), Informe de Observaciones, Informes borrador y final, etc. Ademas, estas estan organizdas por negocio ya que las plantillas llevan una marca de agua alusivo al negocio.
##### **OJO** 
Para los ppts de observaciones se tiene una plantilla segun la cantidad de observaciones, es decir par ala plantilla **"plantilla_observaciones_8.pptx"** quiere decir que tiene espacio para 8 observaciones ya que en cada slide va una observacion. Por otro lado en cada ppt y cada slide hay cuadros de texto con informacion que sera reemplazada con el valor obtenido de la base de datos segun la logica de las listas de diccionarios.


### Funciones de creacion

#### Sprint Planning

Todas las funciones tienen la misma estructura, primero definen varibles para construir el path donde se va exportar el ppt modificado y luego comienza con la logica de llenado haciendo uso de la lisat de diccionario que se necesita, es posible que en un ppt se necesiten  una o mas listas de diccioanrios.
```python
def create_memorando(tipo,negocio,codigo,df, output_path):
    if negocio == 'SEGUROS':
        ppt_template_path = os.path.join(PLANTILLAS_PS_PATH, "07. Sprint Planning.pptx")
    elif negocio == 'PRIMA':
        ppt_template_path = os.path.join(PLANTILLAS_PRI_PATH, "07. Sprint Planning.pptx")   
    elif negocio == 'SALUD':
        ppt_template_path = os.path.join(PLANTILLAS_EPS_PATH, "07. Sprint Planning.pptx")
    elif negocio == 'CREDISEGUROS':
        ppt_template_path = os.path.join(PLANTILLAS_CRE_PATH, "07. Sprint Planning.pptx")
    else:
        ppt_template_path = os.path.join(PLANTILLAS_PS_PATH, "07. Sprint Planning.pptx")
```
Se realizan verificaciones de cantidad de slides y luego se recorre cada slide, en cada slide se debe identificar cada cuadro de texto y en cada cuadr de texto se identifica el texto que se debe reemplazar, si se encuentra en el diccioanrio entonces recorro el dataframe y reemplazo con la informacion del data frame, en este caso solo se realiza la verificacion de cuadros de texto.

```python
try:
        ppt = Presentation(ppt_template_path)
    except Exception as e:
        print(f"Error al abrir el archivo PPT: {e}")
        return

    for slide_num, slide_data in enumerate(memorando_list, start=1):
        if slide_num > len(ppt.slides):
            print(f"No hay suficiente cantidad de slides en la presentación para el diccionario número {slide_num}")
            break
        slide = ppt.slides[slide_num - 1]
        print(f"Diapositiva número: {slide_num}")

        for shape in slide.shapes:
            if shape.has_text_frame:
                for paragraph in shape.text_frame.paragraphs:
                    for run in paragraph.runs:
                        for key, column_name in slide_data.items():
                            if run.text == key:
                                run.text = str(df[column_name].iloc[0])

    try:
        final_path = obtenerpath(tipo,negocio,codigo)
        ppt.save(final_path)
        print(f"PPT guardado en {final_path}")
    except Exception as e:
        print(f"Error al guardar el archivo PPT: {e}")
```
#### Observaciones Borrador y Final
En el caso de los PPTS de Observaciones las estructuras de cada slide es la misma y se reemplaza con la informacion de cada observacion, por lo que en cada slide recorro los cuadros de texto, parrafos y tablas:
##### Cuadros de texto:

```python
for index, row in enumerate(df.itertuples(index=False)):
        slide = ppt.slides[index + 1]  
        for shape in slide.shapes:
            if shape.has_text_frame:
                for paragraph in shape.text_frame.paragraphs:
                    for run in paragraph.runs:
                        for key, column_name in observaciones_list[0].items():
                            if key in run.text:
                                if key == 'Unidad_auditada_n':
                                    run.text = run.text.replace(key, str(getattr(row, column_name)))
                                else:
                                    run.text = run.text.replace(key, str(getattr(row, column_name)))
                                    run.font.size = font_size_observaciones
```

##### Parrafos:

```python
first_slide = ppt.slides[0]
    for shape in first_slide.shapes:
        if shape.has_text_frame:
            for paragraph in shape.text_frame.paragraphs:
                for run in paragraph.runs:
                    for key, value in primera_slide_dict.items():
                        if key in run.text:
                            run.text = run.text.replace(key, str(value))
```
##### Tablas:

```python
for shape in slide.shapes:
            if shape.has_table:
                table = shape.table
                for cell in table.iter_cells():
                    for key, column_name in observaciones_list[0].items():
                        if key in cell.text:
                            cell.text = cell.text.replace(key, str(getattr(row, column_name)))
                            for paragraph in cell.text_frame.paragraphs:
                                for run in paragraph.runs:
                                    run.font.size = font_size_observaciones
```
#### Informe Borrador y final

En este caso se usan varias listas de diccionarios para rellenar los slides con informacion:


```python
listas_diccionarios = [
        (calificativo_total_list, df_calificativo_total),
        (calificativo_unidad_responsable_list, df_calificativo_unidad_responsable),
        (cantidad_controles_list, df_cantidad_controles),
        (observaciones_informe_list, df_observaciones_informe),
        (memorando_list, df_datos)
    ]
```

Se recorre cada lista de diccionario para llenar la informacion verificando cuadros de texto y tablas:

```python
for lista_dicc, df in listas_diccionarios:
        for slide_num, slide_data in enumerate(lista_dicc):
            if slide_num >= len(ppt.slides):
                break
            slide = ppt.slides[slide_num]

            
            font_size = font_size_first_slide if slide_num == 0 else font_size_other_slides

            
            for shape in slide.shapes:
                if shape.has_text_frame:
                    for paragraph in shape.text_frame.paragraphs:
                        for run in paragraph.runs:
                            # logica continua...
            
            for shape in slide.shapes:
                if shape.has_table:
                    table = shape.table
                    for cell in table.iter_cells():
                        # logica continua...

```

### Funciones auxiliares

#### Funciones para extraer el ultimo registro del excel temporal, extraemos el codigo del proyecto, el tipo de informe y negocio del proyecto


```python
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

```
#### Funcion para construir el path donde se exportara el PPT, el path se crea apartir del Negocio, el codigo del proyecto y el tipo del informe.
```python
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

```




















