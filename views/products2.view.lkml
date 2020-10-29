view: products2 {

  derived_table: {
    sql: select * from demo_db.products
    where products.id = {% parameter brand_parameter %} and products.id = {% parameter category_parameter %} ;;
  }

  parameter: brand_parameter {
    suggest_explore: products2
    suggest_dimension: brand
  }

  parameter: category_parameter {
    suggest_explore: products2
    suggest_dimension: suggestion_category
  }

  dimension: suggestion_brand {
    #sql: {% if products2.id_a_parameter._is_filtered %} "do not filter!" {% else %} ${id_b} {% endif %};;
    type: string
    sql: ${brand} ;;
  }

  dimension: suggestion_category {
    #sql: {% if products2.id_b_parameter._is_filtered %} "do not filter!" {% else %} ${id_a} {% endif %};;
    type: string
    sql: ${category} ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }



}
