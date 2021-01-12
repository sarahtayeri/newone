view: sme {
  derived_table: {
    sql:
    SELECT DATE(orders.created_at ) AS `created_date`,
    CASE WHEN {% parameter us_or_eu %}= 'US' THEN "US" ELSE "EU" END AS `place`
    FROM demo_db.orders  AS orders
    WHERE {% condition date_filter %} orders.created_at {% endcondition %}
    ;;

  }

  dimension_group: created {
    type: time
    timeframes: [date]
    sql: ${TABLE}.created_date ;;
    html: {% if place._value == 'US' %} {{ rendered_value | date: "%m/%d/%Y" }} {% elsif place._value == 'EU' %}  {{ rendered_value | date: "%d/%m/%Y" }} {% else %} {{rendered_value}} {% endif %}  ;;
  }

  dimension: place {
    type: string
    sql: ${TABLE}.place ;;
  }

  filter: date_filter {
    label: "Use this to pick the date"
    type: date
  }

  parameter: us_or_eu {
    label: "Use this to pick US or EU date formatting"
    allowed_value: {
      label: "US"
      value: "US"
    }
    allowed_value: {
      label: "EU"
      value: "EU"
    }
  }

  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: sme {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
