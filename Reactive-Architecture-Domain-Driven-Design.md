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


