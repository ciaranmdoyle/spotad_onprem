connection: "qubole_presto"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: staging_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: staging_default_datagroup

explore: conversiondata_orc_stg {}

explore: rawdata_lose_orc_stg {}

explore: rawdata_orc_stg {}

explore: rawdata_sampling_orc {}

explore: rawdata_summary_cm_orc_stg {}

explore: rt_rbo_placements {}

explore: rawdata_summary_cm_orc_cn {
group_label: "Daily Summary Reports"
  #join: rawdata_orc {
  #  type: left_outer
  #  sql_on: ${rawdata_orc.actualwinprice}=${rawdata_orc.ad_context} ;;
  #  relationship: many_to_one
  #}
}
