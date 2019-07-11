
### Q: What is Dependency Injection?
Topic: Design Patterns
Difficulty: ⭐⭐
Dependency injection makes it easy to create loosely coupled components, which typically means that components consume functionality defined by interfaces without having any first-hand knowledge of which implementation classes are being used.
Dependency injection makes it easier to change the behavior of an application by changing the components that implement the interfaces that define application features. It also results in components that are easier to isolate for unit testing.

### Q: What Is BASE Property Of A System?
Topic: Software Architecture
Difficulty: ⭐⭐⭐⭐

BASE properties are the common properties of recently evolved NoSQL databases. According to CAP theorem, a BASE system does not guarantee consistency. This is a contrived acronym that is mapped to following property of a system in terms of the CAP theorem:

Basically available indicates that the system is guaranteed to be available
Soft state indicates that the state of the system may change over time, even without input. This is mainly due to the eventually consistent model.
Eventual consistency indicates that the system will become consistent over time, given that the system doesn't receive input during that time.

### Q: What does SOLID stand for? What are its principles?
Topic: Software Architecture
Difficulty: ⭐⭐⭐

S.O.L.I.D is an acronym for the first five object-oriented design (OOD) principles by Robert C. Martin.

S - Single-responsiblity principle. A class should have one and only one reason to change, meaning that a class should have only one job.
O - Open-closed principle. Objects or entities should be open for extension, but closed for modification.
L - Liskov substitution principle. Let q(x) be a property provable about objects of x of type T. Then q(y) should be provable for objects y of type S where S is a subtype of T.
I - Interface segregation principle. A client should never be forced to implement an interface that it doesn't use or clients shouldn't be forced to depend on methods they do not use.
D - Dependency Inversion Principle. Entities must depend on abstractions not on concretions. It states that the high level module must not depend on the low level module, but they should depend on abstractions.

### Q: What does “program to interfaces, not implementations” mean?
Topic: Design Patterns
Difficulty: ⭐⭐⭐

Coding against interface means, the client code always holds an Interface object which is supplied by a factory.

Any instance returned by the factory would be of type Interface which any factory candidate class must have implemented. This way the client program is not worried about implementation and the interface signature determines what all operations can be done.

This approach can be used to change the behavior of a program at run-time. It also helps you to write far better programs from the maintenance point of view.

### Q: What are Heuristic Exceptions?
Topic: Software Architecture
Difficulty: ⭐⭐⭐⭐⭐

A Heuristic Exception refers to a transaction participant’s decision to unilaterally take some action without the consensus of the transaction manager, usually as a result of some kind of catastrophic failure between the participant and the transaction manager.

In a distributed environment communications failures can happen. If communication between the transaction manager and a recoverable resource is not possible for an extended period of time, the recoverable resource may decide to unilaterally commit or rollback changes done in the context of a transaction. Such a decision is called a heuristic decision. It is one of the worst errors that may happen in a transaction system, as it can lead to parts of the transaction being committed while other parts are rolled back, thus violating the atomicity property of transaction and possibly leading to data integrity corruption.

Because of the dangers of heuristic exceptions, a recoverable resource that makes a heuristic decision is required to maintain all information about the decision in stable storage until the transaction manager tells it to forget about the heuristic decision. The actual data about the heuristic decision that is saved in stable storage depends on the type of recoverable resource and is not standardized. The idea is that a system manager can look at the data, and possibly edit the resource to correct any data integrity problems.

### Q: What Is CAP Theorem?
- Topic: Software Architecture
- Difficulty: ⭐⭐⭐⭐⭐

- The CAP Theorem for distributed computing was published by Eric Brewer. This states that it is not possible for a distributed computer system to simultaneously provide all three of the following guarantees:

1. Consistency (all nodes see the same data even at the same time with concurrent updates )
2. Availability (a guarantee that every request receives a response about whether it was successful or failed)
3. Partition tolerance (the system continues to operate despite arbitrary message loss or failure of part of the system)
- The CAP acronym corresponds to these 3 guarantees. This theorem has created the base for modern distributed computing approaches. Worlds most high volume traffic companies (e.g. Amazon, Google, Facebook) use this as basis for deciding their application architecture. Its important to understand that only two of these three conditions can be guaranteed to be met by a system.

### Q: What are the differences between continuous integration, continuous delivery, and continuous deployment?<dev ops>
- Developers practicing continuous integration merge their changes back to the main branch as often as possible. By doing so, you avoid the integration hell that usually happens when people wait for release day to merge their changes into the release branch.
- Continuous delivery is an extension of continuous integration to make sure that you can release new changes to your customers quickly in a sustainable way. This means that on top of having automated your testing, you also have automated your release process and you can deploy your application at any point of time by clicking on a button.
-  Continuous deployment goes one step further than continuous delivery. With this practice, every change that passes all stages of your production pipeline is released to your customers. There's no human intervention, and only a failed test will prevent a new change to be deployed to production.
  
  
### Q: Do you familiar with The Twelve-Factor App principles?
Topic: Software Architecture
Difficulty: ⭐⭐⭐⭐⭐

The Twelve-Factor App methodology is a methodology for building software as a service applications. These best practices are designed to enable applications to be built with portability and resilience when deployed to the web.

1. Codebase - There should be exactly one codebase for a deployed service with the codebase being used for many deployments.
2. Dependencies - All dependencies should be declared, with no implicit reliance on system tools or libraries.
3. Config - Configuration that varies between deployments should be stored in the environment.
4. Backing services All backing services are treated as attached resources and attached and detached by the execution environment.
5. Build, release, run - The delivery pipeline should strictly consist of build, release, run.
6. Processes - Applications should be deployed as one or more stateless processes with persisted data stored on a backing service.
7. Port binding - Self-contained services should make themselves available to other services by specified ports.
8. Concurrency - Concurrency is advocated by scaling individual processes.
9. Disposability - Fast startup and shutdown are advocated for a more robust and resilient system.
10. Dev/Prod parity - All environments should be as similar as possible.
11. Logs - Applications should produce logs as event streams and leave the execution environment to aggregate.
12. Admin Processes - Any needed admin tasks should be kept in source control and packaged with the application.

### Q: What Is Shared Nothing Architecture? How Does It Scale?
Topic: Software Architecture
Difficulty: ⭐⭐⭐⭐⭐

A shared nothing architecture (SN) is a distributed computing approach in which each node is independent and self-sufficient, and there is no single point of contention required across the system.

This means no resources are shared between nodes (No shared memory, No shared file storage)
The nodes are able to work independently without depending on each other for any work.
Failure on one node affects only the users of that node, however other nodes continue to work without any disruption.
This approach is highly scalable since it avoid the existence of single bottleneck in the system. Shared nothing is recently become popular for web development due to its linear scalability. Google has been using it for long time.

In theory, A shared nothing system can scale almost infinitely simply by adding nodes in the form of inexpensive machines.

### Q: What Does Eventually Consistent Mean?
Topic: Software Architecture
Difficulty: ⭐⭐⭐⭐⭐

Unlike relational database property of Strict consistency, eventual consistency property of a system ensures that any transaction will eventually (not immediately) bring the database from one valid state to another. This means there can be intermediate states that are not consistent between multiple nodes.

Eventually consistent systems are useful at scenarios where absolute consistency is not critical. For example in case of Twitter status update, if some users of the system do not see the latest status from a particular user its may not be very devastating for system.

Eventually consistent systems can not be used for use cases where absolute/strict consistency is required. For example a banking transactions system can not be using eventual consistency since it must consistently have the state of a transaction at any point of time. Your account balance should not show different amount if accessed from different ATM machines.
