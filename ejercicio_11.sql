SELECT 
    c1.ivr_id,
    c1.phone_number,

    
    CASE 
        WHEN (
            SELECT COUNT(*)
            FROM keepcoding.ivr_calls c2
            WHERE c2.phone_number = c1.phone_number
              AND TIMESTAMP_DIFF(c1.start_date, c2.start_date, SECOND) <= 86400  -- en segundos
              AND c2.start_date < c1.start_date
        ) > 0 THEN 1 
        ELSE 0 
    END AS repeated_phone_24H,

    CASE 
        WHEN (
            SELECT COUNT(*)
            FROM keepcoding.ivr_calls c3
            WHERE c3.phone_number = c1.phone_number
              AND TIMESTAMP_DIFF(c3.start_date, c1.start_date, SECOND) <= 86400  -- en segundos
              AND c3.start_date > c1.start_date
        ) > 0 THEN 1 
        ELSE 0 
    END AS cause_recall_phone_24H

FROM 
    keepcoding.ivr_calls c1;
