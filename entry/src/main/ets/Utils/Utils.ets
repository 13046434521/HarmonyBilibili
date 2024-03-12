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

  static upRichText(title:string,fontSize:number){
    return title.replace(`em class="keyword`,`p style="font-size: ${fontSize}px;text-align: start;font-weight: bold; color: rgb(24,78,228)`).replace(`em`,`p`)
  }
  static upRichTextClear(title:string){
    let msg =  title.replace(`<em class="keyword">`,"").replace(`</em>`,"")
    console.log("rich text:"+msg)
    return msg
  }
}

