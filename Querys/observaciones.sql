SELECT 
O.PROYECTO [PROYECTO],
O.[TITULO OBSERVACION] [TITULO], 
O.OBSERVACION [OBSERVACION],
O.RECOMENDACION [RECOMENDACION],
O.[PRIMERA RESPUESTA] [PLAN],
O.[UNIDAD RESPONSABLE] [UNIDAD_RESPONSABLE],
O.PROPIETARIO [PROPIETARIO],
O.[FECHA DE VENCIMIENTO] [FECHA],
SI.Estado [ESTADO]
from TG_Observacion O
LEFT JOIN (SELECT ID , IssueID FROM  TeamMateR12.dbo.TM_Recommendation WHERE StatusLID IN (2,3,13,9,10,11,12) AND TrackFlag = 1) RE ON 'PS-' + CONVERT(VARCHAR,RE.ID) = O.Identificador
	LEFT JOIN (SELECT ID, IssueID FROM  TeamMate_Prima.dbo.TM_Recommendation WHERE StatusLID IN (2,3,13,9,10,11,12) AND TrackFlag = 1) REP ON 'PRI-' + CONVERT(VARCHAR,REP.ID) = O.Identificador
	LEFT JOIN (
		SELECT RA.RecommendationID, MAX(RA.ID) ID FROM TeamMateR12.dbo.TM_RecommendationAction RA 
		 GROUP BY RA.RecommendationID
	) RA1 ON 'PS-' + CONVERT(VARCHAR,RA1.RecommendationID) = O.Identificador

	LEFT JOIN (
		SELECT RAP.RecommendationID, MAX(RAP.ID) ID FROM TeamMate_Prima.dbo.TM_RecommendationAction RAP 
		 GROUP BY RAP.RecommendationID
	) RA1P ON 'PRI-' + CONVERT(VARCHAR,RA1P.RecommendationID) = O.Identificador
LEFT JOIN (SELECT ID , StatusLID , RecommendationID FROM TeamMateR12.dbo.TM_RecommendationAction )RA2 ON 'PS-' + CONVERT(VARCHAR,RA2.RecommendationID) = O.Identificador AND RA2.ID = RA1.ID 
LEFT JOIN (SELECT ID , StatusLID , RecommendationID FROM TeamMate_Prima.dbo.TM_RecommendationAction ) RA2P ON 'PRI-' + CONVERT(VARCHAR,RA2P.RecommendationID) = O.Identificador AND RA2P.ID = RA1P.ID 
LEFT JOIN TG_Situacion SI ON SI.ID = RA2.StatusLID OR SI.ID = RA2P.StatusLID
where PROYECTO ='%proyecto_reemplazo%'