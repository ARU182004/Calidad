select  CAST(ISNULL(SUM(CONVERT(FLOAT,  Puntuación)), 0) AS numeric(20, 0)) AS [IFC_RESIDUAL],   
CAST(ISNULL(SUM(CONVERT(FLOAT, [IFC (en US$ miles)])), 0) AS numeric(20, 0)) AS [IFC_INHERENTE],
count([Unidad Responsable del Control]) [CONTROLES],
CASE 
        WHEN CAST(ISNULL(SUM(CONVERT(FLOAT, [IFC (en US$ miles)])), 0) AS numeric(20, 2)) = 0 THEN NULL
        ELSE convert(varchar,cast(round(CAST(ISNULL(SUM(CONVERT(FLOAT, Puntuación)), 0) AS numeric(20, 2)) / CAST(ISNULL(SUM(CONVERT(FLOAT, [IFC (en US$ miles)])), 0) AS numeric(20, 2))*100,2) AS numeric(20, 2)))+'%'
    END AS [PORCENTAJE_CALIFICATIVO],
    CASE 
        WHEN CAST(ISNULL(SUM(CONVERT(FLOAT, [IFC (en US$ miles)])), 0) AS numeric(20, 2)) = 0 THEN NULL
        WHEN CAST(ISNULL(SUM(CONVERT(FLOAT, Puntuación)), 0) AS numeric(20, 2)) / CAST(ISNULL(SUM(CONVERT(FLOAT, [IFC (en US$ miles)])), 0) AS numeric(20, 2)) >= 0.85 THEN 'Satisfactorio'
        WHEN CAST(ISNULL(SUM(CONVERT(FLOAT, Puntuación)), 0) AS numeric(20, 2)) / CAST(ISNULL(SUM(CONVERT(FLOAT, [IFC (en US$ miles)])), 0) AS numeric(20, 2)) >= 0.70 THEN 'Aceptable'
        WHEN CAST(ISNULL(SUM(CONVERT(FLOAT, Puntuación)), 0) AS numeric(20, 2)) / CAST(ISNULL(SUM(CONVERT(FLOAT, [IFC (en US$ miles)])), 0) AS numeric(20, 2)) >= 0.55 THEN 'Regular'
        WHEN CAST(ISNULL(SUM(CONVERT(FLOAT, Puntuación)), 0) AS numeric(20, 2)) / CAST(ISNULL(SUM(CONVERT(FLOAT, [IFC (en US$ miles)])), 0) AS numeric(20, 2)) < 0.55 THEN 'Deficiente'
        ELSE ''
    END AS [CALIFICATIVO]
from TG_TMP 

where Referencia_del_Proceso = REPLACE('%proyecto_reemplazo%', ' ', '')

group by [Referencia_del_Proceso]