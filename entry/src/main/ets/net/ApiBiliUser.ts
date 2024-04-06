import { AccInfo } from '../bean/biliUser/AccInfo'
import { UserInfoBean } from '../bean/biliUser/UserInfoBean'
import { UserStateBean } from '../bean/biliUser/UserStateBean'
import { ApiBase } from './ApiBase'
import NetEncryption from './NetEncryption'

 export class ApiBiliUser extends ApiBase{
  // https://api.bilibili.com/x/space/wbi/acc/info?mid=''&wts=1685070149&w_rid=f7b376124782ae8cb42c56fdd69144ed
  // 用户空间详细信息 Cookie（SESSDATA）
  getUserAccInfo(mid:number){
    let param={'mid':mid}
    return NetEncryption.getWbi(param).then(webi=>{
      let url =  `https://api.bilibili.com/x/space/wbi/acc/info?${webi}`
      console.warn('WBI',url)
      return this.request<AccInfo>(url,this.instanceAxios)
    })
    let url = "https://api.bilibili.com/x/space/wbi/acc/info?mid=''&wts=1685070149&w_rid=f7b376124782ae8cb42c56fdd69144ed"
  }

   // 临时测试cookie：let temp = "i-wanna-go-back=-1; _uuid=C23E3C8B-4A3F-3BEC-4FEE-6C7692E8178330018infoc; enable_web_push=DISABLE; buvid4=A26F40F9-7FBF-43AA-5BD9-80F4924FCBFD30208-023111012-KxfNF8XJX%2FbkT0eszmLSXw%3D%3D; is-2022-channel=1; buvid_fp_plain=undefined; hit-dyn-v2=1; LIVE_BUVID=AUTO3317015948042453; CURRENT_BLACKGAP=0; bsource_origin=baidu_aladdin; share_source_origin=COPY; bp_article_offset_68406011=906886996051361810; msource=pc_web; deviceFingerprint=e82561c17bd52ea232fc909eec721919; from=pc_ticketlist; bsource=search_baidu; CURRENT_QUALITY=112; fingerprint=7a3b2b714f87d63975025c0c8e3d10f8; CURRENT_FNVAL=4048; buvid_fp=7a3b2b714f87d63975025c0c8e3d10f8; rpdid=|(k|kmJl|m~J0J'u~uul|mm)|; home_feed_column=5; browser_resolution=1920-911; PVID=3; bili_ticket=eyJhbGciOiJIUzI1NiIsImtpZCI6InMwMyIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MTE4OTI0MTAsImlhdCI6MTcxMTYzMzE1MCwicGx0IjotMX0.QbrQ7yWZ7PyaSi_JUItfn1Adfb1ieZ0bpFuL3Si8o-Q; bili_ticket_expires=1711892350; bp_video_offset_68406011=913942420408762371; b_lsid=3747774B_18E883A5D0A; buvid3=A02544D4-2C6A-6A25-15A2-521309AECBB457861infoc; b_nut=1711687757; b_ut=7; FEED_LIVE_VERSION=V8; header_theme_version=CLOSE; SESSDATA=e85b5348%2C1727239821%2C402b9%2A32CjCMa5xR1ftZOTOQidtxnK4R3wxt-jz7Ab8BTMPL6dOTdLLGnrPs9FK8bMhQf36XIfASVkQwMkc4SkE1VmpoTjdWb0VhaGN2QTVMeEE3TWZucGJBTDBUS29qb21XUlBBQTJFM1dmYkFDd21RdkxXVFRSclhaaVRDbVd3aXV6aUNoWlBhaGp3Qnl3IIEC; bili_jct=d3ac63861f253f083cc5bb7377aeb0b0; DedeUserID=430281002; DedeUserID__ckMd5=c3caa09fe9c35dbb; sid=hhkcaaag"

   // https://api.bilibili.com/x/web-interface/card?mid=68406011
   // 用户名片信息 Cookie（SESSDATA）
   loginUserInfo(mid:number):Promise<UserInfoBean>{
     let url = `https://api.bilibili.com/x/web-interface/card?mid=${mid}`
     return this.request<UserInfoBean>(url,this.instanceAxios)
   }

   getUserState():Promise<UserStateBean>{
     let url = "https://api.bilibili.com/x/web-interface/nav/stat"
     return this.request<UserStateBean>(url,this.instanceAxios)
   }

   // https://api.bilibili.com/x/relation/followings?vmid=11474631
   // 查看用户关注列表，（隐藏的无法查看）

   // https://api.bilibili.com/x/relation/tags
   // 获取关注分组,每组数量以及分组id。没有详细内容

   // https://api.bilibili.com/x/relation/tag?tagid=-10&order_type=&ps=2&pn=1
   // 根据分组id，获取对应的关注列表  ps为返回个数，pn为页数  order_type:attention(常访问排序)，''或者不填写(默认排序)

    // https://api.bilibili.com/x/space/top/arc?vmid=17920281
   // 查询置顶视频

   // https://api.bilibili.com/x/space/masterpiece?vmid=17920281
   // 查询代表作视频

   // https://api.bilibili.com/x/space/notice?mid=17920281
   // 个人空间公告

   // https://api.bilibili.com/x/space/like/video?vmid=17920281
   // 点赞的视频

   // https://api.bilibili.com/x/space/coin/video?vmid=17920281
   // 投币的视频

   // https://api.bilibili.com/x/v3/fav/folder/created/list-all?up_mid=68406011
   // 查询用户收藏夹列表

   //https://space.bilibili.com/ajax/Bangumi/getList?mid=68406011&type=1&ps=2&pn=1
   // 查询用户追番列表

   // https://api.bilibili.com/x/space/bangumi/follow/list?vmid=68406011&type=1&ps=2&pn=1
   // 查询用户追番明细 (type=1：追番  2：追剧)

   // https://space.bilibili.com/ajax/tags/getSubList?mid=68406011&type=1&ps=2&pn=1
   // 查询用户关注话题

   // https://api.bilibili.com/x/space/upstat?mid=430426421
   // 获取播放量和获赞

   // https://api.bilibili.com/x/relation/stat?vmid=430426421
   // 获取用户关注和粉丝数

   // https://api.bilibili.com/x/v3/fav/folder/collected/list?pn=1&ps=20&up_mid=68406011&platform=web
   // 我的收藏和订阅文件夹（我的收藏页面-》我创建的收藏文件夹下面）


   //https://api.bilibili.com/x/v3/fav/resource/list?media_id=101882111&pn=1&ps=20&keyword=&order=mtime&type=0&tid=0&platform=web
   //收藏文件夹中的内容

   // https://api.bilibili.com/x/space/navnum?mid=68406011
   // 用户页面各种类型数量（番剧多少，投稿多少）

   // https://api.bilibili.com/x/space/wbi/arc/search?mid=430426421&pn=1&ps=25&index=1&order=pubdate&order_avoided=true&platform=web&w_rid=6ed1f11e18291a9f155072385322452a&wts=1712057502
   // https://api.bilibili.com/x/space/wbi/arc/search?mid=68406011&pn=1&ps=25&index=1&order=pubdate&order_avoided=true&w_rid=3f00e9fd28a90211c77b040d9d2859ae&wts=1712059082
   // https://api.bilibili.com/x/space/wbi/arc/search?mid=68406011&pn=1&ps=25&order=&keyword=&tid=0
   // 主页->我的视频 ----不能用  tid：分区筛选，默认为0不进行分区筛选，	order:默认为pubdate最新发布：pubdate最多播放：click多收藏：stow

   // https://api.bilibili.com/x/space/coin/video?vmid=68406011&gaia_source=main_web&web_location=333.999&w_rid=e06f116942a6a9ff58f08647f9320666&wts=1712059082
   // 主页->最近投币视频

   //https://api.bilibili.com/x/space/like/video?vmid=68406011&gaia_source=main_web&web_location=333.999&w_rid=e06f116942a6a9ff58f08647f9320666&wts=1712059082
   //主页->最近点赞视频

   //https://api.bilibili.com/x/v3/fav/folder/created/list?pn=1&ps=10&up_mid=68406011
   //主页->我的收藏夹（只有收藏夹名字和里面的数量，没有详细信息

   //https://api.bilibili.com/x/space/bangumi/follow/list?vmid=68406011&type=1
  // 主页->订阅的番剧(有seasonid和mediaid)type可能是番剧和影视切换

   //https://api.bilibili.com/x/polymer/web-space/home/seasons_series?mid=68406011&page_num=1&page_size=10
   //主页->我的合集和视频列表(有aid，bid等)

   // https://api.bilibili.com/x/polymer/web-dynamic/v1/feed/space?offset=&host_mid=68406011&timezone_offset=-480&platform=web&features=itemOpusStyle,listOnlyfans,opusBigCover,onlyfansVote&web_location=333.999&w_rid=eb7961909fd3914d26043aa99684dcf3&wts=1712058933
   // 我的动态

   // https://api.bilibili.com/x/space/bangumi/follow/list?type=1&follow_status=0&pn=1&ps=15&vmid=68406011&ts=1712058829031
   // 我的追番内容


 }

const biliUser = new ApiBiliUser()
export default biliUser as ApiBiliUser
