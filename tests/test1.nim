# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import macroutils2
import macros except name

test "converter, generator, accessor, and setter":
  macro test(): untyped =
    let testTableConst = TableConstr(ExprColonExpr(toLit("hello"), toLit(100)))
    testTableConst.muArguments[0] = ExprColonExpr(toLit("goodbye"), toLit(42))
    testTableConst.muArguments.add ExprColonExpr(toLit("world"), toLit(4242))
    testTableConst.muArguments.insert(0, ExprColonExpr(toLit("hello"), toLit(32)))
    assert testTableConst == nnkTableConstr.newTree(
      nnkExprColonExpr.newTree(newLit("hello"), newLit(32)),
      nnkExprColonExpr.newTree(newLit("goodbye"), newLit(42)),
      nnkExprColonExpr.newTree(newLit("world"), newLit(4242))
      )
    let testComment = CommentStmt("Hello world")
    assert testComment.muArgument == newLit("Hello world")
    testComment.muArgument = "test"
    let verifyComment = newNimNode(nnkCommentStmt)
    verifyComment.strVal = "test"
    assert testComment == verifyComment
    let testCommand = Command("testCmd", toLit(100))
    assert testCommand == nnkCommand.newTree(newIdentNode("testCmd"), newLit(100))
    assert testCommand.muName == newIdentNode("testCmd")
    testCommand.muName = "echo"
    assert testCommand.muName == newIdentNode("echo")
  test()
