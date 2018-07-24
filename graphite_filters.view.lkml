

view: graphite_filters {

  derived_table: {
    sql:
     with filters as (select 0 as priority, 'Dynamic' as filter, 'Dynamic' as level1, null as level2, null as level3
union all
select f.priority, f.name as filter, f.parent as level1, f.name as level2,  null as level3
from spotad.gc_filters f where level=2
union all
select f.priority,f.name as filter,f1.parent as level1, f.parent as level1, f.name as level3
from spotad.gc_filters f left join spotad.gc_filters f1 on f.parent=f1.name
where f.level=3),

temp as (select day_ts, clone, campaign_id, ex,
if(metric='bids',data_avg,null) as after_dymanic,
if(metric='intoDynamicFilters',data_avg,null) as into_dymanic
from spotad.gc_metrics_prd
where day_ts=CAST(DATE_FORMAT(DATE(CURRENT_DATE),'%Y%m%d') AS INTEGER)
  and metric in ('bids','intoDynamicFilters'))

select day_ts, clone, cast(campaign_id as varchar) as campaign_id, ex,metric, filtered as num_of_filtered, level1, level2,level3
from
(select day_ts, clone, campaign_id, ex, 'Dynamic' as metric, (avg(into_dymanic) - avg(after_dymanic))*300 as filtered
 from temp
 group by 1,2,3,4,5
union all
select day_ts, clone, campaign_id, ex, metric, avg(data_avg)*300 as filtered
from spotad.gc_metrics_prd
where day_ts=CAST(DATE_FORMAT(DATE(CURRENT_DATE),'%Y%m%d') AS INTEGER)
group by 1,2,3,4,5) a join filters f on a.metric=f.filter;;
  }

  # Define your dimensions and measures here, like this:
  dimension: day_ts {
    description: "Date of the metrics format (yyyymmdd)"
    type: number
    sql: ${TABLE}.day_ts ;;
  }


  dimension: clone {
    label: "SLR Instance"
    description: "SLR Instance"
    type: number
    sql: ${TABLE}.clone ;;
  }

  dimension: campaign_id {
    label: "Campaign Id"
    description: "Campaign Id"
    full_suggestions: yes
    type: string
    can_filter: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: ex {
    label: "Exchange"
    description: "Exchange"
    type: string
    sql: ${TABLE}.ex ;;
  }

  dimension: metric {
    description: "The filter name"
    type: string
    sql: ${TABLE}.metric ;;
  }

  dimension: num_of_filtered {
    label: "Number of Filtered Bids"
    description: "The number of filtered bids"
    type: number
    hidden: yes
    sql: ${TABLE}.num_of_filtered ;;
  }

  measure: total_of_filtered {

    label: "Sum filtered bids"
    type: sum
    sql: ${num_of_filtered} ;;

  }

  dimension: level1 {
    label:"Filter Level 1"
    description: "The name of level 1 filter "
    type: string
    drill_fields:[level2,level3,ex]
    sql:${TABLE}.level1 ;;
  }

  dimension: level2 {
    label:"Filter Level 2"
    description: "The name of level 2 filter "
    type: string
    drill_fields:[level3,ex]
    sql:${TABLE}.level2 ;;
  }

  dimension: level3 {
    label:"Filter Level 3"
    description: "The name of level 3 filter "
    type: string
    drill_fields:[ex]
    sql:${TABLE}.level3 ;;
  }
}
