connection: "qubole_presto"

include: "*.view" # include all the views
include: "*.dashboard" # include all the dashboards


# ------ CACHING POLICY ------------------------------------
# datagroup: cahcing_policy {
#   sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }
# persist_with: cahcing_policy

persist_for: "24 hours"
# ----------------------------------------------------------


explore: dt_rawdata_summary_combined {
  always_filter: {
    filters: {
      field: number_days_to_analyse
      value: "30"
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
