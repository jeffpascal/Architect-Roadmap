# Part 3 Microservices

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
- simple scalability model (deploy more copies of it)

#### Disadvantages of the Monolith

- limited by the maximum size of a single physical machine
- only scales as far as the database will allow
- components must be scaled as a group
- deep coupling leads to inflexibility
- developement is typically slow
- serious failures in one component often brings down the whole monolith
    - redistribution of load can cause cascading failure

### How to clean up

- introduce isolation
- divide the application along clear domain boundaries
- we introduce libraries that help isolate related pieces of code
- libraries provide a clean and consistent interface

### Service oriented Architecture

- services don't share databases
- all access must go through the API exposed by the service
- Services may live in the same process (monolith), or may be separated (microservices)

# Microservices

- Microservices are a subset of SOA
- Logical components are separated into isolated microservices
- Microservices can be phisically separated and independently deployed
- Each component/microservice has its own independent data store
- Microservices are independent and self governing


## Microservice characteristics

- each service is deployed independently
- multiple independent databases
- communication is synchronous or asyncrhonous (Reactive Microservices)
- loose coupling between components
- Rapid deployments (possibily continous)
- Teams release features when they are ready
- Teams often organized around a DevOps approach

## Scaling a Microservice application

- each microservice is scaled independently
- Could be one or more copies of the service pet machine
- each machine hosts a subset of the entire system
 ![Imgur](https://imgur.com/v3iEnTx)
 