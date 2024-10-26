SELECT  
    CAST(ISNULL(SUM(CONVERT(FLOAT, Puntuación)), 0) AS numeric(20, 2)) AS [IFC_RESIDUAL],   
    CAST(ISNULL(SUM(CONVERT(FLOAT, [IFC (en US$ miles)])), 0) AS numeric(20, 2)) AS [IFC_INHERENTE],
    COUNT([Unidad Responsable del Control]) [CONTROLES],
    [Unidad Responsable del Control] [UNIDAD_RESPONSABLE],
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
FROM TG_TMP 
WHERE Referencia_del_Proceso = REPLACE('%proyecto_reemplazo%', ' ', '')
GROUP BY [Unidad Responsable del Control]
HAVING CAST(ISNULL(SUM(CONVERT(FLOAT, [IFC (en US$ miles)])), 0) AS numeric(20, 2)) >= 324 
AND COUNT([Unidad Responsable del Control]) >= 7