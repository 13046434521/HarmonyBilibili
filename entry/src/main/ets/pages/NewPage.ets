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

@Observed
class ClassB {
  public a: ClassA;

  constructor(a: ClassA) {
    this.a = a;
  }
}
@Component
struct ViewA {
  label: string = 'ViewA1';
  @ObjectLink a: ClassA;

  build() {
    Row() {
      Button(`ViewA [${this.label}] this.a.c=${this.a.c} +1`)
        .onClick(() => {
          this.a.c += 1;
        })
    }
  }
}
@Preview
@Component
export struct NewPage {

  @State b: ClassB = new ClassB(new ClassA(0));

  build() {
    Column() {
      // in low version,DevEco may throw a warning,but it does not matter.
      // you can still compile and run.
      // ViewA({ label: 'ViewA #1', a: this.b.a })
      //       // ViewA({ label: 'ViewA #2', a: this.b.a })
      Image($r('app.media.ic_svg_all_screen'))
        .objectFit(ImageFit.Contain)
        .width('100%')
        .height('100%')
        .fillColor($r('app.color.bilibili_text_black'))
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