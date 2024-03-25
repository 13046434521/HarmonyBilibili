// 年会不能停：1920 * 804
// https://api.bilibili.com/pgc/view/web/season?season_id=45735
export class MediaFtBean{
        actors: string
        alias: string
        bkg_cover:string
        cover: string
        delivery_fragment_video: boolean
        enable_vt: boolean
        episodes: MediaFtEpisodesBean[]

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
        section: MediaFtSectionBean[]
        series: {
            display_type: 0
            series_id: 0
            series_title:string
        }
        share_copy: string
        share_sub_title: string
        share_url: string
        show: {
            wide_screen: 1
        }
        show_season_type: 2
        square_cover: string
        staff: string
        stat: {
            coins: 158967
            danmakus: 83267
            favorite: 55957
            favorites: 494176
            follow_text: string
            likes: 237467
            reply: 12189
            share: 49013
            views: 19105309
            vt: 0
        }
        status: 13
        styles: string[]
        subtitle: string
        title: string
        total: 1
        type: 2
        up_info: {
            avatar: string
            avatar_subscript_url:string
            follower: 7632413
            is_follow: 0
            mid: 15773384
            nickname_color: string
            pendant: {
                image:string
                name:string
                pid: 0
            }
            theme_type: 0
            uname: string
            verify_type: 3
            vip_label: {
                bg_color: string
                bg_style: 1
                border_color:string
                text: string
                text_color:string
            }
            vip_status: 1
            vip_type: 2
        }
        user_status: {
            area_limit: 0
            ban_area_show: 0
            follow: 0
            follow_status: 0
            login: 0
            pay: 0
            pay_pack_paid: 0
            sponsor: 0
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
  dimension: {
    height: number
    rotate: number
    width: number
  }
  duration: number
  enable_vt: false
  ep_id: number
  from: string
  id: number
  is_view_hide: false
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