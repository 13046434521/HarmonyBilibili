/*
"seid": "15732692243741184881",
"page": 1,
"pagesize": 20,
"numResults": 1000,
"numPages": 50,
"suggest_keyword": "",
"rqt_type": "search",
"cost_time": Object{...},
"exp_list": Object{...},
"egg_hit": 0,
"result": Array[20],
"show_column": 0,
"in_black_key": 0,
"in_white_key": 0*/
import observer from '@ohos.telephony.observer'

export interface SearchVideoBean{
  type:string
  id:number
  author:string
  typeid:string
  mid:number
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
  upic:string
  /*  "type": "video",
    "id": 1951684520,
    "author": "阿斗归来了",
    "mid": 21837784,
    "typeid": "182",
    "typename": "影视杂谈",
    "arcurl": "http://www.bilibili.com/video/av1951684520",
    "aid": 1951684520,
    "bvid": "BV11C41187pa",
    "title": "【阿斗】真实事件翻拍，韩国总统也敢黑？没看过比这更大胆的电影！2023韩国票房冠军《\u003cem class=\"keyword\"\u003e首尔之春\u003c/em\u003e》",
    "description": "韩国电影：\n\n《特工》：BV1Dp4y1r7Bk\n《新世界》：BV1Zg4y1z71E\n《局内人》：BV1qi4y1L7DH\n《辩护人》：BV1Bh41127gs\n《走到尽头》：BV11i4y1u7Ui\n《一定要抓住》：BV1kx411Z7L6\n《南山的部长们》：BV1g3411K7CM\n\n喜欢的话多多点赞、投币、收藏吧，你们的三连支持就我更新的最大动力。\n更多精彩内容，关注我的微信公众号——阿斗归来了（adouGLL）",
    "arcrank": "0",
    "pic": "//i1.hdslb.com/bfs/archive/e53b8e7f17ffc5b4cccaa299c47705c705ffbf86.jpg",
    "play": 770845,
    "video_review": 1925,
    "favorites": 8909,
    "tag": "郑雨盛,高分电影,黄政民,电影解说,全斗焕,影评杂谈,韩国影帝,李星民,人人都能聊影视,首尔之春",
    "review": 1152,
    "pubdate": 1709892300,
    "senddate": 1709898481,
    "duration": "32:41",
    "badgepay": false,
    "hit_columns": [
    "title",
    "tag"
    ],
    "view_type": "",
    "is_pay": 0,
    "is_union_video": 0,
    "rec_tags": null,
    "new_rec_tags": [

    ],
    "rank_score": 128091781,
    "like": 47849,
    "upic": "https://i1.hdslb.com/bfs/face/b6dad37ef0a68341b6e2f84de5e1f9ee02f8365e.jpg",
    "corner": "",
    "cover": "",
    "desc": "",
    "url": "",
    "rec_reason": "",
    "danmaku": 1925,
    "biz_data": null,
    "is_charge_video": 0,
    "vt": 0,
    "enable_vt": 0,
    "vt_display": "",
    "subtitle": "",
    "episode_count_text": "",
    "release_status": 0,
    "is_intervene":0*/
}