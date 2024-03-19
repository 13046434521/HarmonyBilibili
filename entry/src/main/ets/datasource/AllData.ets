import { SearchDefaultBean, SearchDefaultDataBean } from '../bean/SearchDefaultBean'
import { BasicDataSource } from './BasicDataSource'

export class AllData extends BasicDataSource<SearchDefaultDataBean>{

  // result_type:string
  // data:SearchDefaultDataBean[] 我需要的是SearchDefaultDataBean[]数组，同时含有result_type
  // 将SearchDefaultBean中的resultType和SearchDefaultDataBean数组，生成一个SearchDefaultDataBean数组且含有resultType
  dealData(data:SearchDefaultBean[]):SearchDefaultDataBean[]{
    let searchDataBean :SearchDefaultDataBean[] =[]

    for (const element of data) {
      let tempData = element.data
      let resultType = element.result_type

      for (const element of tempData) {
        element.result_type = resultType
        searchDataBean.push(element)
      }
    }

    return searchDataBean
  }

  specialData(datas:SearchDefaultBean[]){
    // 1.生成特殊数据
    let temp = this.dealData(datas)
    // 2.清理已存在的所有数据
    this.cleanData()
    // 3.将新生成的数据添加至Data中
    this.pushDataAll(temp)
  }
}