import { SearchMediaBangumiEps } from './SearchMediaBangumiBean'

//https://api.bilibili.com/x/web-interface/search/type?search_type=media_ft&keyword=年会不能停&page=1
// 影视的返回数据，和番剧是一样的。这里用两个类来进行区分，以免后续出现修改
export interface SearchMediaFtBean{
  type: string
  media_id: number
  title: string
  org_title: string
  media_type: number
  cv:string
  staff: string
  season_id: number
  is_avid: boolean
  hit_columns: string[]
  hit_epids:string
  season_type: number
  season_type_name: string
  selection_style: string
  ep_size: number
  url: string
  button_text: string
  is_follow: number
  is_selection: number

  cover: string
  areas: string
  styles: string
  goto_url: string
  desc: string
  pubtime: number
  media_mode: number
  fix_pubtime_str:string
  media_score: {
    score: number
    user_count: number
  }
  display_info: SearchMediaFtBadgesColor[]
  pgc_season_id: number
  corner: number
  index_show: string
  eps: SearchMediaBangumiEps[]
  badges: SearchMediaFtBadgesColor[]
}
export interface SearchMediaFtEps{
  id: number
  cover: string
  title: number
  url: string
  release_date:string
  badges: SearchMediaFtBadgesColor[]
  index_title: number
  long_title: string
}

export interface SearchMediaFtBadgesColor{
  text: string
  text_color: string
  text_color_night:string
  bg_color:string
  bg_color_night: string
  border_color: string
  border_color_night: string
  bg_style: number
}