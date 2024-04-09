import { SearchDefaultBean, SearchDefaultDataBean } from '../bean/search/SearchDefaultBean'
import { BasicDataSource } from './BasicDataSource'

export class AllData extends BasicDataSource<SearchDefaultDataBean>{

  // result_type:string
  // data:SearchDefaultDataBean[] ����Ҫ����SearchDefaultDataBean[]���飬ͬʱ����result_type
  // ��SearchDefaultBean�е�resultType��SearchDefaultDataBean���飬����һ��SearchDefaultDataBean�����Һ���resultType
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
    // 1.������������
    let temp = this.dealData(datas)
    // 2.�����Ѵ��ڵ���������
    this.cleanData()
    // 3.�������ɵ����������Data��
    this.pushDataAll(temp)
  }
}