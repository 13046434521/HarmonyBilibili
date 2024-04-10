/*
"total": "629",
"count": "464",
"show_switch": {
  "total": true,
  "count": true
},
"abtest": {
  "group": "b"
}*/

// https://api.bilibili.com/x/player/online/total?cid=1499268571&bvid=BV1Mm411677N
// 实时在线人数
export class Online {
  total: string ='-'
  count: string ='-'
  show_switch: {
    total: boolean
    count: boolean
  }
  abtest: {
    group: string
  }
}