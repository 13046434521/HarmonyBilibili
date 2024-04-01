import Constants from '../common/Constants'
import { JLog } from '../common/JLog'
import StorageManager from '../common/StorageManager'

@Component
export struct ShoppingPage {
  @State msg:string = "123"
  @StorageLink('isLogin') isLogin:boolean = false
  @StorageLink('login_img_url') vipImageUrl :string = ''
  @StorageProp('background_color') backgroundColors :string = Constants.BACKGROUND_HOME_COLOR
  @State isLoginImg:boolean = false
  @State url:string='https://www.bilibili.com/read/mobile?id=1110920'
  num = 1
  build() {
    Column() {

      Button("测试啊").onClick(()=>{
        let value = this.url.includes('https://www.bilibili.com/read/mobile?id')
        let value2 = !this.url.includes('https://www.bilibili.com/read/mobile?id')
        let value3 = this.url.includes('abcdefg')
        this.msg = value+"   "+value2 +"   "+value3
        JLog.warn("JTL",'url:'+this.msg)
      })

      Text(this.isLogin ?"true":"false")

      Image(this.isLogin?$r('app.media.bili_nologin_avatar'):'https://img1.baidu.com/it/u=3825090768,663587812&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1711904400&t=ed4de14b0f10fce34b16aad9ab781b2e').width(100).height(100)
      Image(this.isLogin?$r('app.media.bili_nologin_avatar'):$r('app.media.test')).width(100).height(100)
      Image(!this.isLogin?$r('app.media.bili_nologin_avatar'):'https://img1.baidu.com/it/u=3825090768,663587812&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1711904400&t=ed4de14b0f10fce34b16aad9ab781b2e').width(100).height(100)

      Image(this.isLoginImg?$r('app.media.bili_nologin_avatar'):$r('app.media.test')).width(100).height(100)
      Image(this.isLoginImg?$r('app.media.bili_nologin_avatar'):this.vipImageUrl).width(100).height(100)
      Image(this.isLoginImg?$r('app.media.bili_nologin_avatar'):this.vipImageUrl).width(100).height(100)
      Text(this.msg)
      Button('getCookie').onClick(()=>{
        this.msg = StorageManager.getCookie()
      })

      Button('setCookie').onClick(()=>{
        StorageManager.loginCookie(""+this.num++)
      })
      Button('isLogin').onClick(()=>{
        // this.msg ="AppStorage:isLogin:"+ StorageManager.isLogin()
      })
      Button('setLogin').onClick(()=>{
        // StorageManager.setLogin(true)
      })
    }
  }
}