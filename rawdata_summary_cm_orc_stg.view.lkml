view: rawdata_summary_cm_orc_stg {
  sql_table_name: hive.spotad.rawdata_summary_cm_orc_stg ;;
  suggestions: no

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: ad_type {
    type: string
    sql: ${TABLE}.ad_type ;;
  }

  dimension: auction_date {
    type: string
    sql: ${TABLE}.auction_date ;;
  }

  dimension: auctions {
    type: number
    sql: ${TABLE}.auctions ;;
  }

  dimension: banner_size {
    type: string
    sql: ${TABLE}.banner_size ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: citycode {
    type: string
    sql: ${TABLE}.citycode ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: countrycode {
    type: string
    sql: ${TABLE}.countrycode ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: customer_fee {
    type: number
    sql: ${TABLE}.customer_fee ;;
  }

  dimension: daily_budget {
    type: number
    sql: ${TABLE}.daily_budget ;;
  }

  dimension: datacenter {
    type: string
    sql: ${TABLE}.datacenter ;;
  }

  dimension: date1 {
    type: string
    sql: ${TABLE}.date1 ;;
  }

  dimension: day_ts {
    type: number
    sql: ${TABLE}.day_ts ;;
  }

  dimension: device_model {
    type: string
    sql: ${TABLE}.device_model ;;
  }

  dimension: device_type {
    type: number
    sql: ${TABLE}.device_type ;;
  }

  dimension: downloads {
    type: number
    sql: ${TABLE}.downloads ;;
  }

  dimension: engagements {
    type: number
    sql: ${TABLE}.engagements ;;
  }

  dimension: exchange2 {
    type: string
    sql: ${TABLE}.exchange2 ;;
  }

  dimension: goal_type {
    type: string
    sql: ${TABLE}.goal_type ;;
  }

  dimension: goal_value {
    type: number
    sql: ${TABLE}.goal_value ;;
  }

  dimension: hour_ts {
    type: number
    sql: ${TABLE}.hour_ts ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: m_inventory {
    type: string
    sql: ${TABLE}.m_inventory ;;
  }

  dimension: mobile_os {
    type: string
    sql: ${TABLE}.mobile_os ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }

  dimension: model_external_id {
    type: string
    sql: ${TABLE}.model_external_id ;;
  }

  dimension: opportunities {
    type: number
    sql: ${TABLE}.opportunities ;;
  }

  dimension: origin_type {
    type: string
    sql: ${TABLE}.origin_type ;;
  }

  dimension: os_version {
    type: string
    sql: ${TABLE}.os_version ;;
  }

  dimension: payout {
    type: number
    sql: ${TABLE}.payout ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
  }

  dimension: placementid {
    type: number
    value_format_name: id
    sql: ${TABLE}.placementid ;;
  }

  dimension: position {
    type: string
    sql: ${TABLE}.position ;;
  }

  dimension: publisher_id {
    type: string
    sql: ${TABLE}.publisher_id ;;
  }

  dimension: purchases {
    type: number
    sql: ${TABLE}.purchases ;;
  }

  dimension: rate {
    type: number
    sql: ${TABLE}.rate ;;
  }

  dimension: registers {
    type: number
    sql: ${TABLE}.registers ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: statecode {
    type: string
    sql: ${TABLE}.statecode ;;
  }

  dimension: sub_account {
    type: string
    sql: ${TABLE}.sub_account ;;
  }

  dimension: sub_account_id {
    type: number
    sql: ${TABLE}.sub_account_id ;;
  }

  dimension: timezone_offset {
    type: number
    sql: ${TABLE}.timezone_offset ;;
  }

  dimension: vertical {
    type: string
    sql: ${TABLE}.vertical ;;
  }

  dimension: vertical_parent {
    type: string
    sql: ${TABLE}.vertical_parent ;;
  }

  dimension: video_start_counter {
    type: number
    sql: ${TABLE}.video_start_counter ;;
  }

  dimension: viewability {
    type: number
    sql: ${TABLE}.viewability ;;
  }

  dimension: wins {
    type: number
    sql: ${TABLE}.wins ;;
  }

  measure: count {
    type: count
    drill_fields: [placement_name, campaign_name, account_name]
  }

  measure: win_sum {
    type: sum
    sql:  ${wins} ;;
    drill_fields: [placement_name, campaign_name, account_name]
  }
}
