view: orders {
  sql_table_name: demo_db.orders ;;
  #drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;

  }

  dimension: id_with_null {
    type: number
    sql: case when ${id}=10 then null else ${id} end ;;
  }



  measure: testa {
    type: count
    drill_fields: [id]
  }

  measure: testb {
    type: count
    drill_fields: [id, user_id]
  }

  measure: depends {
    type: number
    sql: {% if _user_attributes['sarah_string']='blue' %} ${testa} {% else %} ${testb} {% endif %} ;;
  }

  dimension: ex {
    type: string
    sql: "hi";;
   # html: https://google.com ;;
  }

  dimension_group: created {
    convert_tz:  no
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


  dimension: max_order_date {
    type: date
    sql: (SELECT MAX(DATE(orders.created_at)) FROM demo_db.orders) ;;
  }

  dimension: is_latest_date {
    type: yesno
    sql: ${created_date}=${max_order_date} ;;

  }



  dimension: created_year_string {
    type: string
    sql: ${created_year} ;;
  }

  measure: rolling_sum {
    type: sum
    sql: ${id} ;;
    #filters: [created_date: "7 days ago for 7 days"]
  }

  dimension: jayaram {
    type: date_raw
    sql: ${created_raw} ;;
  }

  measure: max_date {
    type: date
    convert_tz: no
    sql: max(${created_date}) ;;
  }

  measure: min_date {
    type: date
    sql: min(${created_date}) ;;
  }

  measure: number_days {
    type: number
    sql: DATEDIFF(${min_date}, ${max_date}) ;;
  }


  dimension: othniel {
    type: string
    sql: case when ${created_month}="2019-12" then "dec of 2019" else "other month" end ;;
  }


  parameter: red {
    type: number
  }

  parameter: amber {
    type: number
  }

  dimension: tolulope {
    type: number
    sql: ${orders.id};;
  }

  dimension: tolulope_2 {
    type: number
    sql: ${tolulope} ;;
    html:
    <a href="#drillmenu" target="_self">
    {% assign red = red._parameter_value | plus: 0 %}
    {% assign amber = amber._parameter_value | plus: 0 %}

    {% assign red_array = red | split: "." %}
    {% assign red_decimal_count = red_array[1] | size %}
    {% assign pct_late_parcel_round_red = tolulope._value  | round: red_decimal_count %}

    {% assign amber_array = amber | split: "." %}
    {% assign amber_decimal_count = amber_array[1] | size %}
    {% assign pct_late_parcel_round_amber = tolulope._value  | round: amber_decimal_count %}

    {% if pct_late_parcel_round_red <= red %}
    <div style="color: black; background-color: rgba(224, 91, 91, 1); font-size:100%; text-align:center">{{linked_value}}</div>
    {% elsif pct_late_parcel_round_amber <= amber %}
    <div style="color: black; background-color: rgba(237, 172, 84, 1); font-size:100%; text-align:center">{{linked_value}}</div>
    {% else %}
    <div style="color: black; background-color: green; font-size:100%; text-align:center">{{linked_value}}</div>
    {% endif %}
    </a>
    ;;
  }


  dimension: created_week_test {
    type: string
    sql: ${created_week} ;;
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

  dimension: is_cancelled {
    type: yesno
    sql: ${status}="pending" OR ${status}="complete" ;;
  }

  measure: is_cancelled_measure {
    type: yesno
    sql: ${status}="pending" OR ${status}="complete" ;;
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
    drill_fields: [id, users.last_name, users.id, users.first_name, order_items.count, orders.count]
    link: {
      label: "to explore"
      url: "/explore/sarah_ecomm/products?fields=products.brand,products.category"
      }
      description: "blah"
  }



  measure: count_coalesce {
    type: number
    sql: coalesce(${count}, 0) ;;
  }
}
