view: rt_rbo_placements {
  sql_table_name: hive.spotad.rt_rbo_placements ;;
  suggestions: no

  dimension: account {
    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: placement_id {
    type: string
    sql: ${TABLE}.placement_id ;;
  }

  dimension: subaccount {
    type: string
    sql: ${TABLE}.subaccount ;;
  }

  measure: count {
    type: count
    drill_fields: [campaign_name]
  }
}
