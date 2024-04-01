import hilog from '@ohos.hilog'

export class JLog{
  static info(tag:string='jtl_log:',msg?:string){
    hilog.info(0X0000,tag,msg)
  }

  static debug(tag:string='jtl_log:',msg?:string){
    hilog.debug(0X0000,tag,msg)
  }

  static warn(tag?:string,msg?:string){
    hilog.warn(0X0000,'JTL:'+tag,msg)
  }

  static error(tag:string='jtl_log:',msg?:string){
    hilog.error(0X0000,tag,msg)
  }

  static fatal(tag:string='jtl_log:',msg?:string){
    hilog.fatal(0X0000,tag,msg)
  }
}