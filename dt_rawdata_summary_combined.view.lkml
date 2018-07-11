view: dt_rawdata_summary_combined {
  view_label: "Daily Summary"
#   suggestions: no
  derived_table: {
    sql:
    SELECT *
      FROM
      hive.spotad.rawdata_summary_cm_orc_cn
      WHERE
      day_ts >= CAST(DATE_FORMAT(DATE({% parameter date_start %}),'%Y%m%d') AS INTEGER)
      AND day_ts <= CAST(DATE_FORMAT(DATE({% parameter date_finish %}),'%Y%m%d') AS INTEGER)
      UNION ALL
      SELECT *
      FROM
      hive.spotad.rawdata_summary_cm_orc_prd
      WHERE
      day_ts >= CAST(DATE_FORMAT(DATE({% parameter date_start %}),'%Y%m%d') AS INTEGER)
      AND day_ts <= CAST(DATE_FORMAT(DATE({% parameter date_finish %}),'%Y%m%d') AS INTEGER)
       ;;
  }

  parameter: date_start {
    type: date
  }

  parameter: date_finish {
    type: date
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date1 {
    type: string
    sql: ${TABLE}.date1 ;;
  }

  dimension: timezone_offset {
    type: number
    sql: ${TABLE}.timezone_offset ;;
  }

  dimension: auction_date {
    type: string
    sql: ${TABLE}.auction_date ;;
  }

  dimension: datacenter {
    type: string
    sql: ${TABLE}.datacenter ;;
  }

  dimension: vertical {
    type: string
    sql: ${TABLE}.vertical ;;
  }

  dimension: vertical_parent {
    type: string
    sql: ${TABLE}.vertical_parent ;;
  }

  dimension: placementid {
    type: number
    sql: ${TABLE}.placementid ;;
  }

  dimension: country {
    group_label: "Location"
    type: string
    sql: ${TABLE}.country ;;
    map_layer_name: countries

  }

  dimension: countrycode {
    group_label: "Location"
    type: string
    sql: ${TABLE}.countrycode ;;
    map_layer_name: countries
  }

  dimension: city {
    group_label: "Location"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: citycode {
    group_label: "Location"
    type: string
    sql: ${TABLE}.citycode ;;
  }

  dimension: state {
    group_label: "Location"
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: statecode {
    group_label: "Location"
    type: string
    sql: ${TABLE}.statecode ;;
  }

  dimension: device_model {
    type: string
    sql: ${TABLE}.device_model ;;
  }

  dimension: mobile_os {
    type: string
    sql: ${TABLE}.mobile_os ;;
  }

  dimension: os_version {
    type: string
    sql: ${TABLE}.os_version ;;
  }

  dimension: m_inventory {
    type: string
    sql: ${TABLE}.m_inventory ;;
  }

  dimension: source {
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: position {
    type: string
    sql: ${TABLE}.position ;;
  }

  dimension: exchange2 {
    type: string
    sql: ${TABLE}.exchange2 ;;
  }

  dimension: auctions {
    type: number
    sql: ${TABLE}.auctions ;;
  }

  dimension: wins {
    type: number
    sql: ${TABLE}.wins ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: engagements {
    type: number
    sql: ${TABLE}.engagements ;;
  }

  dimension: clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.clicks ;;
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
    drill_fields: [detail*,-auctions]
  }

  dimension: spend {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.spend,0) ;;
  }

  measure: total_spend {
    type: sum
    value_format_name: usd
    sql: ${spend} ;;
    drill_fields: [detail*]
  }

  measure: average_spend {
    type: average
    sql: ${spend} ;;
  }

  dimension: downloads {
    type: number
    sql: ${TABLE}.downloads ;;
  }

  measure: total_downloads {
    type: sum
    sql: ${downloads} ;;
  }

  measure: eCPC {
    description: "Spend per Click"
    type: number
    value_format_name: usd
    sql: 1.0*${total_spend}/NULLIF(${total_clicks},0)  ;;
  }

  dimension: registers {
    type: number
    sql: ${TABLE}.registers ;;
  }

  dimension: purchases {
    type: number
    sql: ${TABLE}.purchases ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }

   dimension: video_start_counter {
    type: number
    hidden: yes
    sql: ${TABLE}.video_start_counter ;;
  }

  measure: total_video_started {
    type: sum
    sql: ${video_start_counter} ;;
  }

  dimension: rate {
    type: number
    sql: ${TABLE}.rate ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: sub_account_id {
    type: number
    sql: ${TABLE}.sub_account_id ;;
  }

  dimension: sub_account {
    type: string
    sql: ${TABLE}.sub_account ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: goal_type {
    type: string
    sql: ${TABLE}.goal_type ;;
  }

  dimension: goal_value {
    type: number
    sql: ${TABLE}.goal_value ;;
  }

  dimension: ad_type {
    type: string
    sql: ${TABLE}.ad_type ;;
  }

  dimension: daily_budget {
    type: number
    sql: ${TABLE}.daily_budget ;;
  }

  dimension: banner_size {
    type: string
    sql: ${TABLE}.banner_size ;;
  }

  dimension: publisher_id {
    type: string
    sql: ${TABLE}.publisher_id ;;
  }

  dimension: placement_name {
    type: string
    sql: ${TABLE}.placement_name ;;
  }

  dimension: customer_fee {
    type: number
    sql: ${TABLE}.customer_fee ;;
  }

  dimension: origin_type {
    type: string
    sql: ${TABLE}.origin_type ;;
  }

  dimension: payout {
    type: number
    sql: ${TABLE}.payout ;;
  }

  dimension: model_external_id {
    type: string
    sql: ${TABLE}.model_external_id ;;
  }

  dimension: device_type {
    type: number
    sql: ${TABLE}.device_type ;;
  }

  dimension: day_ts {
    type: number
    sql: ${TABLE}.day_ts ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      date,week,month
    ]
    sql: CAST(CONCAT(substr(CAST(${TABLE}.day_ts as varchar), 1, 4),'-',substr(CAST(${TABLE}.day_ts as varchar), 5, 2),'-',substr(CAST(${TABLE}.day_ts as varchar), 7, 2)) As timestamp) ;;
  }

  dimension: hour_ts {
    type: number
    sql: ${TABLE}.hour_ts ;;
  }

  set: detail {
    fields: [
      date1,
      timezone_offset,
      auction_date,
      datacenter,
      vertical,
      vertical_parent,
      placementid,
      country,
      countrycode,
      city,
      citycode,
      state,
      statecode,
      device_model,
      mobile_os,
      os_version,
      m_inventory,
      source,
      position,
      exchange2,
      auctions,
      wins,
      impressions,
      engagements,
      clicks,
      spend,
      downloads,
      registers,
      purchases,
      model,
      video_start_counter,
      rate,
      currency,
      account_id,
      account_name,
      sub_account_id,
      sub_account,
      campaign_id,
      campaign_name,
      goal_type,
      goal_value,
      ad_type,
      daily_budget,
      banner_size,
      publisher_id,
      placement_name,
      customer_fee,
      origin_type,
      payout,
      model_external_id,
      device_type,
      day_ts,
      hour_ts
    ]
  }
}
