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
#       --{% if timeframe.value = "Monthly" %}
#       --day_ts >= CAST(DATE_FORMAT(DATE(DATE_ADD('month',-1,current_date)),'%Y%m%d') AS INTEGER)
#       --{% else if timeframe.value = "Weekly" %}
#       --day_ts >= CAST(DATE_FORMAT(DATE(DATE_ADD('week',-1,current_date)),'%Y%m%d') AS INTEGER)
#       --{% else %}
#       --day_ts >= CAST(DATE_FORMAT(DATE(DATE_ADD('day',-1,current_date)),'%Y%m%d') AS INTEGER)
#       --{% endif %}
  }

  parameter: timeframe {
    default_value: "Daily"
    allowed_value: {
      value: "Daily"
    }
    allowed_value: {
      value: "Weekly"
    }
    allowed_value: {
      value: "Monthly"
    }
  }

  parameter: date_part {
    type: unquoted
    allowed_value: {
      label: "Years"
      value: "DAYOFYEAR"
    }
    allowed_value: {
      label: "Weeks"
      value: "DAYOFWEEK"
    }
    allowed_value: {
      label: "Months"
      value: "DAYOFMONTH"
    }
  }

  dimension: responded_dynamic_date {
    type: date
    sql: DATEADD(d, (-1 * {% parameter date_part %}(${TABLE}.date_field) + 1), ${TABLE}.date_field) ;;
  }

  parameter: date_finish {
    type: date
  }

  parameter: date_start {
    type: date
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: date1 {
    hidden: yes
    type: string
    sql: ${TABLE}.date1 ;;
  }

  dimension: timezone_offset {
    hidden: yes
    type: number
    sql: ${TABLE}.timezone_offset ;;
  }

  dimension: auction_date {
    hidden: yes
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
    label: "Placement Id"
    type: number
    sql: ${TABLE}.placementid ;;
  }

  dimension: country {
    group_label: "Location"
    type: string
    sql: ${TABLE}.country ;;
    map_layer_name: countries
    drill_fields: [state,city]
  }

  dimension: countrycode {
    group_label: "Location"
    type: string
    sql: ${TABLE}.countrycode ;;
    map_layer_name: countries
    drill_fields: [state,city]
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
    drill_fields: [city]
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
    label: "Mobile Inventory"
    type: string
    sql: ${TABLE}.m_inventory ;;
  }

  dimension: source {
    label: "Domain"
    type: string
    sql: ${TABLE}.source ;;
  }

  dimension: position {
    label:"Ad Position"
    type: string
    sql: ${TABLE}.position ;;
  }

  dimension: exchange2 {
    label: "Exchange"
    type: string
    sql: ${TABLE}.exchange2 ;;
  }


  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }


  dimension: rate {
    hidden: yes
    type: number
    sql: ${TABLE}.rate ;;
  }

  dimension: currency {
    hidden: yes
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: account_id {
    hidden: yes
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    view_label: "Accounts"
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: sub_account_id {
    hidden: yes
    type: number
    sql: ${TABLE}.sub_account_id ;;
  }

  dimension: sub_account {
    label: "Brand"
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
    label: "Creative Dimensions"
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
    hidden: yes
    type: string
    sql: ${TABLE}.origin_type ;;
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
    hidden: yes
    type: number
    sql: ${TABLE}.day_ts ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      date,week,month
    ]
    sql: CAST(CONCAT(substr(CAST(${TABLE}.day_ts as varchar), 1, 4),'-',substr(CAST(${TABLE}.day_ts as varchar), 5, 2),'-',substr(CAST(${TABLE}.day_ts as varchar), 7, 2)) As timestamp) ;;
  }

  dimension: hour_ts {
    label: "Hour"
    type: number
    sql: ${TABLE}.hour_ts ;;
  }
  dimension: auctions {
    hidden: yes
    type: number
    sql: ${TABLE}.auctions ;;
  }
  measure: total_bids {
    type: sum
    sql: ${auctions} ;;
    drill_fields: [detail*]
  }
  dimension: wins {
    hidden: yes
    type: number
    sql: ${TABLE}.wins ;;
  }

  measure: total_wins {
    type: sum

    sql: ${wins} ;;
    drill_fields: [detail*]
  }
  measure: Win_Rate {
    description: "Persentage of bids resulted in wins"
    type: number
    value_format_name: percent_2
    sql: 1.0*${total_wins}/NULLIF(${total_bids},0)  ;;
  }
  measure: eCPM {
    description: "Effective Cost of thousand Wins"
    type: number
    value_format_name: usd
    sql: 1000.0*${total_net_spend}/NULLIF(${total_wins},0)  ;;
  }
  dimension: impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.impressions ;;
  }

  measure: total_impressions {
    type: sum
    label: "Impressions"
    sql: ${impressions} ;;
    drill_fields: [detail*]
  }
  measure: Render_Rate {
    description: "Percentage of wins resulted in impressions"
    type: number
    value_format_name: percent_2
    sql: 1.0*${total_impressions}/NULLIF(${total_wins},0)  ;;
  }

  dimension: engagements {
    hidden: yes
    type: number
    sql: ${TABLE}.engagements ;;
  }

  measure: total_engagements {
    type: sum

    sql: ${engagements} ;;
    drill_fields: [detail*]
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
    link: {
      label: "Monthly Trend"
      url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/1"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }
  measure: eCPC {
    description: "Spend per Click"
    type: number
    value_format_name: usd
    sql: 1.0*${total_net_spend}/NULLIF(${total_clicks},0)  ;;
  }
  measure: CTR {
    description: "Click trough Rate"
    type: number
    value_format_name: percent_2
    sql: 1.0*${total_clicks}/NULLIF(${total_impressions},0)  ;;
  }
  dimension: spend {
    hidden: yes
    type: number
    sql: COALESCE(${TABLE}.spend,0) ;;
  }

  measure: total_net_spend {
    type: sum
    value_format_name: usd
    sql: ${spend} ;;
    drill_fields: [detail*]
  }


  measure: total_spend {
    type: sum
    value_format_name: usd
    sql: ${spend}*(1+cast(coalesce(${customer_fee},0) as double)/100) ;;
    drill_fields: [detail*]
  }


  dimension: downloads {
    hidden: yes
    type: number
    sql: ${TABLE}.downloads ;;
  }

  measure: total_downloads {
    type: sum
    sql: ${downloads} ;;
    drill_fields: [account_name,total_net_spend]
    link: {
      label: "Monthly Trend"
      url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/2"
      icon_url: "http://www.looker.com/favicon.ico"
    }
  }
  measure: CR {
    description: "Conversion Rate"
    type: number
    value_format_name: percent_3
    sql: 1.0*${total_downloads}/NULLIF(${total_clicks},0)  ;;
  }
  measure: eCPI {
    description: "Cost of Download"
    type: number
    value_format_name: usd
    sql: 1.0*${total_net_spend}/NULLIF(${total_downloads},0)  ;;
  }

  dimension: registers {
    hidden: yes
    type: number
    sql: ${TABLE}.registers ;;
  }
  measure: total_registers {
    type: sum
    sql: ${registers} ;;
    drill_fields: [detail*]
  }


  dimension: purchases {
    hidden: yes
    type: number
    sql: ${TABLE}.purchases ;;
  }
  measure: total_buys {
    type: sum
    sql: ${purchases} ;;
    drill_fields: [detail*]
  }

  measure: CPFT {
    description: "Effective Cost of first Transaction (Purchase)"
    type: number
    value_format_name: usd
    sql: 1.0*${total_spend}/NULLIF(${total_buys},0)  ;;
  }

  measure: eCPFT {
    description: "Cost of first Transaction (Purchase)"
    type: number
    value_format_name: usd
    sql: 1.0*${total_payout}/NULLIF(${total_buys},0)  ;;
  }

  dimension: video_start_counter {
    type: number
    hidden: yes
    sql: ${TABLE}.video_start_counter ;;
  }

  measure: total_video_ad_starts {
    type: sum
    sql: ${video_start_counter} ;;
    drill_fields: [detail*]
  }
  measure: VCPM {
    description: "Cost of thousand Video Ad Starts"
    type: number
    value_format_name: usd
    sql: 1000.0*${total_net_spend}/NULLIF(${total_video_ad_starts},0)  ;;
  }

  measure: fill_rate {
    description: "Video Ad Starts per Win"
    type: number
    value_format_name: percent_2
    sql: *${total_video_ad_starts}/NULLIF(${total_wins},0)  ;;
  }
  dimension: payout {
    hidden: yes
    type: number
    sql: ${TABLE}.payout ;;
  }

  measure: total_payout {
    type: sum
    value_format_name: usd
    sql: ${payout} ;;
    drill_fields: [detail*]
  }

  measure: RPM {
    description: "Revenue (Payout) per thousand impressions"
    type: number
    value_format_name: usd
    sql: 1000.0*${total_payout}/NULLIF(${total_impressions},0) ;;
    drill_fields: [detail*]
  }

  measure: total_profit {
    description: "Payout - Spend"
    type: number
    value_format_name: usd
    sql: (${total_payout}-${total_net_spend})  ;;
  }

  measure: ROI {
    description: "Return on Investment"
    type: number
    value_format_name: percent_2
    sql: (1.0*${total_payout}/NULLIF(${total_net_spend},0)-1)  ;;
  }
  measure: profit_margin {
    type: number
    value_format_name: percent_2
    sql: 1.0*${total_profit}/NULLIF(${total_payout},0)  ;;
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
