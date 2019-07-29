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

