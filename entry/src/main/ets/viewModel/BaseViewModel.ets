import CommentsInfo, { CommentsReply } from '../bean/CommentsInfo'
import { Online } from '../bean/Online'
import Api from '../net/Api'
import { showDialog } from '../Utils/DialogUtil'

export class BaseViewModel{
  videoOnline(bvid:string,cid:number){
    return Api.getOnline<Online>(bvid,cid)
  }
  /**
   * 按热度评论，oid为aid：https://api.bilibili.com/x/v2/reply/wbi/main?oid=450096728&type=1&mode=3&pagination_str=%7B%22offset%22:%22%22%7D&plat=1&web_location=1315875&w_rid=1b67f8f94f4c6b45b5fec94222f0ac20&wts=1713286200
   * 最新评论，oid为aid:https://api.bilibili.com/x/v2/reply/wbi/main?oid=450096728&type=1&mode=2&pagination_str=%7B%22offset%22:%22%22%7D&plat=1&web_location=1315875&w_rid=21609f1b3cfca332036d53c6829f4aae&wts=1713287083
   * @name 获取详细评论
   * @param oid aid
   * @param mode 3为热度，2为最新
   * @param type type=1是视频类型的评论
   * @returns
   */
  commentsInfo(aid:number,mode:2 |3,type:number=1,pn:number=1,ps:number=100){
    return Api.getCommentsInfo<CommentsInfo>(aid,mode,type,pn,ps)
  }
}