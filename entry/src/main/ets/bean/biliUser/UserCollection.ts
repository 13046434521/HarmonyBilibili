/*
 {
    "code": 0,
    "message": "0",
    "ttl": 1,
    "data": {
        "items_lists": {
            "page": {
                "page_num": 1,
                "page_size": 1,
                "total": 1
            },
            "seasons_list": [

            ],
            "series_list": [
                {
                    "archives": [
                        {
                            "aid": 359063596,
                            "bvid": "BV1RX4y1E7Fi",
                            "ctime": 1690556424,
                            "duration": 24428,
                            "enable_vt": false,
                            "interactive_video": false,
                            "pic": "http://i0.hdslb.com/bfs/archive/d9ac6f487a00ca44df63c2f2e1b81f4586cca30c.jpg",
                            "playback_position": 0,
                            "pubdate": 1690556424,
                            "stat": {
                                "view": 350,
                                "vt": 0
                            },
                            "state": 0,
                            "title": "中式悬疑微恐游戏《三伏》全流程配音解说 第一章---山城录像厅",
                            "ugc_pay": 0,
                            "vt_display": ""
                        }
                    ],
                    "meta": {
                        "category": 1,
                        "cover": "http://i0.hdslb.com/bfs/archive/d9ac6f487a00ca44df63c2f2e1b81f4586cca30c.jpg",
                        "creator": "auto",
                        "ctime": 1690559649,
                        "description": "三伏游戏",
                        "keywords": [
                            "三伏"
                        ],
                        "last_update_ts": 1690574970,
                        "mid": 68406011,
                        "mtime": 1690574970,
                        "name": "三伏游戏",
                        "raw_keywords": "三伏",
                        "series_id": 3489399,
                        "state": 2,
                        "total": 6
                    },
                    "recent_aids": [
                        359063596,
                        231571927,
                        914015348,
                        999033383,
                        871546450,
                        956549552
                    ]
                }
            ]
        }
    }
}*/

//https://api.bilibili.com/x/polymer/web-space/home/seasons_series?mid=68406011&page_num=1&page_size=10
//主页->我的合集和视频列表(有aid，bid等)
export class UserCollection {
  items_lists: {
    page: {
      page_num: number
      page_size: number
      total: number
    }
    seasons_list: []
    series_list: UserCollectionSeries[]
  }
}

export class UserCollectionSeries {
  archives: UserCollectionSeriesArchives[]
  meta: {
    category: number
    cover: string
    creator: string
    ctime: number
    description: string
    keywords: string[]
    last_update_ts: number
    mid: number
    mtime: number
    name: string
    raw_keywords: string
    series_id: number
    state: number
    total: number
  }
  recent_aids: number[]
}

export class UserCollectionSeriesArchives {
  aid: number
  bvid: string
  ctime: number
  duration: number
  enable_vt: false
  interactive_video: false
  pic: string
  playback_position: number
  pubdate: number
  stat: {
    view: number
    vt: number
  }
  state: number
  title: string
  ugc_pay: number
  vt_display: number
}
