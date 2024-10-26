select 
P.Evaluación [EVALUACION],
P.Codigo [CODIGO],
P.Subgerente_ejecucion [PRODUCT_OWNER],
P.Supervisor_ejecucion [SCRUM_MASTER],
P.Auditor_1_ejecucion [SCRUM_TEAM_1],
P.Auditor_2_ejecucion [SCRUM_TEAM_2],
P.FechaInicioEjecución [FECHA_INICIO],
A.EjecuciónReal [FECHA_BORRADOR],
AA.EjecuciónReal [FECHA_EMISION_INFORME],
P.FechaFinEjecución [FECHA_FIN]


from TG_Proyecto P
left join TG_Proyecto_Actividad_Informe A on P.IdProyecto = A.IdProyecto and A.IdActividad = 16
left join TG_Proyecto_Actividad_Informe AA on P.IdProyecto = AA.IdProyecto and AA.IdActividad = 17
where codigo = '%proyecto_reemplazo%'