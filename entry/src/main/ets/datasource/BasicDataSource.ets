
export class BasicDataSource<T> implements IDataSource  {
  private listeners: DataChangeListener[] = []
  private dataArray: T[] = []

  public totalCount(): number {
    return this.dataArray.length
  }

  public getData(index: number): T {
    return this.dataArray[index]
  }

  public addData(index: number, data: T): void {
    this.dataArray.splice(index, 0, data)
    this.notifyDataAdd(index)
  }

  public pushData(data: T): void {
    this.dataArray.push(data)
    this.notifyDataAdd(this.dataArray.length - 1)
  }

  /**
   * 数据拼接到原数据后面
   * @param data
   */
  public pushDataAll(data: T[]): void {
    if (data!=null) {
      this.dataArray = this.dataArray.concat(data)
      this.notifyDataReload()
    }
  }
  /**
   * 数据拼接到原数据前面
   * @param data
   */
  public addDataAll(data: T[]): void {
    if (data!=null) {
      this.dataArray = data.concat(this.dataArray)
      // for (const temp of data) {
      //   this.dataArray.unshift(temp)
      // }
      this.notifyDataReload()
    }
  }
  /**
   * 清除原有数据，增加新的数据
   * @param data
   */
  public reloadData(data: T[]): void {
    this.dataArray =[]
    this.addDataAll(data)
  }
  public cleanData(): void {
    this.dataArray =[]
    this.notifyDataReload()
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded()
    })
  }

  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index)
    })
  }

  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index)
    })
  }

  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index)
    })
  }

  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to)
    })
  }
}