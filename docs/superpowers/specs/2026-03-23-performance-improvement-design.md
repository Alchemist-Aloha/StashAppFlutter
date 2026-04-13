# Performance Improvement Design

Goal: Optimize GraphQL fetch policies for better caching behavior.

- findX (list) methods -> FetchPolicy.cacheAndNetwork
- detail methods -> FetchPolicy.cacheFirst

Exceptions:
- Random queries -> FetchPolicy.noCache
