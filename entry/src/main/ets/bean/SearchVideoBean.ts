/*
"seid": "15732692243741184881",
"page": 1,
"pagesize": 20,
"numResults": 1000,
"numPages": 50,
"suggest_keyword": "",
"rqt_type": "search",
"cost_time": Object{...},
"exp_list": Object{...},
"egg_hit": 0,
"result": Array[20],
"show_column": 0,
"in_black_key": 0,
"in_white_key": 0*/
import observer from '@ohos.telephony.observer'

export interface SearchVideoBean{
  type:string
  id:number
  author:string
  typeid:string
  mid:number
  typename:string
  arcurl:string
  bvid:string
  aid:number
  title:string
  description:string
  pic:string
  play:number
  video_review:number
  favorites:number
  tag:string
  danmaku:number
  review:number
  pubdate:number
  senddate:number
  duration:string
  hit_columns:string[]
  rank_score:number
  like:number
  upic:string
  /*  "type": "video",
    "id": 1951684520,
    "author": "����������",
    "mid": 21837784,
    "typeid": "182",
    "typename": "Ӱ����̸",
    "arcurl": "http://www.bilibili.com/video/av1951684520",
    "aid": 1951684520,
    "bvid": "BV11C41187pa",
    "title": "����������ʵ�¼����ģ�������ͳҲ�Һڣ�û����������󵨵ĵ�Ӱ��2023����Ʊ���ھ���\u003cem class=\"keyword\"\u003e�׶�֮��\u003c/em\u003e��",
    "description": "������Ӱ��\n\n���ع�����BV1Dp4y1r7Bk\n�������硷��BV1Zg4y1z71E\n�������ˡ���BV1qi4y1L7DH\n���绤�ˡ���BV1Bh41127gs\n���ߵ���ͷ����BV11i4y1u7Ui\n��һ��Ҫץס����BV1kx411Z7L6\n����ɽ�Ĳ����ǡ���BV1g3411K7CM\n\nϲ���Ļ������ޡ�Ͷ�ҡ��ղذɣ����ǵ�����֧�־��Ҹ��µ��������\n���ྫ�����ݣ���ע�ҵ�΢�Ź��ںš������������ˣ�adouGLL��",
    "arcrank": "0",
    "pic": "//i1.hdslb.com/bfs/archive/e53b8e7f17ffc5b4cccaa299c47705c705ffbf86.jpg",
    "play": 770845,
    "video_review": 1925,
    "favorites": 8909,
    "tag": "֣��ʢ,�߷ֵ�Ӱ,������,��Ӱ��˵,ȫ����,Ӱ����̸,����Ӱ��,������,���˶�����Ӱ��,�׶�֮��",
    "review": 1152,
    "pubdate": 1709892300,
    "senddate": 1709898481,
    "duration": "32:41",
    "badgepay": false,
    "hit_columns": [
    "title",
    "tag"
    ],
    "view_type": "",
    "is_pay": 0,
    "is_union_video": 0,
    "rec_tags": null,
    "new_rec_tags": [

    ],
    "rank_score": 128091781,
    "like": 47849,
    "upic": "https://i1.hdslb.com/bfs/face/b6dad37ef0a68341b6e2f84de5e1f9ee02f8365e.jpg",
    "corner": "",
    "cover": "",
    "desc": "",
    "url": "",
    "rec_reason": "",
    "danmaku": 1925,
    "biz_data": null,
    "is_charge_video": 0,
    "vt": 0,
    "enable_vt": 0,
    "vt_display": "",
    "subtitle": "",
    "episode_count_text": "",
    "release_status": 0,
    "is_intervene":0*/
}