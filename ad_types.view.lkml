view: ad_types {
  sql_table_name: cmdb.spotgames_cm.ad_types ;;
#   derived_table: {
#     sql: SELECT * FROM cmdb.spotgames_cm.ad_types
#       ;;
#   }

  suggestions: no

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: enum {
    type: string
    sql: ${TABLE}.enum ;;
  }

  dimension: parent_id {
    type: number
    sql: ${TABLE}.parent_id ;;
  }

  dimension: dir {
    type: string
    sql: ${TABLE}.dir ;;
  }

  dimension: order {
    type: number
    sql: ${TABLE}."order" ;;
  }

  dimension: has_global_settings {
    type: number
    sql: ${TABLE}.has_global_settings ;;
  }

  dimension: has_template_settings {
    type: number
    sql: ${TABLE}.has_template_settings ;;
  }

  dimension: has_template {
    type: number
    sql: ${TABLE}.has_template ;;
  }

  set: detail {
    fields: [
      id,
      name,
      enum,
      parent_id,
      dir,
      order,
      has_global_settings,
      has_template_settings,
      has_template
    ]
  }
}
