view: testing_persistence {
  derived_table: {
    sql: SELECT
        inventory_items.cost  AS `inventory_items.cost`,
        inventory_items.id  AS `inventory_items.id`,
        COUNT(DISTINCT inventory_items.id ) AS `inventory_items.count`
      FROM demo_db.order_items  AS order_items
      LEFT JOIN demo_db.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id

      GROUP BY 1,2
      ORDER BY COUNT(DISTINCT inventory_items.id ) DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: inventory_items_cost {
    type: number
    sql: ${TABLE}.`inventory_items.cost` ;;
  }

  dimension: inventory_items_id {
    type: number
    sql: ${TABLE}.`inventory_items.id` ;;
  }

  dimension: inventory_items_count {
    type: number
    sql: ${TABLE}.`inventory_items.count` ;;
  }

  set: detail {
    fields: [inventory_items_cost, inventory_items_id, inventory_items_count]
  }
}
