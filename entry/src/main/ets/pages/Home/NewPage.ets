import { RefreshList } from '../../common/RefreshList';
import { showDialog } from '../../Utils/DialogUtil';
import router from '@ohos.router';
import { HomeData } from '../../datasource/HomeData';
import { HomeBeanItem } from '../../bean/HomeBean';
import Api from '../../net/Api';
import { Utils } from '../../Utils/Utils';

@Preview
@Component
export struct NewPage {
  @State isVisible: Visibility = Visibility.Visible;
  @State isShow: boolean = true;

  @State res:string="测试"
  page = 1
  @State homeData:HomeData = new HomeData()
  @State isRefresh:boolean = false
  @State isLoadMore :boolean = false
  aboutToAppear(){
    if (router.getParams()!==undefined){
      // 主页数据
      let homeData_splash = router.getParams()['homeData']
      this.homeData.pushDataAll(homeData_splash)
    }
  }


  build() {
    Column() {
      // RefreshList({isRefreshing:this.isRefresh,isLoadMore:this.isLoadMore,onRefreshListener:this.onRefresh.bind(this),onLoadMoreListener:this.onLoadMore.bind(this),listItem:this.listItem.bind(this)})
    }
  }

  onRefresh(){
    Api.getHomePages(1).then(response=>{
      if (response.item!=undefined) {
        this.page=1
        this.homeData.reloadData(response.item)
      }
    }).catch(err=>{
      Utils.Toast("NewPage:"+err)
    })
  }

  onLoadMore(){
    Api.getHomePages(this.page+1).then(response=>{
      if (response.item!=undefined) {
        this.page++
        this.homeData.pushDataAll(response.item)
      }
    }).catch(err=>{
      Utils.Toast("NewPage:"+err)
    })
  }

  @Builder
  listItem(){
     LazyForEach(this.homeData,(item:HomeBeanItem)=>{
       Column(){
         Text(item.title)
           .margin('3%')
         Divider().strokeWidth(1).color(Color.Grey)
       }
     })
  }
}

@Component
struct TestCompoment{
  aboutToAppear(){
    showDialog('TestCompoment','aboutToAppear:创建组件')
  }
  aboutToDisappear(){
    showDialog('TestCompoment','aboutToDisappear:销毁组件')
  }


  build(){
    Row()
      .width(300).height(300).backgroundColor(Color.Pink)
  }
}