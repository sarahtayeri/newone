connection: "thelook"

# include all the views
include: "/views/*.view"
include: "/trevor.dashboard"
include: "/refine.explore"




datagroup: sarah_ecomm_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}



##testing


datagroup: testing_pdtlog {
  sql_trigger: SELECT max(id) FROM demo_db.events ;;
  max_cache_age: "24 hours"
}



explore: testing_persistence {
  persist_with: testing_pdtlog
}

#datagroup: sarah_test_if_it_will_show {}

#persist_with: sarah_ecomm_default_datagroup

map_layer: census_tract {
  format: "vector_tile_region"
  url: "https://a.tiles.mapbox.com/v4/dwmintz.3zfb3asw/{z}/{x}/{y}.mvt?access_token=@{mapbox_api_key}"
  feature_key: "us_tracts-6w08eq"
  extents_json_url: "https://cdn.rawgit.com/dwmintz/census_extents2/396e32db/tract_extents.json"
  min_zoom_level: 6
  max_zoom_level: 14
  property_key: "GEOID"
}

explore: map_dt {
  persist_with: testing_pdtlog
}

explore: connection_reg_r3 {
}

explore: karlee {}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: flights {
  hidden: yes
}



explore: imgsrc1onerroralert2 {}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: products2 {
  from:  products
}


explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }


  join: monthly_sales {
    type: left_outer
    sql_on: ${order_items.returned_month}=${monthly_sales.returned_month} ;;
    relationship: many_to_one
  }


}


# explore: testforndt {
#   extends: [order_items]
#   from: order_items
# }

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {
  cancel_grouping_fields: [products.department]
}

explore: saralooker {
  join: users {
    type: left_outer
    sql_on: ${saralooker.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: schema_migrations {}



# access_grant: maria {
#   user_attribute: maria_ua
#   #allowed_values: ["@{maria_constant"]
#   allowed_values: ["test_string"]
# }

explore: user_data {
  # required_access_grants: [maria]
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  hidden: yes
  join: products {
    type: left_outer
    sql_on: ${users.id}=${products.id} ;;
    relationship: many_to_one
  }
}



explore: sme {}

explore: vvimgsrc1onerroralert2ll {}

explore: xin_test_for_bug2 {}

explore: xss_test {}

explore: xss_test_1 {}

explore: xss_test_10 {}

explore: xss_test_11 {}

explore: xss_test_12 {}

explore: xss_test_13 {}

explore: xss_test_14 {}

explore: xss_test_15 {}

explore: xss_test_16 {}

explore: xss_test_2 {}

explore: xss_test_4 {}

explore: xss_test_5 {}

explore: xss_test_6 {}

explore: xss_test_7 {}

explore: xss_test_8 {}

explore: xss_test_9 {}
