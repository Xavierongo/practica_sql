WITH unique_ivr_id AS (
    SELECT 
        calls_ivr_id,
        MAX(CASE WHEN document_type <> 'UNKNOWN' AND document_type <> 'DESCONOCIDO' THEN document_type END) AS document_type,
        MAX(CASE WHEN document_identification <> 'UNKNOWN' AND document_identification <> 'DESCONOCIDO' THEN document_identification END) AS document_identification
    FROM keepcoding.ivr_detail
    GROUP BY calls_ivr_id
)

SELECT 
    calls_ivr_id,
    document_type, 
    document_identification
FROM unique_ivr_id
WHERE document_type IS NOT NULL 
    OR document_identification IS NOT NULL;

