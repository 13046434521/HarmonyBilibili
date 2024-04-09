/*{
    "code": 0,
    "message": "0",
    "ttl": 1,
    "data": {
        "url": "https://passport.biligame.com/x/passport-login/web/crossDomain?DedeUserID=68406011&DedeUserID__ckMd5=ecb0ad5cd0bcd251&Expires=1726380254&SESSDATA=a57517d0,1726380254,c1803*31CjCweX-TBnemmAcG9RPH6uMZ6-gG0Klw6zvjwS2vrx-q8hdBNTN4tJOuKRyx4Zfa-pUSVkg5MDdKMHZNVmx5VXpwVDlkTHNVbmRJaHJCZ1Y2ZDRnSHJCTWtZbEh6VWVzaXRYeXUzTkotX21fdGQ3RjgyUDlNVVQ4RmhBNEhjcDVTRWtYUmpvdFlBIIEC&bili_jct=8e45ad85bdbf949a146e2b652815567c&gourl=https%3A%2F%2Fwww.bilibili.com",
        "refresh_token": "9fe05c68afdf6491a137baea22696931",
        "timestamp": 1710828254761,
        "code": 0,
        "message": ""
    }
}*/
// https://passport.bilibili.com/x/passport-login/web/qrcode/poll?qrcode_key=d7a23f1b2d7196d7970a5b8428e0fed5
// qrcode_key是QrcodeGenerateBean中的qrcode_key
export interface QrcodeLoginBean{
  url:string
  refresh_token:string
  timestamp:string
  code:number  //0：扫码登录成功 86038：二维码已失效 86090：二维码已扫码未确认 86101：未扫码
  message:string
}