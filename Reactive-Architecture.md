# Goals of reactive architecture (reactive software)

- scales from 10 to 10 mil users
- reduce amount of resources when we don't need them
- minimum impact on user (ideally no effect)
- scale across nay number of machines
- maintain a consistent level of quality and responsiveness despite all of these things

## React Principles

- [Reactive Manifesto](http://www.reactivemanifesto.org)
- 4 basic principles
    - Responsive: A reactive system consistently responds in a timely fashion
    - Resilient: A reactive system remains responsive, even when failure occurs
    - Elastic: A Reactive System remains responsive, despite changes to system load.
    - Message Driven: A reactive system is built on a foundation of async, non-blocking messages

### Responsiveness

- if you can make a website responsive, you don't need anything else
- Responsiveness is the cornerstone of usability
- responds fast and in a consistent fashion
- Responsive systems build user confidence
- Recovery is delegated to an external component

- replication - multiple copies
- isolation - services can function on their own, they have no external dependencies
- containment - is a consequence of isolation: if there is a failure it does not propagate to another component
- delegation - recovery is managed by an external component

Recovery - is delegated to an external componenet, because you cannot handle your own failure.  

### Elasticity

- Elasticity provides responsiveness, despite increases (or decreases) in load
- Implies zero contention and no central bottlenecks
- Predictive auto scalind techniques can be used to support elasticity
- Scaling up provides responsiveness during peak, while scalind down improves cost effectiveness

If we have elasticity we can implement techniques to increase load or decrease it as needed

Scaling down needs to be an option as well to improve cost effectiveness

### Message Driven

- Responsiveness, Resilience, Elasticity are supported by a Message Driven Architecture
- Messages are asyncronous and non-blocking
- Provides Loose coupling, isolation, location transparency
    - provides isolation and location transparent
- Resources are consumed only while active
    - not stuck waiting for a response form someone else
        - while waiting you are consuming phisical resources
    - you might be interested in the response but it comes asyncronously
    

### Netflix- example of responsive software
- netflix is a good example of a reactive software
- maintain resilience by reducing features (menu option missing)

## Reactive Programming

- Reactive programming can be used to create reactive systems
- using reactive programming does not implies that your system is reactive
- Supports breaking problems into small, discrete steps
- steps are executed in an async/non-blocking fashion, usually via callback mechanism
- future/promises, streams, rxJava/rxScala



### Reactive Systems
- reactive systems are separated along asyncronous boundaries
    - eg. reactive microservices


## The actor model
- the Actor Model is a programming paradigm that supports constuction of Reactive Systems
- it is Message Driven
- Abstractions provide Elasticity and Resilience
- it can be used to build Responsive software
- on the jvm:
    - Akka implements the Actor Model
    - Akka is the foundation of Reactive tools like Lagom and Akka Streams

### Fundamental concepts of the Actor Model

- All cmputation occurs inside the Actors
- Each actor has an address
- Actors communicate only through asyncronous messages

### Location Transparency

- The message Driven nature of Actors supports Location Transparency
- Actors communicate using the same technique, regardless of location
- Local vs Remove is mostly configuration
- Location Transparency enables actors to be both Resilient and Elastic

![image](https://imgur.com/a/E8sSfxN)
