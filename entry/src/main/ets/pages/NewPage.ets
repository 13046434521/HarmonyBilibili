
@Component
export struct NewPage {
  @State message: string = `https://cn-hbwh-cm-01-16.bilivideo.com/upgcxcode/59/94/1432159459/1432159459-1-192.mp4?e=ig8euxZM2rNcNbRVhwdVhwdlhWdVhwdVhoNvNC8BqJIzNbfqXBvEqxTEto8BTrNvN0GvT90W5JZMkX_YN0MvXg8gNEV4NC8xNEV4N03eN0B5tZlqNxTEto8BTrNvNeZVuJ10Kj_g2UB02J0mN0B5tZlqNCNEto8BTrNvNC7MTX502C8f2jmMQJ6mqF2fka1mqx6gqj0eN0B599M=\u0026uipk=5\u0026nbs=1\u0026deadline=1710451764\u0026gen=playurlv2\u0026os=bcache\u0026oi=2029350973\u0026trid=0000567b2ce1126d43568db00b106691f471u\u0026mid=68406011\u0026platform=pc\u0026upsig=98ebea8be511ef092a0992ed515e5826\u0026uparams=e,uipk,nbs,deadline,gen,os,oi,trid,mid,platform\u0026cdnid=10212\u0026bvc=vod\u0026nettype=0\u0026orderid=0,3\u0026buvid=F990C62D-8570-E810-1D2A-42B652D1376F29722infoc\u0026build=0\u0026f=u_0_0\u0026agrr=1\u0026bw=96340\u0026logo=80000000`
  aboutToAppear(){
    this.message = this.message.replace(/\\u0026/g, '&')
    console.log("PlayURL:"+this.message)
  }

  build() {
    Row() {
      Column() {
        Search()
        Text(this.message)
          .copyOption(CopyOptions.InApp)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Grey)
          .borderColor(Color.Black)
          .fontColor(Color.White)
          .borderStyle(BorderStyle.Solid)
          .borderRadius(15)
          .padding(16)
      }
      .width('100%')
    }
    .height('100%')
  }
}
