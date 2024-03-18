/*
"type": "media_bangumi",
"media_id": 102252,
"title": "<em class=\"keyword\">OVERLORD</em> ��",
"org_title": "<em class=\"keyword\">OVERLORD</em> ��",
"media_type": 1,
"cv": "���ȣ���Ұ��\n�Ŷ����£�ԭ��ʵ\n�����ţ�������\n����ǉ������Ӣ����\n���ף���ɽϦʵ\n�����ڸ�˹�����ٽ�֮\n������˹����լ��̫\n����˹��ǧҶ��\n������ķ����ɽ����\n������ʮ�ԣ��\n¶��˿�����ȣ�С��δ����\n�ȱ��������Ӳְ���\nϣ˿��������ɳ��\n�����㣺�������\n�����꣺���ù�\n������˹�����غ���\nɳ˹�֣�骼��м�\n��³ѩ���깬��\n��³��ʯ������\n���ȣ���Ұϣ����\n����ķ��������̫\n��ܷ򣺰��ܿ���\n�������������ƶ�\n����˿��С��ˮ����\n����������ٹ�����\n����³��������������\n��ǣ�ʯ�Ͼ���\n��ȣ���������\n�����٣����٧\n�������ḥ��ӣ��Т��\n��³���ʦТҲ",
"staff": "ԭ������ɽ�����ͣ���<em class=\"keyword\">OVERLORD</em>��/KADOKAWA����\n��ɫԭ����so-bin\n�ල����������\nϵ�й��ɣ���ԭѩ��\n��ɫ��ƣ�����ϡ�����Т��\n��Ҫ��ɫ��ơ�������ơ�������ƣ���������ɼ���ҴΡ������ػ�����ľ���塢ǰԭ����\n�����ල�����ﷱ������ɽ�ɼ��ӣ�ATELIER MUSA��\n�����趨����Ұ�����ӡ���ñ���һ��ATELIER MUSA��\nɫ����ƣ�ܥ���ѵ�\n3D�ල�����п�¡\n��Ӱ�ල���̸�����\n�༭��ڣ��������\n����ල������ԣ��\n����������grooove\n���֣�Ƭɽ��־��Team-MAX��\n����������KADOKAWA\n����������MADHOUSE",
"season_id": 24596,
"is_avid": false,
"hit_columns": [
"title",
"org_title"
],
"hit_epids": "",
"season_type": 1,
"season_type_name": "����",
"selection_style": "grid",
"ep_size": 13,
"url": "https://www.bilibili.com/bangumi/play/ss24596",
"button_text": "�����ۿ�",
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
                                "text": "��Ա",
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
                        "text": "����",
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
"areas": "�ձ�",
"styles": "�ܿ�/С˵��/�Ƕ�/���",
"goto_url": "https://www.bilibili.com/bangumi/play/ss24596",
"desc": "ʱ��Ϊ2138�ꡣ������һ��糱��������ʵ�����������Ϸ��YGGDRASIL������ӭ��ͣ������ҷ�����������ͬ����ٻ��԰��ĸ��ݵ��������˵��´��Ĺ������һ�˰����ȴ�����һ�̡�\n���ǣ����Ϸ����ˡ�����...",
"pubtime": 1531152000,
"media_mode": 2,
"fix_pubtime_str": "",
"media_score": {
  "score": 9.4,
  "user_count": 94023
},
"display_info": [
{
                        "text": "����",
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
"index_show": "ȫ13��"
* */

//https://api.bilibili.com/x/web-interface/search/type?search_type=media_bangumi&keyword=overlord&page=1
export interface SearchMediaBangumiBean{
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
  display_info: SearchMediaBangumiTextColor[]
  pgc_season_id: number
  corner: number
  index_show: string
  eps: SearchMediaBangumiEps[]
  badges: SearchMediaBangumiTextColor[]
}
export interface SearchMediaBangumiEps{
  id: number
  cover: string
  title: number
  url: string
  release_date:string
  badges: SearchMediaBangumiTextColor[]
  index_title: number
  long_title: string
}
export interface SearchMediaBangumiTextColor{
  text: string
  text_color: string
  text_color_night:string
  bg_color:string
  bg_color_night: string
  border_color: string
  border_color_night: string
  bg_style: number
}