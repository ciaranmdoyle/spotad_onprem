view: exchange_supply_monitoring {
  derived_table: {
    sql: with --not_mraid as(
      --select distinct auctionid
      --from spotad.rawdata_sampling_orc cross join unnest(impression.battr) as b(battr)
      --where   day_ts >= CAST(DATE_FORMAT(DATE(date_add('day',-{% parameter number_days_to_analyse %},CURRENT_DATE)),'%Y%m%d') AS INTEGER)
     -- AND day_ts <= CAST(DATE_FORMAT(DATE(date_add('day',-1,CURRENT_DATE)),'%Y%m%d') AS INTEGER) and ((exchange2 not in('adx','baidu','tencent') and battr.id =13) or (exchange2='adx' and battr.id =32))
      --),

      sampling as (select coalesce(exchange2,'Other') as Exchange,
      coalesce(geo.country,'Other') as GEO,
      coalesce(inventory_type,'Other') as site_app,
      case
      when device_type in(1,4,5) then 'Mobile'
      when device_type=2 then 'Desktop'
      when device_type=3 then 'CTV'
      else 'Other'
      end as device_type,
      coalesce(ad_type,'Other') as AdType,
      coalesce(ibv_allowed,0) as IBVallowed,
      coalesce(rewarded_video,0) as rewarded,
      --case
      --when auctionid in (select auctionid from not_mraid) then 0
      --else 1 end as MRAID,
      impression.formats as creative_size,
      count (1)*200 as bid_requests,
      sum (if (deals is not null,if(deals[1].id is not null,1,0),0))*200 as pmp_sample,
      avg(if(exchange2 in ('baidu','tanx','weibo','sina','tencent'),0.15 * if(bid_floor is not null ,bid_floor, deals[1].bidfloor ),if(bid_floor is not null ,bid_floor, deals[1].bidfloor ))) as bid_floor_sample
      from spotad.rawdata_sampling_orc
      where  day_ts >= CAST(DATE_FORMAT(DATE(date_add('day',-{% parameter number_days_to_analyse %},CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      AND day_ts <= CAST(DATE_FORMAT(DATE(date_add('day',-1,CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      group by 1,2,3,4,5,6,7,8 ),

      prod_all as (select coalesce(exchange2,'Other') as Exchange,
      coalesce(geo.country,'Other') as GEO,
      coalesce(inventory_type,'Other') as site_app,
      case
      when device_type in(1,4,5) then 'Mobile'
      when device_type=2 then 'Desktop'
      when device_type=3 then 'CTV'
      else 'Other'
      end as device_type,
      coalesce(ad_type,'Other') as AdType,
      coalesce(ibv_allowed,0) as IBVallowed,
      coalesce(rewarded_video,0) as rewarded,
      impression.formats as creative_size,
      count (1) as bid_response,
      sum (if (deals is not null,if(deals[1].id is not null,1,0),0)) as pmp,
      avg(if(exchange2 in ('baidu','tanx','weibo','sina','tencent'),0.15 * if(bid_floor is not null ,bid_floor, deals[1].bidfloor ),if(bid_floor is not null ,bid_floor, deals[1].bidfloor ))) as bid_floor,
      sum (winprice)/1000000 AS spend
      from spotad.rawdata_orc
      where  day_ts >= CAST(DATE_FORMAT(DATE(date_add('day',-{% parameter number_days_to_analyse %},CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      AND day_ts <= CAST(DATE_FORMAT(DATE(date_add('day',-1,CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      group by 1,2,3,4,5,6,7,8

      union all
      select coalesce(exchange2,'Other') as Exchange,
      coalesce(geo.country,'Other') as GEO,
      coalesce(inventory_type,'Other') as site_app,
      case
      when device_type in(1,4,5) then 'Mobile'
      when device_type=2 then 'Desktop'
      when device_type=3 then 'CTV'
      else 'Other'
      end as device_type,
      coalesce(ad_type,'Other') as AdType,
      coalesce(ibv_allowed,0) as IBVallowed,
      coalesce(rewarded_video,0) as rewarded,
      impression.formats as creative_size,
      count (1) as bid_response,
      sum (if (deals is not null,if(deals[1].id is not null,1,0),0)) as pmp,
      avg(if(exchange2 in ('baidu','tanx','weibo','sina','tencent'),0.15 * if(bid_floor is not null ,bid_floor, deals[1].bidfloor ),if(bid_floor is not null ,bid_floor, deals[1].bidfloor ))) as bid_floor,
      sum (winprice)/6666667 AS spend
      from spotad.rawdata_orc_cn
      where  day_ts >= CAST(DATE_FORMAT(DATE(date_add('day',-{% parameter number_days_to_analyse %},CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      AND day_ts <= CAST(DATE_FORMAT(DATE(date_add('day',-1,CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      group by 1,2,3,4,5,6,7,8

      union all
      select coalesce(exchange2,'Other') as Exchange,
      coalesce(geo.country,'Other') as GEO,
      coalesce(inventory_type,'Other') as site_app,
      case
      when device_type in(1,4,5) then 'Mobile'
      when device_type=2 then 'Desktop'
      when device_type=3 then 'CTV'
      else 'Other'
      end as device_type,
      coalesce(ad_type,'Other') as AdType,
      coalesce(ibv_allowed,0) as IBVallowed,
      coalesce(rewarded_video,0) as rewarded,
      impression.formats as creative_size,
      count (1)*10 as bid_response,
      sum (if (deals is not null,if(deals[1].id is not null,1,0),0))*10 as pmp,
      avg(if(exchange2 in ('baidu','tanx','weibo','sina','tencent'),0.15 * if(bid_floor is not null ,bid_floor, deals[1].bidfloor ),if(bid_floor is not null ,bid_floor, deals[1].bidfloor ))) as bid_floor,
      sum (winprice)/1000000 AS spend
      from spotad.rawdata_lose_orc
      where  day_ts >= CAST(DATE_FORMAT(DATE(date_add('day',-{% parameter number_days_to_analyse %},CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      AND day_ts <= CAST(DATE_FORMAT(DATE(date_add('day',-1,CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      group by 1,2,3,4,5,6,7,8

      union all
      select coalesce(exchange2,'Other') as Exchange,
      coalesce(geo.country,'Other') as GEO,
      coalesce(inventory_type,'Other') as site_app,
      case
      when device_type in(1,4,5) then 'Mobile'
      when device_type=2 then 'Desktop'
      when device_type=3 then 'CTV'
      else 'Other'
      end as device_type,
      coalesce(ad_type,'Other') as AdType,
      coalesce(ibv_allowed,0) as IBVallowed,
      coalesce(rewarded_video,0) as rewarded,
      impression.formats as creative_size,
      count (1)*10 as bid_response,
      sum (if (deals is not null,if(deals[1].id is not null,1,0),0))*10 as pmp,
      avg(if(exchange2 in ('baidu','tanx','weibo','sina','tencent'),0.15 * if(bid_floor is not null ,bid_floor, deals[1].bidfloor ),if(bid_floor is not null ,bid_floor, deals[1].bidfloor ))) as bid_floor,
      sum (winprice)/6666667 AS spend
      from spotad.rawdata_lose_orc_cn
      where  day_ts >= CAST(DATE_FORMAT(DATE(date_add('day',-{% parameter number_days_to_analyse %},CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      AND day_ts <= CAST(DATE_FORMAT(DATE(date_add('day',-1,CURRENT_DATE)),'%Y%m%d') AS INTEGER)
      group by 1,2,3,4,5,6,7,8
      ),

      prod_sum as (select  Exchange,
      GEO,
      site_app,
      device_type,
      AdType,
      IBVallowed,
      rewarded,
      creative_size,
      sum (bid_response) as bid_respones,
      sum (pmp) as pmps,
      sum (bid_floor*bid_response)/sum (bid_response) as avg_bid_floor,
      sum (spend) as spend
      from prod_all
      group by 1,2,3,4,5,6,7,8)

      select s.Exchange,
      s.GEO,
      s.site_app,
      s.device_type,
      s.AdType,
      s.IBVallowed,
      s.rewarded,
      s.creative_size,
      s.bid_requests,
      s.pmp_sample,
      s.bid_floor_sample,
      p.bid_respones,
      --p.pmps,
      p.avg_bid_floor,
      p.spend
      from sampling s full join prod_sum p
      on s.Exchange= p.Exchange
      and s.GEO=p.GEO
      and s.site_app=p.site_app
      and s.device_type = p.device_type
      and s.AdType = p.AdType
      and s.IBVallowed = p.IBVallowed
      and s.rewarded=p.rewarded
      and s.creative_size = p.creative_size
       ;;
  }

  suggestions: no

  parameter: number_days_to_analyse {
    type: number
    default_value: "1"
    allowed_value: {
      label: "Day"
      value: "1"
    }
    allowed_value: {
      label: "7 Days"
      value: "7"
    }

    label: "# Days to Analyse"
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  dimension: exchange {
    type: string
    sql: ${TABLE}.exchange ;;
  }

  dimension: geo {
    type: string
    sql: ${TABLE}.geo ;;
  }

  dimension: site_app {
    type: string
    sql: ${TABLE}.site_app ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: adtype {
    type: string
    sql: ${TABLE}.adtype ;;
  }

  dimension: ibvallowed {
    type: number
    sql: ${TABLE}.ibvallowed ;;
  }

  dimension: rewarded {
    type: number
    sql: ${TABLE}.rewarded ;;
  }

  dimension: creative_size {
    type: string
    sql: ${TABLE}.creative_size ;;
  }

  dimension: bid_requests {
    type: number
    sql: ${TABLE}.bid_requests ;;
  }

  dimension: pmp_sample {
    type: number
    sql: ${TABLE}.pmp_sample ;;
  }

  dimension: bid_floor_sample {
    type: number
    sql: ${TABLE}.bid_floor_sample ;;
  }

  dimension: bid_respones {
    type: number
    sql: ${TABLE}.bid_respones ;;
  }

  dimension: avg_bid_floor {
    type: number
    sql: ${TABLE}.avg_bid_floor ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }

  set: detail {
    fields: [
      exchange,
      geo,
      site_app,
      device_type,
      adtype,
      ibvallowed,
      rewarded,
      creative_size,
      bid_requests,
      pmp_sample,
      bid_floor_sample,
      bid_respones,
      avg_bid_floor,
      spend
    ]
  }
}
