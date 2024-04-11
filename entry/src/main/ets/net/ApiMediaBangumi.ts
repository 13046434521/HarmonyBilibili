import { ApiBase } from './ApiBase';

export class ApiMediaBangumi extends ApiBase{
  //https://api.bilibili.com/pgc/review/user
  // 获取剧集基本信息
  getBangumiBasicInfo(){
    let url = 'https://api.bilibili.com/pgc/review/user'
  }
  // https://api.bilibili.com/pgc/view/web/season
  // 获取剧集详细信息
  getBangumiDetailInfo(season_id:number,ep_id =''){
    let url = `https://api.bilibili.com/pgc/view/web/season?season_id=${season_id}&ep_id=${ep_id}`
  }

  // https://api.bilibili.com/pgc/web/season/section?season_id=42290
  // 获取剧集分集信息
  
}



const bangumi:ApiMediaBangumi = new ApiMediaBangumi()
export default bangumi as ApiMediaBangumi