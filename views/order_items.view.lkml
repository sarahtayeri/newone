view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    link: {
      label: "test link"
      url: "/dashboards/862?Date%20test={{_filters['order_items.returned_date'] | url_encode }}"
    }
  }


  dimension: fake_url {
    type: string
    sql: "https://google.com" ;;
  }

  dimension: url_nickname {
    type: string
    sql: SUBSTRING(${fake_url}, 9, 6) ;;
    html: <a href="https://google.com">{{ value }}</a> ;;

  }

  dimension: html_kyle {
    type: string
    sql: "this is an example" ;;
    html: <button type="button">Click Me!</button> ;;
  }





  dimension: inventory_item_id {
    #label: "<font color='green'> Inventory Item ID </font>"
    label: "<div style='color:blue;text-align:center'> text here </div>"
    #label: "<div style='padding-left:25px;padding-right:25px'> text here </div>"
    type: number
    html: <div style='color:blue;text-align:center'> text here </div> ;;
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: order_id_formatting {
    type: number
    value_format_name: usd_0
    sql: ${TABLE}.order_id ;;
  }

  measure: min_order_id {
    type: min
    sql: ${order_id} ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: summed_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  dimension: testing {
    sql: case when {{ _field._name }} =order_items.summed_sale_price then "label1" when {{ _field._name }} =order_items.summed_sale_price then "label2" else "label3" end;;
  }

  measure: test {
    type: number
    sql: ${average_sale_price} ;;
    required_fields: [id]
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }

  measure: will_error {
    type: number
    sql: ${count}/${id} ;;
  }

  measure: count_filtered {
    type: count
    filters: [id: "-1"]
  }
}
