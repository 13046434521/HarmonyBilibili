/*
{
    "code": 0,
    "data": {
        "relates": [
            {
                "desc1": "荒木飞吕彦、集英社",
                "desc2": "共158话",
                "item_id": 25451,
                "pic": "https://i0.hdslb.com/bfs/manga-static/929ff617e0e668ef37326ce9fccb95e384a47bf4.jpg",
                "title": "石之海（乔乔的奇妙冒险第6部）",
                "type": 2,
                "type_name": "漫画",
                "url": "https://manga.bilibili.com/m/detail/mc25451?from=pgc"
            }
],
"season": [
{
                "actor": "乔鲁诺·乔巴纳：小野贤章、布鲁诺·布加拉提：中村悠一、潘纳科达·福葛：榎木淳弥、纳兰迦·吉尔卡：山下大辉、盖多·米斯达：鸟海浩辅、雷欧·阿帕基：诹访部顺一",
                "badge": "独家",
                "badge_info": {
                    "bg_color": "#00C0FF",
                    "bg_color_night": "#0B91BE",
                    "text": "独家"
                },
"badge_type": 1,
"cover": "http://i0.hdslb.com/bfs/bangumi/f34ff3975c39913af936c133ae60a5891babba08.png",
"enable_vt": false,
"from": 0,
"icon_font": {
  "name": "playdata-square-line@500",
  "text": "5.6亿"
},
"new_ep": {
  "cover": "http://i0.hdslb.com/bfs/archive/39c4c078be0700aa4e312aa62402c6b6a7655ac7.jpg",
  "index_show": "全39话"
},
"rating": {
  "count": 263404,
  "score": 9.8
},
"report": {
  "is_wtgt": 0,
  "seriesId": 2397
},
"rights": {
  "can_watch": 1,
  "resource": ""
},
"season_id": 25681,
"season_type": 1,
"stat": {
                    "danmaku": 4707448,
                    "follow": 5219447,
                    "view": 560433989,
                    "vt": 0,
                    "vtForUnity": 4639733553
                },
"styles": [
{
  "id": 1210,
  "name": "冒险"
},
{
  "id": 135,
  "name": "漫画改"
},
{
  "id": 95,
  "name": "战斗"
},
{
  "id": 103,
  "name": "智斗"
}
],
"subtitle": "这就是黄金体验",
"title": "JOJO的奇妙冒险 黄金之风",
"url": "https://www.bilibili.com/bangumi/play/ss25681",
"user_status": {
  "follow": 0
}
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
},
"message": "success"
}*/

export class MediaRelation {
  relates: MediaRelationRelate[]
  season: MediaSeason[]
}
export class MediaRelationRelate {
  /*  "desc1": "荒木飞吕彦、集英社",
    "desc2": "共158话",
    "item_id": 25451,
    "pic": "https://i0.hdslb.com/bfs/manga-static/929ff617e0e668ef37326ce9fccb95e384a47bf4.jpg",
    "title": "石之海（乔乔的奇妙冒险第6部）",
    "type": 2,
    "type_name": "漫画",
    "url": "https://manga.bilibili.com/m/detail/mc25451?from=pgc"*/

  "desc1": string
  "desc2": string
  "item_id": number
  "pic": string
  "title": string
  "type": number
  "type_name": string
  "url": string
}

export class MediaSeason {
  "actor": string
  "badge": string
  "badge_info": {
    "bg_color": string
    "bg_color_night": string
    "text": string
  }
  "badge_type": number
  "cover": string
  "enable_vt": false
  "from": number
  "icon_font": {
    "name": string
    "text": string
  }
  "new_ep": {
    "cover": string
    "index_show": string
  }
  //有可能为undeifned，返回结果中就没rating，原因可能是该番剧或者影视没开评分
  "rating":Rating = new Rating()
  "report": {
    "is_wtgt": number
    "seriesId": number
  }
  "rights": {
    "can_watch": number
    "resource": ""
  }
  "season_id": number
  "season_type": number
  "stat": {
    "danmaku": number
    "follow": number
    "view": number
    "vt": number
    "vtForUnity": number
  }

  "subtitle": string
  "title": string
  "url": string
  "user_status": {
    "follow": number
  }
}
class Rating{
  "count": number = 0
  "score": number = 0
}
/*
export class MediaRelationRelate {
  */
/*  "desc1": "荒木飞吕彦、集英社",
    "desc2": "共158话",
    "item_id": 25451,
    "pic": "https://i0.hdslb.com/bfs/manga-static/929ff617e0e668ef37326ce9fccb95e384a47bf4.jpg",
    "title": "石之海（乔乔的奇妙冒险第6部）",
    "type": 2,
    "type_name": "漫画",
    "url": "https://manga.bilibili.com/m/detail/mc25451?from=pgc"*//*


  "desc1": string
  "desc2": string
  "item_id": number
  "pic": string
  "title": string
  "type": number
  "type_name": string
  "url": string
}

export class MediaSeason {
  "actor": "乔鲁诺·乔巴纳：小野贤章、布鲁诺·布加拉提：中村悠一、潘纳科达·福葛：榎木淳弥、纳兰迦·吉尔卡：山下大辉、盖多·米斯达：鸟海浩辅、雷欧·阿帕基：诹访部顺一"
  "badge": "独家"
  "badge_info": {
    "bg_color": "#00C0FF"
    "bg_color_night": "#0B91BE"
    "text": "独家"
  }
  "badge_type": 1
  "cover": "http://i0.hdslb.com/bfs/bangumi/f34ff3975c39913af936c133ae60a5891babba08.png"
  "enable_vt": false
  "from": 0
  "icon_font": {
    "name": "playdata-square-line@500"
    "text": "5.6亿"
  }
  "new_ep": {
    "cover": "http://i0.hdslb.com/bfs/archive/39c4c078be0700aa4e312aa62402c6b6a7655ac7.jpg"
    "index_show": "全39话"
  }
  "rating": {
    "count": 263404
    "score": 9.8
  }
  "report": {
    "is_wtgt": 0
    "seriesId": 2397
  }
  "rights": {
    "can_watch": 1
    "resource": ""
  }
  "season_id": 25681
  "season_type": 1
  "stat": {
    "danmaku": 4707448
    "follow": 5219447
    "view": 560433989
    "vt": 0
    "vtForUnity": 4639733553
  }

  "subtitle": "这就是黄金体验"
  "title": "JOJO的奇妙冒险 黄金之风"
  "url": "https://www.bilibili.com/bangumi/play/ss25681"
  "user_status": {
    "follow": 0
  }
}*/
