# Reactive Microservices

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

## Microservices

- Microservices are a subset of SOA
- Logical components are separated into isolated microservices
- Microservices can be phisically separated and independently deployed
- Each component/microservice has its own independent data store
- Microservices are independent and self governing


### Microservice characteristics

- each service is deployed independently
- multiple independent databases
- communication is synchronous or asyncrhonous (Reactive Microservices)
- loose coupling between components
- Rapid deployments (possibily continous)
- Teams release features when they are ready
- Teams often organized around a DevOps approach

### Scaling a Microservice application

- each microservice is scaled independently
- Could be one or more copies of the service pet machine
- each machine hosts a subset of the entire system

 ![Imgur](https://imgur.com/v3iEnTx.png)

#### Advantages to the Microservice System

- individual services can be deployed/scaled as needed
- increased availability. Serious failures are isolated to a single service
- Isolation/decoupling provides more flexibility to evolve within a module
- Supports multiple platforms and languages
- ex: if we lose the reservation service, even if cascading, we still have the other services up and running

#### Microservice Team Organization

- Microservices often come with organizational change
- Teams operate more independently
- Release cycles are shorter
- Cross team coordination becomes less necessary
- These changes can facilitate an increase in productivity

#### Disadvantages to the Microservice System

- May require multiple complex deployement and monitoring approaches
- Cross service refactoring is more challenging
- Requires supporting older API versions
- Organizational change to microservices may be challenging

### Responsabilities of Microservices

#### Single Responsibility Principle (A class should have only one reason to change)

- the Single Responsibility Principle applies to object oriented classes, but works for Microservices as well
- A microservice should have single responsibility (ex: managing accounts)
- A change to the internals of one microservice should not necessitate a change to another microservice

#### Bounded Contexts

- Bounded Contexts are a good place to start building microservices
- They define a context in which a specific model applies
- Further subdivision of the Bounded Context is possible

## Principles of Isolation

- how can i isolate my microservice?
- as we move from Monoliths to Microservices we are introducing more isolation
- isolation provides reduced coupling and increased scalability
- Reactive microservices are isolated in:
    - state
    - space
    - time
    - failure

## Isolation of State

- All access to a Microservice's state must go through its API
- No backdoor access via the database
- Allows the microservice to evolve internally without affecting the outside.

![Imgur](https://imgur.com/UNrFkPo.png)

## Isolation in Space

- Microservices should not care where other microservices are deployed
- It should be possible to move a microservice to another machine, possibly in a different data center without issues
- Allows the microservice to be scaled up/down to meed demand

![Imgur](https://imgur.com/2NFwSfD.png)