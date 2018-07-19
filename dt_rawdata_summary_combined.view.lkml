view: dt_rawdata_summary_combined {
  view_label: "Daily Summary"
#   suggestions: no
  derived_table: {
    sql:
    SELECT *
      FROM
      hive.spotad.rawdata_summary_cm_orc_cn
      WHERE
      day_ts >= CAST(DATE_FORMAT(DATE(date_add('day',-{% parameter number_days_to_analyse %},CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      AND day_ts <= CAST(DATE_FORMAT(DATE(date_add('day',-1,CURRENT_DATE)),'%Y%m%d') AS INTEGER)

      UNION ALL
      SELECT *
      FROM
      hive.spotad.rawdata_summary_cm_orc_prd
      WHERE
      day_ts >= CAST(DATE_FORMAT(DATE(date_add('day',-{% parameter number_days_to_analyse %},CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      AND day_ts <= CAST(DATE_FORMAT(DATE(date_add('day',-1,CURRENT_DATE)),'%Y%m%d') AS INTEGER)

       ;;
#       --{% if timeframe.value = "Monthly" %}
#       --day_ts >= CAST(DATE_FORMAT(DATE(DATE_ADD('month',-1,current_date)),'%Y%m%d') AS INTEGER)
#       --{% else if timeframe.value = "Weekly" %}
#       --day_ts >= CAST(DATE_FORMAT(DATE(DATE_ADD('week',-1,current_date)),'%Y%m%d') AS INTEGER)
#       --{% else %}
#       --day_ts >= CAST(DATE_FORMAT(DATE(DATE_ADD('day',-1,current_date)),'%Y%m%d') AS INTEGER)
#       --{% endif %}
    }
    parameter: number_days_to_analyse {
      type: number
      label: "# Days to Analyse"
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
      hidden: yes
      sql: DATEADD(d, (-1 * {% parameter date_part %}(${TABLE}.date_field) + 1), ${TABLE}.date_field) ;;
    }

    parameter: date_finish {
      type: date
    }

    parameter: date_start {
      type: date
    }

    measure: count {
      view_label: "Other Measures"
      hidden: yes
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
      hidden: yes
      type: string
      sql: ${TABLE}.datacenter ;;
    }

    dimension: vertical {
      view_label: "Targeting"
      type: string
      sql: COALESCE(${TABLE}.vertical,'Other') ;;
    }

    dimension: vertical_parent {
      view_label: "Targeting"
      type: string
      sql: COALESCE(${TABLE}.vertical_parent,'Other') ;;
    }

    dimension: placementid {
      view_label: "Identifiers"
      label: "Placement Id"
      type: number
      sql: ${TABLE}.placementid ;;
    }

    dimension: country {
      view_label:"Targeting"
      group_label: "Location"
      type: string
      map_layer_name: countries
      drill_fields: [state,city]
      sql:
          CASE
                WHEN ${TABLE}.country LIKE ('%America%') THEN 'United States'
                WHEN ${TABLE}.country LIKE ('%Korea%') THEN 'South Korea'
                WHEN ${TABLE}.country LIKE ('%Bahamas%') THEN 'Bahamas'
                WHEN ${TABLE}.country LIKE ('%Gambia%') THEN 'Gambia'
                WHEN ${TABLE}.country LIKE ('%Virgin Islands, British%') THEN 'British Virgin Islands'
                WHEN ${TABLE}.country LIKE ('%Virgin Islands, U%') THEN 'U.S. Virgin Islands'
                WHEN ${TABLE}.country LIKE ('%Bolivia, Pl%') THEN 'Bolivia'

                ELSE COALESCE(${TABLE}.country,'Other')
              END

                ;;
    }

    dimension: countrycode {
      view_label:"Targeting"
      group_label: "Location"
      type: string
      sql: COALESCE(${TABLE}.countrycode,'Other') ;;
      map_layer_name: countries
      drill_fields: [state,city]
    }

    dimension: city {
      view_label:"Targeting"
      group_label: "Location"
      type: string
      sql: COALESCE(${TABLE}.city,'Other') ;;
    }

    dimension: citycode {
      view_label:"Targeting"
      group_label: "Location"
      type: string
      sql: COALESCE(${TABLE}.citycode,'Other') ;;
    }

    dimension: state {
      view_label:"Targeting"
      group_label: "Location"
      type: string
      sql: COALESCE(${TABLE}.state,'Other') ;;
      drill_fields: [city]
    }

    dimension: statecode {
      view_label:"Targeting"
      group_label: "Location"
      type: string
      sql: COALESCE(${TABLE}.statecode,'Other') ;;
    }

    dimension: device_model {
      view_label: "Targeting"
      type: string
      sql: COALESCE(${TABLE}.device_model,'Other') ;;
    }

    dimension: mobile_os {
      view_label: "Targeting"
      type: string
      sql: COALESCE(${TABLE}.mobile_os,'Other') ;;
    }

    dimension: os_version {
      view_label: "Targeting"
      type: string
      sql: COALESCE(${TABLE}.os_version,'Other') ;;
    }

    dimension: m_inventory {
      hidden: yes
      type: string
      sql: ${TABLE}.m_inventory ;;
    }
    dimension: device_type {
      hidden: yes
      type: number
      sql: ${TABLE}.device_type ;;
    }
    dimension: inventory_type {
      view_label: "Targeting"
      label: "Inventory Type"
      type: string
      sql:if( ${TABLE}.device_type=2,'Desktop', if(${TABLE}.device_type=3,'Connected TV',${TABLE}.m_inventory)) ;;
    }


    dimension: source {
      view_label: "Targeting"
      label: "Domain"
      type: string
      sql: COALESCE(${TABLE}.source,'Other') ;;
    }

    dimension: position {
      view_label: "Targeting"
      case: {

        when: {
          sql: ${TABLE}.position ='1' ;;
          label: "Above the Fold"
        }
        when: {
          sql: ${TABLE}.position ='3' ;;
          label: "Below the Fold"
        }

        when: {
          sql: ${TABLE}.position = '4' ;;
          label: "Header"
        }
        when: {
          sql: ${TABLE}.position = '5' ;;
          label: "Footer"
        }
        when: {
          sql: ${TABLE}.position = '6' ;;
          label: "Sidebar"
        }
        when: {
          sql: ${TABLE}.position = '7' ;;
          label: "Full Screen"
        }


        else: "Other"

      }
      label:"Ad Position"
      type: string
      #sql: ${TABLE}.position ;;
    }

    dimension: exchange2 {
      view_label: "Targeting"
      case: {
        when: {
          sql: ${TABLE}.exchange2 = 'omax' ;;
          label: "Adcolony"
        }
        when: {
          sql: ${TABLE}.exchange2 = 'adx' ;;
          label: "Google"
        }
        when: {
          sql: ${TABLE}.exchange2 = 'applovin' ;;
          label: "Applovin"
        }
        when: {
          sql: ${TABLE}.exchange2 = 'baidu' ;;
          label: "Baidu"
        }
        when: {
          sql: ${TABLE}.exchange2 = 'fyber' ;;
          label: "Fyber"
        }
        when: {
          sql: ${TABLE}.exchange2 = 'mopub' ;;
          label: "Mopub"
        }
        when: {
          sql: ${TABLE}.exchange2 = 'pubmatic' ;;
          label: "Pubmatic"
        }
        when: {
          sql: ${TABLE}.exchange2 = 'rubicon' ;;
          label: "Rubicon"
        }
        when: {
          sql: ${TABLE}.exchange2 = 'smaato' ;;
          label: "Smaato"
        }
        when: {
          sql: ${TABLE}.exchange2 = 'smaato_cn' ;;
          label: "Smaato_cn"
        }
        when: {
          sql: ${TABLE}.exchange2 = 'tencent' ;;
          label: "Tencent"
        }

        else: "Other"

      }
      label: "Exchange"
      type: string
      #sql: ${TABLE}.exchange2 ;;

    }


    dimension: model {
      view_label: "Strategy"
      type: string
      sql: COALESCE(${TABLE}.model,'Other');;


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
      view_label: "Identifiers"
      hidden: yes
      type: number
      sql: ${TABLE}.account_id ;;
    }

    dimension: account_name {
      view_label: "Identifiers"
      type: string
      sql: ${TABLE}.account_name ;;
    }

    dimension: sub_account_id {
      view_label: "Identifiers"
      hidden: yes
      type: number
      sql: ${TABLE}.sub_account_id ;;
    }

    dimension: sub_account {
      view_label: "Identifiers"
      label: "Brand"
      type: string
      sql: ${TABLE}.sub_account ;;
    }

    dimension: campaign_id {
      view_label: "Identifiers"
      type: number
      sql: ${TABLE}.campaign_id ;;
    }

    dimension: campaign_name {
      view_label: "Identifiers"
      type: string
      sql: ${TABLE}.campaign_name ;;
    }

    dimension: goal_type {
      view_label: "General"
      type: string
      sql: COALESCE(${TABLE}.goal_type,'Other') ;;
    }

    dimension: goal_value {
      view_label: "General"
      type: number
      sql: ${TABLE}.goal_value ;;
    }

    dimension: ad_type {
      view_label: "Creative"
      type: string
      sql: COALESCE(${TABLE}.ad_type,'Other') ;;
    }

    dimension: daily_budget {
      view_label: "General"
      type: number
      sql: ${TABLE}.daily_budget ;;
    }

    dimension: banner_size {
      view_label: "Creative"
      label: "Creative Dimensions"
      type: string
      sql: COALESCE(${TABLE}.banner_size,'Dimensions undefined for Vast/Natie creative') ;;
    }

    dimension: publisher_id {
      view_label: "Targeting"
      type: string
      sql: COALESCE(${TABLE}.publisher_id,'Other') ;;
    }

    dimension: placement_name {
      view_label: "Identifiers"
      type: string
      sql: ${TABLE}.placement_name ;;
    }

    dimension: customer_fee {
      view_label: "General"
      type: number
      sql: ${TABLE}.customer_fee ;;
    }

    dimension: origin_type {
      hidden: yes
      type: string
      sql: ${TABLE}.origin_type ;;
    }


    dimension: model_external_id {
      view_label: "Strategy"
      type: string
      sql: $COALESCE(${TABLE}.model_external_id,'Other') ;;
    }



    dimension: day_ts {
      hidden: yes
      type: number
      sql: ${TABLE}.day_ts ;;
    }

    dimension_group: date {
      view_label:"General"
      label: "Date"
      type: time
      timeframes: [
        date,week,month
      ]
      sql: CAST(CONCAT(substr(CAST(${TABLE}.day_ts as varchar), 1, 4),'-',substr(CAST(${TABLE}.day_ts as varchar), 5, 2),'-',substr(CAST(${TABLE}.day_ts as varchar), 7, 2)) As timestamp) ;;
    }

    dimension: hour_ts {
      view_label: "General"
      label: "Hour"
      type: number
      sql: ${TABLE}.hour_ts ;;
    }


    parameter: measure_picker {
      type: string
      label: "Choose Calculated Measure"
      allowed_value: { value: "eCPC" }
      allowed_value: { value: "CPFT" }
      allowed_value: { value: "eCPM" }
      allowed_value: { value: "VCPM" }
      allowed_value: { value: "CR" }
      allowed_value: { value: "CTR" }
      allowed_value: { value: "eCPI" }
      allowed_value: { value: "Profit Margin" }
      allowed_value: { value: "Render Rate" }
      allowed_value: { value: "Win Rate" }
    }


    measure: cohort_values {
      type: number
      label: "Calculated Measure"
      sql: CASE
        WHEN {% parameter measure_picker %} = 'eCPC' THEN ${eCPC}
        WHEN {% parameter measure_picker %} = 'CPFT' THEN ${CPFT}
        WHEN {% parameter measure_picker %} = 'eCPM' THEN ${eCPM}
        WHEN {% parameter measure_picker %} = 'VCPM' THEN ${VCPM}
        WHEN {% parameter measure_picker %} = 'CR' THEN ${CR}
        WHEN {% parameter measure_picker %} = 'CTR' THEN ${CTR}
        WHEN {% parameter measure_picker %} = 'eCPI' THEN ${eCPI}
        WHEN {% parameter measure_picker %} = 'Profit Margin' THEN ${profit_margin}
        WHEN {% parameter measure_picker %} = 'Render Rate' THEN ${Render_Rate}
        WHEN {% parameter measure_picker %} = 'Win Rate' THEN ${Win_Rate}
        ELSE 0
      END ;;
    }

  parameter: measure_picker_2 {
    type: string
    label: "Choose Summirised Measure"
    allowed_value: { value: "Bids" }
    allowed_value: { value: "Clicks" }
    allowed_value: { value: "Downloads" }
    allowed_value: { value: "Impressions" }
    allowed_value: { value: "Payout" }
    allowed_value: { value: "Profit" }
    allowed_value: { value: "Purchses" }
    allowed_value: { value: "Registers" }
    allowed_value: { value: "Spend" }
    allowed_value: { value: "Video Ad Starts" }
    allowed_value: { value: "Wins" }

  }
  measure: cohort_values_2 {
    type: number
    label: "Summirised Measure"
    sql: CASE
        WHEN {% parameter measure_picker_2 %} = 'Bids' THEN ${total_bids}
        WHEN {% parameter measure_picker_2 %} = 'Clicks' THEN ${total_clicks}
        WHEN {% parameter measure_picker_2 %} = 'Downloads' THEN ${total_downloads}
        WHEN {% parameter measure_picker_2 %} = 'Impressions' THEN ${total_impressions}
        WHEN {% parameter measure_picker_2 %} = 'Payout' THEN ${total_payout}
        WHEN {% parameter measure_picker_2 %} = 'Profit' THEN ${total_profit}
        WHEN {% parameter measure_picker_2 %} = 'Purchses' THEN ${total_purchases}
        WHEN {% parameter measure_picker_2 %} = 'Registers' THEN ${total_registers}
        WHEN {% parameter measure_picker_2 %} = 'Spend' THEN ${total_net_spend}
        WHEN {% parameter measure_picker_2 %} = 'Video Ad Starts' THEN ${total_video_ad_starts}
        WHEN {% parameter measure_picker_2 %} = 'Wins' THEN ${total_wins}
        ELSE 0
      END ;;
  }

    #--------------------MEASURES-----------------------------------------------------------------
    dimension: auctions {
      hidden: yes
      type: number
      sql: ${TABLE}.auctions ;;
    }
    measure: total_bids {
      view_label: "Top Measures"
      label: "Bids"
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
      view_label: "Top Measures"
      label:  "Wins"
      type: sum
      sql: ${wins} ;;
      drill_fields: [detail*]
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/22"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    measure: Win_Rate {
      view_label: "Rate Measures"
      label: "Win Rate"
      description: "Persentage of bids resulted in wins"
      type: number
      value_format_name: percent_2
      sql: 1.0*${total_wins}/NULLIF(${total_bids},0)  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/15"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    measure: eCPM {
      view_label: "Cost Measures"
      label:"eCPM"
      description: "Effective Cost of thousand Wins"
      type: number
      value_format_name: usd
      sql: 1000.0*${total_net_spend}/NULLIF(${total_wins},0)  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/12"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    dimension: impressions {
      hidden: yes
      type: number
      sql: ${TABLE}.impressions ;;
    }

    measure: total_impressions {
      view_label: "Top Measures"
      label:  "Impressions"
      type: sum
      sql: ${impressions} ;;
      drill_fields: [detail*]
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/19"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    measure: Render_Rate {
      view_label: "Rate Measures"
      label:  "Render Rate"
      description: "Percentage of wins resulted in impressions"
      type: number
      value_format_name: percent_2
      sql: 1.0*${total_impressions}/NULLIF(${total_wins},0)  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/14"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }

    dimension: engagements {
      hidden: yes
      type: number
      sql: ${TABLE}.engagements ;;
    }

    measure: total_engagements {
      view_label: "Other Measures"
      label:  "Engagments"
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
      view_label: "Top Measures"
      label: "Clicks"
      type: sum
      sql: ${clicks} ;;
      drill_fields: [detail*,-auctions]
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/1"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    measure: eCPC {
      view_label: "Cost Measures"
      label:  "eCPC"
      description: "Spend per Click"
      type: number
      value_format_name: decimal_2
      sql: 1.0*${total_net_spend}/NULLIF(${total_clicks},0)  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/13"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    measure: CTR {
      view_label: "Rate Measures"
      label: "CTR"
      description: "Click trough Rate"
      type: number
      value_format_name: percent_2
      sql: 1.0*${total_clicks}/NULLIF(${total_impressions},0)  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/8"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    dimension: spend {
      hidden: yes
      type: number
      sql: COALESCE(${TABLE}.spend,0) ;;
    }

    measure: total_net_spend {
      view_label: "Top Measures"
      label: "Spend"
      type: sum
      value_format_name: usd
      sql: ${spend} ;;
      drill_fields: [detail*]
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/5"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }


    measure: total_spend {
      view_label: "Other Measures"
      label: "Total Spend"
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
      view_label: "Top Measures"
      label: "Downloads"
      type: sum
      sql: ${downloads} ;;
      drill_fields: [account_name,total_net_spend]
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/2"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    measure: CR {
      view_label: "Rate Measures"
      label:  "CR"
      description: "Conversion Rate"
      type: number
      value_format_name: percent_3
      sql: 1.0*${total_downloads}/NULLIF(${total_clicks},0)  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/9"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    measure: eCPI {
      view_label: "Cost Measures"
      label: "eCPI"
      description: "Cost of Download"
      type: number
      value_format_name: usd
      sql: 1.0*${total_net_spend}/NULLIF(${total_downloads},0)  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/10"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }

    dimension: registers {
      hidden: yes
      type: number
      sql: ${TABLE}.registers ;;
    }
    measure: total_registers {
      view_label: "Other Measures"
      label: "Registers"
      type: sum
      sql: ${registers} ;;
      drill_fields: [detail*]
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/17"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }


    dimension: purchases {
      hidden: yes
      type: number
      sql: ${TABLE}.purchases ;;
    }
    measure: total_purchases {
      view_label: "Other Measures"
      label: "Purchases"
      type: sum
      sql: ${purchases} ;;
      drill_fields: [detail*]
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/18"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }

    measure: CPFT {
      view_label: "Cost Measures"
      label: "CPFT"
      description: "Effective Cost of first Transaction (Purchase)"
      type: number
      value_format_name: usd
      sql: 1.0*${total_spend}/NULLIF(${total_purchases},0)  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/20"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }

    measure: eCPFT {
      view_label: "Cost Measures"
      label: "eCPFT"
      description: "Cost of first Transaction (Purchase)"
      type: number
      value_format_name: usd
      sql: 1.0*${total_payout}/NULLIF(${total_purchases},0)  ;;
    }

    dimension: video_start_counter {
      type: number
      hidden: yes
      sql: ${TABLE}.video_start_counter ;;
    }

    measure: total_video_ad_starts {
      view_label: "Video Measures"
      label: "Video Ad Starts"
      type: sum
      sql: ${video_start_counter} ;;
      drill_fields: [detail*]
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/6"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    measure: VCPM {
      view_label: "Video Measures"
      label: "VCPM"
      description: "Cost of thousand Video Ad Starts"
      type: number
      value_format_name: usd
      sql: 1000.0*${total_net_spend}/NULLIF(${total_video_ad_starts},0)  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/21"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }

    measure: fill_rate {
      view_label: "Video Measures"
      label: "Fill Rate"
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
      view_label: "Other Measures"
      label: "Payout"
      type: sum
      value_format_name: usd
      sql: ${payout} ;;
      drill_fields: [detail*]
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/16"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }

    measure: RPM {
      view_label: "Video Measures"
      label: "RPM"
      description: "Revenue (Payout) per thousand impressions"
      type: number
      value_format_name: usd
      sql: 1000.0*${total_payout}/NULLIF(${total_impressions},0) ;;
      drill_fields: [detail*]
    }

    measure: total_profit {
      view_label: "Other Measures"
      label: "Profit"
      description: "Payout - Spend"
      type: number
      value_format_name: usd
      sql: (${total_payout}-${total_net_spend})  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/7"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }

    measure: ROI {
      view_label: "Rate Measures"
      label: "ROI"
      description: "Return on Investment"
      type: number
      value_format_name: percent_2
      sql: (1.0*${total_payout}/NULLIF(${total_net_spend},0)-1)  ;;
      link: {
        label: "Trend Over Time"
        url: "https://ec2-34-229-34-243.compute-1.amazonaws.com:9999/looks/11"
        icon_url: "http://www.looker.com/favicon.ico"
      }
    }
    measure: profit_margin {
      view_label: "Rate Measures"
      label: "Profit Margin"
      type: number
      value_format_name: percent_2
      sql: 1.0*${total_profit}/NULLIF(${total_payout},0)  ;;
    }

#-------------------------------DRILLS-------------------------------------------------------
    set: detail {
      fields: [
        vertical,
        vertical_parent,
        placementid,
        country,
        city,
        state,
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
        account_name,
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
        payout,
        model_external_id,
        device_type,
        day_ts,
        hour_ts
      ]
    }
  }
