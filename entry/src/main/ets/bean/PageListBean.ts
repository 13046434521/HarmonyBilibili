/*
 * {
    "code": 0,
    "message": "0",
    "ttl": 1,
    "data": [
        {
            "cid": 1469197725,
            "page": 1,
            "from": "vupload",
            "part": "美国即将封禁tiktok！",
            "duration": 222,
            "vid": "",
            "weblink": "",
            "dimension": {
                "width": 1920,
                "height": 1080,
                "rotate": 0
            },
            "first_frame": "http://i0.hdslb.com/bfs/storyff/n240314sa2e909peujo7pbkqeqe4zik5_firsti.jpg"
        }
    ]
}*/

export interface  PageListBean{

/*  "cid": 1469197725,
  "page": 1,
  "from": "vupload",
  "part": "美国即将封禁tiktok！",
  "duration": 222,
  "vid": "",
  "weblink": "",
  "dimension": {
  "width": 1920,
  "height": 1080,
  "rotate": 0
},
"first_frame": "http://i0.hdslb.com/bfs/storyff/n240314sa2e909peujo7pbkqeqe4zik5_firsti.jpg"*/

  cid:number
  page:number
  from:string
  part:string
  duration:number
  vid:string
  weblink:string
  first_frame:string
  dimension:PageListDimensionBean
}

export interface PageListDimensionBean{
  width:number
  height:number
  rotate:number
}