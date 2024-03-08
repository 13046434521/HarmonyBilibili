export default class HomeBean{
/*  "item": [],
  "business_card": null,
  "floor_info": [{
  "id": -1,
  "name": "赛事",
  "rows": 1
}, {
			"id": 2,
			"name": "番剧",
			"rows": 1
		}, {
			"id": 4,
			"name": "国创",
			"rows": 1
		}, {
			"id": 28,
			"name": "漫画",
			"rows": 1
		}, {
			"id": 27,
			"name": "课堂",
			"rows": 1
		}, {
			"id": 3,
			"name": "电影",
			"rows": 1
		}, {
			"id": 5,
			"name": "电视剧",
			"rows": 1
		}, {
			"id": 7,
			"name": "纪录片",
			"rows": 1
		}],
"user_feature": null,
"preload_expose_pct": 0.5,
"preload_floor_expose_pct": 0.5,
"mid": 68406011*/
  item:HomeBeanItem[]
  preload_expose_pct:number
  preload_floor_expose_pct:number
  mid:number
}


export class HomeBeanItem {
  id:number
  bvid:string
  cid:number
  goto:string
  uri:string
  pic:string
  pic_4_3:string
  title:string
  duration:number
  pubdate:number
  owner:HomeOwnerBean
  stat:HomeStatBean
  name:string
  face:string
/*  "id": 1501436171,
  "bvid": "BV1aS421w7Bv",
  "cid": 1461928765,
  "goto": "av",
  "uri": "https://www.bilibili.com/video/BV1aS421w7Bv",
  "pic": "http://i1.hdslb.com/bfs/archive/915fde9b3d0b1a8b96d5ce07443e04dcefba8cba.jpg",
  "pic_4_3": "http://i0.hdslb.com/bfs/aistory/2024-03-07-18012021841501436171_16_12_6340_crop.jpg",
  "title": "《一个美好的愿望》",
  "duration": 171,
  "pubdate": 1709805600,
  "owner": {
  "mid": 263090405,
  "name": "猫不理咖啡",
  "face": "https://i2.hdslb.com/bfs/face/2f60f753ef27168acf7d2aa8c99033e663073142.jpg"
},
"stat": {
				"view": 135853,
				"like": 27400,
				"danmaku": 171,
				"vt": 0
			},
"av_feature": null,
"is_followed": 1,
"rcmd_reason": {
  "reason_type": 1
},
"show_info": 1,
"track_id": "web_pegasus_2.router-web-pegasus-1436504-6cd7cdcb7b-v5wtx.1709833773528.145",
"pos": 0,
"room_info": null,
"ogv_info": null,
"business_info": null,
"is_stock": 0,
"enable_vt": 0,
"vt_display": "",
"dislike_switch": 1*/

  constructor() {
  }
}

class HomeStatBean{
/*  "stat": {
  "view": 135853,
  "like": 27400,
  "danmaku": 171,
  "vt": 0
},*/
  view:number
  like:number
  danmaku:number
  vt:number

}

class HomeOwnerBean{
  /*"owner": {
				"mid": 263090405,
				"name": "猫不理咖啡",
				"face": "https://i2.hdslb.com/bfs/face/2f60f753ef27168acf7d2aa8c99033e663073142.jpg"
			},*/
  mid:number
  name:string
  face:string
}