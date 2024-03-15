/*
  {
  type": "article",
  "id": 22222610,
  "mid": 1660989969,
  "title": "有点尬，西姆斯自评50分，各解说反应！（<em class=\"keyword\">皓篮球</em>，徐静雨，大彪儿，曾令旭等）",
  "desc": "西姆斯单臂挂筐扣篮各解说的反应\n1.皓篮球调侃西姆斯掉价、没有技术动作\n00:01 皓篮球\n2.徐静雨评价创意马龙不买账，只会直上直下\n02:29 徐静雨...",
  "template_id": 3,
  "image_urls": [
  "//i2.hdslb.com/bfs/note/ec5babc3fdd2fa042f12844044c40324fd88ca34.jpg",
  "//i2.hdslb.com/bfs/note/cae26bd20c3088aa894f58d6b4347ada2a32b138.jpg",
  "//i1.hdslb.com/bfs/note/f851b63526c0ee2edf3072e9677e0c709f2668e3.jpg"
  ],
  "view": 38,
  "like": 1,
  "reply": 0,
  "category_name": "全部笔记",
  "category_id": 42,
  "version": "",
  "sub_type": 0,
  "pub_time": 1678072685,
  "rank_score": 838470,
  "rank_index": 2,
  "rank_offset": 2
}
*/
// https://api.bilibili.com/x/web-interface/search/type?search_type=article&keyword=皓篮球&page=1
export class SearchArticleBean{
  type:string
  id: number
  mid: number
  title: string
  desc: string
  template_id: number
  image_urls: string[]
  view: number
  like: number
  reply: number
  category_name: string
  category_id: number
  version:string
  sub_type: number
  pub_time: number
  rank_score: number
  rank_index: number
  rank_offset: number
}