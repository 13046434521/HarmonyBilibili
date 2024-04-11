import { Online } from '../bean/Online'
import Api from '../net/Api'

export class BaseViewModel{
  videoOnline(bvid:string,cid:number){
    return Api.getOnline<Online>(bvid,cid)
  }
}