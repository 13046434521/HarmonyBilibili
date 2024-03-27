
PersistentStorage.PersistProp<string>('bilibili_cookie','当前无cookie')
AppStorage.SetOrCreate('isLogin', false);
export class StorageManager{
  private link: SubscribedAbstractProperty<boolean> = AppStorage.Link('isLogin');

  init(){

    console.log('StorageManager init')
  }

  loginCookie(cookie:string){
    AppStorage.Set<string>('bilibili_cookie',cookie)
    console.log('StorageManager loginCookie:'+cookie)
  }

  getCookie():string{
    console.log('StorageManager getCookie')
    return AppStorage.Get<string>('bilibili_cookie')
  }

  isLogin():boolean{
    console.log('StorageManager isLogin')
   return this.link.get()
  }

  setLogin(login:boolean){
    console.log('StorageManager setLogin:'+login)
    this.link.set(login)
  }
}

const storageManager:StorageManager = new StorageManager()
export default storageManager as StorageManager