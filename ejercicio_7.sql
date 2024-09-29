
WITH unique_billing_account AS(
SELECT calls_ivr_id,
      MAX(CASE WHEN billing_account_id <> 'UNKNOWN' THEN billing_account_id END) AS billing_account_id
FROM keepcoding.ivr_detail
GROUP BY calls_ivr_id)

SELECT calls_ivr_id,
        billing_account_id
FROM unique_billing_account
WHERE billing_account_id IS NOT NULL;
