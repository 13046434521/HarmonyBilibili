
class Person{
  age:number
  name:string

  constructor(age:number,name:string) {
    this.age = age
    this.name = name
  }
}
// 类中本来的数据会变化
@Entry
@Component
struct Index {
  @State jtl: Person = new Person(31,'贾天龙')
  build() {
    Row() {
      Column() {
        Text(this.jtl.name+"  "+this.jtl.age)

        Child({person:this.jtl})
      }
    }
  }
}

@Component
struct Child{
  @Link person:Person
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