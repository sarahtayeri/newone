view: ndt_test {
    derived_table: {
      explore_source: order_items {
        bind_all_filters: yes
        column: fake_url {}
        column: id {}
        column: count {}
      }
    }
    dimension: fake_url {}
    dimension: id {
      type: number
    }
    dimension: count {
      type: number
    }
  }
