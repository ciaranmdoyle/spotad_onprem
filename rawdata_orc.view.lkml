view: rawdata_orc {
  sql_table_name: hive.spotad.rawdata_orc ;;
  suggestions: no

  dimension: actualbidprice {
    type: number
    sql: ${TABLE}.actualbidprice ;;
  }

  dimension: actualwinprice {
    type: number
    sql: ${TABLE}.actualwinprice ;;
  }

  dimension: ad_context {
    type: string
    sql: ${TABLE}.ad_context ;;
  }

  dimension: ad_type {
    type: string
    sql: ${TABLE}.ad_type ;;
  }

  dimension: adx {
    type: string
    sql: ${TABLE}.adx ;;
  }

  dimension: adx_feedback {
    type: string
    sql: ${TABLE}.adx_feedback ;;
  }

  dimension: app {
    type: string
    sql: ${TABLE}.app ;;
  }

  dimension: auction_type {
    type: number
    sql: ${TABLE}.auction_type ;;
  }

  dimension: auctionid {
    type: string
    sql: ${TABLE}.auctionid ;;
  }

  dimension: banner {
    type: string
    sql: ${TABLE}.banner ;;
  }

  dimension: bid_floor {
    type: number
    sql: ${TABLE}.bid_floor ;;
  }

  dimension: bidprice {
    type: number
    sql: ${TABLE}.bidprice ;;
  }

  dimension: blocked_categories {
    type: string
    sql: ${TABLE}.blocked_categories ;;
  }

  dimension: browser {
    type: string
    sql: ${TABLE}.browser ;;
  }

  dimension: buyer_uid {
    type: string
    sql: ${TABLE}.buyer_uid ;;
  }

  dimension: campaignid {
    type: number
    value_format_name: id
    sql: ${TABLE}.campaignid ;;
  }

  dimension: cookie_id {
    type: string
    sql: ${TABLE}.cookie_id ;;
  }

  dimension: creative {
    type: string
    sql: ${TABLE}.creative ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: dailybudget {
    type: number
    sql: ${TABLE}.dailybudget ;;
  }

  dimension: datacenter {
    type: string
    sql: ${TABLE}.datacenter ;;
  }

  dimension: day_ts {
    type: number
    sql: ${TABLE}.day_ts ;;
  }

  dimension: deals {
    type: string
    sql: ${TABLE}.deals ;;
  }

  dimension: device {
    type: string
    sql: ${TABLE}.device ;;
  }

  dimension: device_type {
    type: number
    sql: ${TABLE}.device_type ;;
  }

  dimension: domain_category {
    type: string
    sql: ${TABLE}.domain_category ;;
  }

  dimension: dt {
    type: string
    sql: ${TABLE}.dt ;;
  }

  dimension: engagedata {
    type: string
    sql: ${TABLE}.engagedata ;;
  }

  dimension: exchange2 {
    type: string
    sql: ${TABLE}.exchange2 ;;
  }

  dimension: exchange_creative_type {
    type: number
    sql: ${TABLE}.exchange_creative_type ;;
  }

  dimension: framework_version {
    type: string
    sql: ${TABLE}.framework_version ;;
  }

  dimension: geo {
    type: string
    sql: ${TABLE}.geo ;;
  }

  dimension: goalvalue {
    type: number
    sql: ${TABLE}.goalvalue ;;
  }

  dimension: historical_ctr {
    type: number
    sql: ${TABLE}.historical_ctr ;;
  }

  dimension: hour_ts {
    type: number
    sql: ${TABLE}.hour_ts ;;
  }

  dimension: ibv_allowed {
    type: number
    sql: ${TABLE}.ibv_allowed ;;
  }

  dimension: imei {
    type: string
    sql: ${TABLE}.imei ;;
  }

  dimension: imei_list {
    type: string
    sql: ${TABLE}.imei_list ;;
  }

  dimension: impression {
    type: string
    sql: ${TABLE}.impression ;;
  }

  dimension: inventory_type {
    type: string
    sql: ${TABLE}.inventory_type ;;
  }

  dimension: media_metrics {
    type: string
    sql: ${TABLE}.media_metrics ;;
  }

  dimension: model_flavor {
    type: string
    sql: ${TABLE}.model_flavor ;;
  }

  dimension: model_predict {
    type: number
    sql: ${TABLE}.model_predict ;;
  }

  dimension: model_timestamp {
    type: string
    sql: ${TABLE}.model_timestamp ;;
  }

  dimension: opt {
    type: string
    sql: ${TABLE}.opt ;;
  }

  dimension: opt_strategies {
    type: string
    sql: ${TABLE}.opt_strategies ;;
  }

  dimension: original_winprice {
    type: number
    sql: ${TABLE}.original_winprice ;;
  }

  dimension: overloadfactor {
    type: number
    sql: ${TABLE}.overloadfactor ;;
  }

  dimension: placementid {
    type: number
    value_format_name: id
    sql: ${TABLE}.placementid ;;
  }

  dimension: publisher_placement_id {
    type: string
    sql: ${TABLE}.publisher_placement_id ;;
  }

  dimension: publisherid_external {
    type: string
    sql: ${TABLE}.publisherid_external ;;
  }

  dimension: rate {
    type: number
    sql: ${TABLE}.rate ;;
  }

  dimension: rewarded_video {
    type: number
    sql: ${TABLE}.rewarded_video ;;
  }

  dimension: sampling {
    type: number
    sql: ${TABLE}.sampling ;;
  }

  dimension: site {
    type: string
    sql: ${TABLE}.site ;;
  }

  dimension: spotad_id {
    type: string
    sql: ${TABLE}.spotad_id ;;
  }

  dimension: timestamp1 {
    type: string
    sql: ${TABLE}.timestamp1 ;;
  }

  dimension: timezone_offset {
    type: number
    sql: ${TABLE}.timezone_offset ;;
  }

  dimension: user_category {
    type: string
    sql: ${TABLE}.user_category ;;
  }

  dimension: user_metrics {
    type: string
    sql: ${TABLE}.user_metrics ;;
  }

  dimension: user_profile_users_lists {
    type: string
    sql: ${TABLE}.user_profile_users_lists ;;
  }

  dimension: userid {
    type: string
    sql: ${TABLE}.userid ;;
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

  dimension: virtual_bids {
    type: string
    sql: ${TABLE}.virtual_bids ;;
  }

  dimension: winprice {
    type: number
    sql: ${TABLE}.winprice ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
