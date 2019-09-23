## Key tenets of a microservices architecture

### Large monoliths are broken down into many small services
- Each service runs its own process
- There is one service per container
### Services are optimized for a single function
- There is only one business function per service
- The Single-responsibility Principle: A microservice should have one, and only one, reason to change
### Communication via REST API and message brokers
- Avoid tight coupling introduced by communication through a database
### Per-service continuous integration (CI) and continuous deployment (CD)
- Services evolve at different rates
- Let the system evolve, but set architectural principles to guide that evolution
### Per-service high availability (HA) and clustering decisions
- One size or scaling policy is not appropriate for all
- Not all services need to scale; others require autoscaling up to large numbers
