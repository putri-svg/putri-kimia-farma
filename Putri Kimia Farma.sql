SELECT
  t0.transaction_id,
  t0.date,
  t0.branch_id,
  t1.branch_name,
  t1.kota,
  t1.provinsi,
  t1.rating,
  t0.customer_name,
  t0.product_id,
  kf_product.product_name,
  kf_product.price,
  t0.discount_percentage,
  CASE
    WHEN kf_product.price <= 50000 THEN 0.1
    WHEN kf_product.price > 50000 AND kf_product.price <= 100000 THEN 0.15
    WHEN kf_product.price > 100000 AND kf_product.price <= 300000 THEN 0.2
    WHEN kf_product.price > 300000 AND kf_product.price <= 500000 THEN 0.25
    ELSE 0.3
    END AS persentase_gross_laba,
  kf_product.price * (1 - t0.discount_percentage) AS nett_sales,
  (kf_product.price * (1 - t0.discount_percentage)) *
  CASE
    WHEN kf_product.price <= 50000 THEN 0.1
    WHEN kf_product.price > 50000 AND kf_product.price <= 100000 THEN 0.15
    WHEN kf_product.price > 100000 AND kf_product.price <= 300000 THEN 0.2
    WHEN kf_product.price > 300000 AND kf_product.price <= 500000 THEN 0.25
    ELSE 0.3
END AS nett_profit,
  t0.rating
FROM
  `shining-relic-455307-s4`.kf_final_transaction.kf_final_transaction AS t0
  INNER JOIN
  `shining-relic-455307-s4`.kf_kantor_cabang.kf_kantor_cabang AS t1
  ON t0.branch_id = t1.branch_id
  INNER JOIN
  `shining-relic-455307-s4`.kf_product.kf_product AS kf_product
  ON t0.product_id = kf_product.product_id;