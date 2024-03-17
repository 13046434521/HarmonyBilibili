import window from '@ohos.window'
import promptAction from '@ohos.promptAction'
import util from '@ohos.util'

export class Utils {
  // 观看量数据转换处理
  static Views(views: number): string {
    //console.log("views:"+views+"---"+(views/10000).toFixed(2)+"w")
    if (views > 10000) {
      return (views / 10000).toFixed(2) + "w"
    }
    return views.toString()
  }
  static TimeDeal(duration: string): string {
    if (!duration) {
      return duration
    }
    let arr:Array<string>  = duration.split(':')
    let second:string|number = ''
    let minute:string|number = ''
    let hour:string|number = ''
    if (arr.length==2 ) {
      second=Number.parseInt(arr[1])
      minute=Number.parseInt(arr[0])

      if (Number.parseInt(arr[1])<10) {
        second = '0'+second
      }
      return minute+":"+second
    }

    if (arr.length==3) {
      second=Number.parseInt(arr[2])
      minute=Number.parseInt(arr[1])
      hour = Number.parseInt(arr[0])
      if (minute<10) {
        minute = '0'+minute
      }
      if (second<10) {
        second = '0'+second
      }
      return hour+":"+minute+":"+second
    }
  }
  // 视频时常，转换处理
  static Duration(duration: number): string {
    //console.log("Duration:time:"+duration)

    let second: number | string = (duration % 60)
    let minute: number | string = Math.floor(duration / 60)
    if (second < 10) {
      second = '0' + second.toFixed(0)
    }else{
      second.toFixed(0)
    }

    //console.log("duration:"+duration+"---"+minute+'---'+second)
    return duration > 3600 ? Math.floor(duration / 3600) + ":" + minute + ":" + second : minute + ":" + second
  }

  static upRichText(title:string){
    let msg =  title.replace(/<em class="keyword">/g,"<font size=25px color=red>")
      .replace(/<\/em>/g,"</font>")
    //console.log("rich text:"+msg)
    return msg
   }

  static upRichTextClear(title:string){
    // utf-8编码
    let coding = title
    // let coding = new util.TextDecoder(title).encoding

    //result: string = str.replace(/[^a-zA-Z0-9]/g, '');
    let msg =  coding.replace(/<em class="keyword">/g,"").replace(/<\/em>/g,"")
      .replace(/&#x27;/g,"'")
    //console.log("rich text:"+msg)
    return msg
  }

  private completionNum(num: number): string | number {
    if (num < 10) {
      return '0' + num;
    } else {
      return num;
    }
  }
  static Toast(message:string){
    promptAction.showToast({message:message})
  }

  static  timestampToDate(timestamp_ms: number): string {
    const date = new Date(timestamp_ms * 1000); // 将时间戳转换为Date对象
    const year = date.getFullYear(); // 获取年份
    const month = (date.getMonth() + 1).toString().padStart(2, '0'); // 获取月份并补零
    const day = date.getDate().toString().padStart(2, '0'); // 获取日期并补零
    const hours = date.getHours().toString().padStart(2, '0'); // 获取小时并补零
    const minutes = date.getMinutes().toString().padStart(2, '0'); // 获取分钟并补零
    const seconds = date.getSeconds().toString().padStart(2, '0'); // 获取秒钟并补零

    // return `${year}年${month}月${day}日 ${hours}:${minutes}:${seconds}`; // 返回格式化的日期字符串
    return `${year}年${month}月${day}日`
  }
  // private stringForTime(timeMs: number): string {
  //   let totalSeconds: number | string = (timeMs / 1000);
  //   let newSeconds: number | string = totalSeconds % 60;
  //   let minutes: number | string = (totalSeconds / 60) % 60;
  //   let hours: number | string = totalSeconds / 3600;
  //   hours = this.completionNum(Math.floor(Math.floor(hours * 100) / 100));
  //   minutes = this.completionNum(Math.floor(Math.floor(minutes * 100) / 100));
  //   newSeconds = Math.floor(Math.floor(newSeconds * 100) / 100)
  //   if (this.isCurrentTime) {
  //     if (this.oldSeconds < newSeconds || newSeconds === 0 || this.isSeekTo) {
  //       this.oldSeconds = newSeconds
  //     } else {
  //       newSeconds = this.oldSeconds
  //     }
  //   }
  //   newSeconds = this.completionNum(newSeconds);
  //   if (hours > 0) {
  //     return hours + ":" + minutes + ":" + newSeconds;
  //   } else {
  //     return minutes + ":" + newSeconds;
  //   }
  // }
}

// 切换横竖屏
function windowOrientation(orientation: window.Orientation){
  if (globalThis.windowStage != undefined) {
    globalThis.windowStage.getMainWindow((err, data) => {
      if (err.code) {
        console.error('IjkPlayer changeWindowDirection Failed to change the window: ' + JSON.stringify(err))
        return
      }
      data.setPreferredOrientation(orientation);
    })
  }
}

