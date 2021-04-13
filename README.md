
RIBs is the cross-platform architecture framework behind many mobile apps at Uber. The name RIBs is short for Router, Interactor and Builder, which are core components of this architecture. This framework is designed for mobile apps with a large number of engineers and nested states.

The RIBs architecture provides:
* **Shared architecture across iOS and Android.** Build cross-platform apps that have similar architecture, enabling iOS and Android teams to cross-review business logic code.
* **Testability and Isolation.** Classes must be easy to unit test and reason about in isolation. Individual RIB classes have distinct responsibilities like: routing, business, view logic, creation. Plus, most RIB logic is decoupled from child RIB logic. This makes RIB classes easy to test and reason about independently.
* **Tooling for developer productivity.** RIBs come with IDE tooling around code generation, memory leak detection, static analysis and runtime integrations - all which improve developer productivity for large teams or small.
* **An architecture that scales.** This architecture has proven to scale to hundreds of engineers working on the same codebase and apps with hundreds of RIBs.
![alt text](https://sun9-6.userapi.com/impg/0Noztf207KR40D7xtEVQRufnRHvKi-J_BPHvUw/ukj_fkJlLig.jpg?size=2288x863&quality=96&sign=b916d0e7bc1e5406733fffaa81381bba&type=album)
