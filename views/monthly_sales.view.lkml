view: monthly_sales {
  derived_table: {
    sql: -- raw sql results do not include filled-in values for 'order_items.returned_month'


      SELECT
        DATE_FORMAT(CONVERT_TZ(order_items.returned_at ,'UTC','America/Los_Angeles'),'%Y-%m') AS `order_items.returned_month`,
        COALESCE(SUM(order_items.sale_price ), 0) AS `order_items.summed_sale_price`
      FROM demo_db.order_items  AS order_items

      GROUP BY 1
      ORDER BY DATE_FORMAT(CONVERT_TZ(order_items.returned_at ,'UTC','America/Los_Angeles'),'%Y-%m') DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: returned_month {
    type: string
    sql: ${TABLE}.`order_items.returned_month` ;;
  }

  dimension: summed_monthly_sale_price {
    type: number
    sql: ${TABLE}.`order_items.summed_sale_price` ;;
  }

  set: detail {
    fields: [returned_month, summed_monthly_sale_price]
  }
}
