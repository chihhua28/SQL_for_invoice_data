WITH RECURSIVE AA AS (
  SELECT 600 AS num
  UNION ALL
  SELECT num + 1 FROM AA WHERE num < 649
),
AB AS (
  SELECT 400 AS num
  UNION ALL
  SELECT num + 1 FROM AB WHERE num < 449
),
AC AS (
  SELECT 900 AS num
  UNION ALL
  SELECT num + 1 FROM AC WHERE num < 988
), 
NUMBERS AS (
  SELECT *
  FROM AA
  UNION
  SELECT *
  FROM AB
  UNION
  SELECT *
  FROM AC
),
IV AS (
  SELECT *,
    RIGHT(invoice_number, 3) AS last_3_num,
    LEFT(invoice_number, 2) AS track,
    RIGHT(invoice_number, 8) AS number
  FROM invoices
)
SELECT IV.id, IV.invoice_number, IVB.track, IVB.year, IVB.month, IVB.begin_number, IVB.end_number
FROM NUMBERS ns
LEFT JOIN IV 
  ON ns.num = IV.last_3_num
LEFT JOIN invoice_books ivb
  ON IV.track = IVB.track AND IV.number BETWEEN IVB.begin_number AND IVB.end_number
WHERE IV.number IS NULL;

