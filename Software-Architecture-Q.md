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
