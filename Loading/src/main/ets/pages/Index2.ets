import promptAction from '@ohos.promptAction'

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

        Child({person:this.jtl})

        Button("输出").onClick(()=>{
          promptAction.showToast({message:"数据变没变啊："+this.jtl.child.name +"  "+this.jtl.child.age})
        })
      }
    }
  }
}

@Component
struct Child{
  @Link person:Person
  build(){
    Column(){
      Button(this.person.child.name+"  "+this.person.child.age)
        .onClick(()=>{
          this.person.child.age++
        })

      Button(this.person.child.name+"  "+this.person.child.age)
        .onClick(()=>{
          this.person.child.name = this.person.child.name + 'a'
        })
    }
  }
}