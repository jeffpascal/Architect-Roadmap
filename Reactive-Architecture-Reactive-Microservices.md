# Microservices

- Monoliths and microservices are seen in a spectrum
    - When building an application, a big part of the job is to figure out which one works best for our needs.
    - We trade some drawbacks for some benefits.

## Monoliths

- no clear isolation in the application
- hard to understand and modify
- over time, they start to stagnate
- deployed as a single unit
- single shared database
- communicate with synchronous method calls
- deep coupling between libraries and components
- long cycle times
- teams carefully synchronize features and releases

### Scaling a monolith

- multiple copies of the monolith are deployed
- each copy is independent
- the database provides consistency between the instances

#### Advantages of a monolith

- easy cross module refactoring
- easier to maintain consistency
- single deployment process
- single thing to monitor
- simple scalability model

### How to clean up

- introduce isolation
- divide the application along clear domain boundaries
- we introduce libraries that help isolate related pieces of code
- libraries provide a clean and consistent interface


