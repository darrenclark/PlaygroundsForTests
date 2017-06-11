# PlaygroundsForTests
Experimenting with Swift playgrounds for writing tests to allow for easier test writing and avoiding long compile times

Basic ideas are:
- tests are written in Swift playgrounds
- using a Run Script build phase to create XCTestCases out of those playgrounds
- handy scripts for importing code into a playground for quick editing and then exporting it back to it's original source file

## Details

Consists of a couple targets:

1. **PlaygroundsForTests** - the usual app target
2. **PlaygroundsForTestsTests** - the usual tests target
3. **AppUI** - framework target that contains a sample view to be used in app target, tests target and playgrounds
4. And 2 frameworks with the same public facing API for defining tests:
    1. **PlaygroundHelper** - used inside the Swift playgrounds
    2. **PlaygroundHelperForTests** - used inside of the tests target

And a couple of scripts:

1. `edit` - copy code from project into a playground
2. `save` - save changes made to code in playground back to project
3. `generate_test_cases` - generates `XCTestCase`s from playgrounds (runs as a Run Script build phase in tests target)

## Moving code into/out of playground

Playgrounds are annotated with comments like:

```swift
// EDIT: ./edit AppUI/DemoView.swift AppUI.playground
```

Running the command (`./edit AppUI/DemoView.swift AppUI.playground`) will replace the above line with something like:

```swift
// SAVE: ./save AppUI/DemoView.swift AppUI.playground
... contents of AppUI/DemoView.swift here
// ENDSAVE
```

so that the contents of `AppUI/DemoView.swift` can easily be edited in line & changes seen immediately.

When finished making tweaks, just need to run the `./save AppUI/DemoView.swift AppUI.playground` command to update
the original file (`AppUI/DemoView.swift`) with the changes made in the playground.  Additionally, the playground will
get reverted back to only having the `// EDIT: .....` comment.

## Tests

Tests in the playground are defined like so:

```swift
test("addition works as expected") {
    Assert(2 + 2 == 4, "two plus two is four")
}
```

- The `test` function defines a test case
- The `Assert` function is used to verify behavior
    - when test is run in the playground, `Assert` returns `"✅"` or `"❌"` so it's easy to see if a test is passing or failing (shows
    up in the right gutter in Xcode's playground editor)
    - when test is run in the test target (i.e. when running tests regularly via Xcode) it will call into `XCTAssert` so that
    `XCTest` can report failures
