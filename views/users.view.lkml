view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    style: integer
    tiers: [15, 50]
    sql: ${age} ;;
  }

  parameter: age_parameter {
    allowed_value: {
      value: "Below 15"
    }
    allowed_value: {
      value: "15 to 49"
    }
    allowed_value: {
      value: "50 or above"
    }
  }

  dimension: age_yesno {
    type: yesno
    sql: CASE WHEN {% parameter age_parameter %}="15 to 49" then (CASE WHEN ${age_tier}= "15 to 49" THEN TRUE else FALSE end) else null end;;
  }

  dimension: age_yesno_2 {
    type: yesno
    sql: {% parameter age_parameter %}=${age_tier} ;;
  }



  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: is_female {
    type: yesno
    sql: ${gender}="f" ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: state_2 {
    type: string
    sql: CASE WHEN ${TABLE}.state="California" THEN "California" ELSE "Other" END ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      last_name,
      first_name,
      events.count,
      orders.count,
      saralooker.count,
      user_data.count
    ]
  }
}
