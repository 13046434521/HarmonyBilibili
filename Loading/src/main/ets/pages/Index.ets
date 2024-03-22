import promptAction from '@ohos.promptAction'

@Observed
class Person{
  age:number
  name:string
  child:Person

  constructor(age:number,name:string,child?:Person) {
    this.age = age
    this.name = name
    this.child = child
  }
}
// 嵌套类中的数据不会变化
@Entry
@Component
struct Index {
  child: Person = new Person(1,'小孩子')
  @State jtl: Person = new Person(31,'贾天龙',this.child)
  build() {
    Row() {
      Column() {
        Text(this.jtl.child.name+"  "+this.jtl.child.age)

        Child({person:this.jtl.child})

        Button("输出").onClick(()=>{
          this.jtl.child.name = this.jtl.child.name + 'bb'
          promptAction.showToast({message:"数据变没变啊："+this.jtl.child.name +"  "+this.jtl.child.age})
        })
      }
    }
  }
}

@Component
struct Child{
  @ObjectLink person:Person

  aboutToAppear(){
    // if (this.person.child instanceof undefined) {
    //   promptAction.showToast({message:"数据类型：undefined"})
    // }
    //
    // if (this.person.child instanceof null) {
    //   promptAction.showToast({message:"数据类型：null"})
    // }
    //
    // if (this.person.child instanceof Person) {
    //   promptAction.showToast({message:"数据类型：Person"})
    // }
    //
    // if (typeof this.person.child =="undefined") {
    //   promptAction.showToast({message:"数据类型 typeof：undefined"})
    // }
  }

  build(){
    Column(){
      Button(this.person.name+"  "+this.person.age)
        .onClick(()=>{
          this.person.age++
        })

      Button(this.person.name+"  "+this.person.age)
        .onClick(()=>{
          this.person.name = this.person.name + 'a'
        })
    }
  }
}