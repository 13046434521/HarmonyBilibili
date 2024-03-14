/**
 MediaCodec class can be used to access low-level media codecs, i.e. encoder/decoder components.
 It is part of the Android low-level multimedia support infrastructure (normally used together
 with {@link MediaExtractor}, {@link MediaSync}, {@link MediaMuxer}, {@link MediaCrypto},
 {@link MediaDrm}, {@link Image}, {@link Surface}, and {@link AudioTrack}.)
 <p>
 <center>
 <img src="https://upload-images.jianshu.io/upload_images/5872452-51f25da88cc1a5c8.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp" style="width: 540px; height: 205px"
 alt="MediaCodec buffer flow diagram">
 </center>
 <p>
 */

@Component
export struct SearchDefaultDetails {
  @State message: string = '默认'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}