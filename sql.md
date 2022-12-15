# SQL

书写顺序

* SELECT
* FROM
* JOIN
* ON
* WHERE
* GROUP BY
* HAVING
* UNION
* ORDER BY
* LIMIT

执行顺序

* FROM
* ON
* JOIN
* WHERE
* GROUP BY
* AGG_FUNC
* WITH
* HAVING
* SELECT
* UNION
* DISTINCT
* ORDER BY
* LIMIT

row_number() over (partition by 字段a order by 计算项b desc ) as alias
