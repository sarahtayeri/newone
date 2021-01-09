project_name: "sarah_ecomm"

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }


constant: mapbox_api_key {
  value: "pk.eyJ1Ijoic2FyYWh0YXllcmkiLCJhIjoiY2tkeXNrdGhwMWM5bzJ5cWloa3RmcGtxaSJ9.emNBp2RPeV0fC9CR5ugnog"
}


constant: nick_constant {
  value: "{{_user_attributes['nicks_link']}}"
}


constant: maria_constant {
  #value: "{% if _user_attributes['maria_ua'] == 3838 %} '123' {% else %} '456' {% endif %}"
  value: "test_string"
}
