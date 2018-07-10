# WebBenchmark
The goal of this project is to build a harness/framework for performance testing http based applications built on InterSystems IRIS 
Overall Goals: 
  * Design a simple harness with modular pieces to allow for testing of a generic application
  * Deploy this using Docker Containers
  * Will contain 3 main pieces
    * Webserver - Apache IRIS web gateway
    * Driver using Apache benchmark which returns statistics in a JSON format
    * IRIS Application Image
  * All modular pieces can be extended or replaced for your specific application or test

Currently under development and subject to change. Current work is being done to write examples using docker-compose, Docker Swarm, and Kubernetes.

TODO:
* Write directions
* Write configuration scripts?
* docker-compose example
* docker swarm example
* kubernetes example
* support nginx web server
