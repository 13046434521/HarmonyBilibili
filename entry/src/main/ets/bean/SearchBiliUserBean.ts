/*  "type": "bili_user",
  "mid": 1273265116,
  "uname": "皓篮球",
  "usign": "合作：NBAhaolanqiu",
  "fans": 649604,
  "videos": 349,
  "upic": "//i0.hdslb.com/bfs/face/c6d30f07b34da86aea69b5289faf48b23fc496f9.jpg",
  "face_nft": 0,
  "face_nft_type": 0,
  "verify_info": "",
  "level": 6,
  "gender": 1,
  "is_upuser": 1,
  "is_live": 0,
  "room_id": 25247881,
  "res": [],
"official_verify": {
  "type": 0,
  "desc": "bilibili 知名UP主"
},
"hit_columns": [],
"is_senior_member": 0*/


// https://api.bilibili.com/x/web-interface/search/type?search_type=bili_user&keyword=皓篮球&page=1
export interface SearchBiliUserBean{
  type :string
  uname :string//?
  usign :string
  upic :string//?
  verify_info :string
  official_verify:SearchBiliUserVerifyBean//?

  mid :number
  fans :number
  videos :number
  face_nft :number
  face_nft_type :number
  level :number
  gender :number
  is_upuser :number
  is_live :number
  room_id :number
  is_senior_member :number
  res:SearchBiliUserResBean[]
}

export interface SearchBiliUserVerifyBean{
  desc :string
  type :number
}
// res[]
export interface SearchBiliUserResBean{
  aid :number
  bvid :string
  title :string
  pubdate :number
  arcurl :string
  pic :string
  play :string
  dm :number
  coin :number
  fav :number
  desc :string
  duration :string
  is_pay :number
  is_union_video :number
  is_charge_video :number
  vt :number
  enable_vt :number
  vt_display :string
}