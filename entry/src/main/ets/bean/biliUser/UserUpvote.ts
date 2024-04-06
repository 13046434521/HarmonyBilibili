/*
 *        "list": [
            {
                "aid": 1652690710,
                "videos": 1,
                "tid": 213,
                "tname": "美食测评",
                "copyright": 1,
                "pic": "http://i1.hdslb.com/bfs/archive/077ab268a2e2fae60730956c97bf17a408534ddd.jpg",
                "title": "把各地代表饮料全部混合会怎么样？我来帮你尝一下！",
                "pubdate": 1712305016,
                "ctime": 1712305016,
                "desc": "",
                "state": 0,
                "duration": 143,
                "mission_id": 1720674,
                "rights": {
                    "bp": 0,
                    "elec": 0,
                    "download": 0,
                    "movie": 0,
                    "pay": 0,
                    "hd5": 0,
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
                    "mid": 9824766,
                    "name": "敬汉卿",
                    "face": "https://i0.hdslb.com/bfs/face/fd8d7ad17af295f7c4256959705f009c5f67e9c6.jpg"
                },
                "stat": {
                    "aid": 1652690710,
                    "view": 474589,
                    "danmaku": 1213,
                    "reply": 785,
                    "favorite": 1957,
                    "coin": 9882,
                    "share": 484,
                    "now_rank": 0,
                    "his_rank": 0,
                    "like": 52499,
                    "dislike": 0,
                    "vt": 0,
                    "vv": 474589
                },
                "dynamic": "",
                "cid": 1494690531,
                "dimension": {
                    "width": 1920,
                    "height": 1080,
                    "rotate": 0
                },
                "season_id": 166065,
                "short_link_v2": "https://b23.tv/BV16E421g776",
                "first_frame": "http://i0.hdslb.com/bfs/storyff/n240405sa2vaedtc7qujdx2p7yke8o09_firsti.jpg",
                "pub_location": "四川",
                "cover43": "",
                "bvid": "BV16E421g776",
                "inter_video": false,
                "resource_type": "ugc",
                "subtitle": "",
                "enable_vt": 0
            },
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...},
            Object{...}
        ]
    }
 * */

//https://api.bilibili.com/x/space/like/video?vmid=68406011&wts=1712425725&w_rid=aa1573efd400be4c3b0af4c092027a6c
//主页->最近点赞视频
export class UserUpvote {
  list: UserUpvoteItem[]
}

export class UserUpvoteItem {
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
  cover43: ""
  bvid: string
  inter_video: false
  resource_type: string
  subtitle: string
  enable_vt: number
}