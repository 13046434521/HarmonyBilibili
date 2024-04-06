/*
"list": {
  "vlist": [
  {
          "comment": 5,
          "typeid": 230,
          "play": 1633,
          "pic": "http://i1.hdslb.com/bfs/archive/4900cdd7f752d173ff31da1f23d73f3587225d03.jpg",
          "subtitle": "",
          "description": "1+6T刷OpenHarmony的踩坑视频。\n固件及文章参考B站AlgoIdeas的文章：https://www.bilibili.com/read/cv27956343/\n希望明年HarmonyNext能够震惊世界......各位加油！！！",
          "copyright": "1",
          "title": "1加6T刷OpenHarmony4.0视频教程",
          "review": 0,
          "author": "可乐儿加冰",
          "mid": 68406011,
          "created": 1703049474,
          "length": "09:08",
          "video_review": 0,
          "aid": 707549442,
          "bvid": "BV1QQ4y1M7Va",
          "hide_click": false,
          "is_pay": 0,
          "is_union_video": 0,
          "is_steins_gate": 0,
          "is_live_playback": 0,
          "is_lesson_video": 0,
          "is_lesson_finished": 0,
          "lesson_update_info": "",
          "jump_url": "",
          "meta": null,
          "is_avoided": 0,
          "season_id": 0,
          "attribute": 16768,
          "is_charging_arc": false,
          "vt": 0,
          "enable_vt": 0,
          "vt_display": "",
          "playback_position": 0
        },
  {
          "comment": 0,
          "typeid": 17,
          "play": 181,
          "pic": "http://i1.hdslb.com/bfs/archive/6ca1e1a9a9a9e24bc20eef3eba719a83a674bdac.jpg",
          "subtitle": "",
          "description": "三伏游戏实况语音解说。点播电视节目篇。\n新人up，希望大家喜欢支持。\n如果能点个赞，那就是最大的动力了~",
          "copyright": "1",
          "title": "中式微恐游戏《三伏》全流程配音解说 最终章---缘尽水中月",
          "review": 0,
          "author": "可乐儿加冰",
          "mid": 68406011,
          "created": 1690572532,
          "length": "58:36",
          "video_review": 0,
          "aid": 956549552,
          "bvid": "BV1wp4y1L7F3",
          "hide_click": false,
          "is_pay": 0,
          "is_union_video": 0,
          "is_steins_gate": 0,
          "is_live_playback": 0,
          "is_lesson_video": 0,
          "is_lesson_finished": 0,
          "lesson_update_info": "",
          "jump_url": "",
          "meta": null,
          "is_avoided": 0,
          "season_id": 0,
          "attribute": 16512,
          "is_charging_arc": false,
          "vt": 0,
          "enable_vt": 0,
          "vt_display": "",
          "playback_position": 0
        },
  ],
  "slist": []
},
"page": {
      "pn": 1,
      "ps": 30,
      "count": 16
    },
"episodic_button": {
  "text": "播放全部",
  "uri": "//www.bilibili.com/medialist/play/68406011?from=space"
},
"is_risk": false,
"gaia_res_type": 0,
"gaia_data": null
BUILD SUCCESSFUL in 13s
19 actionable tasks: 11 executed, 8 up-to-date

Build Analyzer results available
23:43:09: Execution finished ':app:testDebugUnitTest --tests "com.example.baidu.ExampleUnitTest.Test"'.
*/
//  https://api.bilibili.com/x/space/wbi/arc/search?mid=68406011&order=&pn=1&wts=1712417536&w_rid=2c915ca0c273fd92bb2eb248088cff60
// 用户主页（视频），也是投稿的内容
export class UserVideoBean {
  list: {
    vlist: UserVideoItem[]
    slist: []
    page: {
      pn: number
      ps: number
      count: number
    }
    episodic_button: {
      text: string
      uri: string
    }
    is_risk: boolean
    gaia_res_type: number
    gaia_data: null
  }
}

//vlist 中的数据，每个视频的详细数据
export class UserVideoItem {
  comment: number
  typeid: number
  play: number
  pic: string
  subtitle: string
  description: string
  copyright: number
  title: string
  review: number
  author: string
  mid: number
  created: number
  length: string
  video_review: number
  aid: number
  bvid: string
  hide_click: boolean
  is_pay: number
  is_union_video: number
  is_steins_gate: number
  is_live_playback: number
  is_lesson_video: number
  is_lesson_finished: number
  lesson_update_info: string
  jump_url: string
  meta: null
  is_avoided: number
  season_id: number
  attribute: number
  is_charging_arc: boolean
  vt: number
  enable_vt: number
  vt_display: string
  playback_position: number
}
