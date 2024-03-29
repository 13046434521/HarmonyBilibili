PersistentStorage.PersistProp<string>('bilibili_cookie','当前无cookie')
AppStorage.SetOrCreate('isLogin', false);

export class StorageManager{
  private loginLink: SubscribedAbstractProperty<boolean> = AppStorage.Link('isLogin');
  private cookieLink: SubscribedAbstractProperty<string> = AppStorage.Link('bilibili_cookie');

  init(){
    console.log('StorageManager init')
  }

  loginCookie(cookie:string){
    this.cookieLink.set(cookie)
    console.log('StorageManager loginCookie:'+cookie)
  }

  getCookie():string{
    console.log('StorageManager getCookie')
    return this.cookieLink.get()
  }

  setData<T>(key:string,data:T){
    AppStorage.SetOrCreate(key, data);
  }

  getData<T>(key:string){
    return AppStorage.Get<T>(key)
  }
}

const storageManager:StorageManager = new StorageManager()
export default storageManager as StorageManager