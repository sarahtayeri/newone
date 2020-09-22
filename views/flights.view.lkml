view: flights {
  sql_table_name: demo_db.flights ;;

  dimension: arr_delay {
    type: number
    sql: ${TABLE}.arr_delay ;;
  }


  dimension: cohort_month {
    type: string
    sql:"sarah";;
    html: <a href="/explore/mixmax/fct_revenue_customers_monthly_changes_details?fields=fct_revenue_customers_monthly_changes_details.cohort_month,fct_revenue_customers_monthly_changes_details.stripe_customer_id,fct_revenue_customers_monthly_changes_details.admin_email,fct_revenue_customers_monthly_changes_details.account_name, fct_revenue_customers_monthly_changes_details.sf_account_id, fct_revenue_customers_monthly_changes_details.change_month,fct_revenue_customers_monthly_changes_details.change_type,fct_revenue_customers_monthly_changes_details.prev_month_mrr,fct_revenue_customers_monthly_changes_details.delta_mrr,fct_revenue_customers_monthly_changes_details.current_mrr&f[fct_revenue_customers_monthly_changes_details.cohort_month]={{ value }}">{{value}}</a>;;
  }

  dimension_group: arr {
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
    sql: ${TABLE}.arr_time ;;
  }

  dimension: cancelled {
    type: string
    sql: ${TABLE}.cancelled ;;
  }

  dimension: carrier {
    type: string
    sql: ${TABLE}.carrier ;;
  }

  dimension: dep_delay {
    type: number
    sql: ${TABLE}.dep_delay ;;
  }

  dimension_group: dep {
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
    sql: ${TABLE}.dep_time ;;
  }

  dimension: destination {
    type: string
    sql: ${TABLE}.destination ;;
  }

  dimension: distance {
    type: number
    sql: ${TABLE}.distance ;;
  }

  dimension: diverted {
    type: string
    sql: ${TABLE}.diverted ;;
  }

  dimension: flight_num {
    type: string
    sql: ${TABLE}.flight_num ;;
  }

  dimension: flight_time {
    type: number
    sql: ${TABLE}.flight_time ;;
  }

  dimension: id2 {
    type: number
    sql: ${TABLE}.id2 ;;
  }

  dimension: origin {
    type: string
    sql: ${TABLE}.origin ;;
  }

  dimension: tail_num {
    type: string
    sql: ${TABLE}.tail_num ;;
  }

  dimension: taxi_in {
    type: number
    sql: ${TABLE}.taxi_in ;;
  }

  dimension: taxi_out {
    type: number
    sql: ${TABLE}.taxi_out ;;
  }

  dimension: stockton {

    #this works
    sql: {% if _user_attributes.['stockton'] == "True" and flights.taxi_in._in_query %}
    "a"
    {%else%}
    "b" {%endif%};;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
