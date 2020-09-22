view: ndt_test {
    derived_table: {
      explore_source: order_items {
        column: fake_url {}
        column: id {}
        column: count {}
      }
    }
    dimension: id {
      type: number
    }
    dimension: count {
      type: number
    }
  }
