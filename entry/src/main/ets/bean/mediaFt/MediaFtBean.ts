// 年会不能停：1920 * 804
import Dimension from '../Dimension'
import Stat from '../Stat'

// https://api.bilibili.com/pgc/view/web/season?season_id=45735
export class MediaFtBean{
        actors: string
        alias: string
        bkg_cover:string
        cover: string
        delivery_fragment_video: boolean
        enable_vt: boolean
        episodes: MediaFtEpisodesBean[] =[]

        evaluate: string

        icon_font: {
            name: string
            text: string
        }
        jp_title:string
        link: string
        media_id: number
        mode: number
        new_ep: {
            desc: string
            id: number
            is_new: number
            title: string
        }

        rating: {
            count: number
            score: number
        }

        season_id: number
        season_title: string
        seasons: []
        section: MediaFtSectionBean[]=[]
        series: {
            display_type:number
            series_id:number
            series_title:string
        }
        share_copy: string
        share_sub_title: string
        share_url: string
        show: {
            wide_screen: number
        }
        show_season_type: number
        square_cover: string
        staff: string
        stat: Stat
        status: number
        styles: string[]
        subtitle: string
        title: string
        total: number
        type: number
        up_info: {
            avatar: string
            avatar_subscript_url:string
            follower: number
            is_follow:number
            mid: number
            nickname_color: string
            pendant: {
                image:string
                name:string
                pid:number
            }
            theme_type:number
            uname: string
            verify_type: number
            vip_label: {
                bg_color: string
                bg_style: number
                border_color:string
                text: string
                text_color:string
            }
            vip_status: number
            vip_type: number
        }
        user_status: {
            area_limit: number
            ban_area_show:number
            follow:number
            follow_status:number
            login:number
            pay:number
            pay_pack_paid:number
            sponsor:number
        }
}
export class MediaFtSectionBean{
  attr: number
  episode_id: number
  episode_ids: []
  episodes: MediaFtEpisodesBean[]
  id: number
  title: string
  type: number
  type2: number
}

export class MediaFtEpisodesBean{
  aid: number
  badge: string
  badge_info: {
    bg_color: string
    bg_color_night: string
    text: string
  }
  badge_type: number
  bvid: string
  cid: number
  cover: string
  dimension: Dimension
  duration: number
  enable_vt: boolean
  ep_id: number
  from: string
  id: number
  is_view_hide: boolean
  link: string
  long_title:string
  pub_time: number
  pv: number
  release_date:string
  rights: {
    allow_demand: number
    allow_dm: number
    allow_download: number
    area_limit: number
  }
  share_copy: string
  share_url: string
  short_link: string
  showDrmLoginDialog: boolean
  status: number
  subtitle: string
  title: string
  vid:string
}