connection: "qubole_presto"

include: "*.view" # include all the views
include: "*.dashboard" # include all the dashboards


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
      value: "1"
    }
  }
}
