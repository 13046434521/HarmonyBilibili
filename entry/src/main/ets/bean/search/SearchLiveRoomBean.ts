/*{
                "type": "live_room",
                "roomid": 22953950,
                "short_id": 0,
                "title": "那<em class=\"keyword\">什么</em>，启动！",
                "cover": "//i0.hdslb.com/bfs/live-key-frame/keyframe03181802000022953950c3dtb9.jpg",
                "user_cover": "//i0.hdslb.com/bfs/live/new_room_cover/f482754212cde1be7315df9a25e0cdbdd2e40d60.jpg",
                "uid": 1041474702,
                "uname": "病院坂Rei",
                "area": 6,
                "tags": "",
                "uface": "//i2.hdslb.com/bfs/face/127667cb0e3f20191dc2cbf31e58bf79735824fc.jpg",
                "attentions": 129080,
                "online": 94123,
                "live_time": "2024-03-18 17:20:20",
                "cate_name": "虚拟日常",
                "hit_columns": [
                    "title"
                ],
                "live_status": 1,
                "is_live_room_inline": 0,
                "rank_score": 13933100,
                "rank_index": 1,
                "rank_offset": 1
            },*/

//https://api.bilibili.com/x/web-interface/search/type?search_type=live_room&keyword=什么&page=1
export interface SearchLiveRoomBean{
  type: string
  roomid: number
  short_id: number
  title: string
  cover: string
  user_cover: string
  uid: number
  uname: string
  area: 6
  tags:string
  uface: string
  attentions: number
  online: number
  live_time: string
  cate_name: string
  hit_columns: string[]
  live_status: number
  is_live_room_inline: number
  rank_score: number
  rank_index: number
  rank_offset: number
}