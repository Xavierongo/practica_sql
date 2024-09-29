SELECT calls.ivr_id,
      MAX(CASE WHEN step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK' THEN 1 ELSE 0
       END) AS info_by_dni_lg

FROM keepcoding.ivr_calls AS calls
LEFT JOIN keepcoding.ivr_steps AS steps
ON calls.ivr_id = steps.ivr_id
GROUP BY calls.ivr_id;

