SELECT TOP 3 [TITULO OBSERVACION] AS [TITULO_OBSERVACION], RIESGO AS [RIESGO]
FROM TG_Observacion 
WHERE PROYECTO = '%proyecto_reemplazo%'