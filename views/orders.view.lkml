view: orders {
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    link: {
      label: "link to Dash B"
      url: "/dashboards/832?Dash%20B%20Date%20Filter={{ _filters['orders.created_date'] }}&First%20Name={{users.first_name._value}}&Gender={{users.gender._value}}"
    }
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }


  dimension: created_week_test {
    type: date_week
    sql: ${created_week} ;;
  }

  measure: max_date {
    type: date
    convert_tz: no
    sql: MAX(${created_date}) ;;
  }


  parameter: status_param {
    allowed_value: {
      value: "cancelled"
    }
    allowed_value: {
      value: "pending"
    }
    allowed_value: {
      value: "complete"
    }
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: dynamic_filter {
    type: yesno
    sql: {% parameter status_param %} = ${status} ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: exxxx {
    type: count_distinct
    sql: ${id} ;;
    html: {{orders.status._rendered_value}} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.last_name, users.id, users.first_name, order_items.count]
  }
}
