/*
"type": "media_bangumi",
"media_id": 102252,
"title": "<em class=\"keyword\">OVERLORD</em> Ⅲ",
"org_title": "<em class=\"keyword\">OVERLORD</em> Ⅲ",
"media_type": 1,
"cv": "安兹：日野聪\n雅儿贝德：原由实\n夏提雅：上坂堇\n亚乌菈：加藤英美里\n马雷：内山夕实\n迪米乌哥斯：加藤将之\n科塞特斯：三宅健太\n塞巴斯：千叶繁\n威克提姆：东山奈央\n由莉：五十岚裕美\n露普丝雷其娜：小松未可子\n娜贝拉尔：沼仓爱美\n希丝：濑户麻沙美\n索留香：佐仓绫音\n安特玛：真堂圭\n扎里尤斯：东地宏树\n沙斯林：楠见尚己\n库鲁雪：雨宫天\n泽贝鲁：石井康嗣\n拉娜：安野希世乃\n克莱姆：逢坂良太\n葛杰夫：白熊宽嗣\n布莱恩：游佐浩二\n拉裘丝：小清水亚美\n格格兰：齐藤贵美子\n依比鲁艾：花守由美里\n缇亚：石上静香\n缇娜：富田美忧\n琪雅蕾：嶋村侑\n吉尔克尼弗：樱井孝宏\n福鲁达：土师孝也",
"staff": "原作：丸山くがね（《<em class=\"keyword\">OVERLORD</em>》/KADOKAWA刊）\n角色原案：so-bin\n监督：伊藤尚往\n系列构成：菅原雪绘\n角色设计：田崎聪、吉松孝博\n次要角色设计、怪物设计、道具设计：今村大树、杉浦幸次、出云重机、铃木政彦、前原桃子\n美术监督：池田繁美、丸山由纪子（ATELIER MUSA）\n美术设定：友野加世子、大久保修一（ATELIER MUSA）\n色彩设计：堀川佳典\n3D监督：田中康隆\n摄影监督：继冈梦月\n编辑：冢常真理子\n音响监督：乡文裕贵\n音响制作：grooove\n音乐：片山修志（Team-MAX）\n音乐制作：KADOKAWA\n动画制作：MADHOUSE",
"season_id": 24596,
"is_avid": false,
"hit_columns": [
"title",
"org_title"
],
"hit_epids": "",
"season_type": 1,
"season_type_name": "番剧",
"selection_style": "grid",
"ep_size": 13,
"url": "https://www.bilibili.com/bangumi/play/ss24596",
"button_text": "立即观看",
"is_follow": 0,
"is_selection": 1,
"eps": [
{
                        "id": 232544,
                        "cover": "http://i0.hdslb.com/bfs/archive/09ef607ef9700453d00785a5217faca74b155016.jpg",
                        "title": "13",
                        "url": "https://www.bilibili.com/bangumi/play/ep232544",
                        "release_date": "",
                        "badges": [
                            {
                                "text": "会员",
                                "text_color": "#FFFFFF",
                                "text_color_night": "#E5E5E5",
                                "bg_color": "#FB7299",
                                "bg_color_night": "#BB5B76",
                                "border_color": "#FB7299",
                                "border_color_night": "#BB5B76",
                                "bg_style": 1
                            }
],
"index_title": "13",
"long_title": "PVP"
}
],
"badges": [
{
                        "text": "独家",
                        "text_color": "#FFFFFF",
                        "text_color_night": "#E5E5E5",
                        "bg_color": "#00C0FF",
                        "bg_color_night": "#0B91BE",
                        "border_color": "#00C0FF",
                        "border_color_night": "#0B91BE",
                        "bg_style": 1
                    }
],
"cover": "http://i0.hdslb.com/bfs/bangumi/image/dd7a9d0a0bee32b1f43c2656398d8463d12b3069.jpg",
"areas": "日本",
"styles": "架空/小说改/智斗/奇幻",
"goto_url": "https://www.bilibili.com/bangumi/play/ss24596",
"desc": "时间为2138年。曾卷起一大风潮的虚拟现实体感型网络游戏《YGGDRASIL》即将迎来停服。玩家飞鼠在曾经以同伴和荣华自傲的根据地纳萨力克地下大坟墓，独自一人安静等待着那一刻。\n但是，不料发生了“过了...",
"pubtime": 1531152000,
"media_mode": 2,
"fix_pubtime_str": "",
"media_score": {
  "score": 9.4,
  "user_count": 94023
},
"display_info": [
{
                        "text": "独家",
                        "text_color": "#FFFFFF",
                        "text_color_night": "#E5E5E5",
                        "bg_color": "#00C0FF",
                        "bg_color_night": "#0B91BE",
                        "border_color": "#00C0FF",
                        "border_color_night": "#0B91BE",
                        "bg_style": 1
                    }
],
"pgc_season_id": 24596,
"corner": 13,
"index_show": "全13话"
* */

//https://api.bilibili.com/x/web-interface/search/type?search_type=media_bangumi&keyword=overlord&page=1
//https://api.bilibili.com/x/web-interface/search/type?search_type=media_ft&keyword=年会不能停&page=1
// 影视的返回数据，和番剧是一样的。这里用两个类来进行区分，以免后续出现修改

export interface SearchMediaBean{
  type: string
  media_id: number
  title: string
  org_title: string
  media_type: number
  cv:string
  staff: string
  season_id: number
  is_avid: boolean
  hit_columns: string[]
  hit_epids:string
  season_type: number
  season_type_name: string
  selection_style: string
  ep_size: number
  url: string
  button_text: string
  is_follow: number
  is_selection: number

  cover: string
  areas: string
  styles: string
  goto_url: string
  desc: string
  pubtime: number
  media_mode: number
  fix_pubtime_str:string
  media_score: {
    score: number
    user_count: number
  }
  display_info: SearchMediaBadges[]
  pgc_season_id: number
  corner: number
  index_show: string
  eps: SearchMediaEps[]
  badges: SearchMediaBadges[]
}
export interface SearchMediaEps{
  id: number
  cover: string
  title: number
  url: string
  release_date:string
  badges: SearchMediaBadges[]
  index_title: number
  long_title: string
}
export interface SearchMediaBadges{
  text: string
  text_color: string
  text_color_night:string
  bg_color:string
  bg_color_night: string
  border_color: string
  border_color_night: string
  bg_style: number
}