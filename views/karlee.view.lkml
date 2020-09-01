view: karlee {
  derived_table: {
    sql: -- raw sql results do not include filled-in values for 'order_items.returned_date'


      SELECT
        DATE(CONVERT_TZ(order_items.returned_at ,'UTC','America/Los_Angeles')) AS `order_items.returned_date`,
        MIN(order_items.order_id ) AS `order_items.min_order_id`
      FROM demo_db.order_items  AS order_items

      GROUP BY 1
      ORDER BY DATE(CONVERT_TZ(order_items.returned_at ,'UTC','America/Los_Angeles')) DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_returned_date {
    type: date
    sql: ${TABLE}.`order_items.returned_date` ;;
  }

  dimension: order_items_min_order_id {
    type: number
    sql: ${TABLE}.`order_items.min_order_id` ;;
  }

  set: detail {
    fields: [order_items_returned_date, order_items_min_order_id]
  }
}
