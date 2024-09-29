        
CREATE TABLE keepcoding.ivr_summary (
    ivr_id STRING,                                
    phone_number STRING,                          
    ivr_result STRING,                           
    vdn_aggregation STRING,                       
    start_date TIMESTAMP,                         
    end_date TIMESTAMP,                           
    total_duration INT64,                         
    customer_segment STRING,                      
    ivr_language STRING,                         
    steps_module INT64,                           
    module_aggregation STRING,                    
    document_type STRING,                         
    document_identification STRING,               
    customer_phone STRING,                        
    billing_account_id STRING,                    
    masiva_lg BOOL,                               
    info_by_phone_lg BOOL,                       
    info_by_dni_lg BOOL,                          
    repeated_phone_24H BOOL,                       
    cause_recall_phone_24H BOOL                   
);


INSERT INTO keepcoding.ivr_summary(
    ivr_id, 
    phone_number, 
    ivr_result, 
    start_date, 
    end_date, 
    total_duration, 
    customer_segment, 
    ivr_language, 
    steps_module, 
    module_aggregation)


SELECT DISTINCT
    CAST(calls_ivr_id AS STRING),
    calls_phone_number AS phone_number,
    calls_ivr_result AS ivr_result,
    calls_start_date AS start_date,
    calls_end_date AS end_date,
    calls_total_duration AS total_duration,
    calls_customer_segment AS customer_segment,
    calls_ivr_language AS ivr_language,
    COUNT(DISTINCT calls_steps_module) AS steps_module,     -- Contamos los módulos distintos que la llamada atravesó
    STRING_AGG(calls_module_aggregation, ', ') AS module_aggregation -- Listamos todos los módulos por los que pasa la llamada
   
FROM 
    keepcoding.ivr_detail
GROUP BY 
    calls_ivr_id, 
    phone_number, 
    ivr_result, 
    start_date, 
    end_date, 
    total_duration, 
    customer_segment, 
    ivr_language;



INSERT INTO `keepcoding.ivr_summary` (vdn_aggregation)
SELECT 
    CASE 
        WHEN calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
        WHEN calls_vdn_label LIKE 'TECH%' THEN 'TECH'
        WHEN calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
        ELSE 'RESTO'
    END AS vdn_aggregation
FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id,
      calls_vdn_label;


INSERT INTO `keepcoding.ivr_summary` (ivr_id, document_type, document_identification)
WITH unique_ivr_id AS (
    SELECT 
        CAST(calls_ivr_id AS STRING) AS calls_ivr_id,
        MAX(CASE 
            WHEN document_type <> 'UNKNOWN' AND document_type <> 'DESCONOCIDO' 
            THEN document_type 
            END) AS document_type,
        MAX(CASE 
            WHEN document_identification <> 'UNKNOWN' AND document_identification <> 'DESCONOCIDO' 
            THEN document_identification 
            END) AS document_identification
    FROM keepcoding.ivr_detail
    GROUP BY calls_ivr_id
)
SELECT 
    calls_ivr_id AS ivr_id,
    document_type, 
    document_identification
FROM unique_ivr_id
WHERE document_type IS NOT NULL 
    OR document_identification IS NOT NULL;



