
SELECT 
	 A.CODIGO,
	 cast(A.Evaluación as varchar(255))PROYECTOS, 
	 
	 
    CASE WHEN SUM(D.EFECTIVOS_TOTAL) = 0 THEN '-' ELSE CAST(SUM(D.EFECTIVOS_TOTAL) AS VARCHAR) END AS [EFECTIVOS_TOTAL],
    CASE WHEN SUM(D.EFECTIVOS_CRITICO) = 0 THEN '-' ELSE CAST(SUM(D.EFECTIVOS_CRITICO) AS VARCHAR) END AS [EFECTIVOS_CRITICO],
    CASE WHEN SUM(D.EFECTIVOS_MODERADO) = 0 THEN '-' ELSE CAST(SUM(D.EFECTIVOS_MODERADO) AS VARCHAR) END AS [EFECTIVOS_MODERADO],
    CASE WHEN SUM(D.EFECTIVOS_ALTO) = 0 THEN '-' ELSE CAST(SUM(D.EFECTIVOS_ALTO) AS VARCHAR) END AS [EFECTIVOS_ALTO],
    CASE WHEN SUM(D.EFECTIVOS_BAJO) = 0 THEN '-' ELSE CAST(SUM(D.EFECTIVOS_BAJO) AS VARCHAR) END AS [EFECTIVOS_BAJO],
    CASE WHEN SUM(D.EFECTIVOS_RELEVANTE) = 0 THEN '-' ELSE CAST(SUM(D.EFECTIVOS_RELEVANTE) AS VARCHAR) END AS [EFECTIVOS_RELEVANTE],

    CASE WHEN SUM(D.[EFECTIVO NO FORMALIZADO_TOTAL]) = 0 THEN '-' ELSE CAST(SUM(D.[EFECTIVO NO FORMALIZADO_TOTAL]) AS VARCHAR) END AS [EFECTIVO_NO_FORMALIZADO_TOTAL],
    CASE WHEN SUM(D.[EFECTIVO NO FORMALIZADO_CRITICO]) = 0 THEN '-' ELSE CAST(SUM(D.[EFECTIVO NO FORMALIZADO_CRITICO]) AS VARCHAR) END AS [EFECTIVO_NO_FORMALIZADO_CRITICO],
    CASE WHEN SUM(D.[EFECTIVO NO FORMALIZADO_MODERADO]) = 0 THEN '-' ELSE CAST(SUM(D.[EFECTIVO NO FORMALIZADO_MODERADO]) AS VARCHAR) END AS [EFECTIVO_NO_FORMALIZADO_MODERADO],
    CASE WHEN SUM(D.[EFECTIVO NO FORMALIZADO_ALTO]) = 0 THEN '-' ELSE CAST(SUM(D.[EFECTIVO NO FORMALIZADO_ALTO]) AS VARCHAR) END AS [EFECTIVO_NO_FORMALIZADO_ALTO],
    CASE WHEN SUM(D.[EFECTIVO NO FORMALIZADO_BAJO]) = 0 THEN '-' ELSE CAST(SUM(D.[EFECTIVO NO FORMALIZADO_BAJO]) AS VARCHAR) END AS [EFECTIVO_NO_FORMALIZADO_BAJO],
    CASE WHEN SUM(D.[EFECTIVO NO FORMALIZADO_RELEVANTE]) = 0 THEN '-' ELSE CAST(SUM(D.[EFECTIVO NO FORMALIZADO_RELEVANTE]) AS VARCHAR) END AS [EFECTIVO_NO_FORMALIZADO_RELEVANTE],

    CASE WHEN SUM(D.[INEFECTIVO PRUEBA_TOTAL]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO PRUEBA_TOTAL]) AS VARCHAR) END AS [INEFECTIVO_PRUEBA_TOTAL],
    CASE WHEN SUM(D.[INEFECTIVO PRUEBA_CRITICO]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO PRUEBA_CRITICO]) AS VARCHAR) END AS [INEFECTIVO_PRUEBA_CRITICO],
    CASE WHEN SUM(D.[INEFECTIVO PRUEBA_MODERADO]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO PRUEBA_MODERADO]) AS VARCHAR) END AS [INEFECTIVO_PRUEBA_MODERADO],
    CASE WHEN SUM(D.[INEFECTIVO PRUEBA_ALTO]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO PRUEBA_ALTO]) AS VARCHAR) END AS [INEFECTIVO_PRUEBA_ALTO],
    CASE WHEN SUM(D.[INEFECTIVO PRUEBA_BAJO]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO PRUEBA_BAJO]) AS VARCHAR) END AS [INEFECTIVO_PRUEBA_BAJO],
    CASE WHEN SUM(D.[INEFECTIVO PRUEBA_RELEVANTE]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO PRUEBA_RELEVANTE]) AS VARCHAR) END AS [INEFECTIVO_PRUEBA_RELEVANTE],

    CASE WHEN SUM(D.[INEFECTIVO DISEÑO_TOTAL]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO DISEÑO_TOTAL]) AS VARCHAR) END AS [INEFECTIVO_DISEÑO_TOTAL],
    CASE WHEN SUM(D.[INEFECTIVO DISEÑO_CRITICO]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO DISEÑO_CRITICO]) AS VARCHAR) END AS [INEFECTIVO_DISEÑO_CRITICO],
    CASE WHEN SUM(D.[INEFECTIVO DISEÑO_MODERADO]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO DISEÑO_MODERADO]) AS VARCHAR) END AS [INEFECTIVO_DISEÑO_MODERADO],
    CASE WHEN SUM(D.[INEFECTIVO DISEÑO_ALTO]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO DISEÑO_ALTO]) AS VARCHAR) END AS [INEFECTIVO_DISEÑO_ALTO],
    CASE WHEN SUM(D.[INEFECTIVO DISEÑO_BAJO]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO DISEÑO_BAJO]) AS VARCHAR) END AS [INEFECTIVO_DISEÑO_BAJO],
    CASE WHEN SUM(D.[INEFECTIVO DISEÑO_RELEVANTE]) = 0 THEN '-' ELSE CAST(SUM(D.[INEFECTIVO DISEÑO_RELEVANTE]) AS VARCHAR) END AS [INEFECTIVO_DISEÑO_RELEVANTE],

    CASE WHEN SUM(D.[CONTROL INEXISTENTE_TOTAL]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL INEXISTENTE_TOTAL]) AS VARCHAR) END AS [CONTROL_INEXISTENTE_TOTAL],
    CASE WHEN SUM(D.[CONTROL INEXISTENTE_CRITICO]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL INEXISTENTE_CRITICO]) AS VARCHAR) END AS [CONTROL_INEXISTENTE_CRITICO],
    CASE WHEN SUM(D.[CONTROL INEXISTENTE_MODERADO]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL INEXISTENTE_MODERADO]) AS VARCHAR) END AS [CONTROL_INEXISTENTE_MODERADO],
    CASE WHEN SUM(D.[CONTROL INEXISTENTE_ALTO]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL INEXISTENTE_ALTO]) AS VARCHAR) END AS [CONTROL_INEXISTENTE_ALTO],
    CASE WHEN SUM(D.[CONTROL INEXISTENTE_BAJO]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL INEXISTENTE_BAJO]) AS VARCHAR) END AS [CONTROL_INEXISTENTE_BAJO],
    CASE WHEN SUM(D.[CONTROL INEXISTENTE_RELEVANTE]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL INEXISTENTE_RELEVANTE]) AS VARCHAR) END AS [CONTROL_INEXISTENTE_RELEVANTE],

    CASE WHEN SUM(D.[CONTROL CRITICO]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL CRITICO]) AS VARCHAR) END AS [CONTROL_CRITICO_TOTAL],
    CASE WHEN SUM(D.[CONTROL MODERADO]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL MODERADO]) AS VARCHAR) END AS [CONTROL_MODERADO_TOTAL],
    CASE WHEN SUM(D.[CONTROL BAJO]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL BAJO]) AS VARCHAR) END AS [CONTROL_BAJO_TOTAL],
    CASE WHEN SUM(D.[CONTROL RELEVANTE]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL RELEVANTE]) AS VARCHAR) END AS [CONTROL_RELEVANTE_TOTAL],
    CASE WHEN SUM(D.[CONTROL ALTO]) = 0 THEN '-' ELSE CAST(SUM(D.[CONTROL ALTO]) AS VARCHAR) END AS [CONTROL_ALTO_TOTAL],

    CASE WHEN ( SUM(D.EFECTIVOS_TOTAL)+SUM(D.[EFECTIVO NO FORMALIZADO_TOTAL])+SUM(D.[INEFECTIVO PRUEBA_TOTAL])+SUM(D.[INEFECTIVO DISEÑO_TOTAL])+SUM(D.[CONTROL INEXISTENTE_TOTAL]) ) = 0 THEN '-' ELSE CAST(( SUM(D.EFECTIVOS_TOTAL)+SUM(D.[EFECTIVO NO FORMALIZADO_TOTAL])+SUM(D.[INEFECTIVO PRUEBA_TOTAL])+SUM(D.[INEFECTIVO DISEÑO_TOTAL])+SUM(D.[CONTROL INEXISTENTE_TOTAL]) ) AS VARCHAR) END AS [TOTAL_CONTROLES],
	 CASE
		WHEN A.Compañia = 'CRS' THEN 'Crediseguro'
		WHEN A.Compañia = 'PS' THEN 'Pacifico Seguros'
		WHEN A.Compañia = 'AIP' THEN 'Prima'
		ELSE 'Pacifico Salud'
	 END AS NEGOCIO	
	
FROM (
	 SELECT  
	  C.Referencia_del_Proceso, 
	  (CASE WHEN [Ponderado del Control] = 1 THEN 1 ELSE 0 END)EFECTIVOS_TOTAL,
	  (CASE WHEN [Ponderado del Control] = 1 AND  IFC2 = 'Critico' THEN 1 ELSE 0 END)EFECTIVOS_CRITICO,
	  (CASE WHEN [Ponderado del Control] = 1 AND  IFC2 = 'Moderado' THEN 1 ELSE 0 END)EFECTIVOS_MODERADO,
	  (CASE WHEN [Ponderado del Control] = 1 AND  IFC2 = 'Alto' THEN 1 ELSE 0 END)EFECTIVOS_ALTO,
	  (CASE WHEN [Ponderado del Control] = 1 AND  IFC2 = 'Bajo' THEN 1 ELSE 0 END)EFECTIVOS_BAJO,
	  (CASE WHEN [Ponderado del Control] = 1 AND  IFC2 = 'Relevante' THEN 1 ELSE 0 END)EFECTIVOS_RELEVANTE,

	  
	  (CASE WHEN [Ponderado del Control] = 2 THEN 1 ELSE 0 END)[EFECTIVO NO FORMALIZADO_TOTAL], 
	  (CASE WHEN [Ponderado del Control] = 2 AND  IFC2 = 'Critico' THEN 1 ELSE 0 END)[EFECTIVO NO FORMALIZADO_CRITICO],
	  (CASE WHEN [Ponderado del Control] = 2 AND  IFC2 = 'Moderado' THEN 1 ELSE 0 END)[EFECTIVO NO FORMALIZADO_MODERADO],
	  (CASE WHEN [Ponderado del Control] = 2 AND  IFC2 = 'Alto' THEN 1 ELSE 0 END)[EFECTIVO NO FORMALIZADO_ALTO],
	  (CASE WHEN [Ponderado del Control] = 2 AND  IFC2 = 'Bajo' THEN 1 ELSE 0 END)[EFECTIVO NO FORMALIZADO_BAJO],
	  (CASE WHEN [Ponderado del Control] = 2 AND  IFC2 = 'Relevante' THEN 1 ELSE 0 END)[EFECTIVO NO FORMALIZADO_RELEVANTE],
	

	  (CASE WHEN [Ponderado del Control] = 3 THEN 1 ELSE 0 END)[INEFECTIVO PRUEBA_TOTAL], 
	  (CASE WHEN [Ponderado del Control] = 3 AND  IFC2 = 'Critico' THEN 1 ELSE 0 END)[INEFECTIVO PRUEBA_CRITICO],
	  (CASE WHEN [Ponderado del Control] = 3 AND  IFC2 = 'Moderado' THEN 1 ELSE 0 END)[INEFECTIVO PRUEBA_MODERADO],
	  (CASE WHEN [Ponderado del Control] = 3 AND  IFC2 = 'Alto' THEN 1 ELSE 0 END)[INEFECTIVO PRUEBA_ALTO],
	  (CASE WHEN [Ponderado del Control] = 3 AND  IFC2 = 'Bajo' THEN 1 ELSE 0 END)[INEFECTIVO PRUEBA_BAJO],
	  (CASE WHEN [Ponderado del Control] = 3 AND  IFC2 = 'Relevante' THEN 1 ELSE 0 END)[INEFECTIVO PRUEBA_RELEVANTE],


	  (CASE WHEN [Ponderado del Control] = 4 THEN 1 ELSE 0 END)[INEFECTIVO DISEÑO_TOTAL],
	  (CASE WHEN [Ponderado del Control] = 4  AND  IFC2 = 'Critico' THEN 1 ELSE 0 END)[INEFECTIVO DISEÑO_CRITICO],
	  (CASE WHEN [Ponderado del Control] = 4  AND  IFC2 = 'Moderado' THEN 1 ELSE 0 END)[INEFECTIVO DISEÑO_MODERADO],
	  (CASE WHEN [Ponderado del Control] = 4  AND  IFC2 = 'Alto' THEN 1 ELSE 0 END)[INEFECTIVO DISEÑO_ALTO],
	  (CASE WHEN [Ponderado del Control] = 4  AND  IFC2 = 'Bajo' THEN 1 ELSE 0 END)[INEFECTIVO DISEÑO_BAJO],
	  (CASE WHEN [Ponderado del Control] = 4  AND  IFC2 = 'Relevante' THEN 1 ELSE 0 END)[INEFECTIVO DISEÑO_RELEVANTE],
	  
	  (CASE WHEN [Ponderado del Control] = 5 THEN 1 ELSE 0 END)[CONTROL INEXISTENTE_TOTAL],
	  (CASE WHEN [Ponderado del Control] = 5  AND  IFC2 = 'Critico' THEN 1 ELSE 0 END)[CONTROL INEXISTENTE_CRITICO],
	  (CASE WHEN [Ponderado del Control] = 5  AND  IFC2 = 'Moderado' THEN 1 ELSE 0 END)[CONTROL INEXISTENTE_MODERADO],
	  (CASE WHEN [Ponderado del Control] = 5  AND  IFC2 = 'Alto' THEN 1 ELSE 0 END)[CONTROL INEXISTENTE_ALTO],
	  (CASE WHEN [Ponderado del Control] = 5  AND  IFC2 = 'Bajo' THEN 1 ELSE 0 END)[CONTROL INEXISTENTE_BAJO],
	  (CASE WHEN [Ponderado del Control] = 5  AND  IFC2 = 'Relevante' THEN 1 ELSE 0 END)[CONTROL INEXISTENTE_RELEVANTE],

	  (CASE WHEN IFC2 = 'Critico' THEN 1 ELSE 0 END)[CONTROL CRITICO],
	  (CASE WHEN IFC2 = 'Moderado' THEN 1 ELSE 0 END)[CONTROL MODERADO],
	  (CASE WHEN IFC2 = 'Alto' THEN 1 ELSE 0 END)[CONTROL ALTO],
	  (CASE WHEN IFC2 = 'Bajo' THEN 1 ELSE 0 END)[CONTROL BAJO],
	  (CASE WHEN IFC2 = 'Relevante' THEN 1 ELSE 0 END)[CONTROL RELEVANTE]
	  
	 FROM TG_TMP C) D
  FULL JOIN TG_Proyecto A  
		

	 ON REPLACE(A.CODIGO,' ','') = D.Referencia_del_Proceso 
  INNER JOIN DPA_Plan_Anual DPA on DPA.ID_Plan_Anual = A.IdPlanAnual 
  LEFT JOIN TG_RiesgoBCP RB ON RB.IDTipo = A.IDRiesgoBCP
 
  WHERE dpa.Anio_Plan IN (2021, 2022, 2023 , 2024) and  A.CODIGO = '%proyecto_reemplazo%'
  GROUP BY DPA.Anio_Plan, A.CODIGO, A.Tipo,A.Evaluación,A.Riesgo,A.Auditor_1_plan,A.Compañia, A.[Plan], 
   isnull(RB.Nombre,'')
  ORDER BY CODIGO