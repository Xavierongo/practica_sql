SELECT  calls.ivr_id,
        
            MAX(CASE WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_result = 'OK' THEN 1
            ELSE 0
            END )AS info_by_phone_lg
        --step_name,
        --step_result
FROM keepcoding.ivr_calls AS calls
LEFT JOIN keepcoding.ivr_steps AS steps
ON calls.ivr_id = steps.ivr_id
GROUP BY calls.ivr_id;

