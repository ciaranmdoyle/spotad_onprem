connection: "qubole_presto"

include: "*.view" # include all the views
include: "*.dashboard" # include all the dashboards

datagroup: cahcing_policy {
#   sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}
persist_with: cahcing_policy


explore: dt_rawdata_summary_combined {

  persist_for: "24 hour"
  always_filter: {
    filters: {
      field: date_start
    }
    filters: {
      field: date_finish
    }

  }
}


explore: rawdata_summary_cm_orc_cn {
  group_label: "Daily Summary Reports"
  join: rt_rbo_placements {
    type: left_outer
    sql_on: ${rawdata_summary_cm_orc_cn.campaign_id} = ${rt_rbo_placements.campaign_id}
    AND ${rawdata_summary_cm_orc_cn.placementid} = ${rt_rbo_placements.placement_id}
    ;;
    relationship: many_to_one
  }


  #join: rawdata_orc {
  #  type: left_outer
  #  sql_on: ${rawdata_orc.actualwinprice}=${rawdata_orc.ad_context} ;;
  #  relationship: many_to_one
  #}
}


# explore: conversiondata_orc_stg {}
# explore: rawdata_lose_orc_stg {}
# explore: rawdata_orc_stg {}
# explore: rawdata_sampling_orc {}
# explore: rawdata_summary_cm_orc_stg {}
# explore: rt_rbo_placements {}
