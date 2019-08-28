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
    - take concept of customer and always looks the same [[[FALLLLSE]]]
- some concepts can cross multiple subdomains

        - if a bounded context has too many dependencies it may be overcomplicated

#### Event first Domain Driven Design
     - traditionally, domain driven design focused on the objects within the domain
        eg: server places an order is an event
    - look to define the activities first then create boundaries
    - event storming [book to read]


