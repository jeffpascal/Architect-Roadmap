# Domani Driven Design

- In modern Event First Domain Driven Design, we focus on the activities, or events, that happen in the domain to help us determine our Bounded Contexts.

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

## Decomposing the Domain

- Business Domains are often large and complicated
- They contain many ideas, actions, and rules that interact in complex ways
- Trying to model a large domain can become problematic

### Some concepts may exist in multiple subdomains

- shared concepts may not be identical initially
- they may also evolve differently
- avoid the temptation of abstract
    - take the concept of "customer" and always looks at it in the same way as different context (context of order or reservation) [[[FALLLLSE]]]
- some concepts can cross multiple subdomains

## Bounded Contexts

- Each subdomain has its own ubiquitous language and model.
- The language and model for a subdomain is called Bounded Context
- Subdomains or Bounded Contexts are good starting points for building Reactive Microservices

### Each bonded context can be a microservice

- break a bounded context into multiple microservices
- do not create one microservices for all bounded contexts. That#s a monolith.

### Understanding Bounded Contexts

#### How to determine bounded contexts

    - consider human culture and interaction
    - look for changes in the ubiquitous language
        - if the use of language or the meaning of the language changes, that may suggest a new context
    - look for a varying or unnecessary information
        - employee id is very important in an employee, meaningless in a customer
    - strongly separated bounded contexts will result in smooth workflows
        - an awkward workflow may signal a misunderstanding of the domain
        - if a bounded context has too many dependencies it may be overcomplicated

#### Event first Domain Driven Design
     - traditionally, domain driven design focused on the objects within the domain
        eg: server places an order is an event
    - look to define the activities first then create boundaries
    - event storming [book to read]

- Each bounded context may have domain concepts that are unique
- concepts are not always ocmpatible fron one context to the next
- anti-corruption layers are introduced to translate these concepts
- an anti-corruption layer will prevent bounded contexts from leaking into each other
- anti-corruption layers help the bounded context to stand alone

### Context Maps
- contxt maps are a way of bisualizing bounded contexts and the relationships between them
- bounded contexts are drawn as simple shapes
- lines connect the bounded contexts to indicate relationships
- lines may be labelled to indicate the nature of the relationship
- lines indicate dependencies

TLDR:
- Bounded context is an approximation of a component
- Anti corruption layer is an abstract interface 
- By studying the domain, we can extract nouns that determine a component

## Activities in the domain

### Commands

- commands are a type of activity that occurs in the domain
    - specific recipient in mind
- represents a request to perform an action
- the action has not yet happened and it can be rejected
- usually delivered to a specific destination
- causes a change to the state of the domain
    - the domain won't be the same state after a command
- example: add an item to an order, pay a bill, prepare a meal

### Events

- events are another activity in the domain
- They Represent an action that happened in the past
- because the action already completed, they can not be rejected
- often broadcast to many destinations
- record a change to the state of the domain, ofthen the result of a command
- eg: an item was added to an order, a bill was paid, a meal was prepared
- an event records a change in the domain (to the state) often result to a command
- event is in the past tense

### Queries

- they represent a request of information about the domain
- because they are a query, a response is always expected
- usually delivered to a specific destination
- queries should not alter the state of the domain
- eg: get the details of an order, check if a bill has been paid

#### Commands, Events, Queries are the messages in a Reactive System

- They form the API for a Bounded Context or Microservice

##### Example of bounded Contexts

- Orders - Manages the contents of an order, and the lifecycle of the order.
- Reservations - Handles reservations for tables, as well as marking tables as occupied.
- Payments - Deals with collecting and recording payment details for orders.
- Menu - Contains details about menu items, including their descriptions, photos, prices etc.
- Customers - Manages customer personal data (name, phone number, address etc).

##### Example of Commands

- Open an Order (OpenOrder) (We use the name of the class)

    - Here, the Command is "Open an Order". This is using domain terminology and we could talk to our domain experts about how we "Open an Order" and they would be able to grasp what we are talking about. When we translate that into code we use a class name such as "OpenOrder" or even "OpenAnOrder". This allows us to maintain the Ubiquitous Language in the code.

## Ubiquotous Language to Code

### Value Objects (defined by its attributes)

- A Value Object is defined by its attributes
- Two value objects are equivalent if their attributes are the same
- *Value objects are immutable*
- in addition to state, value objects can contain business logic
- Messages in Reactive Systems are implemented as Value Objects

### Entities (defined by its key)

- An **Entity** is defined by a unique identiy (i.e. an id or key)
- An entity may change its attributes, but not its identity
- If the identity changes, it is a new entity, regardless of its attributes
- Entities are the single source of truth for the particular id
- Entities can also contain business logic
- Actors in Akka, Entities in Lagom

### Aggregates

- An Aggregate Root is an Entity in a Bounded Context that aggregates other objects and is not aggregated by anything. I.E. it is at the root of the aggregation tree. Aggregate Roots are always Entities, never Value Objects.

- An *Aggregate* is a collection of domain objects bount to a root Entity
- The root *Entity* is called **Aggregate Root**
- Objects in an *Aggregate* can be treated as a single unit
- Access to objects in the Aggregate must go thourgh the Aggregate Riit
- Transactions should not span multiple Aggreate Roots
- Aggregates are good candidates for distribution in a Reactive System

#### Determining the Aggregate Roots

- Choosing an aggregate root is not always straightforward
- The aggregate root can be different from one context to the next
- Some contexts may require multiple aggregate roots
- *Usually one Aggregate Root per context*
    - Questions to consider:
        - Is the entity involved in most operations in that bounded context?
        - If you delete the entity, does it require you to delete other entities? **if i delete a reservation, a customer is still a customer. What if i delete all reservations? The customer will not matter anymore because he has no reservations**
        - Will a single transaction span multiple events? **A transaction should not span multiple aggregate roots**

### Domain Abstractions

#### Services

- Business logic doesn't always fit with an entity or value object
- The Logic can be encapsulated by a Service
- Services should be stateless
- Often used to abstract away an anti-corruption layer
- Note: Too many services leads to an anaemic domain. Look for a missing domain object before resorting to a service
