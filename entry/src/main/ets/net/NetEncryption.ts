import cryptoFramework from '@ohos.security.cryptoFramework';
import StorageManager from '../common/StorageManager';


export class NetEncryption {
  private mixinKeyEncTab = [
    46, 47, 18, 2, 53, 8, 23, 32, 15, 50, 10, 31, 58, 3, 45, 35, 27, 43, 5, 49,
    33, 9, 42, 19, 29, 28, 14, 39, 12, 38, 41, 13, 37, 48, 7, 16, 24, 55, 40,
    61, 26, 17, 0, 1, 60, 51, 30, 4, 22, 25, 54, 21, 56, 59, 6, 63, 57, 62, 11,
    36, 20, 34, 44, 52
  ]

  // 对 imgKey 和 subKey 进行字符顺序打乱编码
  private getMixinKey = (orig) => this.mixinKeyEncTab.map(n => orig[n]).join('').slice(0, 32)

  // 计算md5
  getMd5(blob:string){
    var md = cryptoFramework.createMd("MD5");
    // 无符号
    var content:Uint8Array = this.stringToUint8Array(blob)
    md.update({data:content})
    return md.digest()
  }

  stringToUint8Array(str):Uint8Array {
    let arr = [];
    for (let i = 0, j = str.length; i < j; ++i) {
      arr.push(str.charCodeAt(i));
    }
    return new Uint8Array(arr);
  }

  uint8ArrayToHexStr(data: Uint8Array): string {
    let hexString = "";
    let i: number;
    for (i = 0; i < data.length; i++) {
      let char = ('00' + data[i].toString(16)).slice(-2);
      hexString += char;
    }
    return hexString;
  }
  uint8ArrayToHexStr1(data: Uint8Array): string {
    return  Array.prototype.map
      .call(data, (x) => ('00' + x.toString(16)).slice(-2))
      .join('');
  }



  // 为请求参数进行 wbi 签名
  encWbi(params, img_key, sub_key) {
    const mixin_key = this.getMixinKey(img_key + sub_key),
      curr_time = Math.round(Date.now() / 1000),
      chr_filter = /[!'()*]/g

    Object.assign(params, { wts: curr_time }) // 添加 wts 字段
    // 按照 key 重排参数
    const query = Object
      .keys(params)
      .sort()
      .map(key => {
        // 过滤 value 中的 "!'()*" 字符
        const value = params[key].toString().replace(chr_filter, '')
        return `${encodeURIComponent(key)}=${encodeURIComponent(value)}`
      })
      .join('&')
    // 计算 w_rid
    return this.getMd5(query + mixin_key).then((data)=>{
      return query + '&w_rid=' + this.uint8ArrayToHexStr(data.data)
    })
  }

  test() {
    const params = { foo: '114', bar: '514', baz: 1919810 }
    const img_key = StorageManager.getData<string>('img_key')
    const sub_key = StorageManager.getData<string>('sub_key')
    console.warn('WBI',"取出img："+img_key)
    console.warn('WBI',"取出sub："+sub_key)

    return this.encWbi(params, img_key, sub_key)
  }

  getWbi(param:object) {
    const params = param;
    const img_key = StorageManager.getData('img_key');
    const sub_key = StorageManager.getData('sub_key');
    console.warn('WBI', "取出img：" + img_key);
    console.warn('WBI', "取出sub：" + sub_key);
    return this.encWbi(params, img_key, sub_key);
  }
}

const net: NetEncryption = new NetEncryption()

export default net as NetEncryption