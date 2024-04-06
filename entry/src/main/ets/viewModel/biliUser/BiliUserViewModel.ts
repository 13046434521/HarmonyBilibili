import ApiBiliUser from '../../net/ApiBiliUser'

export class BiliUserViewModel{
  // 获取用户数据
  async getUserData(mid:number){
    return await ApiBiliUser.loginUserInfo(mid)
      .then(item=>{
        return item
      })
  }

  // 获取主页数据
  getUserMineData(){

  }

  // 获取动态数据
  getUserDynamicData(){

  }

  // 获取投稿数据
  getUserVideoData(){

  }

  // 获取追番数据
  getUserBangumiData(){

  }

  // 获取投币数据
  getUserCoinData(){

  }

  // 获取点赞视频数据
  getUserLikeData(){

  }
}