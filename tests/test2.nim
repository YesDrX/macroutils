import unittest
import macroutils2
import macros except name
# import macros

test "extract: syntax pleaser":
  macro test(args: untyped): untyped =
    args.extract do:
      type `name` = object
        `fields*`: `*`

      var
        `assignments*` = `*`

    assert name == Ident "MyType"
    for field in fields:
      assert field.kind == nnkIdentDefs
    for assignment in assignments:
      assert assignment.kind == nnkIdentDefs
  test:
    type MyType = object
      firstField: int
      secondField: string

    var
      firstVariable = 100
      secondVariable = "string"
