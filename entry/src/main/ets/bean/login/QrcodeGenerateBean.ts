/*{
    "code": 0,
    "message": "0",
    "ttl": 1,
    "data": {
        "url": "https://passport.bilibili.com/h5-app/passport/login/scan?navhide=1&qrcode_key=d7a23f1b2d7196d7970a5b8428e0fed5&from=",
        "qrcode_key": "d7a23f1b2d7196d7970a5b8428e0fed5"
    }
}*/
//https://passport.bilibili.com/x/passport-login/web/qrcode/generate
export interface QrcodeGenerateBean{
  url:string
  qrcode_key:string
}