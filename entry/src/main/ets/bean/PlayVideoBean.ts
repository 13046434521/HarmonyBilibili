/*  "data": {
    "from": "local",
    "result": "suee",
    "message": "",
    "quality": 64,
    "format": "mp4720",
    "timelength": 25174,
    "accept_format": "mp4720,mp4",
    "accept_description": [
      "高清 720P",
      "流畅 360P"
    ],
    "accept_quality": [
      64,
      16
    ],
    "video_codecid": 7,
    "seek_param": "start",
    "seek_type": "offset",
    "durl": [
      {
        "order": 1,
        "length": 25174,
        "size": 3062515,
        "ahead": "",
        "vhead": "",
        "url": "https://upos-hz-mirrorakam.akamaized.net/upgcxcode/31/99/1461669931/1461669931-1-192.mp4?e=ig8euxZM2rNcNbRghWdVhwdlhWN1hwdVhoNvNC8BqJIzNbfqXBvEqxTEto8BTrNvN0GvT90W5JZMkX_YN0MvXg8gNEV4NC8xNEV4N03eN0B5tZlqNxTEto8BTrNvNeZVuJ10Kj_g2UB02J0mN0B5tZlqNCNEto8BTrNvNC7MTX502C8f2jmMQJ6mqF2fka1mqx6gqj0eN0B599M=\u0026uipk=5\u0026nbs=1\u0026deadline=1709909091\u0026gen=playurlv2\u0026os=akam\u0026oi=887475816\u0026trid=ac4c192e5257458fa6fe92ff2bb60315u\u0026mid=68406011\u0026platform=pc\u0026upsig=62fe413e11e960269629f309caac769f\u0026uparams=e,uipk,nbs,deadline,gen,os,oi,trid,mid,platform\u0026hdnts=exp=1709909091~hmac=d2aaa1ef7093ec27453b10de05ac89317a6464cea26bf664777927bb9b2bfe20\u0026bvc=vod\u0026nettype=0\u0026orderid=0,1\u0026buvid=F990C62D-8570-E810-1D2A-42B652D1376F29722infoc\u0026build=0\u0026f=u_0_0\u0026agrr=0\u0026bw=122500\u0026logo=80000000",
        "backup_url": null
      }
    ],
    "support_formats": [
      {
        "quality": 64,
        "format": "mp4720",
        "new_description": "720P 高清",
        "display_desc": "720P",
        "superscript": "",
        "codecs": null
      },
      {
        "quality": 16,
        "format": "mp4",
        "new_description": "360P 流畅",
        "display_desc": "360P",
        "superscript": "",
        "codecs": null
      }
    ],
    "high_format": null,
    "last_play_time": 0,
    "last_play_cid": 0,
    "view_info": null
  }*/
export class PlayVideoBean{
  from:string
  result:string
  message:string
  quality:number
  format:string
  timelength:number
  accept_format:string
  accept_description:string[]
  accept_quality:number[]
  video_codecid:number
  seek_param:string
  seek_type:string
  last_play_time:number
  last_play_cid:number
  high_format: object
  view_info: object
  durl:PlayURL[]
  support_formats:PlaySupportFormats[]
}
export class PlayURL{
  order:number
  length:number
  size:number
  ahead:string
  vhead:string
  url:string
  backup_url:object
}
export class PlaySupportFormats{
  quality:number
  format:string
  new_description:string
  display_desc:string
  superscript:string
  codecs:object
}