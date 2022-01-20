@propertyWrapper
struct ThreadSafe {
  private var value: T
  private let queue: DispatchQueue
  
  init(wrappedValue value:T, queue:DispatchQueue) {
    self.value = value
    self.queue = queue
  }
  
  var wrappedValue: T {
    get { return queue.sync { value } }
    set {
      queue.sync {
        value = newValue
      }
    }
  }
  
  var projectedValue: T {
    get { return value }
    set { value = newValue }
  }
}
