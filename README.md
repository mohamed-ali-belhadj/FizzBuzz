# ⚙️ Fizz Buzz

**Fizz Buzz is an iOS application that demonstrates the "Fizz-Buzz" task with various improvments and bonus modifications to its core implementation** 
- [Requirements](#requirements)
- [Features](#features)
- [Project Architecture](#project-architecture)
- [Behind the scenes](#behind-the-scenes)
- [Scalability](#scalability)
- [Licence](#licence)

## Requirements

Fizz Buzz Application is build using **Swift v5.7** 

* Xcode v13.2 
* Swift v5.5.2
* Xcode 13.2 requires a Mac running macOS Big Sur 11.6.5 or later.

## Features

Fizz Buzz Application Core is build to the application, plus some variations to its principle logic, such as:

* SwiftUI Form to handle user inputs.
* Combine Form validation.
* invoking the task using n number of **parameters**.
* invoking the task using n number of **predicats**.
* supporting the brand-new **async await** operators.
* Well Documented. 
* UnitTests to core methods.
* Absolutly Zero depending on 3rd party packages.


## Project Architecture
The project respects the **MVVM** architure with one minor modification. I included the  **Interactor** part to hide the implementation behind my algorith to fix the Fizz-Buzz task. 
The Interactor part can be, in later times, seperated from the whole project into a Swift Package in order to be reused or sold by **injecting** it properly into other applications.

Back to the MVVM part, my Views are simple SwiftUI views controlled by a single ViewModel to simplify the task. 
The ViewModel is responsible of the communication between the View from one hand, and the Interactor from the other. Plus, one of its tasks, is to validate the View's Form using needed Publishers (inputs).

The Interactor's main objectif is to manipulate user inputs to return the needed output for the Fizz-Buzz task. 

## Behind the scenes
The Interactor contains a method called **invoke** which uses its own parameters passed during construction by the ViewModel. 
This method's complexity is **O(n)** with n equals the **limit** passed by user as input.
Testing if the index of current iteration is equals the multiplication of two integers passed as input first, then testing the two inputs separately makes the algorithm works perfectly. 
Knowing that the two tests are declared separately as boolean results, makes our code respect the **KISS & DRY** principles. And looping using **forEach** instead of **for** loop makes the code even better with **Functional Programming** spirit. 
**Do we stop here ?**
Of course not, what about **Scalability** ?

## Scalability
**Please Check file Interactor+Bonus.swift**
What if we want to pass, not only a "Fizz" and "Buzz" for two given integers ? 
Let's say we want to print "Fizz" if the value is multiple of 3, "Buzz" if it's multiple of "5" and "Zaaz" if it's a multiple of "7". Also, we want to pass a **Range** of Integers such as 1 to 100 or 100 to 1000 as example.
We will consider the number of parameters passed as **n** parameters which every single one of them is identified by a **String** and leads to a value of type **Int**. So the signature will be : 
```swift
func invoke(range: ClosedRange<Int>, applying parameters: [String:Int]) async -> [String]
```
The catch here, that we want to sort the parameters before applying them to the algorithm. 
Next, knowing that the number of parameters can varies, what about the test itself ? 
Saying for example, we want to show "Fuzz" if the number is 3 AND below 10.
Or, saying that we want to show "FizzBuzz" of the number is 3*5 AND NOT equals 15. 
This new method signature should takes no longer parameters only, but instead a collection of **Triggers** that contains the **Predicate** and what to show if the predicate is satisfied. 
So the signature will be : 
```swift
public typealias Predicate = (Int) -> Bool
public typealias Trigger = [String : Predicate]
public typealias TriggerCollection = [Trigger]
func invoke(range: ClosedRange<Int>, triggers: TriggerCollection) async -> [String] 
```

So the user should be able to create his own custom triggers, no matter what the boolean result of it.
## License

Fizz Buzz is under [GPL](https://github.com/Illumina/licenses/blob/master/gpl-3.0.txt)-licensed v3.0.
