view: conversiondata_orc_cn {
  sql_table_name: hive.spotad.conversiondata_orc_cn ;;
  suggestions: no

  dimension: auctionid {
    type: string
    sql: ${TABLE}.auctionid ;;
  }

  dimension: clickid {
    type: string
    sql: ${TABLE}.clickid ;;
  }

  dimension: conversiontype {
    type: string
    sql: ${TABLE}.conversiontype ;;
  }

  dimension: day_ts {
    type: number
    sql: ${TABLE}.day_ts ;;
  }

  dimension: env {
    type: string
    sql: ${TABLE}.env ;;
  }

  dimension: exchange2 {
    type: string
    sql: ${TABLE}.exchange2 ;;
  }

  dimension: external_info {
    type: string
    sql: ${TABLE}.external_info ;;
  }

  dimension: externalclickid {
    type: string
    sql: ${TABLE}.externalclickid ;;
  }

  dimension: gaaccountid {
    type: string
    sql: ${TABLE}.gaaccountid ;;
  }

  dimension: mediator {
    type: string
    sql: ${TABLE}.mediator ;;
  }

  dimension: placementid {
    type: number
    value_format_name: id
    sql: ${TABLE}.placementid ;;
  }

  dimension: timestamp {
    type: string
    sql: ${TABLE}."timestamp" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
