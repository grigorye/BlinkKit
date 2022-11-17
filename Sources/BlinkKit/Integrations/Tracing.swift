#if canImport(GETracing)
    import GETracing
    func x$<T>(_ value: T) -> T { GETracing.x$(value) }
#else
    func x$<T>(_ value: T) -> T { value }
#endif
