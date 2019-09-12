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

### Isolation of State

![Imgur](https://i.imgur.com/LMahVPl.png)

- All access to a Microservice's state must go through its API
- No backdoor access via the database
- Allows the microservice to evolve internally without affecting the outside.



### Isolation in Space

![Imgur](https://imgur.com/wAjGAQo.png)

- Microservices should not care where other microservices are deployed
- It should be possible to move a microservice to another machine, possibly in a different data center without issues
- Allows the microservice to be scaled up/down to meed demand

### Isolation in Time

![Imgur](https://imgur.com/iCX8TFg.png)

- Microservices should not wait for each other. Requests are asynchronous and non-blocking.
    - More efficient use of resources. Resources can be freed immediatly, rather than waiting for a request to finish
- Between microservices we expect eventual consistency
    - Provides increased scalability. Total consistency requires central coordination which limits scalability.

### Isolation of Failure

- Reactive Microservices also isolate failure
- A failure in one microservice should not cause another to fail
- allows the system to remain operational in spite of failure

## Isolation techniques

### Bulkheading (we try to create failure zones, so they don't propagate to other services)

![Imgur](https://imgur.com/zR8ZKtS.png)

- Overall system can remain active if a failure occurs
- Bulkheading is a tool to isolate failures
- Failures are isolated to failure zones
- Failures in one service will not propagate to other services
- Overall system can remain operational (possibly in a degraded state)
- ex: netflix does good isolation

#### Example:

![Imgur](https://imgur.com/f1jph0S.png)

- orders may require loyalty information
- if loyalty is down, we don't want to fail
- Instead, Orders operated without Loyalty
- It may be in a degraded state and show Loyalty information as *unavailable*
- Payments may not depend on Loyalty. It operates normally

- orders depend on loyalty
- if loyalty is down we don't want to fail
- allow ways to operate without loyalty
- we don't want Payments to fail because Loyalty is down
- if this was made with Reactive in mind, we wouldn't have relations between payments and orders and orders and loyalty
- **A properly bulkheaded system will prevent scenarios where a failure of one microservice cascades into other services.**

### Circuit breakers

#### Effects of Overloaded Services

- What happens when a service depends on another that is overloaded?
- Calls to the overloaded service may fail.
- The caller may not realize the service is under stress and may retry *(retry makes the load worse)* **We don't want retrys to put additional load on a Overloaded service**
- The retry makes the load worse
- Callers need to be careful to avoid this

#### Circuit Breakers

![Imgur](https://i.imgur.com/w887lBZ.png)

- a way to avoid overloading a service
- they quarantine a failing service so it can **fail fast**
- Allows the failing service time to recover without overloading it
- Akka and Lagom both feature circuit breakers
- if circuit breaker is open we don't even allow the request to go through. Get exception fast (lose retry capability)
- all calls go through the circuit breaker

- *What happens when it recovers?*

- Over time when you build these circuit breakers these circuit breakers usually have a timeout of some kind. Essentially what happens is after that period of time the circuit breaker attempts to reset itself.
- goes into the half open state (lets only one through) if that one goes through, the circuit breaker will close

- ex: When a circuit breaker is in the Open state, it's behaviour is:
    - All calls are immediately failed without contacting the external service.
- A circuit breaker in a Half Open state will:
    - Allow a single request through

- **A circuit breaker between the service and the database would allow us to prevent the database from becoming overloaded. It also allows us to fail fast when the database is slow to respond.**

### Message Driven Architecture

- Reactive systems are Message Driven (asynchronous non-blocking messages)
- Async, non-blocking messaging allows us to decouple both Time and Failures
- Services are not dependent on the response from each other
- If a requiest to a service fails, the failure won't propagate
- The client service isn't waiting for a response. It can continue to operate normally
ex: If you do something in a synchronous way, you need to wait for the task to finish to start another one

### Autonomy

- each of our services can operate independently

#### Autonomous Services

- Microservices can only guarantee their own behaviour (via their api)
- Isolation allows a service to operate independent of other services
- Each service can be Autonomous
- Autonomous services have enough information to resolve conflicts and repair failures
- They don't require other services to be operational all the time

- **its very useeful to think about people because people represent a natural distributed system**
- (if my work relies on 50 people to get it done, it will be very messy)
- making them autonomous solves that problem

##### Benefits of Autonomous Services

- Autonomy allows for stronger scalability and availablily
- Fully autonomous services can be scaled indefinetly (no external dependencies) **pretty rare**
- Operating independently meants they can tolerate any amount of failure
- Few services will be fully autonomous, but the closer we get, the better

- **we want to get to as close to fully autonomous as possible**

##### Achieve Autonomy

- Communicate only through asynchronous messages
- Maintain enough internal state for the microservice to function in isolation (making copies of data)
- Use **Eventual Consistency**
- Avoid direct, synchronous dependencies or external services
- **its all about finding ways to isolate your microservices**

### Gateway Services

#### Managing API Complexity

- Microservices can lead to complexities in the API
- A single request may require information from multiple microservices
- Clients could send out many requests, and aggregate the results, but this may be too complex
- How can we manage complex APIs that access many microservices?

![Imgur](https://imgur.com/WfQhhF0.png)

- clients are harder to update (updating apps is hard in case of ios/android devices)

#### API Gateway Services

![Imgur](https://imgur.com/vvuidgW.png)

- Requests can be sent through a Gateway Service
- A Gateway Service sends the requests to individual microservices and aggregates the responses
- Logic for aggregation is moved out of the client and into the Gateway Servoce
- Gateway handles failures from each service. Client only needs to deal with possible failure from the gateway
- We can have domain specific gateways for example Reservation domain has its own Gateway
- **We are creating an additional layer of isolation between the client and the services**


##### test:

###### 1

Two Generals Video is an online video streaming service. They have built their system with a series of microservices. One microservice is responsible for streaming the video to users, while a separate microservice tracks information about the users watch history.

When a user finishes watching a video, the watch history is updated. This operation spans two different microservices. The team wants to ensure that users watch history is accurate. They want to avoid situations where a user finishes watching the video, but the watch history doesn't show that. To that end they are doing a synchronous request when the user finishes watching the video in order to update the watch history.

Now they are looking at implementing additional information in that watch history. They want to include how far into a video a user has watched so that they can resume where they left off. This requires another synchronous call. However, this call seems to be impacting the video stream. Since they tried to introduce it the videos are now stuttering because the calls to update the watch history are taking too long.

This system is violating which of the principles of isolation? Isolation of **time:**

###### 2

Spectrum Messages has a mobile application that provides instant messaging and chat features.

There system has a "presence" microservice that has the responsibility of tracking when a user is online or offline. This information is then exposed to the user's contacts.

They have built a Gateway which collects information from a variety of microservices, and builds a view of the data that is then exposed through the mobile application.

Recently, the Gateway experienced a problem which caused it to fail. They have a robust monitoring system in place which automatically restarted the Gateway. However, when it restarted, it had to pull data for all of their users in a very short period of time. This sudden influx of requests to the Presence service caused it to slow down, and eventually fail.

To mitigate this, they have implemented a technique in the Gateway Service so that when it sees a timeout in the presence service, it will stop trying to contact it for a period of time, instead simply failing any requests. The idea is to allow the Presence service time to recover.

This technique is known as **circuit breakers**

###### 3

Available Advertising has built a microservices platform to transform data from it's advertising network and syndicate it to various partners.

They have built several different microservices, each of which has a different job. Some of their services import from the various data sources, while others syndicate that data. Then there are services responsible for specific transformations.

To simplify deployment, all of their services have been packaged into a single bundle so they can be deployed as one unit, rather than individually. This allows them to have a single deployment process and eliminates issues with API compatibility between services.

They have discovered that the scalability requirements of their services are very different and the bundled package is now hindering them because they can't scale individual pieces of their system, only the system as a whole.

This system is violating which of the principles of isolation? Isolation of **space**

###### 4

Saga Electronics is an online electronics retailer.

They have built their system using a series of microservices. These microservices have in turn been grouped according to different domains within their business. The sales microservices handle the process of ushering a customer through the sales process. The inventory services manage the tracking of inventory.

Although there are touch points between sales and inventory, they have tried to keep them as separate as possible. The goal is that a failure in one part of the system should be isolated so that it doesn't propagate to another part of the system. If the inventory management system is down, they want their customers to still be able to buy products, and vice versa.

By isolating these two systems, they are using the technique called:

**autonomy - correct**

- Correct:They are attempting to build an autonomous system here so this is correct. However they are doing it using the specific technique of Bulkheading.

###### 5

Consistent Fitness has built a set of microservices in order to support their wearable fitness tracker.

They have deployed an "Import" microservice that accepts data from the users tracker and stores it in a SQL database.

They also have a "Aggregation" microservice that reads the imported data directly from the SQL database, and aggregates it by day/week/month etc. This data is then written back to the SQL database to be consumed by other microservices.

They are looking to introduce a new model of fitness tracker that will record more data than the old one. This will require them to update the tables that the data is being written to to store this new information. However they are realizing that update is not trivial because they also have to update not just the Aggregation service but other services that were using that data as well.

This system is violating which of the principles of isolation? Isolation of **state**
