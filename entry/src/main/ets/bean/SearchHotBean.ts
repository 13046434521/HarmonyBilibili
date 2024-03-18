export interface SearchHotBean {
/*  "data": {
    "trackid": "11135390230791623592",
    "list": [],
    "top_list": [],
    "hotword_egg_info": "0"
  }*/
  list:SearchHotBeanItem[]
  top_list:[]
  hotword_egg_info:string
}

export interface SearchHotBeanItem{
/*  {
  "position": 1,
  "keyword": "48岁博士生8年未毕业被劝退",
  "show_name": "48岁博士生8年未毕业被劝退",
  "word_type": 5,
  "icon": "http://i0.hdslb.com/bfs/activity-plat/static/20221213/eaf2dd702d7cc14d8d9511190245d057/lrx9rnKo24.png",
  "hot_id": 148332,
  "is_commercial": "0"
},*/
  position:number
  keyword:string
  show_name:string
  word_type:number
  icon:string
  hot_id:number
  is_commercial:string
}