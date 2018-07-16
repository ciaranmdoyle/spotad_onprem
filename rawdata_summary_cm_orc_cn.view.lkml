view: rawdata_summary_cm_orc_cn {
  sql_table_name: hive.spotad.rawdata_summary_cm_orc_cn ;;
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
    hidden: yes
    type: number
    sql: ${TABLE}.clicks ;;
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    drill_fields: [state,city,citycode]
  }

  dimension: countrycode {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.countrycode ;;
    drill_fields: [state,city,citycode]
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
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.spend,0) ;;
  }

  measure: total_spend {
    type: sum
    sql: ${spend} ;;
  }

  measure: average_spend {
    type: average
    sql: ${spend} ;;
#     html:
#     {% if value > 0 %}
#         <font color="#42a338 ">{{ rendered_value }} good</font>
#       {% elsif value > 1 %}
#         <font color="#ffb92e ">{{ rendered_value }} ok</font>
#       {% else %}
#         <font color="#fa4444 ">{{ rendered_value }} bad</font>
#       {% endif %}
#     ;;
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

  measure: total_video_started {
    type: sum
    sql: ${video_start_counter} ;;
  }

  dimension: wins {
    type: number
    sql: ${TABLE}.wins ;;
  }

  measure: count {
    type: count
    drill_fields: [account_name, campaign_name, placement_name]
  }
}
