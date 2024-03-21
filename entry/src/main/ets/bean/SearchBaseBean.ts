// 默认搜索结果：https://api.bilibili.com/x/web-interface/wbi/search/all/v2?keyword=%E6%B4%9B%E5%A4%A9%E4%BE%9D&page=1
export interface SearchBaseBean<T>{
/*  "seid": "1871174439078139085",
  "page": 1,
  "pagesize": 20,
  "numResults": 1000,
  "numPages": 50,
  "suggest_keyword": "",
  "rqt_type": "search",
"exp_list": Object{...},
"egg_hit": 0,
"pageinfo": Object{...},
"top_tlist": Object{...},
"show_column": 0,
"show_module_list": Array[12],
"app_display_option": Object{...},
"in_black_key": 0,
"in_white_key": 0,*/
  seid:string
  suggest_keyword:string
  rqt_type:string
  page:number
  pagesize:number
  numResults:number
  numPages:number

  top_tlist:topTlistBean
  show_module_list:string[]
  in_black_key:number
  in_white_key:number
  result:T[]
}

export class  topTlistBean{
  video:number
  bangumi:number
  special:number
  topic:number
  live:number
  media_bangumi:number
  media_ft:number
  live_room:number
  bili_user:number
  article:number
/*  "video": 1000,
  "bangumi": 0,
  "special": 0,
  "topic": 0,
  "upuser": 0,
  "tv": 0,
  "movie": 0,
  "card": 0,
  "media_bangumi": 0,
  "media_ft": 0,
  "pgc": 0,
  "live": 4,
  "user": 0,
  "activity": 0,
  "operation_card": 0,
  "live_room": 3,
  "live_user": 0,
  "article": 400,
  "live_master": 1,
  "bili_user": 1000*/
}
export interface SearchDefaultResultBean{

/*  "brand_ad",
  "tips",
  "esports",
  "bili_user",
  "user",
  "activity",
  "web_game",
  "card",
  "media_bangumi",
  "media_ft",
  "star",
  "video"*/
  result_type:string // result_type的值是show_module_list数组中的数据
  data:SearchDefaultALLResultBean[]
}

// 搜索综合页面，所有类型（bili_user，video等类型）的数据，全都放在这里，如果没有就解析不出来即可
export interface SearchDefaultALLResultBean{
  /*------------------------------------------- biliUser用户 --------------------------------------------*/
  /*  "type": "bili_user",
  "mid": 36081646,
  "uname": "洛天依",
  "usign": "Vsinger旗下虚拟歌手，世界首位中文V家虚拟歌手，主唱，15岁，2012年7月12日出道。合作联系：shhn@vsinger.com。",
  "fans": 3684870,
  "videos": 223,
  "upic": "//i2.hdslb.com/bfs/face/9583c2c1ddd95e2f3ab4b4ea9b3a1d3200b64fda.webp",
  "face_nft": 1,
  "face_nft_type": 1,
  "verify_info": "",
  "level": 6,
  "gender": 2,
  "is_upuser": 1,
  "is_live": 0,
  "room_id": 1546736,*/
  type:string
  uname:string
  usign:string
  upic:string
  verify_info:string

  mid:number
  fans:number
  videos:number
  face_nft:number
  face_nft_type:number
  level:number
  gender:number
  is_upuser:number
  is_live:number
  room_id:number
  res:BiliUserItemBean[]
  /*------------------------------------------- Video 和SearchVideoBean一样 --------------------------------------------*/
  //type:string
  id:number
  author:string
  typeid:string
  //mid:number
  typename:string
  arcurl:string
  bvid:string
  aid:number
  title:string
  description:string
  pic:string
  play:number
  video_review:number
  favorites:number
  tag:string
  danmaku:number
  review:number
  pubdate:number
  senddate:number
  duration:string
  hit_columns:string[]
  rank_score:number
  like:number
  //upic:string
}

export interface  BiliUserItemBean{
/*  "aid": 1151130190,
  "bvid": "BV1TZ421y7XX",
  "title": "洛天依 灯火春澜Ver.Q版手办 实物展示",
  "pubdate": 1709029507,
  "arcurl": "http://www.bilibili.com/video/av1151130190",
  "pic": "//i1.hdslb.com/bfs/archive/4447f9d5bac26872072fa36497910206092b5d68.png",
  "play": "16297",
  "dm": 22,
  "coin": 914,
  "fav": 428,
  "desc": "洛天依 灯火春澜Ver.Q版手办 实物展示\n踩着年的尾巴，天依祝大家学业、工作和生活都红红火火、顺顺利利哒！[洛天依歌行四方_咚嚓！]",
  "duration": "0:54",
  "is_pay": 0,
  "is_union_video": 0,
  "is_charge_video": 0,
  "vt": 0,
  "enable_vt": 0,
  "vt_display": ""*/
  bvid:string
  title:string
  arcurl:string
  pic:string
  play:string
  desc:string
  duration:string
  vt_display:string

  aid:number
  pubdate:number
  dm:number
  coin:number
  fav:number
  is_pay:number
  is_union_video:number
  is_charge_video:number
  vt:number
  enable_vt:number
}