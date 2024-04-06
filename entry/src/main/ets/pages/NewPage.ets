import Constants from '../common/Constants';
import { Utils } from '../Utils/Utils'

// objectLinkNestedObjects.ets
let NextID: number = 1;

@Observed
class ClassA {
  public id: number;
  public c: number;

  constructor(c: number) {
    this.id = NextID++;
    this.c = c;
  }
}


class ClassB {
  public a: ClassA;

  constructor(a: ClassA) {
    this.a = a;
  }
}
@Component
struct ViewA {
  label: string = 'ViewA1';
  // @ObjectLink a: ClassA;
  @Prop a: ClassA;
  build() {
    Row() {
      Button(`ViewA [${this.label}] this.a.c=${this.a.c} +1`)
        .onClick(() => {
          this.a.c += 1;
        })
    }
    // .backgroundColor(Constants.BACKGROUND_COLOR)
  }
}
@Preview
@Component
export struct NewPage {
  @State b: ClassB = new ClassB(new ClassA(0));
  aboutToAppear(){
    Utils.Toast(Math.sqrt(4)+'  '+Math.sqrt(9))
  }
  build() {
    Column() {

      ViewA({ label: 'ViewA #1', a: this.b.a })
      ViewA({ label: 'ViewA #2', a: this.b.a })

      Button(`ViewB: this.b.a.c+= 1`)
        .onClick(() => {
          this.b.a.c += 1;
        })
      Button(`ViewB: this.b.a = new ClassA(0)`)
        .onClick(() => {
          this.b.a = new ClassA(0);
        })
      Button(`ViewB: this.b = new ClassB(ClassA(0))`)
        .onClick(() => {
          this.b = new ClassB(new ClassA(0));
        })
    }
  }
}