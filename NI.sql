SELECT * FROM apps.oe_order_lines_all;


SELECT * FROM apps.oe_order_headers_all;

SELECT * 
FROM  apps.oe_order_lines_all ol,
            apps.oe_order_headers_all oh
WHERE ol.header_id = oh.header_id AND ol.header_id = 114096;


SELECT order_number,  avg(unit_cost)
FROM  apps.oe_order_lines_all ol,
            apps.oe_order_headers_all oh
WHERE ol.header_id = oh.header_id
GROUP BY order_number;


SELECT order_number,  line_id, unit_cost, avg(unit_cost) over (partition by order_number) -- így meg lehet jeleníteni a line_id-t is 
FROM  apps.oe_order_lines_all ol,
            apps.oe_order_headers_all oh
WHERE ol.header_id = oh.header_id;


SELECT * FROM apps.mtl_system_items;


/* Orderek átlag értéke, amelyik item description tartalmazza a "mobile" szót */
SELECT * FROM apps.mtl_system_items sysitems,  apps.oe_order_lines_all ol
WHERE  sysitems.organization_id = ol.org_id AND LOWER(description) like '%mobile%';

/* order_headers - order_lines; Egy order number-hez hány darab order tartozik */
SELECT order_number, count(order_number)
FROM  apps.oe_order_lines_all ol,
            apps.oe_order_headers_all oh
WHERE ol.header_id = oh.header_id
GROUP BY order_number;





