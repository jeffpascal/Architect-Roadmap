# Sysops path

## Useful links

### Eres & Dashboard & Rambo documentation

https://evercloud-docs.dev.everseen.com/ contains all relevant documentation for the Dashboard. Servers as a central repository of information about Eres & Dashboard and includes migration guides.

#### Start here

Begin learning about the architecture of Everseen, can be found here https://evercloud-docs.dev.everseen.com/docs/architecture/

Continue with the DB structure for the Dashboard stack. This will allow you to understand how data is stored, and what kind of things we look at. https://evercloud-docs.dev.everseen.com/docs/redash/data-structures

Continue with the DB structure for Rambo. https://evercloud-docs.dev.everseen.com/docs/rambo/Data%20Structures

Those are the main tools that will be used to manage Everseen fully.

### Composer documentation

Composer implements an API that allows users to selectively start or stop the existing services available the box, or to send various commands to included services. 

The composer is a service that starts the Everseen stack on servers. Documentation can be found here: https://composer-docs.dev.everseen.com/docs/versions

## Learning resources

### ELK stack

The ELK stack is the database for the Everseen software. Elastic Search is an important tool to know and query for a deeper understanding of the data schema and allows easier troubleshooting of issues

#### Learning resources and certifications

##### Start here

- Basics of Elastic Search https://www.elastic.co/webinars/getting-started-elasticsearch
- A full list of usual queries for elastic search used by Everseen can be found here:

### Docker

Docker is the containerization software we use right now. With newer releases of Kubernetes we will move away from Docker and toward standard container software

#### Learning resources and certifications

##### Start here

- Cheat sheet for docker commands: https://dockerlabs.collabnix.com/docker/cheatsheet/

##### Certifications

- https://cloudacademy.com/learning-paths/docker-certified-associate-dca-exam-preparation-1-1393/

### Ansible

Ansible is the simplest way to automate apps and IT infrastructure. We use it to automate deployments of the Everseen stack and doing mass changes to hundreds and even thousands of servers at once.

#### Learning resources and certifications

##### Start here

- Quick intro to ansbile https://www.youtube.com/watch?v=tWR1KXgEYxE

##### Certifications

- https://www.redhat.com/en/services/certification/rhcs-ansible-automation

### Kubernetes

#### Learning resources and certifications

##### Start here

- Interfacing with Kubernetes is done through kubectl. Here's a cheat sheet with commands: https://kubernetes.io/docs/reference/kubectl/cheatsheet/

##### Certifications

- https://kubernetes.io/training/

## Everseen specific learning resources

## Everseen people

### Developement

Head of developement is Razvan Pocaznoi

#### Rambo

Rambo is a configuration tool for the stack. Instead of managing configuration on a server by server basis, Rambo allows for a centralised hub of configuration for an entire client. Easy features include cloning from one store to another and setting defaults for newly installed stores

#### Eres

Eres is a analysis tool used to approve or decline alerts sent by the system. It serves as a middleware to the store to the Dashabord

Andra Radu

#### Dashboard

Robert Belu

#### Lego

### Research

#### G4 Integrated NN

G4 Integrated is a compilation of every solution Everseen offers and is fully documented here: https://devel-evs.atlassian.net/wiki/spaces/OD/pages/3362128114/Generic+-+Integrated+Checkout+SCO+4.9.1+Q1+2022+release

#### Product switching

- Stefan Mosilovic

### Devops

- Cornel Cirti
- Alexandru Zeveleanu

## 