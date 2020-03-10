# iOS Programming Study

---

# Chapter 1 : A Simple iOS Application

---

# Xcode workspace 구조

![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_workspacewindow_callouts_2x.png)
![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_schememenu_2x.png)
![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_toolbar_2x.png)
![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_projectnavigator_2x.png)
![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/object_library_2x.png)
![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/BBUI_inspector_attributes_2x.png)
![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/assistant_editor_toggle_2x.png)
![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/navigator_utilities_toggle_on_2x.png)
![](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Art/standard_toggle_2x.png)

---

# Model-View-Controller

![](https://koenig-media.raywenderlich.com/uploads/2016/04/diagram-mvc-480x241.png)
- [ref](https://www.raywenderlich.com/132662/mvc-in-ios-a-modern-approach)

---

# Chapter 2 : The Swift Language

- Types
    - structures
    - classes
    - enumerations

```
struct MyStruct {
    // properties
    // initializers
    // methods
}

enum MyStruct {
    // properties
    // initializers
    // methods
}

class MyStruct {
    // properties
    // initializers
    // methods
}
```
    - structure 와 enum 은 value type, protocol 사용가능
    - 모든 swift type 은 structure
    - class 는 reference type, protocol 사용가능
    - Optional : 값을 가지고 있거나, nil 둘 중 하나의 상태

- Type Inference
    - 컴파일러가 type 을 추론함.
    - `var a = "hello"` 컴파일러가 a: String 을 추론
- Specifying types
    - `var a: String = "hello"`
- Collections
    - arrays, dictionaries, and sets
- Properties
    - `countings.count`, `countings.isEmpty`
- Instance Methods
    - `greetings.append("hello")`
- Optionals
    - optional binding : `if-let, guard let`
- Loops and String Interpolation

```
for i in 0...countingUp.count {
}

for string in countingUp {
}

for (i, string) in countingUp.enumerated() {
}

for (key, value) in someDictionary {
}
```

- Enumerations and the Switch Statement

```
enum Color {
    case red
    case blue
}
let color = Color.red
switch color {
  case .red:
    print("It's red")
  case .blue:
    print("It's blue")
}
fallthrough
break
return
case .red, .blue:
```

- Enumerations and raw values

```
enum PieType: Int {
    case apple = 0
    case cherry // 1
    case pecan  // 2
}

PieType.pecan.rawValue is 2
if let pieType = PieType(rawValue: 2) {
   // Got a valid 'pieType'!
}
```

- First Class and Higher-Order Functions
  - 함수가 변수에 할당 될수도 있고, 파라미터로 넘겨질 수도 있으면 : first class function
  - 파라미터로 함수를 받고 다른 함수를 리턴할 수 있는 함수 : higher order function

```
// Filter
let list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

let filterResult = list.filter { value -> Bool in
    return value % 2 == 0
}
print(filterResult) // [0, 2, 4, 6, 8]

// Map
let mapResult = list.map { value -> String in
    return "\(value * value)"
}
print(mapResult) // ["0", "1", "4", "9", "16", "25", "36", "49", "64", "81"]

// Reduce

let reduceResult = list.reduce(0) { result, value -> Int in
    return result + value
}
print(reduceResult) // 45


```

---

- [For More About Swift](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)

---

# Chapter 3 : View and the View Hierarchy

---

## View Basics

A view: 
- is an instance of UIView or one of its subclasses 
- knows how to draw itself 
- can handle events, like touches 
- exists within a hierarchy of views whose root is the application’s window

---

## Size to Fit Content
- ⌘=

---

## The Auto Layout System

- Using Auto Layout, you can describe the layout of your views in a relative way that enables their frames to be determined at runtime so that the frames’ definitions can take into account the screen size of the device that the application is running on.

### The alignment rectangle and layout attributes

- The Auto Layout system is based on the alignment rectangle. This rectangle is defined by several layout attributes

/autolayout.png

### Constraints 

- A constraint defines a specific relationship in a view hierarchy that can be used to determine a layout attribute for one or more views.

### Intrinsic Content Size

- This is where the intrinsic content size of a view comes into play. You can think of the intrinsic content size as the size that a view “wants” to be. For labels, this size is the size of the text rendered at the given font. For images, this is the size of the image itself.


---

# Chapter 4 : Text Input and Delegate

---

## Number formatters

- You use a number formatter to customize the display of a number. There are other formatters for formatting dates, energy, mass, length, measurements, and more. Create a constant number formatter in ConversionViewController.swift. 

```
let numberFormatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.minimumFractionDigits = 0
    nf.maximumFractionDigits = 1
    return nf
}()

```


---


# Chapter 8 : Controlling Animations

---

## Basic Animations



```
class func animate(withDuration duration: TimeInterval, animations: () -> Void)
```

---

## Closure


```
A closure is a discrete bundle of functionality that can be passed around your code. Closures are a lot like functions and methods. In fact, functions and methods are just special cases of closures.
```


```
(arguments) -> return type
func functionName(arguments) -> return type

{ (arguments) -> return type in
...
}
```


## Animation Completion

- completion block

## Timing Functions

```
[.curveLinear]
```

## [Swift OptionSet](https://developer.apple.com/documentation/swift/optionset?changes=_8)

```
struct ShippingOptions: OptionSet {
    let rawValue: Int

    static let nextDay    = ShippingOptions(rawValue: 1 << 0)
    static let secondDay  = ShippingOptions(rawValue: 1 << 1)
    static let priority   = ShippingOptions(rawValue: 1 << 2)
    static let standard   = ShippingOptions(rawValue: 1 << 3)

    static let express: ShippingOptions = [.nextDay, .secondDay]
    static let all: ShippingOptions = [.express, .priority, .standard]
}
```

- [REF](https://oleb.net/blog/2016/09/swift-option-sets/)

---

# Chapter 9

---

## Debugging Basic

```
2018-08-02 09:48:11.629320+0900 Buggy[3020:98836] -[Buggy.ViewController buttonTapped:]: unrecognized selector sent to instance 0x7fbaaac091d0

...
```

> The expression -[Buggy.ViewController buttonTapped:] is a representation of Objective-C code. A message in Objective-C is always enclosed in square brackets in the form [receiver selector]. The receiver is the class or instance to which the message is sent. The dash (-) before the opening square bracket indicates that the receiver is an instance of ViewController. (A plus sign (+) would indicate that the receiver was the class itself.)


---

## Caveman debugging

This is an example of a technique that is fondly called *caveman debugging*: strategically placing print() calls in your code to verify that functions and methods are being called (and called in the proper sequence) and to log variable values to the console to keep an eye on important data.

### Literal expressions useful for debugging

- `#function` : String
- `#line` : Int
- `#column` : Int
- `#file` : String
- `print("Method: \(#function) in file: \(#file) line: \(#line) called.")`


```
Method: buttonTapped in file: /Users/user/development/iOS-Programming-Study/Buggy/Buggy/ViewController.swift line: 19 called.
```

## The Xcode Debugger LLDB

```
2018-08-02 10:19:50.607454+0900 Buggy[4682:208470] *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM removeObjectsInRange:]: range {0, 1} extends beyond bounds for empty array'

```

## Setting Breakpoints

- Continue program execution – resumes normal execution of the program
- Step over – executes a single line of code without entering any function or method call
- Step into – executes the next line of code, including entering a function or method call 
- Step out – continues execution until the current function or method is exited

## The LLDB console

- p
- po
- br
- b
- continue
- n (Step over)
- s (Step in)
- finish (step out)
- expr
	- `expr self.view.hidden = YES`
- bt, bt all
- thread
- frame
	- 로컬 변수 살펴보기: frame variable self
	- 정보 보기: frame info
	- 직접 이동하기: frame select 2
	- 상대 이동하기: frame -r -1
- watchpoint
	- 특정한 변수 값이 변할 때 마다 실행 멈추고 값 보기
	- 리스트 보기: watchpoint list
	- 삭제: watchpoint delete 1
	- 설정하기: watchpoint set variable _x
	- watchpoint set expression — my_point
	- 조건넣기: watchpoint modify — -c “_x < 0″ 1
	- 조건 없애기: watchpoint modify -c “” 1
- script
	- LLDB에는 파이썬 언어 해석기가 포함되어 있다. 그리고 브레이크 포인트에서 스크립트를 실행 시킬수 있다.
	- 실시간 파이썬 실행하기: script
	- 브레이크 포인트에 파이썬 심기: br command add -s python  1
	- 브레이크 포인트에 command 삽입하기: breakpoint command add -f my.breakpoint_func
- command
	- 현존하는 스크립트를 심을 수 있다.
	- 임포트하기: command script import ~/my_script.py
	- 추가하기: command script add -f my_script.python_function cmd_name
	- 히스토리 보기: command history
	- 디버깅 스크립트 임포트하기: command import ~/my_lldb.txt

- [REF](http://bartysways.net/?p=682)


---

# Chapter 10 : UITableView and UITableViewController

- *model*: holds data and knows nothing about the UI 
- *view*: is visible to the user and knows nothing about the model objects 
- *controller*: keeps the UI and the model objects in sync and controls the flow of the application

Classes can have two kinds of initializers: designated initializers and convenience initializers.


A designated initializer is a primary initializer for the class. Every class has at least one designated initializer. A designated initializer ensures that all properties in the class have a value. Once it ensures that, a designated initializer calls a designated initializer on its superclass (if it has one).

---

Every class must have at least one designated initializer, but convenience initializers are optional. helpers. A convenience initializer always calls another initializer on the same class.

---

The `@discardableResult` annotation means that a caller of this function is free to ignore the result of calling this function.

---

## Dependency Inversion

- 첫째, 상위 모듈은 하위 모듈에 의존해서는 안된다. 상위 모듈과 하위 모듈 모두 추상화에 의존해야 한다.
- 둘째, 추상화는 세부 사항에 의존해서는 안된다. 세부사항이 추상화에 의존해야 한다.
- High-level objects should not depend on low-level objects. Both should depend on abstractions. 
- Abstractions should not depend on details. Details should depend on abstractions.

![](https://upload.wikimedia.org/wikipedia/commons/9/96/Dependency_inversion.png)

---

## Dependency Injection

마틴 파울러는 다음과 같은 세 가지의 의존성 주입 패턴을 제시하였다.

생성자 주입 : 필요한 의존성을 모두 포함하는 클래스의 생성자를 만들고 그 생성자를 통해 의존성을 주입한다.
세터(Setter)를 통한 주입 : 의존성을 입력받는 세터(Setter) 메소드를 만들고 이를 통해 의존성을 주입한다.
인터페이스(Interface)를 통한 주입 : 의존성을 주입하는 함수를 포함한 인터페이스를 작성하고 이 인터페이스를 구현하도록 함으로써 실행시에 이를 통하여 의존성을 주입한다.


![Dependency Injection](https://upload.wikimedia.org/wikipedia/commons/1/10/W3sDesign_Dependency_Injection_Design_Pattern_UML.jpg)

---

# Chapter 11 : Editing TableView

---


A design pattern solves a common software engineering problem. Design patterns are not actual snippets of code, but instead are abstract ideas or approaches that you can use in your applications.

 Good design patterns are valuable and powerful tools for any developer. 
 
 The consistent use of design patterns throughout the development process reduces the mental overhead in solving a problem so you can create complex applications more easily and rapidly. Here are some of the design patterns that you have already used: 
 
 **Delegation**: One object delegates certain responsibilities to another object. You used delegation with the UITextField to be informed when the contents of the text field change. 
 
 **Data source**: A data source is similar to a delegate, but instead of reacting to another object, a data source is responsible for providing data to another object when requested. You used the data source pattern with table views: Each table view has a data source that is responsible for, at a minimum, telling the table view how many rows to display and which cell it should display at each index path. 
 
 **Model-View-Controller**: Each object in your applications fulfills one of three roles. Model objects are the data. Views display the UI. Controllers provide the glue that ties the models and views together. 

**Target-action pairs**: One object calls a method on another object when a specific event occurs. The target is the object that has a method called on it, and the action is the method being called. For example, you used target-action pairs with buttons: When a touch event occurs, a method will be called on another object (often a view controller).


---

# Chapter 12 : Subclassing UITableViewCell

---

## Dynamic Cell Heights

> `UITableViewAutomaticDimension` is the default value for rowHeight, so while it is not necessary to add, it is useful for understanding what is going on. Setting the estimatedRowHeight property on the table view can improve performance. Instead of asking each cell for its height when the table view loads, setting


> The method awakeFromNib() gets called on an object after it is loaded from an archive, which in this case is the storyboard file. By the time this method is called, all of the outlets have values and can be used.

---

# Chapter 13 : Stack Views

---


## Implicit constraints

- intrinsic content size

---

## Stack view distribution 

> Let’s take a look at another way of solving the problem. Stack views have a number of properties that determine how their content is laid out. Select the stack view, either on the canvas or using the document outline. Open its attributes inspector and find the section at the top labeled Stack View. One of the properties that determines how the content is laid out is the Distribution property. Currently it is set to Fill, which lets the views lay out their content based on their intrinsic content size. Change the value to Fill Equally. 

---

...

---

# Chapter 20 : Web Services
 
## Access Control 
> You can control what can access the properties and methods on your own types. There are five levels of access control that can be applied to types, properties, and methods:


---

- *open* – This is used only for classes, and mostly by framework or third-party library authors. Anything can access this class, property, or method. Additionally, classes marked as open can be subclassed and methods can be overridden outside of the module. 
- *public* – This is very similar to open; however, classes can only be subclassed and methods can only be overridden inside (not outside of) the module.
- *internal* – This is the default. Anything in the current module can access this type, property, or method. For an app, only files within your project can access these. If you write a third-party library, then only files within that third-party library can access them – apps that use your third-party library cannot. 
- *fileprivate* – Anything in the same source file can see this type, property, or method. 
- *private* – Anything within the enclosing scope can access this type, property, or method.

---

# URLSession

## URLRequest

- `allHTTPHeaderFields` – a dictionary of metadata about the HTTP transaction, including character encoding and how the server should handle caching 
- `allowsCellularAccess` – a Boolean that represents whether a request is allowed to use cellular data 
- `cachePolicy` – the property that determines whether and how the local cache should be used 
- `httpMethod` – the request method; the default is GET, and other values are POST, PUT, and DELETE 
- `timeoutInterval` – the maximum duration a connection to the server will be attempted for


## [URLSessionTask](https://developer.apple.com/documentation/foundation/urlsessiontask)

> 3 kind of tasks

- data task
- download task
- upload task
- stream task

---

- **URLSession** acts as a factory for **URLSessionTask** instances.
- Tasks are always created in the suspended state, so calling resume()

---

## Main Thread

> When the web service completes, you want it to update the image view. But by default, **URLSessionDataTask** runs the completion handler on a **background thread**. You need a way to force code to run on the main thread to update the image view. You can do that easily using the OperationQueue class.

```
OperationQueue.main.addOperation {
// code here
}
```

---

# Chapter 21 : Collection Views

---

## Flow layout

- A flow layout fits as many cells on a row as possible before flowing down to the next row.

## Customizable Properties

- `scrollDirection` – Do you want to scroll vertically or horizontally? 
- `minimumLineSpacing` – What is the minimum spacing between lines? 
- `minimumInteritemSpacing` – What is the minimum spacing between items in a row (or column, if scrolling horizontally)? 
- `itemSize` – What is the size of each item? 
- `sectionInset` – What are the margins used to lay out content for each section?


## UICollectionViewCell

- The method `awakeFromNib()` will be used for the former, and the method `prepareForReuse()` will be used for the latter.
- The method `prepareForReuse()` is called when a cell is about to be reused.

## Interface Builder top

- A helpful Interface Builder tip is to hold Control and Shift together and then click on top of the view you want to select.


## Extensions 

Extensions serve a couple of purposes: 

- They allow you to group chunks of functionality into a logical unit, 
- and they also allow you to add functionality to your own types as well as types provided by the system or other frameworks. 
- Being able to add functionality to a type whose source code you do not have access to is a very powerful and flexible tool. 
- Extensions can be added to classes, structs, and enums.

---

# Chapter 22 : Core Data


- Entity (table)
- Attributes
- to Many
- to One
- Inverse
- codegen

---

> The **viewContext** is an instance of NSManagedObjectContext. This is the portal through which you interact with your entities. You can think of the managed object context as an intelligent scratch pad. When you ask the context to fetch some entities, the context will work with its persistent store coordinator to bring temporary copies of the entities and object graph into memory. Unless you ask the context to save its changes, the persisted data remains the same.

---

## Chapter 23 : Core Data Relationships

---

## Chapter 24 : Accessibility

---