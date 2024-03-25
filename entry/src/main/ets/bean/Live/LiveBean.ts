/*
"code": 0,
"message": "0",
"ttl": 1,
"data": {
        "current_quality": 4,
        "accept_quality": [
            "4",
            "3"
        ],
        "current_qn": 400,
        "quality_description": [
            {
                "qn": 10000,
                "desc": "原画"
            },
{
  "qn": 400,
  "desc": "蓝光"
},
{
  "qn": 250,
  "desc": "超清"
},
{
  "qn": 150,
  "desc": "高清"
}
],
"durl": [
{
                "url": "https://cn-lnsy-cm-01-03.bilivideo.com/live-bvc/306520/live_1388514638_9387369_4000.flv?expires=1711351657&pt=web&deadline=1711351657&len=0&oi=2029350973&platform=web&qn=400&trid=10009300ca0a045643388fd7ccef7dee9c5a&uipk=100&uipv=100&nbs=1&uparams=cdn,deadline,len,oi,platform,qn,trid,uipk,uipv,nbs&cdn=cn-gotcha01&upsig=2c3bf1b588844a672e4c9c08842dca9a&sk=e7fc62c489ef21e103dff04af1fce1d2&p2p_type=0&sl=10&free_type=0&mid=68406011&sid=cn-lnsy-cm-01-03&chash=0&bmt=1&sche=ban&score=12&pp=rtmp&source=one&trace=941&site=fd6e322c0cbca8149256607fad90f4b9&zoneid_l=151339011&sid_l=live_1388514638_9387369_4000&order=1",
                "length": 0,
                "order": 1,
                "stream_type": 0,
                "p2p_type": 1
            }
]
}*/
import { DefinitionBean } from '../DefinitionBean'
// https://api.live.bilibili.com/room/v1/Room/playUrl?qn=400&platform=web&cid=23982773
// 获取直播间内容
export class LiveBean{
  current_quality: number
  accept_quality:string[]
  current_qn:number
  quality_description:DefinitionBean[]
  durl:LiveUrlBean[]
}

export class LiveUrlBean{
  url:string
  order:number
  length:number
  p2p_type:number
  stream_type:number
}