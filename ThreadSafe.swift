@propertyWrapper
struct ThreadSafe<T> {
    private var value: T
    private let queue: DispatchQueue
    
    init(wrappedValue value:T, queue:DispatchQueue = DispatchQueue(label: "BBThreadSafe", attributes: .concurrent)) {
        self.value = value
        self.queue = queue
    }
    
    var wrappedValue: T {
        get { return queue.sync { value } }
        set {
            queue.sync(flags: .barrier) {
                value = newValue
            }
        }
    }
    
    var projectedValue: T {
        get { return value }
        set { value = newValue }
    }
}
