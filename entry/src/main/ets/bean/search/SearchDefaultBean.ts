import { SearchArticleBean } from './SearchArticleBean';
import { SearchBiliUserBean,
  SearchBiliUserResBean,
  SearchBiliUserVerifyBean } from './SearchBiliUserBean';
import { SearchLiveRoomBean } from './SearchLiveRoomBean';
import { SearchMediaBean,
  SearchMediaEps,
  SearchMediaBadges } from './SearchMediaBean';
import { SearchVideoBean } from './SearchVideoBean';

// 6合1的数据源
//https://api.bilibili.com/x/web-interface/wbi/search/all/v2?keyword=overlord&page=1
export class SearchDefaultBean{
  result_type:string
  data:SearchDefaultDataBean[]
}

export class SearchDefaultDataBean implements SearchBiliUserBean,SearchMediaBean,SearchVideoBean,SearchMediaBean,SearchArticleBean,SearchLiveRoomBean{
  result_type:string
  media_id: number;
  title: string;
  org_title: string;
  media_type: number;
  cv: string;
  staff: string;
  season_id: number;
  is_avid: boolean;
  hit_columns: string[];
  hit_epids: string;
  season_type: number;
  season_type_name: string;
  selection_style: string;
  ep_size: number;
  url: string;
  button_text: string;
  is_follow: number;
  is_selection: number;
  cover: string;
  areas: string;
  styles: string;
  goto_url: string;
  desc: string;
  pubtime: number;
  media_mode: number;
  fix_pubtime_str: string;
  media_score: {
    score: number;
    user_count: number;
  };
  display_info: SearchMediaBadges[];
  pgc_season_id: number;
  corner: number;
  index_show: string;
  eps: SearchMediaEps[];
  badges: SearchMediaBadges[];
  id: number;
  author: string;
  typeid: string;
  typename: string;
  arcurl: string;
  bvid: string;
  aid: number;
  description: string;
  pic: string;
  play: number;
  video_review: number;
  favorites: number;
  tag: string;
  danmaku: number;
  review: number;
  pubdate: number;
  senddate: number;
  duration: string;
  rank_score: number;
  like: number;
  template_id: number;
  image_urls: string[];
  view: number;
  reply: number;
  category_name: string;
  category_id: number;
  version: string;
  sub_type: number;
  pub_time: number;
  rank_index: number;
  rank_offset: number;
  roomid: number;
  short_id: number;
  user_cover: string;
  uid: number;
  area: 6;
  tags: string;
  uface: string;
  attentions: number;
  online: number;
  live_time: string;
  cate_name: string;
  live_status: number;
  is_live_room_inline: number;

  type: string;
  uname: string;
  usign: string;
  upic: string;
  verify_info: string;
  official_verify: SearchBiliUserVerifyBean;
  mid: number;
  fans: number;
  videos: number;
  face_nft: number;
  face_nft_type: number;
  level: number;
  gender: number;
  is_upuser: number;
  is_live: number;
  room_id: number;
  is_senior_member: number;
  res: SearchBiliUserResBean[];
}