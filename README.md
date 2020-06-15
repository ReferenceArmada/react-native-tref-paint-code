## Getting started

Library implements a general approach for using PaintCode generated files with React Native on both iOS and Android platforms.

## Installation
1. Prepare PaintCode files
   > Generate Swift export for iOS, and Java file for Android.
   
   > Convert generated Java file to Kotlin file.

   > Do not forget to use name "PaintCode" for exported classes.

2. Place exported PaintCode files into projects root folders.

3. Install the library from NPM, by following instructions on latest package:
   https://github.com/ReferenceArmada/react-native-tref-paint-code/packages/

4. Install dependencies for iOS project

```sh
$ cd ios
$ pod install
```

5. On native Android project, open **MainApplication.java** file and add following to the file:

```java
private static void initializePaintCode(Context context) {
    try {
        Class<?> aClass = Class.forName("be.reference.rnpaintcode.PackageUtil");
        Field packageName = aClass.getDeclaredField("packageName");
        packageName.setAccessible(true);
        packageName.set(aClass, context.getPackageName());
    } catch (Exception e) {
        e.printStackTrace();
    }
}
```

Add following line to your **onCreate()** method on **MainApplication.java** file.

```java
@Override
public void onCreate() {
  ...    
  initializePaintCode(this);
  ...
}
```

6. Ready to go.


## Usage
1. Add required imports

```javascript
import {TrefPaintCode,
        TrefPaintCodeType,
        TrefPaintCodeResizingBehaviour,
        TrefPaintCodeHelper}
        from '@referencearmada/react-native-tref-paint-code';
```

2. Use **TrefPaintCode** component in views.

There are two required parameters to draw into **TrefPaintCode** component.

- **method**: Method name that you want to invoke from native PaintCode generated file

> **For example:** drawView_someButton

- **params**: Parameter object for that specific method that you wanted to call

> Each parameter object should have two properties which are **type** and **value**. Usable types are defined in TrefPaintCodeType JS file.

```javascript
    {
        resizing:
        {
            type: TrefPaintCodeType.RESIZING_BEHAVIOUR,
            value: TrefPaintCodeResizingBehaviour.ASPECT_FIT
        },
        radius:
        {
            type: TrefPaintCodeType.FLOAT,
            value: 8
        },
        title: {
            type: TrefPaintCodeType.STRING,
            value: "Do something"
        }
    }
```

3. Use colors in your styles.

```javascript
const styles = StyleSheet.create({
  someStyle: {
    backgroundColor: TrefPaintCodeHelper.Colors.light_background_color
  }
});
```

### Full example

```javascript
<TrefPaintCode
    style={styles.someButton}
    method="drawView_someButton"
    params={
    {
        resizing:
        {
            type: TrefPaintCodeType.RESIZING_BEHAVIOUR,
            value: TrefPaintCodeResizingBehaviour.ASPECT_FIT
        },
        radius:
        {
            type: TrefPaintCodeType.FLOAT,
            value: 8
        },
        title: {
            type: TrefPaintCodeType.STRING,
            value: "Do something"
        }
    }
} />

const styles = StyleSheet.create({
  someButton: {
    width: 200,
    height: 100,      
    backgroundColor: TrefPaintCodeHelper.Colors.light_background_color
  }
});
```

## How it works?
For both platforms:
- Native module called **TrefPaintCodeHelper** used for reaching colors defined in PaintCode files
- Native UI component modules called **TrefPaintCode** used for actual drawing of the graphics

### **Tech stack**

**On Android:**

- **kotlin-reflect** library to reach, read set and invoke class members and methods on runtime
- An initializer method to initialize library from the native application
- Kotlin language

**On iOS:**

- Objective-C runtime to reach, read, set and invoke class members (both Swift and Objective-C) on runtime. Used NSInvocation class.
- Objective-C and Swift together

### **Flow**

Using reflection on both platforms, when a TrefPaintCode component is used:

1. Method name and method parameters passed to native modules from JS via component
2. Native modules takes method and parameters and invokes the method from provided PaintCode files via reflection
3. Native UI component module draws invoked method contents to the screen

## Known issues and TODOs
- Code is not very DRY, refactor is needed
- Work with Java classes instead of Kotlin (converting is sometimes problematic)
- Test more!
