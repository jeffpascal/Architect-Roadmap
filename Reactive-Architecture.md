# Goals of reactive architecture (reactive software)

- scales from 10 to 10 mil users
- reduce amount of resources when we don't need them
- minimum impact on user (ideally no effect)
- scale across any number of machines
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
- Predictive auto scaling techniques can be used to support elasticity
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
- **AKKA**
- the Actor Model is a programming paradigm that supports constuction of Reactive Systems
- it is Message Driven
- Abstractions provide Elasticity and Resilience
- it can be used to build Responsive software
- on the jvm:
    - Akka implements the Actor Model
    - Akka is the foundation of Reactive tools like Lagom and Akka Streams

- the actor model can be reactive at the level of actors and actors are within a microservice. You can have many actors within a single microservice. Whereas using these tools you have built something that is reactive at the level of microservices as opposed to internally. It's still possible to build something that is going to be reactive at the level of components inside that service but it gets a lot harder. Whereas with the Actor Model it's very easy

### Fundamental concepts of the Actor Model

- All cmputation occurs inside the Actors
- Each actor has an address
- Actors communicate only through asyncronous messages

### Location Transparency

- The message Driven nature of Actors supports Location Transparency
- Actors communicate using the same technique, regardless of location
- Local vs Remove is mostly configuration
- Location Transparency enables actors to be both Resilient and Elastic
- local calls look like remote calls
- assume you are always making local calls

![Imgur](https://i.imgur.com/2vx8Sku.png)

### Transparent remoting

- Remote calls looke like local calls
- Hide the fact that you are making remote calls
- hides potential failure scenarios

### Importance of the Actor Model

- There are many Reactive Programming tools
- Most support only some of the Reactive Principles
- You often have to combine different technologies to build a Reactive System
- The actor model provides facilities to support all of the Reactive Principles
    - Message Driven by default
    - Location Transparency to support Elasticity and Resilience through distribution
    - Elasticity and Resilience to provide Responsiveness

## Reactive system without Actors

- Components are added on rather than being built in
- Requires additional infrastructure such as
    - service registry
    - load balancer
    - message bus
- Result will be Reactive at the large scale, not necessarily small

![Imgur](https://imgur.com/Tf9TL34)

# Domani Driven Design

## Domanins

- A domain is a sphere of knowledge
- in the context of software, it refers to the business or idea that we are modeling
- experts in the domain are people who understand the business, not necessarely the software
- key goals of ddd is to build a model that the domain experts understand
    - Note: The model is not software
        - the model represents our understanding of the domain
        - the software is an implementation of the model

## Ubiquitous Language

- communication between developers and domain experts requires a common language
- terminology comes from the domain experts
- words originate in the domain and are used in the software
- avoid taking software terms and introducing them into the domain
- *domain experts and software developers should be able to have a conversation without resorting to software terms*

