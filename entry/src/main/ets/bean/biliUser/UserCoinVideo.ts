/*
 * {
  "code": 0,
  "message": "0",
  "ttl": 1,
  "data": [
    {
      "aid": 1702490302,
      "videos": 1,
      "tid": 212,
      "tname": "美食侦探",
      "copyright": 1,
      "pic": "http://i2.hdslb.com/bfs/archive/7e6f8c7ddd338b09fbe69ea6c01ab2ba7d37307a.jpg",
      "title": "29岁第一次坐躺着的高铁，中国高铁都这么Newbility吗？",
      "pubdate": 1711877681,
      "ctime": 1711877681,
      "desc": "欢迎搭乘本次穿越旅行器\n请您打开遮阳帘，收起小桌板，调直座椅靠背\n洗手间在旅行器的前部和后部.在洗手间内请不要吸烟\n本次航程的终点是“中国五星卡”\n敬请留下宝贵意见，感谢你的关心和支持！",
      "state": 0,
      "duration": 546,
      "mission_id": 1720674,
      "rights": {
        "bp": 0,
        "elec": 0,
        "download": 0,
        "movie": 0,
        "pay": 0,
        "hd5": 1,
        "no_reprint": 1,
        "autoplay": 1,
        "ugc_pay": 0,
        "is_cooperation": 0,
        "ugc_pay_preview": 0,
        "no_background": 0,
        "arc_pay": 0,
        "pay_free_watch": 0
      },
      "owner": {
        "mid": 3537122973714533,
        "name": "老王在中国",
        "face": "https://i2.hdslb.com/bfs/face/5cc0f66946ba560d0ccbd8e5bffc45ac94793cf4.jpg"
      },
      "stat": {
        "aid": 1702490302,
        "view": 876044,
        "danmaku": 4773,
        "reply": 1789,
        "favorite": 3597,
        "coin": 12619,
        "share": 515,
        "now_rank": 0,
        "his_rank": 0,
        "like": 52326,
        "dislike": 0,
        "vt": 0,
        "vv": 876044
      },
      "dynamic": "",
      "cid": 1488129553,
      "dimension": {
        "width": 1920,
        "height": 1080,
        "rotate": 0
      },
      "season_id": 1933870,
      "short_link_v2": "https://b23.tv/BV1wK421Y7F8",
      "first_frame": "http://i2.hdslb.com/bfs/storyff/n240331savkciu90w7rfjxaf8ifdm9yt_firsti.jpg",
      "pub_location": "四川",
      "cover43": "",
      "bvid": "BV1wK421Y7F8",
      "coins": 2,
      "time": 1711901059,
      "ip": "",
      "inter_video": false,
      "resource_type": "ugc",
      "subtitle": "",
      "enable_vt": 0
    }
  ]
}*/
//  https://api.bilibili.com/x/space/coin/video?vmid=68406011&wts=1712425725&w_rid=aa1573efd400be4c3b0af4c092027a6c
// 主页->最近投币视频
export class UserCoinVideo {
  aid: number
  videos: number
  tid: number
  tname: string
  copyright: number
  pic: string
  title: string
  pubdate: number
  ctime: number
  desc: string
  state: number
  duration: number
  mission_id: number
  rights: {
    bp: number
    elec: number
    download: number
    movie: number
    pay: number
    hd5: number
    no_reprint: number
    autoplay: number
    ugc_pay: number
    is_cooperation: number
    ugc_pay_preview: number
    no_background: number
    arc_pay: number
    pay_free_watch: number
  }
  owner: {
    mid: number
    name: string
    face: string
  }
  stat: {
    aid: number
    view: number
    danmaku: number
    reply: number
    favorite: number
    coin: number
    share: number
    now_rank: number
    his_rank: number
    like: number
    dislike: number
    vt: number
    vv: number
  }
  dynamic: string
  cid: number
  dimension: {
    width: number
    height: number
    rotate: number
  }
  season_id: number
  short_link_v2: string
  first_frame: string
  pub_location: string
  cover43: string
  bvid: string
  coins: number
  time: number
  ip: string
  inter_video: boolean
  resource_type: string
  subtitle: string
  enable_vt: number
}