PersistentStorage.PersistProp<string>('bilibili_cookie','当前无cookie')
PersistentStorage.PersistProp<string>('img_key','')//签名用的
PersistentStorage.PersistProp<string>('sub_key','')//签名用的
PersistentStorage.PersistProp<string>('background_color','#FFFFFF')
PersistentStorage.PersistProp<string>('day_night','day')

AppStorage.SetOrCreate('isLogin', false);
class StorageManager{
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

  getData<T>(key:string):T{
    return AppStorage.Get<T>(key)
  }

  setKey(img_key:string,sub_key:string){
    let startImg = img_key.lastIndexOf('\/')
    let endImg = img_key.lastIndexOf('\.')
    let imgKey = img_key.slice(startImg+1,endImg)

    let startSub = sub_key.lastIndexOf('\/')
    let endSub = sub_key.lastIndexOf('\.')
    let subKey = sub_key.slice(startSub+1,endSub)

    console.warn('WBI','img:'+imgKey)
    console.warn('WBI','sub:'+subKey)

    AppStorage.SetOrCreate('img_key', imgKey);
    AppStorage.SetOrCreate('sub_key', subKey);
  }
}

const storageManager:StorageManager = new StorageManager()
export default storageManager as StorageManager