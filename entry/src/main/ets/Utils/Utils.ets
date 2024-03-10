export class Utils {
  // 观看量数据转换处理
  static Views(views: number): string {
    //console.log("views:"+views+"---"+(views/10000).toFixed(2)+"w")
    if (views > 10000) {
      return (views / 10000).toFixed(2) + "w"
    }
    return views.toString()
  }

  // 视频时常，转换处理
  static Duration(duration: number): string {
    let second: number | string = duration % 60
    let minute: number | string = Math.floor(duration / 60)
    if (second < 10) {
      second = '0' + second
    }
    // console.log("duration:"+duration+"---"+minute+'---'+second)
    return duration > 3600 ? Math.floor(duration / 3600) + ":" + minute + ":" + second : minute + ":" + second
  }
}

