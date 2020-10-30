view: products {
  sql_table_name: demo_db.products ;;
  drill_fields: [id]


  parameter: id_param {
    #suggest_dimension:
  }

  parameter: id_deanna_param {}

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: id_faked {
    sql: case when ${id}>50 and ${id}<60 then null else ${id} end ;;
  }

  dimension: id_deanna {
    type: number
    sql: ${id}+1 ;;
  }



  filter: example {}

  parameter: test_link {
    type: unquoted
    allowed_value: {
      value: "apple"
    }
    allowed_value: {
      value: "banana"
    }
  }

  dimension: asldkfj {
    type: string
    sql: {% if test_link._parameter_value == 'apple' %} "this is a" {% elsif test_link._parameter_value == 'banana' %} "this is b" {% else %} "broken" {% endif %};;
    #sql: {% parameter test_link %} ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }


  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }


  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: site {
    type: string
    sql: ${department} ;;
    link: {
      url: "{{page._value}}"
      label: "{{page._value}}"
    }
  }

  dimension: page {
    type: string
    sql: "https://google.com" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }

  measure: cd_category {
    type: count_distinct
    sql: ${category} ;;
  }
}
