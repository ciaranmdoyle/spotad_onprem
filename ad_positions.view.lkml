view: ad_positions {
  sql_table_name: cmdb.spotgames_cm.ad_positions ;;

  suggestions: no

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: external_id {
    type: string
    sql: ${TABLE}.external_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: group_id {
    type: number
    sql: ${TABLE}.group_id ;;
  }

  set: detail {
    fields: [id, external_id, name, group_id]
  }
}
