connection: "qubole_presto"
label: "Internal Looker Model"
include: "*.view" # include all the views
include: "*.dashboard" # include all the dashboards


# ------ CACHING POLICY ------------------------------------
# datagroup: cahcing_policy {
#   sql_trigger: SELECT CURRENT_DATE;;
#   max_cache_age: "1 hour"
# }
# persist_with: cahcing_policy

persist_for: "24 hours"
# ----------------------------------------------------------

week_start_day: sunday

explore: dt_rawdata_summary_combined {
  label: "Daily Summary"
#    access_filter: {
#      field: account_id
#      user_attribute: account_id
#
#    }
  always_filter: {
    filters: {
      field: number_days_to_analyse

      value: "7"
    }
  }
}

explore: rawdata_sampling_orc {
  label: "Inventory Discovery"
#   access_filter: {
#     field: account_id
#     user_attribute: customer_account
#
#   }
  always_filter: {
   filters: {
      field: number_days_to_analyse
      value: "1"
    }
  }
}

explore: graphite_filters {
  label: "Graphite Filters"
#   access_filter: {
#     field: account_id
#     user_attribute: customer_account
#
#   }
}
  explore: exchange_supply_monitoring {
    label: "Exchange Supply Monitoring"
  always_filter: {
    filters: {
      field: number_days_to_analyse
      value: "7"
    }
}
}

explore: rawdata_summary_cm_orc_cn {
  group_label: "Daily Summary Reports"
  hidden: yes
  join: rt_rbo_placements {
    type: left_outer
    sql_on: ${rawdata_summary_cm_orc_cn.campaign_id} = ${rt_rbo_placements.campaign_id}
    AND ${rawdata_summary_cm_orc_cn.placementid} = ${rt_rbo_placements.placement_id}
    ;;
    relationship: many_to_one
  }
  sql_always_having: NOT (${engagements}  = 0) ;;
}
