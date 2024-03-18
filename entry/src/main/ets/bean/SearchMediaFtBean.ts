import { SearchMediaBangumiEps } from './SearchMediaBangumiBean'

//https://api.bilibili.com/x/web-interface/search/type?search_type=media_ft&keyword=��᲻��ͣ&page=1
// Ӱ�ӵķ������ݣ��ͷ�����һ���ġ����������������������֣�������������޸�
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