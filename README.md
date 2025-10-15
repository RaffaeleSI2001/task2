# task2

A small prototype webapp for renting cars.

## Components

- Java 11
- Tomcat 9
- Servlet API 4.0.4
- Spring MVC 5.2.22.RELEASE
- Thymeleaf 3.0.15.RELEASE
- HikariCP 5.0.1
- Spring Transactions 5.2.22.RELEASE
- Hibernate 5.6.15.Final
- JPA 2.2
- Spring ORM 5.2.22.RELEASE
- MySQL 8.0.33

## Build

Start the webapp and the DB with `./run.sh`.

Stop all containers with `./stop/sh`.

## Docs

### SCM Workflow

Gitflow: 

- main branch: `main`
- development branch: `dev`
- feature branch (prefix): `feature_`
- release branch (prefix): `release_`
- hotfix branch (prefix): `hotfix_`

Every last commit merged to `main` at a certain time must be tagged.

Remember to push each `release` and `hotfix` to both `main` and `dev`.
