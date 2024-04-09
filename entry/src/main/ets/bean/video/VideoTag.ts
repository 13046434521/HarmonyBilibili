/*
 * "data": [
    {
      "tag_id": 11563642,
      "tag_name": "全民音乐UP主",
      "cover": "",
      "head_cover": "",
      "content": "",
      "short_content": "",
      "type": 4,
      "state": 0,
      "ctime": 1566394259,
      "count": {
        "view": 0,
        "use": 0,
        "atten": 0
      },
      "is_atten": 0,
      "likes": 13,
      "hates": 0,
      "attribute": 0,
      "liked": 0,
      "hated": 0,
      "extra_attr": 0
    },
    {
      "tag_id": 529,
      "tag_name": "说唱",
      "cover": "http://i0.hdslb.com/bfs/archive/79f1ff3b7bb5c422c6f9dc8f7e1bb36b4de2b201.jpg",
      "head_cover": "http://i0.hdslb.com/bfs/archive/c427fec8e9501db6294a2a286e4bbe2d0cfb9646.jpg",
      "content": "说唱音乐是一种跟着伴奏、带着韵律吟诵的音乐风格，诞生于美国1970年代，并于1980年代成为大众流行文化之一。",
      "short_content": "说唱音乐相关。",
      "type": 3,
      "state": 0,
      "ctime": 1436866637,
      "count": {
        "view": 0,
        "use": 0,
        "atten": 0
      },
      "is_atten": 0,
      "likes": 5,
      "hates": 0,
      "attribute": 0,
      "liked": 0,
      "hated": 0,
      "extra_attr": 0
    }
  ]
 * */
// https://api.bilibili.com/x/tag/archive/tags?bvid=BV117411r7R1
export default class VideoTag{
  tag_id: number
  tag_name: string
  cover: string
  head_cover: string
  content: string
  short_content: string
  type: number
  state: number
  ctime: number
  count: {
  view: number
  use: number
  atten: number
}
is_atten: number
likes: number
hates: number
attribute: number
liked: number
hated: number
extra_attr: number
}