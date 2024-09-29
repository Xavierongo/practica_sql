
SELECT DISTINCT calls_ivr_id,
       customer_phone
  FROM keepcoding.ivr_detail
  WHERE customer_phone <> 'UNKNOWN';


